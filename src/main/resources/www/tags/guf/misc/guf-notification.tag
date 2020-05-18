<guf-notification>
	<guf-mutable tag-name="{itemTag}"></guf-mutable>
	<style type="text/css">
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
			align-items: center;
			position: absolute;
			left: 0;
			right: 0;
			z-index: 100;
			transform: translate(0, -100%);
			transition: -webkit-transform 0.25s cubic-bezier(0, 0, 0.2, 1);
			transition: transform 0.25s cubic-bezier(0, 0, 0.2, 1);
			transition: transform 0.25s cubic-bezier(0, 0, 0.2, 1), -webkit-transform 0.25s cubic-bezier(0, 0, 0.2, 1);
		}
		:scope.show {
			transform: translate(0,0);
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.itemTag = guf.param.string(opts.itemTag);
		var currentNotification = null;
		var notificationTimeout = 5000;

		function clickHandler() {
			if(currentNotification) {
				guf.clearTimeout(currentNotification);
				tag.root.classList.remove("show");
				currentNotification = null;
			}
			tag.trigger("click", tag, tag.tags["guf-mutable"].getTag().getCurrentNotification());
		}

		function initEvents() {
			tag.root.addEventListener("click", clickHandler);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", clickHandler);
		}

		tag.show = function(notification) {
			if(currentNotification) {
				guf.clearTimeout(currentNotification);
			}
			tag.tags["guf-mutable"].getTag().updateData(notification);
			tag.root.classList.add("show");
			currentNotification = guf.setTimeout(function() {
				tag.root.classList.remove("show");
				currentNotification = null;
			}, notificationTimeout);
		};

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</guf-notification>