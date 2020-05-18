<guf-live-list-item>
	<style scoped type="text/css">
		:scope {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			min-width: 0;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var dynamicTagName = guf.param.string(opts.itemTag, null);
		var data = opts.data;
		var currentDynamicTag = null;

		tag.mixin("relay-events");

		function createDynamicTag() {
			if(dynamicTagName) {
				if(currentDynamicTag) {
					currentDynamicTag.updateData(data);
				} else {
					var dom = document.createElement(dynamicTagName);
					currentDynamicTag = guf.appendChildTag(tag, dom, {data:data});
					tag.dynamicTag = currentDynamicTag;
					tag.addRelayHandlers(currentDynamicTag);
				}
			}
		}

		function destroyDynamicTag() {
			if(dynamicTagName && currentDynamicTag) {
				tag.removeRelayHandlers(currentDynamicTag);
				currentDynamicTag.unmount();
				currentDynamicTag = null;
			}
		}

		tag.updateData = function(newData) {
			data = newData;
			createDynamicTag();
		};

		tag.clearData = function() {
			if(dynamicTagName && currentDynamicTag) {
				currentDynamicTag.clearData();
			}
		};

		tag.select = function(types) {
			if(dynamicTagName && currentDynamicTag) {
				currentDynamicTag.select(types);
			}
		};

		tag.deselect = function(types) {
			if(dynamicTagName && currentDynamicTag) {
				currentDynamicTag.deselect(types);
			}
		};

		tag.on("mount", function() {
			createDynamicTag();
		});

		tag.on("unmount", function() {
			destroyDynamicTag();
		});

	</script>
</guf-live-list-item>