<guf-image>
	<img ref="img" src="{currentsrc}" width="{opts.width}" height="{opts.height}"/>
	<style scoped type="dcss">

		:scope > img {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}

	</style>
	<script type="text/javascript">
		var tag = this;
		var imageSet = false;
		
		tag.imagesrc = guf.param.string(opts.imagesrc, "");
		tag.errorsrc = guf.param.string(opts.errorsrc, null);
		tag.loadingsrc = guf.param.string(opts.loadingsrc, null);
		tag.currentsrc = tag.loadingsrc ? tag.loadingsrc : tag.imagesrc;
		
		tag.mdlClasses = {};
		tag.defaultDcss = {};
		tag.mixin("mdl");

		var loadedOrError = false;

		function setActiveImage(src) {
			imageSet = true;
			tag.currentsrc = src;
			tag.update();
		}
		
		tag.on('mount', function() {
			var image = tag.refs["img"];
			if (tag.loadingsrc) {
				image = new Image();
				image.src = tag.imagesrc;
			}
			image.onload = function() {
				tag.trigger("image-load", tag);
				if (tag.loadingsrc) {
					setActiveImage(tag.imagesrc);
				}
			};
			image.onerror = function() {
				tag.trigger("image-error", tag);
				if (tag.errorsrc) {
					setActiveImage(tag.errorsrc);
				} else {
					setActiveImage("");
				}
			};
			tag.refs["img"].onclick = function(event) {
				tag.trigger("click", tag, event);
			};
		});

		tag.on("update", function() {
			if (!imageSet) {
				tag.imagesrc = guf.param.string(opts.imagesrc, "");
			}
		});

		tag.setImage = function(src) {
			if (tag.imagesrc !== src) {
				tag.imagesrc = src;
				if (tag.loadingsrc) {
					setActiveImage(tag.loadingsrc);
				}
				var image = new Image();
				image.src = tag.imagesrc;
				image.onload = function() {
					setActiveImage(tag.imagesrc);
				};
				image.onerror = function() {
					if (tag.errorsrc) {
						setActiveImage(tag.errorsrc);
					} else {
						setActiveImage("");
					}
				};
			}
		};
		
	</script>
</guf-image>