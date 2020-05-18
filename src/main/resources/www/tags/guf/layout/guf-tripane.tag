<guf-tripane>
	<guf-frame-layout>
		<guf-linear-layout orientation="horizontal" ref="container" class="{leftfixed:parent.leftColumnFlexFixed, alwaysnarrow: parent.alwaysNarrow}">
			<div ref="left"><yield from="left"/></div>
			<div ref="middle"><yield from="middle"/></div>
			<div ref="middle-obfuscate" class="hidden"></div>
			<div ref="right"><yield from="right"/></div>
			<div ref="right-obfuscate" class="hidden"></div>
		</guf-linear-layout>
		<guf-linear-layout orientation="horizontal" ref="popupcontainer" class="{leftfixed:parent.leftColumnFlexFixed}">
			<div ref="left" class="{alwayshidden:!parent.parent.leftColumnVisibleForPopup}">&nbsp;</div>
			<div ref="popup" class="hidden"><yield from="popup"/></div>
		</guf-linear-layout>
	</guf-frame-layout>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			min-width: 0;
		}

		:scope > guf-frame-layout {
			-webkit-flex:1;
			-ms-flex:1;
			flex: 1;
		}

		:scope > guf-frame-layout > [ref="popupcontainer"] > [ref="popup"] {
			-webkit-flex:1;
			-ms-flex:1;
			flex:1;
			min-width: 0;
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
		}

		:scope > guf-frame-layout > [ref="popupcontainer"],
		:scope > guf-frame-layout > [ref="popupcontainer"] > [ref="popup"] {
			pointer-events: none;
		}

		:scope.popup > guf-frame-layout > [ref="popupcontainer"] > [ref="popup"] {
			pointer-events: auto;
		}

		:scope > guf-frame-layout > guf-linear-layout[ref="popupcontainer"] > div[ref="left"].alwayshidden {
			-webkit-flex:0;
			-ms-flex:0;
			flex:0;
			width:0;
			display:none;
		}

		:scope > guf-frame-layout > guf-linear-layout[ref="popupcontainer"].fullsize > div[ref="left"] {
			-webkit-flex:0;
			-ms-flex:0;
			flex:0;
			width:0;
			display:none;
		}

		:scope > guf-frame-layout > guf-linear-layout {
			-webkit-flex:1;
			-ms-flex:1;
			flex:1;
			min-width: 0;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
			z-index: 1;
		}

		:scope > guf-frame-layout > guf-linear-layout > [ref="left"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="middle"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="middle-obfuscate"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="right"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="right-obfuscate"] {
			background-color: transparent;
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			scroll-behavior: smooth;
		}
		
		:scope > guf-frame-layout > guf-linear-layout.hidden {
			display: none;
		}

		:scope > guf-frame-layout > guf-linear-layout.fullscreen {
			position: fixed;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
		}

		:scope > guf-frame-layout > guf-linear-layout > [ref="left"] {
			-webkit-flex:@leftColumnFlex;
			-ms-flex:@leftColumnFlex;
			flex:@leftColumnFlex;
			overflow:auto;
			min-width: @leftMinWidth;
		}

		:scope > guf-frame-layout > guf-linear-layout > [ref="middle"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="middle-obfuscate"],
		:scope > guf-frame-layout > [ref="popupcontainer"] > [ref="popup"] {
			-webkit-flex:@middleColumnFlex;
			-ms-flex:@middleColumnFlex;
			flex:@middleColumnFlex;
			overflow:auto;
		}

		:scope.leftSp > guf-frame-layout > guf-linear-layout.leftfixed > [ref="middle"],
		:scope.leftSp > guf-frame-layout > guf-linear-layout.leftfixed > [ref="middle-obfuscate"],
		:scope.middleSp > guf-frame-layout > guf-linear-layout.leftfixed > [ref="middle"],
		:scope.middleSp > guf-frame-layout > guf-linear-layout.leftfixed > [ref="middle-obfuscate"],
		:scope > guf-frame-layout > [ref="popupcontainer"].leftfixed > [ref="popup"],
		:scope.rightSp > guf-frame-layout > [ref="popupcontainer"] > [ref="popup"] {
			-webkit-flex:@middleNoRightColumnFlex;
			-ms-flex:@middleNoRightColumnFlex;
			flex:@middleNoRightColumnFlex;
			overflow:auto;
		}

		:scope > guf-frame-layout > guf-linear-layout > [ref="right"],
		:scope > guf-frame-layout > guf-linear-layout > [ref="right-obfuscate"] {
			-webkit-flex:@rightColumnFlex;
			-ms-flex:@rightColumnFlex;
			flex:@rightColumnFlex;
			overflow:auto;
		}

		body.guf-screen-narrow :scope > guf-frame-layout > guf-linear-layout > .spHidden,
		body.guf-screen-wide :scope > guf-frame-layout > guf-linear-layout.alwaysnarrow > .spHidden {
			-webkit-flex:0;
			-ms-flex:0;
			flex:0;
			width:0;
			display:none;
		}

		body.guf-screen-wide :scope > guf-frame-layout > guf-linear-layout > [ref="right"].spHidden,
		body.guf-screen-wide :scope > guf-frame-layout > guf-linear-layout > [ref="right-obfuscate"].spHidden {
			-webkit-flex:0;
			-ms-flex:0;
			flex:0;
			width:0;
			display:none;
		}
	</style>
	<script>
		var tag = this;
		var currentStack = [0];
		var contents = {
			left: null,
			middle: null,
			right: null,
			popup: null
		};
		tag.LEFT_COLUMN = "left";
		tag.MIDDLE_COLUMN = "middle";
		tag.RIGHT_COLUMN = "right";
		tag.POPUP_COLUMN = "popup";
		tag.alwaysNarrow = guf.param.booleanExpr(opts, "alwaysNarrow", false);
		tag.leftColumnFlexFixed = guf.param.booleanExpr(opts, "leftColumnFlexFixed", false);
		tag.leftColumnVisibleForPopup = guf.param.booleanExpr(opts, "leftColumnVisibleForPopup", false);
		tag.state = {
			left: true,
			middle: true,
			right: false,
			popup: false,
			leftSp: true,
			middleSp: false,
			rightSp: false
		};
		var columns = [tag.LEFT_COLUMN, tag.MIDDLE_COLUMN, tag.RIGHT_COLUMN];

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"leftColumnFlex": "1",
			"middleColumnFlex": "3",
			"rightColumnFlex": "1",
			"middleNoRightColumnFlex": "4",
			"leftMinWidth": "unset"
		};
		tag.mixin('mdl');

		function middleColumnScrollHandler(evt) {
			guf.trigger("scroll", "middle", tag.tags["guf-frame-layout"].refs["container"].refs["middle"].scrollTop, tag.tags["guf-frame-layout"].refs["container"].refs["middle"].scrollLeft, evt);
		}

		tag.on('mount', function(){
			tag.updateState();
			var middleColumn = tag.tags["guf-frame-layout"].refs["container"].refs["middle"];
			middleColumn.addEventListener("scroll", middleColumnScrollHandler);
		});

		tag.on('before-unmount', function() {
			var middleColumn = tag.tags["guf-frame-layout"].refs["container"].refs["middle"];
			middleColumn.removeEventListener("scroll", middleColumnScrollHandler);
			for(var i in contents) {
				var content = contents[i];
				if(content) {
					content.unmount();
					contents[i] = null;
				}
			}
		});

		tag.updateState = function() {
			for (var prop in tag.state) {
				if (tag.state[prop]) {
					tag.root.classList.add(prop);
				} else {
					tag.root.classList.remove(prop);
				}
			}
		}

		tag.showColumn = function(column, hideOthers, isOpaque) {
			var container = tag.tags["guf-frame-layout"].refs["container"].refs;
			var popupcontainer = tag.tags["guf-frame-layout"].refs["popupcontainer"].refs;
			if (column == tag.POPUP_COLUMN) {
				tag.state.popup = true;
				if(guf.device.isIos && isOpaque) {
					if(tag.leftColumnVisibleForPopup) {
						container[tag.MIDDLE_COLUMN].classList.add("hidden");
						container["middle-obfuscate"].classList.remove("hidden");
						if(container[tag.RIGHT_COLUMN].classList.contains("spVisible")) {
							container[tag.RIGHT_COLUMN].classList.add("hidden");
							container["right-obfuscate"].classList.remove("hidden");
						}
					} else {
						tag.tags["guf-frame-layout"].refs["container"].root.classList.add("hidden");
					}
				}
				popupcontainer[tag.POPUP_COLUMN].classList.remove("hidden");
				popupcontainer[tag.LEFT_COLUMN].classList.add("spHidden");
				popupcontainer[tag.LEFT_COLUMN].classList.remove("spVisible");
				if (container[tag.LEFT_COLUMN].classList.contains("hidden")) {
					popupcontainer[tag.LEFT_COLUMN].classList.add("hidden");
				} else {
					popupcontainer[tag.LEFT_COLUMN].classList.remove("hidden");
				}
				tag.updateState();
				return;
			} else {
				tag.state.popup = false;

				if(guf.device.isIos) {
					if(tag.leftColumnVisibleForPopup) {
						container[tag.MIDDLE_COLUMN].classList.remove("hidden");
						container["middle-obfuscate"].classList.add("hidden");
						container[tag.RIGHT_COLUMN].classList.remove("hidden");
						container["right-obfuscate"].classList.add("hidden");
					} else {
						tag.tags["guf-frame-layout"].refs["container"].root.classList.remove("hidden");
					}
				}
				popupcontainer[tag.POPUP_COLUMN].classList.add("hidden");
				if (container[tag.LEFT_COLUMN].classList.contains("spHidden")) {
					popupcontainer[tag.LEFT_COLUMN].classList.add("spHidden");
					popupcontainer[tag.LEFT_COLUMN].classList.remove("spVisible");
				} else {
					popupcontainer[tag.LEFT_COLUMN].classList.remove("spHidden");
					popupcontainer[tag.LEFT_COLUMN].classList.add("spVisible");					
				}				
			}
			for(var j in columns) {
				var i = columns[j];
				if(i == column) {
					tag.state[i] = true;
					tag.state[i + "Sp"] = true;

					tag.tags["guf-frame-layout"].refs["container"].root.setAttribute("spColumn", column);
					container[i].classList.remove("hidden");
					container[i].classList.remove("spHidden");
					container[i].classList.add("spVisible");
					if (j == tag.LEFT_COLUMN) {
						popupcontainer[tag.LEFT_COLUMN].classList.remove("spHidden");
						popupcontainer[tag.LEFT_COLUMN].classList.add("spVisible");
					} else if (j == tag.RIGHT_COLUMN) {
						popupcontainer[tag.POPUP_COLUMN].classList.add("rightopen");
					}
				} else {
					tag.state[i + "Sp"] = false;
					if (hideOthers) {
						tag.state[i] = false;
					}

					container[i].classList.remove("spVisible");
					container[i].classList.add("spHidden");
					if (j == tag.LEFT_COLUMN) {
						popupcontainer[tag.LEFT_COLUMN].classList.remove("spVisible");
						popupcontainer[tag.LEFT_COLUMN].classList.add("spHidden");
					} else
					if (hideOthers) {
 						if (j == tag.RIGHT_COLUMN) {
							popupcontainer[tag.POPUP_COLUMN].classList.remove("rightopen");
						}						
						container[i].classList.add("hidden");
						if (contents[i] != null) {
							contents[i].unmount();
						}
					} else {
						container[i].classList.remove("hidden");
					}
				}
			}
			tag.updateState();
		};

		tag.hideColumn = function(column) {
			tag.state[column] = false;
			if (column != "popup") {
				tag.state[column + "Sp"] = false;
				if (column == "right") {
					if (tag.state["middle"]) {
						tag.state["middleSp"] = true;
					} else {
						tag.state["leftSp"] = true;
					}
				} else if (column == "middle") {
					if (tag.state["left"]) {
						tag.state["leftSp"] = true;
					}
					tag.state["middle"] = true;
				}
			} else {
				if(guf.device.isIos) {
					if(tag.leftColumnVisibleForPopup) {
						var container = tag.tags["guf-frame-layout"].refs["container"].refs;
						container[tag.MIDDLE_COLUMN].classList.remove("hidden");
						container["middle-obfuscate"].classList.add("hidden");
						container[tag.RIGHT_COLUMN].classList.remove("hidden");
						container["right-obfuscate"].classList.add("hidden");
					} else {
						tag.tags["guf-frame-layout"].refs["container"].root.classList.remove("hidden");
					}
				}
			}
			tag.updateState();

			if (column == tag.POPUP_COLUMN) {
				tag.tags["guf-frame-layout"].refs["popupcontainer"].root.classList.remove("fullsize");
				tag.tags["guf-frame-layout"].refs["popupcontainer"].refs[tag.POPUP_COLUMN].classList.add("hidden");
            } else {
                tag.tags["guf-frame-layout"].refs["container"].refs[column].classList.add("hidden");
			}
		}

		tag.setFullscreenColumn = function(column, fullscreen) {
			if(fullscreen) {
				var container = tag.tags["guf-frame-layout"].refs["container"];
				for(var j in columns) {
					var i = columns[j];
					if(i == column) {
						container[i].classList.add("fullscreen");
					} else {
						container[i].classList.add("hidden");
					}
				}
			} else {
				var container = tag.tags["guf-frame-layout"].refs["container"];
				for(var j in columns) {
					var i = columns[j];
					if(i == column) {
						container[i].classList.remove("fullscreen");
					} else {
						container[i].classList.remove("hidden");
					}
				}
			}
		};

		tag.setLeftColumnContent = function(dom, options, configFn) {
			var content = contents.left;
			if (content) {
				tag.hideColumn("left");
				content.unmount();
				contents.left = null;
			}
			if (dom) {
				var column = tag.tags["guf-frame-layout"].refs["container"].refs["left"];
				column.appendChild(dom);
				riot.compile(function() {
					contents.left = riot.mount(dom, options)[0];
					tag.showColumn("left");
					configFn.apply(contents.left, [contents.left]);
				});
			}
		};

		tag.setMiddleColumnContent = function(dom, options, configFn, forceShow) {
			tag.setRightColumnContent();
			var content = contents.middle;
			if (content) {
				tag.hideColumn("middle");
				content.unmount();
				contents.middle = null;
			}
			if (dom) {
				var column = tag.tags["guf-frame-layout"].refs["container"].refs["middle"];
				column.appendChild(dom);
				riot.compile(function() {
					contents.middle = riot.mount(dom, options)[0];
					if (forceShow || guf.device.screen.wide) {
						tag.showColumn("middle");
					}
					configFn.apply(contents.middle, [contents.middle]);
				});
			}
		};

		tag.setRightColumnContent = function(dom, options, configFn) {
			var content = contents.right;
			if (content) {
				tag.hideColumn("right");
				content.unmount();
				contents.right = null;
			}
			if (dom) {
				var column = tag.tags["guf-frame-layout"].refs["container"].refs["right"];
				column.appendChild(dom);
				riot.compile(function() {
					contents.right = riot.mount(dom, options)[0];
					tag.showColumn("right");
					configFn.apply(contents.right, [contents.right]);
				});
			}
		};

		tag.setPopupColumnContent = function(dom, options, configFn, fullsize, isOpaque) {
			var previousFullsize = tag.tags["guf-frame-layout"].refs["popupcontainer"].root.classList.contains("fullsize");
			var content = contents.popup;
			if (content) {
				tag.hideColumn("popup");
				content.unmount();
				contents.popup = null;
			}
			if (dom) {
				var column = tag.tags["guf-frame-layout"].refs["popupcontainer"].refs[tag.POPUP_COLUMN];
				column.appendChild(dom);
				if(fullsize || previousFullsize) {
					tag.tags["guf-frame-layout"].refs["popupcontainer"].root.classList.add("fullsize");
				}
				riot.compile(function() {
					contents.popup = riot.mount(dom, options)[0];
					tag.showColumn(tag.POPUP_COLUMN, false, isOpaque);
					configFn.apply(contents.popup, [contents.popup]);
				});
			} else {
				if(previousFullsize) {
					tag.tags["guf-frame-layout"].refs["popupcontainer"].root.classList.remove("fullsize");
				}
				tag.tags["guf-frame-layout"].refs["popupcontainer"].refs[tag.POPUP_COLUMN].classList.add("hidden");
			}
		};

		tag.getLeftColumnContent = function() {
			return contents.left;
		};

		tag.getMiddleColumnContent = function() {
			return contents.middle;
		};

		tag.getRightColumnContent = function() {
			return contents.right;
		};

		tag.getPopupColumnContent = function() {
			return contents.popup;
		};

		tag.isRightColumnVisible = function() {
			return tag.state.rightSp;
		};

		tag.scrollColumn = function(column, offset) {
			tag.tags["guf-frame-layout"].refs["container"].refs[column].scrollTop = offset;
		};

		var pendingScrollDelta = 0;
		var applyPendingScrollDeltaTimeout = null;

		function applyPendingScrollDelta(column) {
			tag.tags["guf-frame-layout"].refs["container"].refs[column].scrollTop += pendingScrollDelta;
			pendingScrollDelta = 0;
			applyPendingScrollDeltaTimeout = null;
		}

		tag.scrollDeltaColumn = function(column, delta) {
			if (applyPendingScrollDeltaTimeout == null) {
				pendingScrollDelta = 0;
			} else {
				guf.clearTimeout(applyPendingScrollDeltaTimeout);
			}
			pendingScrollDelta += delta;
			applyPendingScrollDeltaTimeout = guf.setTimeout(applyPendingScrollDelta.bind(this, column),100);
		};
	</script>
</guf-tripane>