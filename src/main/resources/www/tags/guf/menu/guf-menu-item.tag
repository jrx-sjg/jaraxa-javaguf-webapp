<guf-menu-item>
	<li ref="menu-item" class="{mdl-menu__item:1, mdl-menu__item--full-bleed-divider:full, mdl-menu__item-selected: !!selected}" disabled="{disabled}">
		<i if="{type=='icon' && icon}" class="material-icons">{icon}</i>
		<span class="{icon-space: type=='icon' && !icon}"><yield/></span>
	</li>

	<style scoped type="dcss">
		:scope i {
			vertical-align: middle;
			margin-right: 16px;
		}

		:scope .icon-space {
			margin-left: 44px;
		}

		:scope .mdl-menu__item-selected {
			background: #eeeeee;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		
		tag.name = opts.name;
		tag.full = opts.full;
		tag.disabled = opts.disabled;
		tag.type = opts.type;
		tag.icon = opts.icon;

		tag.mdlClasses = {};
		tag.defaultDcss = {};
		tag.relayEvents = ["menu-click"];
		tag.mixin("mdl");

		tag.on("mount", function() {
			tag.root.addEventListener("click", function(evt) {
				tag.trigger("menu-click", evt, tag);
			});
		});

		tag.setSelected = function(selected) {
			if (!!selected) {
				tag.refs["menu-item"].classList.add("mdl-menu__item-selected");
			} else {
				tag.refs["menu-item"].classList.remove("mdl-menu__item-selected");
			}
		}
	</script>
</guf-menu-item>