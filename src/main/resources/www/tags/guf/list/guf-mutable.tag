<guf-mutable>
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
		var dynamicTagName = guf.param.string(opts.tagName, null);
		var data = opts.data;
		var index = opts.index;
		var currentDynamicTag = null;

		tag.mixin("relay-events");

		function createDynamicTag() {
			if(dynamicTagName) {
				if(currentDynamicTag) {
					currentDynamicTag.updateData(data, index);
				} else {
					var dom = document.createElement(dynamicTagName);
					tag.root.appendChild(dom);
					riot.compile(function() {
						currentDynamicTag = riot.mount(dom, dynamicTagName, {
							data: data,
							index: index
						})[0];
						tag.addRelayHandlers(currentDynamicTag);
						tag.dynamicTag = currentDynamicTag;
					});
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

		tag.on("mount", function() {
			createDynamicTag();
		});

		tag.on("unmount", function() {
			destroyDynamicTag();
		});

		tag.on("update", function() {
			if(dynamicTagName && currentDynamicTag) {
				currentDynamicTag.update();
			}
		});

		tag.getTag = function() {
			return currentDynamicTag;
		}

	</script>
</guf-mutable>