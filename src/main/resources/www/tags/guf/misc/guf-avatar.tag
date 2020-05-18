<guf-avatar>
	<div class="avatar">
		<guf-image ref="image" if={hasAvatar} class="size{opts.size}" imagesrc={imagesrc}></guf-image>
		<div if={!hasAvatar} class="avatar-text size{opts.size}">
			<div class="avatar-letter">{letter}</div>
		</div>
	</div>

	<style scoped type="dcss">

		.size img, .size { width: 64px;	height: 64px; }
		.size128 img, .size128 { width: 128px; height: 128px; }
		.size96 img, .size96 { width: 96px; height: 96px; }
		.size48 img, .size48 { width: 48px; height: 48px; }
		.size32 img, .size32 { width: 32px; height: 32px; }
		.size24 img, .size24 { width: 24px; height: 24px; }

		:scope .avatar {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: flex;
			align-items: center;
		}
		
		:scope .avatar .avatar-text {
			background-color: @avatarBackground;
			text-align: center;
			text-transform: uppercase;
			color: white;
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			align-items: center;
		    -webkit-box-pack: center;
		    -webkit-justify-content: center;
		    -ms-flex-pack: center;
			justify-content: center;
		}

		:scope .avatar .avatar-text .avatar-letter {
			font-size: 16px;
		}

		:scope .guf-avatar--circle img,
		:scope .guf-avatar--circle .avatar-text {
			border-radius: 50%;
		}

		:scope .guf-avatar--rounded img,
		:scope .guf-avatar--rounded .avatar-text {
			border-radius: 10px;
		}


	</style>
	<script type="text/javascript">
		var tag = this;
		
		tag.imagesrc = guf.param.string(opts.imagesrc, null);
		tag.hasAvatar = tag.imagesrc != null;
		tag.letter = guf.param.string(opts.letter, "");

		tag.mdlClasses = {
			"type" : {
				"circle" : {
					"root": ["guf-avatar--circle"]
				},
				"rounded": {
					"root": ["guf-avatar--rounded"]
				},
				"square": {
					"root": ["guf-avatar--square"]
				}
			}
		};
		tag.defaultDcss = {
			"avatarBackground": "@accent"
		};
		tag.mixin("mdl", "after-mount");

		tag.on("after-mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			if (tag.hasAvatar) {
				tag.refs.image.on("image-load", imageLoad);
				tag.refs.image.on("image-error", imageError);
			}
		});

		tag.on("update", function() {
			tag.imagesrc = guf.param.string(opts.imagesrc, null);
			tag.hasAvatar = tag.imagesrc != null;
			tag.letter = guf.param.string(opts.letter, "");
		});

		tag.setImage = function(src) {
			if (src) {
				tag.imagesrc = src;
				if (tag.hasAvatar) {
					tag.refs["image"].setImage(src);
				}
				tag.hasAvatar = true;
			} else {
				tag.imagesrc = null;
				tag.hasAvatar = false;
			}
			tag.update();
		};

		tag.setLetter = function(letter) {
			tag.hasAvatar = false;
			tag.letter = letter;
			tag.update();
		};
		
		function initEvents() {
			if (tag.hasAvatar) {
				tag.refs.image.on("image-load", imageLoad);
				tag.refs.image.on("image-error", imageError);
			}
		}

		function imageLoad(imageTag) {
			tag.trigger("image-load", imageTag, tag);
		}

		function imageError(imageTag) {
			tag.trigger("image-error", imageTag, tag);
		}
	</script>
</guf-avatar>