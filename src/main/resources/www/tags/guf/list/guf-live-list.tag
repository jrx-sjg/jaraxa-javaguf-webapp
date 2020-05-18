<guf-live-list>
	<div ref="wrapper">
		<div if={emptyState} ref="empty-view"><yield /></div>
		<div if={!emptyState} ref="container" class="container">
			<div ref="top-block"></div>
			<div ref="current-block">
				<guf-list-item class="list-item" each={item in renderedItems} dcss-background-hover="{parent.backgroundHover}" dcss-background="{parent.backgroundContent}">
					<guf-live-list-item item-tag={parent.itemTag} data={item} ></guf-live-list-item>
				</guf-list-item>
			</div>
			<div ref="bottom-block"></div>
		</div>
	</div>
	<style scoped type="dcss">
		:scope {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			min-height: 0;
		}

		:scope > div[ref="wrapper"] {
			display: block;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			overflow: auto;
			-webkit-transform: translate3d(0,0,0);
		}

		:scope > div[ref="wrapper"] > div[ref="empty-view"] {
			display: block;
		}

		:scope > div[ref="wrapper"] > div.container {
			display: block;
		}

		:scope > div > div > div[ref="top-block"],
		:scope > div > div > div[ref="bottom-block"] {
			display: none;
		}

		:scope > div > div > div[ref="current-block"] > guf-list-item {
			padding: 0px;
		}

		.guf-device-ios :scope > div > div > div[ref="top-block"],
		.guf-device-ios :scope > div > div > div[ref="bottom-block"],
		.guf-browser-firefox :scope > div > div > div[ref="top-block"],
		.guf-browser-firefox :scope > div > div > div[ref="bottom-block"] {
			display: block;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.renderedItems = [];
		tag.itemTag = guf.param.string(opts.itemTag, null);
		tag.emptyState = guf.param.boolean(opts.emptyState, false);
		tag.backgroundHover = guf.param.string(opts.backgroundHover, "rgba(0,0,0, 0.1)");
		tag.backgroundContent = guf.param.string(opts.backgroundContent, "transparent");
		tag.mixin('mdl', 'relay-events');

		var SCROLLING_TIME_CONSTANT = 525;
		var SCROLLING_DOWN = 1;
		var SCROLLING_UP = 0;
		var PREFETCH_DELAY = guf.param.number(opts.prefetchDelay, 50);
		
		var dataProvider = opts.dataProvider;
		var selectionModel = opts.selectionModel;
		var prefetching = null;
		var prefetchTask = null;
		var chunkSize = guf.param.number(opts.chunkSize, 35);
		var chunkData = [];
		var chunkStartingIndex = 0;
		var chunkOffset = guf.param.number(opts.chunkLoadOffset, 10);
		var prefetchChunkStartingIndex = -1;
		var currentRenderedStartingIndex = 0;
		var offsetLimit = guf.param.number(opts.prefetchLimit, 5);
		var rowHeight = guf.param.number(opts.rowHeight, 90);
		var totalRows = 0;
		var maxVisibleRows = 0;
		var currentScrollOffset = 0;
		var topBlockHeight = 0;
		var currentBlockHeight = 0;
		var bottomBlockHeight = 0;
		var totalHeight = 0;
		var currentScrollDirection = SCROLLING_DOWN;
		var listInitialized = false;

		var timestamp = 0,
			minOffset = 0,
			maxOffset = 0,
			frame = 0,
			velocity = 0,
			amplitude = 0,
			pressed = 0,
			reference = 0,
			offset = 0,
			target = 0,
			touchPositions = [];

		function initList() {
			if(dataProvider instanceof GufDataProvider) {
				dataProvider.requestDataBlock(0, chunkSize, function(rows, data) {
					if(!tag.isMounted) {
						return;
					}
					totalRows = rows;
					chunkData = data;
					chunkStartingIndex = 0;
					tag.emptyState = false;
					tag.trigger("before-created", tag, totalRows);
					tag.update();
					createList();
					listInitialized = true;
					tag.trigger("created", tag);
				});
				if(selectionModel instanceof GufSelectionModel) {
					selectionModel.on("select-item", selectItemHandler);
					selectionModel.on("deselect-item", deselectItemHandler);
					selectionModel.on("clear-selection", clearSelectionHandler);
				}
			} else {
				guf.console.error("guf-live-list: data provider must be a subclass of GufDataProvider");
			}
		}

		function createList() {
			setListParameters();
			tag.renderedItems = [];
			for(var i = 0; i < maxVisibleRows; i++) {
				tag.renderedItems.push(chunkData[i]);
			}
			tag.refs['top-block'].style.height = "0px";
			tag.refs['bottom-block'].style.height = ((totalRows - tag.renderedItems.length) * rowHeight) + "px";
			tag.refs['current-block'].style.height = (tag.renderedItems.length * rowHeight) + "px";
			totalHeight = calculateListHeight();
			tag.refs['container'].style.height = totalHeight + 'px';
			tag.update();
			if(typeof selectionModel !== "undefined") {
				var children = tag.refs['current-block'].children;
				for(var i = 0; i < maxVisibleRows; i++) {
					var itemData = chunkData[i];
					var selected = selectionModel.isSelected(selectionModel.getId(itemData));
					var types = selectionModel.getSelectionTypes(selectionModel.getId(itemData));
					if(selected) {
						children[i]._tag.tags['guf-live-list-item'].select(types);
					} else {
						children[i]._tag.tags['guf-live-list-item'].deselect();
					}
				}
			}
			attachItemEvents();
			maxOffset = totalHeight - getContainerHeight();
		}

		function resetList(reset) {
			setListParameters();
			removeItemEvents();
			tag.renderedItems = [];
			tag.update();
			currentBlockHeight = maxVisibleRows * rowHeight;
			tag.refs['current-block'].style.height = (maxVisibleRows * rowHeight) + "px";
			if(reset) {
				topBlockHeight = 0;
				currentRenderedStartingIndex = 0;
				tag.scrollToTop();
				tag.refs['top-block'].style.height = topBlockHeight + "px";
			}
			bottomBlockHeight = ((totalRows - maxVisibleRows) * rowHeight) - topBlockHeight;
			if(bottomBlockHeight <= 0) {
				if(!guf.device.isIos || ((topBlockHeight + currentBlockHeight) < (currentScrollOffset + getContainerHeight()))) {
					bottomBlockHeight = 0;
					topBlockHeight = (totalRows - maxVisibleRows) * rowHeight;
					tag.refs['top-block'].style.height = topBlockHeight + "px";
					currentRenderedStartingIndex = totalRows - maxVisibleRows;
					currentScrollOffset = topBlockHeight + currentBlockHeight - getContainerHeight();
					if(guf.device.isIos) {
						scroll(currentScrollOffset);
					} else if (guf.device.normalizedName !== "firefox") {
						tag.refs["current-block"].style["webkitTransform"] = 'matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0' + ',' + topBlockHeight + ', 0, 1)';
					}
				}
			}
			tag.refs['bottom-block'].style.height = bottomBlockHeight + "px";
			var index;
			for(var i = 0; i < maxVisibleRows; i++) {
				index = currentRenderedStartingIndex + i;
				tag.renderedItems.push(getItemAtIndex(index, function(resultItem, startingIndex) {
					if((index >= startingIndex) && (index < (startingIndex + chunkSize))) {
						var children = tag.refs['current-block'].children;
						for(var i = 0; i < maxVisibleRows; i++) {
							var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
							var itemData = chunkData[itemIndex];
							if(typeof selectionModel !== "undefined") {
								var selected = selectionModel.isSelected(selectionModel.getId(itemData));
								var types = selectionModel.getSelectionTypes(selectionModel.getId(itemData));
								if(selected) {
									children[i]._tag.tags['guf-live-list-item'].select(types);
								} else {
									children[i]._tag.tags['guf-live-list-item'].deselect();
								}
							}
							children[i]._tag.tags['guf-live-list-item'].updateData(chunkData[currentRenderedStartingIndex + i - chunkStartingIndex]);
						}
					}
				}));
			}
			totalHeight = calculateListHeight();
			tag.refs['container'].style.height = totalHeight + 'px';
			tag.update();
			if(typeof selectionModel !== "undefined") {
				var children = tag.refs['current-block'].children;
				for(var i = 0; i < maxVisibleRows; i++) {
					var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
					var itemData = chunkData[itemIndex];
					if(itemData) {
						var selected = selectionModel.isSelected(selectionModel.getId(itemData));
						var types = selectionModel.getSelectionTypes(selectionModel.getId(itemData));
						if(selected) {
							children[i]._tag.tags['guf-live-list-item'].select(types);
						} else {
							children[i]._tag.tags['guf-live-list-item'].deselect();
						}
					}
				}
			}
			attachItemEvents();
			maxOffset = totalHeight - getContainerHeight();
			tag.trigger("reset", tag, totalRows);
		}

		function refreshList(reset) {
			if(!listInitialized) {
				guf.console.warn("Tried to refresh guf-live-list before initializing it");
				return;
			}
			if(dataProvider instanceof GufDataProvider) {
				tag.trigger("before-refresh");
				var startingIndex = prefetchChunkStartingIndex;
				if(prefetching) {
					guf.clearTimeout(prefetching);
					prefetching = null;
				}
				if(prefetchTask) {
					dataProvider.cancelRequest(prefetchTask);
					prefetchTask = null;
				}
				if(prefetchChunkStartingIndex == -1) {
					startingIndex = chunkStartingIndex;
				}
				prefetchChunkStartingIndex = reset ? 0 : startingIndex;
				startingIndex = prefetchChunkStartingIndex;
				prefetchTask = dataProvider.requestDataBlock(prefetchChunkStartingIndex, chunkSize, function(rows, data) {
					if(!tag.isMounted) {
						return;
					}
					prefetchTask = null;
					totalRows = rows;
					chunkData = data;
					chunkStartingIndex = startingIndex;
					tag.trigger("before-reset", tag, totalRows);
					resetList(reset);
				});
			} else {
				guf.console.error("guf-live-list: data provider must be a subclass of GufDataProvider");
			}
		}

		function setListParameters() {
			maxVisibleRows = Math.min(totalRows, Math.ceil(getContainerHeight() / rowHeight) + 1);
			var fixedChunkLoadOffset = (typeof opts.chunkLoadOffset !== "undefined");
			var fixedPrefetchLimit = (typeof opts.prefetchLimit !== "undefined");
			if(!fixedChunkLoadOffset) {
				if(fixedPrefetchLimit) {
					chunkOffset = offsetLimit * 2;
				} else {
					chunkOffset = Math.min(Math.floor(chunkSize / 4), maxVisibleRows * 2);
				}
			}
			if(!fixedPrefetchLimit) {
				offsetLimit = Math.min(Math.floor(chunkOffset / 2), maxVisibleRows);
			}
			if(chunkSize > chunkOffset && chunkOffset > offsetLimit) {
				// values are ok
			} else if(chunkSize > chunkOffset) {
				offsetLimit = Math.min(Math.floor(chunkOffset / 2), maxVisibleRows);
			} else {
				chunkOffset = Math.floor(chunkSize / 4);
				if(offsetLimit > chunkOffset) {
					offsetLimit = Math.min(Math.floor(chunkOffset / 2), maxVisibleRows);
				}
			}
		}

		function getItemAtIndex(index, callback) {
			// guf.console.log("getItemAtIndex: ", index);
			if((prefetching || prefetchTask) && (index >= prefetchChunkStartingIndex) && (index < prefetchChunkStartingIndex + chunkSize)) {
				// data is being requested, return it if in current chunkData
				if((index >= chunkStartingIndex) && (index < chunkStartingIndex + chunkData.length)) {
					return chunkData[index - chunkStartingIndex];
				}
			} else if(!(prefetching || prefetchTask) && (currentScrollDirection == SCROLLING_DOWN) && (index >= chunkStartingIndex) && (index < chunkStartingIndex + chunkData.length - offsetLimit)) {
				// data available in current chunkData scrolling down
				return chunkData[index - chunkStartingIndex];
			} else if(!(prefetching || prefetchTask) && (currentScrollDirection == SCROLLING_UP) && (index >= chunkStartingIndex + offsetLimit) && (index < chunkStartingIndex + chunkData.length)) {
				// data available in current chunkData scrolling up
				return chunkData[index - chunkStartingIndex];
			} else {
				// data is beyond available and/or prefetching chunkData
				// guf.console.log("prefetching case", index, chunkStartingIndex, prefetchChunkStartingIndex, prefetching);
				var chunkIndex;
				if(currentScrollDirection == SCROLLING_DOWN) {
					chunkIndex = index - maxVisibleRows - chunkOffset;
				} else {
					chunkIndex = index + maxVisibleRows + chunkOffset - chunkSize;
				}
				// Set the limits
				if(chunkIndex > (totalRows - chunkSize)) chunkIndex = totalRows - chunkSize;
				if(chunkIndex < 0) chunkIndex = 0;
				// Clear previous prefetch as it is no longer valid
				if(prefetching) {
					guf.clearTimeout(prefetching);
					prefetching = null;
				}
				if(prefetchTask) {
					dataProvider.cancelRequest(prefetchTask);
					prefetchTask = null;
				}
				if(chunkIndex != chunkStartingIndex) {
					prefetchChunkStartingIndex = chunkIndex;
					prefetching = guf.setTimeout(function() {
						prefetching = null;
						prefetchTask = dataProvider.requestDataBlock(chunkIndex, chunkSize, function(newTotal, data) {
							if(!tag.isMounted) {
								return;
							}
							if(prefetchChunkStartingIndex > 0 && newTotal == 0) {
								// maybe went out of range
								refreshList(true);
							} else if(totalRows != newTotal) {
								// list dimensions changed
								totalRows = newTotal;
								prefetchChunkStartingIndex = -1;
								prefetchTask = null;
								chunkStartingIndex = chunkIndex;
								chunkData = data;
								resetList();
							} else {
								prefetchChunkStartingIndex = -1;
								prefetchTask = null;
								chunkStartingIndex = chunkIndex;
								chunkData = data;
								if(callback) {
									callback(chunkData[index - chunkStartingIndex], chunkIndex);
								}
							}
						});
					}, PREFETCH_DELAY);
				}
				// return item if available in current chunkData
				if((index >= chunkStartingIndex) && (index < chunkStartingIndex + chunkData.length)) {
					return chunkData[index - chunkStartingIndex];
				}
			}
			return null;
		}

		function render() {
			var currentPosition = offset;
			var currentIndex = Math.floor(currentPosition / rowHeight);
			if(currentPosition > currentScrollOffset) {
				// going down
				currentScrollDirection = SCROLLING_DOWN;
				if((topBlockHeight + rowHeight) < currentPosition) {
					// top rows out of screen
					var nonVisibleRows = Math.floor((currentPosition - topBlockHeight) / rowHeight);
					recycleTopRows(nonVisibleRows, currentIndex);
				}
			} else if(currentPosition < currentScrollOffset) {
				// going up
				currentScrollDirection = SCROLLING_UP;
				if((topBlockHeight + currentBlockHeight) >= (currentPosition + getContainerHeight() + rowHeight)) {
					var nonVisibleRows = Math.floor(((topBlockHeight + currentBlockHeight) - (currentPosition + getContainerHeight())) / rowHeight);
					recycleBottomRows(nonVisibleRows, currentIndex);
				}
			}
			tag.refs["wrapper"].scrollTop = currentPosition;
			currentScrollOffset = currentPosition;
			tag.trigger("scroll", tag, currentPosition);
		}

		// touch events handlers

		function ypos (e) {
			// touch event
			if (e.targetTouches && (e.targetTouches.length >= 1)) {
				return e.targetTouches[0].clientY;
			}

			// mouse event
			return e.clientY;
		}

		function scroll (y) {
			offset = y;//Math.min( Math.max(y, minOffset), maxOffset);
			render();
		}

		function autoScroll () {
			var elapsed, delta, newOffset;

			if (amplitude) {
				elapsed = Date.now() - timestamp;
				delta = amplitude * Math.exp(-elapsed / SCROLLING_TIME_CONSTANT);
				newOffset = target - delta;

				if (newOffset < minOffset) {
					if (target - delta >= minOffset-2){
						scroll(minOffset);
						return;
					}
					bounce(true);
				} else if (newOffset > maxOffset) {
					if (target - delta <= maxOffset + 2){
						scroll(maxOffset);
						return;
					}
					bounce(false);
				} else if (delta > 2 || delta < -2) {
					scroll(target - delta);
					requestAnimationFrame(autoScroll);
				} else {
					scroll(target);
				}
			}
		}

		function bounce (top){
			var finalDestination = top ? minOffset : maxOffset,
				isBouncingBack = top && amplitude > 0 || !top && amplitude < 0;

			if (amplitude == 0){
				return;
			}

			var elapsed = Date.now() - timestamp;
			var delta = amplitude * Math.exp(-elapsed / (target == finalDestination ? 125 : SCROLLING_TIME_CONSTANT) );

			if ( isBouncingBack && Math.abs(delta) < 2 ) {
				scroll(top ? minOffset : maxOffset);
				return;
			}

			scroll(target - delta);        

			if (isBouncingBack) {
				if (target != finalDestination) {
					target = finalDestination;
					amplitude = target - offset;
					timestamp = new Date();
				}
			} else {
				target = finalDestination - (finalDestination - target) * 0.1;
				amplitude = target - offset;            
			}

			requestAnimationFrame(function(){
				bounce(top);
			});
			return;
		}

		function recordTouches(e) {
			var touches = e.touches || [{pageX: e.pageX, pageY: e.pageY}],
				timestamp = e.timeStamp,
				currentTouchTop = touches[0].pageY;

			if (touches.length === 2) {
				currentTouchTop = Math.abs(touches[0].pageY + touches[1].pageY) / 2;
			}

			touchPositions.push({offset: currentTouchTop, timestamp: timestamp});
			if (touchPositions.length > 60) {
				touchPositions.splice(0, 30);
			}
		}

		function tapHandler (e) {
			pressed = true;
			reference = ypos(e);

			velocity = amplitude = 0;
			frame = offset;
			timestamp = Date.now();
			recordTouches(e);

			e.stopPropagation();
		}

		function dragHandler (e) {
			var y, delta, scaleFactor = offset < minOffset || offset > maxOffset ? 0.5 : 1;
			if (pressed) {
				recordTouches(e);
				y = ypos(e);
				delta = reference - y;
				if (delta > 2 || delta < -2) {
					reference = y;                
					scroll(offset + delta * scaleFactor);
				}
			}
			e.preventDefault();
			e.stopPropagation();
		}

		function releaseHandler (e) {
			pressed = false;

			if(touchPositions.length > 1) {
				var endPos = touchPositions.length - 1;
				var startPos = endPos - 1;

				// Move pointer to position measured 100ms ago
				for (var i = endPos - 1; i > 0 && touchPositions[i].timestamp > (touchPositions[endPos].timestamp - 100); i -= 1) {
					startPos = i;
				}

				var elapsed = touchPositions[endPos].timestamp - touchPositions[startPos].timestamp;
				var delta = touchPositions[endPos].offset - touchPositions[startPos].offset;

				var v = -1000 * delta / (1 + elapsed);
				velocity = 0.8 * v + 0.2 * velocity;

				amplitude = 1.0 * velocity;
				target = Math.round(offset + amplitude);
				timestamp = Date.now();
				requestAnimationFrame(autoScroll);
				e.stopPropagation();
			}
			touchPositions = [];

		}

		function mouseWheelHandler(e) {
			guf.console.log("mouseWheelHandler");
		}

		function scrollHandler(e) {
			var currentPosition = e.target.scrollTop;
			// guf.console.log("scrollHandler", currentScrollOffset, currentPosition);
			var currentIndex = Math.floor(currentPosition / rowHeight);
			// guf.console.log("currentIndex: ", currentIndex);
			if(currentPosition > currentScrollOffset) {
				// going down
				currentScrollDirection = SCROLLING_DOWN;
            	if((topBlockHeight + rowHeight) < currentPosition) {
            		// top rows out of screen
            		var nonVisibleRows = Math.floor((currentPosition - topBlockHeight) / rowHeight);
            		recycleTopRows(nonVisibleRows, currentIndex);
            	}
			} else if(currentPosition < currentScrollOffset) {
				// going up
				currentScrollDirection = SCROLLING_UP;
				if((topBlockHeight + currentBlockHeight) >= (currentPosition + getContainerHeight() + rowHeight)) {
					var nonVisibleRows = Math.floor(((topBlockHeight + currentBlockHeight) - (currentPosition + getContainerHeight())) / rowHeight);
					recycleBottomRows(nonVisibleRows, currentIndex);
				}
			}
			if (guf.device.normalizedName !== "firefox") {
				tag.refs["current-block"].style["webkitTransform"] = 'matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0' + ',' + topBlockHeight + ', 0, 1)';
			}
			currentScrollOffset = currentPosition;
			tag.trigger("scroll", tag, currentPosition);
		}

		function recycleTopRows(rowsParam, currentIndex) {
			var rows = Math.min(Math.floor(bottomBlockHeight / rowHeight), rowsParam);
			if(rows < rowsParam) {
				currentIndex -= rowsParam - rows;
			}
			if(rows < maxVisibleRows) {
				var offset = rowHeight * rows;
				topBlockHeight += offset;
				tag.refs['top-block'].style.height = topBlockHeight + "px";
				bottomBlockHeight -= offset;
				tag.refs['bottom-block'].style.height = bottomBlockHeight + "px";
				var domNode, index;
				// guf.console.log("selective recycleTopRows: ", currentIndex, rows);
				currentRenderedStartingIndex = currentIndex;
				for(var i = 0; i < rows; i++) {
					domNode = tag.refs['current-block'].insertBefore(tag.refs['current-block'].firstElementChild, null);
					tag.tags['guf-list-item'].unshift(tag.tags['guf-list-item'].pop());
					index = currentIndex - rows + maxVisibleRows + i;
					// guf.console.log("index: ", index, currentIndex, i);
					renderItem(domNode._tag, index);
				}
			} else {
				// full new block
				topBlockHeight = currentIndex * rowHeight;
				if((topBlockHeight + currentBlockHeight) > totalHeight) {
					topBlockHeight = totalHeight - currentBlockHeight;
					currentIndex = totalRows - maxVisibleRows;
				}
				tag.refs['top-block'].style.height = topBlockHeight + "px";
				bottomBlockHeight = totalHeight - (topBlockHeight + currentBlockHeight);
				tag.refs['bottom-block'].style.height = bottomBlockHeight + "px";
				var children = tag.refs['current-block'].children;
				var current, index;
				// guf.console.log("full recycleTopRows with index: ", currentIndex);
				currentRenderedStartingIndex = currentIndex;
				for(var i = 0; i < maxVisibleRows; i++) {
					current = children[i]._tag;
					index = currentIndex + i;
					renderItem(current, index);
				}
			}
		}

		function recycleBottomRows(rows, currentIndex) {
			rows = Math.min(Math.floor(topBlockHeight / rowHeight), rows);
			var firstRenderedIndex = topBlockHeight / rowHeight;
			// guf.console.log("firstRenderedIndex: ", firstRenderedIndex);
			if(rows < maxVisibleRows) {
				var offset = rowHeight * rows;
				topBlockHeight -= offset;
				tag.refs['top-block'].style.height = topBlockHeight + "px";
				bottomBlockHeight += offset;
				tag.refs['bottom-block'].style.height = bottomBlockHeight + "px";
				var domNode, index, aux, size;
				// guf.console.log("selective recycleBottomRows: ", firstRenderedIndex - rows, currentIndex, rows);
				currentRenderedStartingIndex = firstRenderedIndex - rows;
				for(var i = 0; i < rows; i++) {
					aux = tag.refs['current-block'].children;
					size = aux.length;
					domNode = tag.refs['current-block'].insertBefore(aux[size-1], tag.refs['current-block'].firstElementChild);
					tag.tags['guf-list-item'].push(tag.tags['guf-list-item'].shift());
					index = firstRenderedIndex - i - 1;
					// guf.console.log("index: ", index, currentIndex, i);
					renderItem(domNode._tag, index);
				}
			} else {
				// full new block
				topBlockHeight = currentIndex * rowHeight;
				tag.refs['top-block'].style.height = topBlockHeight + "px";
				bottomBlockHeight = totalHeight - (topBlockHeight + currentBlockHeight);
				tag.refs['bottom-block'].style.height = bottomBlockHeight + "px";
				var children = tag.refs['current-block'].children;
				var current, index;
				// guf.console.log("full recycleBottomRows with index: ", currentIndex);
				currentRenderedStartingIndex = currentIndex;
				for(var i = 0; i < maxVisibleRows; i++) {
					current = children[i]._tag;
					index = currentIndex + i;
					renderItem(current, index);
				}
			}
		}

		function renderItem(itemTag, index) {
			// guf.console.log("rendering item at index:", index);
			var item = getItemAtIndex(index, function(resultItem, startingIndex) {
				if((index >= startingIndex) && (index < (startingIndex + chunkSize))) {
					var children = tag.refs['current-block'].children;
					for(var i = 0; i < maxVisibleRows; i++) {
						var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
						var itemData = chunkData[itemIndex];
						if(typeof selectionModel !== "undefined") {
							var selected = selectionModel.isSelected(selectionModel.getId(itemData));
							var types = selectionModel.getSelectionTypes(selectionModel.getId(itemData));
							if(selected) {
								children[i]._tag.tags['guf-live-list-item'].select(types);
							} else {
								children[i]._tag.tags['guf-live-list-item'].deselect();
							}
						}
						children[i]._tag.tags['guf-live-list-item'].updateData(chunkData[currentRenderedStartingIndex + i - chunkStartingIndex]);
					}
				}
			});
			if(item) {
				// item available in chunk data
				if(typeof itemTag !== "undefined") {
					if(typeof selectionModel !== "undefined") {
						var selected = selectionModel.isSelected(selectionModel.getId(item));
						var types = selectionModel.getSelectionTypes(selectionModel.getId(item));
						if(selected) {
							itemTag.tags['guf-live-list-item'].select(types);
						} else {
							itemTag.tags['guf-live-list-item'].deselect();
						}
					}
					itemTag.tags['guf-live-list-item'].updateData(item);
				} else {
					guf.console.log("itemTag undefined");
				}
			} else {
				// item not available in chunk data
				if(typeof selectionModel !== "undefined") {
					itemTag.tags['guf-live-list-item'].deselect();
				}
				itemTag.tags['guf-live-list-item'].clearData();
			}
		}

		function calculateListHeight() {
			var result = 0;
			var styles = window.getComputedStyle(tag.refs["top-block"]);
			topBlockHeight = parseFloat(styles['height']);
			result += topBlockHeight;
			styles = window.getComputedStyle(tag.refs["current-block"]);
			currentBlockHeight = parseFloat(styles['height']);
			result += currentBlockHeight;
			styles = window.getComputedStyle(tag.refs["bottom-block"]);
			bottomBlockHeight = parseFloat(styles['height']);
			result += bottomBlockHeight;
			return result;
		}

		function getContainerHeight() {
			var styles = window.getComputedStyle(tag.root);
			return parseFloat(styles['height']);
		}

		function resizeHandler() {
			if(!listInitialized) {
				return;
			}
			resetList();
		}

		function initEvents() {
			if(guf.device.isIos) {
				tag.refs["wrapper"].addEventListener('touchstart', tapHandler);
				tag.refs["wrapper"].addEventListener('touchmove', dragHandler);
				tag.refs["wrapper"].addEventListener('touchend', releaseHandler);
				guf.on("orientation-changed", resizeHandler);
			} else {
				tag.refs["wrapper"].addEventListener("scroll", scrollHandler);
				window.addEventListener("resize", resizeHandler);
			}
		}

		// Relay item events

		function attachItemEvents() {
			var listItems = tag.tags["guf-list-item"];
			if (listItems) {
				for(var j = 0; j < listItems.length; j++) {
					var item = listItems[j].tags["guf-live-list-item"];
					tag.addRelayHandlers(item);
				}
			}
		}

		function removeItemEvents() {
			var listItems = tag.tags["guf-list-item"];
			if (listItems) {
				for(var j = 0; j < listItems.length; j++) {
					var item = listItems[j].tags["guf-live-list-item"];
					tag.removeRelayHandlers(item);
				}
			}
		}

		// Selection model event handlers

		function selectItemHandler(itemId, types) {
			var children = tag.refs['current-block'].children;
			for(var i = 0; i < maxVisibleRows; i++) {
				var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
				var itemData = chunkData[itemIndex];
				if(selectionModel.getId(itemData) === itemId) {
					children[i]._tag.tags['guf-live-list-item'].select(types);
					break;
				}
			}
		}

		function deselectItemHandler(itemId, types) {
			var children = tag.refs['current-block'].children;
			for(var i = 0; i < maxVisibleRows; i++) {
				var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
				var itemData = chunkData[itemIndex];
				if(selectionModel.getId(itemData) === itemId) {
					children[i]._tag.tags['guf-live-list-item'].deselect(types);
					break;
				}
			}
		}

		function clearSelectionHandler(types) {
			var children = tag.refs['current-block'].children;
			for(var i = 0; i < maxVisibleRows; i++) {
				var itemIndex = currentRenderedStartingIndex + i - chunkStartingIndex;
				var itemData = chunkData[itemIndex];
				children[i]._tag.tags['guf-live-list-item'].deselect(types);
			}
		}

		function scrollToTop() {
			if(!listInitialized) {
				return;
			}
			if(guf.device.isIos) {
				scroll(0);
			} else {
				tag.refs["wrapper"].scrollTop = 0;
				if (guf.device.normalizedName !== "firefox") {
					tag.refs["current-block"].style["webkitTransform"] = 'matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)';
				}
			}
		}

		function getItemTags() {
			var result = [];
			if (tag.tags["guf-list-item"]) {
				for (var i=0; i<tag.tags["guf-list-item"].length; i++) {
					result.push(tag.tags["guf-list-item"][i].tags["guf-live-list-item"].dynamicTag);
				}
			}
			return result;
		}

		tag.refresh = refreshList;
		tag.scrollToTop = scrollToTop;
		tag.getItemTags = getItemTags;

		tag.getScrollOffset = function() {
			return currentScrollOffset;
		};

		tag.scrollTo = function(offset) {
			if(guf.device.isIos) {
				scroll(offset);
			} else {
				tag.refs["wrapper"].scrollTop = offset;
				if (guf.device.normalizedName !== "firefox") {
					tag.refs["current-block"].style["webkitTransform"] = 'matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,' + offset + ',0,1)';
				}
			}
		};

		tag.getListHeight = function() {
			return totalHeight;
		};

		tag.on("mount", function() {
			initList();
			initEvents();
		});

		tag.on('update', function() {
			for (var i=0; i<tag.getItemTags().length; i++) {
				tag.getItemTags()[i].update();
			}
		});

		tag.on("before-unmount", function() {
			if(guf.device.isIos) {
				tag.refs["wrapper"].removeEventListener('touchstart', tapHandler);
				tag.refs["wrapper"].removeEventListener('touchmove', dragHandler);
				tag.refs["wrapper"].removeEventListener('touchend', releaseHandler);
				guf.off("orientation-changed", resizeHandler);
			} else {
				tag.refs["wrapper"].removeEventListener("scroll", scrollHandler);
				window.removeEventListener("resize", resizeHandler);
			}
			if(selectionModel instanceof GufSelectionModel) {
				selectionModel.off("select-item", selectItemHandler);
				selectionModel.off("deselect-item", deselectItemHandler);
				selectionModel.off("clear-selection", clearSelectionHandler);
			}
			removeItemEvents();
		});
	</script>
</guf-live-list>