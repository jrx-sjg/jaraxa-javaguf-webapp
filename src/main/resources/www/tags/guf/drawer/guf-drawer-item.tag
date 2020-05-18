<guf-drawer-item>
	<div ref="item-link" class="mdl-navigation__link">
		<i if={opts.icon} class="material-icons">{opts.icon}</i>
		<yield />
	</div>
	<style scoped type="dcss">
		:scope {
			cursor: pointer;
		}

		.mdl-layout__drawer .mdl-navigation :scope > .mdl-navigation__link {
			display: -webkit-flex;
		    display: -ms-flexbox;
		    display: flex;
			padding: 16px 16px;
			color: @textColor;
		}

		.mdl-layout__drawer .mdl-navigation :scope:hover > .mdl-navigation__link {
			color: @textColorHover;
		}

		.mdl-layout__drawer .mdl-navigation :scope > .mdl-navigation__link > .material-icons {
			margin-right: 26px;
		}

		.mdl-layout__drawer .mdl-navigation :scope:hover > .mdl-navigation__link > .material-icons {
			color: @textColorHover;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.on("mount", function() {
			initEvents();
		});
		
		tag.on("before-unmount", function() {
			release();
		});
		tag.defaultDcss = {
			"textColor": "@textPrimary",
			"textColorHover": "@primary"
		};
		tag.mixin('mdl');
		
		function initEvents() {
			tag.refs['item-link'].addEventListener("click", itemClickHandler);
		}
		
		function release() {
			tag.refs['item-link'].removeEventListener("click", itemClickHandler);
		}
		
		function itemClickHandler(event) {
			event.stopPropagation();
			tag.trigger("click", tag);
		}
	</script>
</guf-drawer-item>