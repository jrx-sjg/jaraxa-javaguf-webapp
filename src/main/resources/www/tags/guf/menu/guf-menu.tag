<guf-menu>
	<ul ref="mdlmenu" for="{opts.buttonid}" class="mdl-menu {position} {mdl-js-menu-overflow: overflow, mdl-js-menu: !overflow}">
		<yield/>
	</ul>

	<style scoped type="dcss">
		.overflow-menu {
			max-height: 316px;
		}

		.overflow-menu .mdl-menu__outline {
			max-height: 316px;
		}

		.overflow-menu .mdl-menu {
			max-height: 300px;
			overflow-y: auto;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.overflow = guf.param.booleanExpr(opts, "overflow", false);
		
		switch(opts.position) {
			case "top-left": tag.position = "mdl-menu--top-left";
				break;
			case "top-right": tag.position = "mdl-menu--top-right";
				break;
			case "bottom-right": tag.position = "mdl-menu--bottom-right";
				break;
			case "bottom-left":
			default: tag.position = "mdl-menu--bottom-left";
				break;
		}

		tag.mdlClasses = {};

		tag.defaultDcss = {
		};
		tag.mixin("mdl");
		tag.mixin("after-mount")

		tag.on('after-mount', function() {
			if (tag.overflow) {
				tag.root.childNodes[0].classList.add('overflow-menu');
			}
		});

		tag.show = function() {
			tag.refs["mdlmenu"].MaterialMenu.show();
		};

		tag.hide = function() {
			tag.refs["mdlmenu"].MaterialMenu.hide();
		};

		tag.on('update', function() {
			tag.overflow = guf.param.boolean(opts.overflow, false);
		
			switch(opts.position) {
				case "top-left": tag.position = "mdl-menu--top-left";
					break;
				case "top-right": tag.position = "mdl-menu--top-right";
					break;
				case "bottom-right": tag.position = "mdl-menu--bottom-right";
					break;
				case "bottom-left":
				default: tag.position = "mdl-menu--bottom-left";
					break;
			}
			componentHandler.downgradeElements(tag.root);
			componentHandler.upgradeElement(tag.root);
		});

		/* The guf-menu and guf-button must to be between a div with position !static */
	</script>
</guf-menu>