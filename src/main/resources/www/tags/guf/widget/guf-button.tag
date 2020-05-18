<guf-button>
	<button class="mdl-button mdl-js-button" id="{ buttonId }" ref="button" title="{ toggled ? toggledTitle : title }" disabled="{disabled}">
		<i class="{material-icons: !iconOutlined, material-icons-outlined: iconOutlined} {opts.size}" if="{ opts.icon }">{ getIcon() }</i>
		<yield/>
	</button>
	<style scoped type="dcss">
		:scope .material-icons.md-18 {font-size: 18px;}
 		:scope .material-icons.md-24 {font-size: 24px;}
 		:scope .material-icons.md-36 {font-size: 36px;}
 		:scope .material-icons.md-48 {font-size: 48px;}

		:not(.mdl-button--icon):not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored,
		:not(.mdl-button--icon):not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored:hover,
		:not(.mdl-button--icon):not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored:active,
		:not(.mdl-button--icon):not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored:focus:not(:active) {
			color:@background;
			border: @border;
		}

		:not(.mdl-button--icon):not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored[disabled] {
			background-color:@backgroundDisabled;
			color:@textColorDisabled;
		}

		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored-accent,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored-accent:hover,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored-accent:active,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised):not(.mdl-button--outline).mdl-button--colored-accent:focus:not(:active) {
			color:@backgroundToggled;
			border: @borderToggled;
		}

		.mdl-button--outline {
			border: 1px solid;
			border-radius: 4px;
		}

		.mdl-button--outline.mdl-button--colored,
		.mdl-button--outline.mdl-button--colored:hover,
		.mdl-button--outline.mdl-button--colored:active,
		.mdl-button--outline.mdl-button--colored:focus:not(:active) {
			color:@background;
			border-color: @background;
		}

		.mdl-button--outline.mdl-button--colored-accent,
		.mdl-button--outline.mdl-button--colored-accent:hover,
		.mdl-button--outline.mdl-button--colored-accent:active,
		.mdl-button--outline.mdl-button--colored-accent:focus:not(:active) {
			color:@backgroundToggled;
			border-color: @backgroundToggled;
		}

		

		.color-flat.mdl-button--colored,
		.color-flat.mdl-button--colored:hover,
		.color-flat.mdl-button--colored:active,
		.color-flat.mdl-button--colored:focus:not(:active),
		.mdl-button--fab.mdl-button--colored,
		.mdl-button--fab.mdl-button--colored:hover,
		.mdl-button--fab.mdl-button--colored:active,
		.mdl-button--fab.mdl-button--colored:focus:not(:active),
 		.mdl-button--raised.mdl-button--colored,
		.mdl-button--raised.mdl-button--colored:hover,
		.mdl-button--raised.mdl-button--colored:active,
		.mdl-button--raised.mdl-button--colored:focus:not(:active) {
			background-color:@background;
			color: @textColor;
			border: @border;
		}

		.color-flat.mdl-button {
			height: @height;
		}

		.mdl-button--icon {
			height: @height;
			width: @height;
			min-width: @height;
		}

		.color-flat.mdl-button--colored-accent,
		.color-flat.mdl-button--colored-accent:hover,
		.color-flat.mdl-button--colored-accent:active,
		.color-flat.mdl-button--colored-accent:focus:not(:active),
		.mdl-button--fab.mdl-button--colored-accent,
		.mdl-button--fab.mdl-button--colored-accent:hover,
		.mdl-button--fab.mdl-button--colored-accent:active,
		.mdl-button--fab.mdl-button--colored-accent:focus:not(:active),
 		.mdl-button--raised.mdl-button--colored-accent,
		.mdl-button--raised.mdl-button--colored-accent:hover,
		.mdl-button--raised.mdl-button--colored-accent:active,
		.mdl-button--raised.mdl-button--colored-accent:focus:not(:active) {
			background-color:@backgroundToggled;
			color: @textColorToggled;
			border: @borderToggled;
		}

		.mdl-button--outline[disabled],
		.mdl-button--outline[disabled]:hover,
		.mdl-button--outline[disabled]:active,
		.mdl-button--outline[disabled]:focus:not(:active),
		.mdl-button--outline.mdl-button--colored-accent[disabled],
		.mdl-button--outline.mdl-button--colored-accent[disabled]:hover,
		.mdl-button--outline.mdl-button--colored-accent[disabled]:active,
		.mdl-button--outline.mdl-button--colored-accent[disabled]:focus:not(:active) {
			color: @textColorDisabled;
			border: 1px solid @textColorDisabled;
		}

		.color-flat.mdl-button--colored[disabled],
		.color-flat.mdl-button--colored[disabled]:hover,
		.color-flat.mdl-button--colored[disabled]:active,
		.color-flat.mdl-button--colored[disabled]:focus:not(:active),
		.mdl-button--fab.mdl-button--colored[disabled],
		.mdl-button--fab.mdl-button--colored[disabled]:hover,
		.mdl-button--fab.mdl-button--colored[disabled]:active,
		.mdl-button--fab.mdl-button--colored[disabled]:focus:not(:active),
		.mdl-button--raised.mdl-button--colored[disabled],
		.mdl-button--raised.mdl-button--colored[disabled]:hover,
		.mdl-button--raised.mdl-button--colored[disabled]:active,
		.mdl-button--raised.mdl-button--colored[disabled]:focus:not(:active),
		.color-flat.mdl-button--colored-accent[disabled],
		.color-flat.mdl-button--colored-accent[disabled]:hover,
		.color-flat.mdl-button--colored-accent[disabled]:active,
		.color-flat.mdl-button--colored-accent[disabled]:focus:not(:active),
		.mdl-button--fab.mdl-button--colored-accent[disabled],
		.mdl-button--fab.mdl-button--colored-accent[disabled]:hover,
		.mdl-button--fab.mdl-button--colored-accent[disabled]:active,
		.mdl-button--fab.mdl-button--colored-accent[disabled]:focus:not(:active),
		.mdl-button--raised.mdl-button--colored-accent[disabled],
		.mdl-button--raised.mdl-button--colored-accent[disabled]:hover,
		.mdl-button--raised.mdl-button--colored-accent[disabled]:active,
		.mdl-button--raised.mdl-button--colored-accent[disabled]:focus:not(:active) {
			background-color:@backgroundDisabled;
			color: @textColorDisabled;
			border: @borderDisabled;
		}

		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored[disabled],
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored[disabled]:hover,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored[disabled]:active,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored[disabled]:focus:not(:active) {
			color: @backgroundDisabled;
		}

		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored-accent[disabled],
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored-accent[disabled]:hover,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored-accent[disabled]:active,
		:not(.color-flat):not(.mdl-button--fab):not(.mdl-button--raised).mdl-button--colored-accent[disabled]:focus:not(:active) {
			color: @backgroundDisabled;
		}

		.mdl-button[disabled] .material-icons,
		.mdl-button[disabled] .material-icons-outlined {
			color: @textColorDisabled;
		}

		button.color-flat.toggled,
		button.color-flat.toggled:hover,
		button.color-flat.toggled:active,
		button.color-flat.toggled:focus:not(:active),
		button.mdl-button--fab.toggled,
		button.mdl-button--fab.toggled:hover,
		button.mdl-button--fab.toggled:active,
		button.mdl-button--fab.toggled:focus:not(:active),
 		button.mdl-button--raised.toggled,
		button.mdl-button--raised.toggled:hover,
		button.mdl-button--raised.toggled:active,
		button.mdl-button--raised.toggled:focus:not(:active) {
			background-color:@backgroundToggled;
			color: @textColorToggled;
			border: @borderToggled;
		}

		button.mdl-button--icon,
		button.mdl-button--icon:hover,
		button.mdl-button--icon:active,
		button.mdl-button--icon:focus:not(:active) {
			color: @textColor;
			border: @border;
		}
		button.mdl-button--icon.toggled,
		button.mdl-button--icon.toggled:hover,
		button.mdl-button--icon.toggled:active,
		button.mdl-button--icon.toggled:focus:not(:active) {
			color: @textColorToggled;
			border: @borderToggled;
		}

		body.guf-browser-firefox :scope > .mdl-button--fab .mdl-ripple.is-animating {
			transition: transform 0s cubic-bezier(0, 0, 0.2, 1)
		}

		button.mdl-button .material-icons-outlined {
			vertical-align: middle;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.buttonId = guf.param.string(opts.menuid, guf.getAutoId());
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.title = guf.param.string(opts.title, null);
		tag.toggledTitle = guf.param.string(opts.toggledTitle, tag.title);
		tag.icon = guf.param.string(opts.icon, null);
		tag.toggledIcon = guf.param.string(opts.toggledIcon, tag.icon);
		tag.toggled = guf.param.booleanExpr(opts, "toggled", false);
		tag.iconOutlined = guf.param.booleanExpr(opts, "iconOutlined", false);

		tag.mdlClasses = {
			"ripple" : {
				"true" : {
					"root": ["mdl-js-ripple-effect"]
				}
			},
			"color" : {
				"true" : {
					"root": ["mdl-button--colored"]
				},
				"accent" : {
					"root": ["mdl-button--colored-accent"]
				}
			},
			"type" : {
				"fab" : {
					"root": ["mdl-button--fab"]
				},
				"mini-fab": {
					"root": ["mdl-button--fab", "mdl-button--mini-fab"]
				},
				"color-flat": {
					"root": ["color-flat"]
				},
				"raised": {
					"root": ["mdl-button--raised"]
				},
				"outline": {
					"root": ["mdl-button--outline"]
				},
				"icon": {
					"root": ["mdl-button--icon"]
				}
			}
		};
		tag.defaultDcss = {
			"background": "@primary",
			"backgroundDisabled": "@disabled",
			"backgroundToggled": "@accent",
			"textColor": "@textPrimary",
			"textColorToggled": "@textAccent",
			"textColorDisabled": "@textDefault",
			"border": "none",
			"borderToggled": "none",
			"borderDisabled": "none",
			"height": "36px"
		};
		tag.mixin('mdl');

		tag.getIcon = function() {
			if (tag.toggled) {
				return tag.toggledIcon;
			} else {
				return tag.icon;
			}
		}

		function clickHandler(evt) {
			tag.trigger('click', evt, tag);
		}

		function focusHandler(evt) {
			tag.trigger('focus', evt, tag);
		}

		function blurHandler(evt) {
			tag.trigger('blur', evt, tag);
		}
		
		// Behaviour
		tag.on('mount', function() {
			if (opts.disabled) {
				tag.disable();
			}
			tag.refs["button"].addEventListener('click', clickHandler, false);
			tag.refs["button"].addEventListener('focus', focusHandler, false);
			tag.refs["button"].addEventListener('blur', blurHandler, false);
		});
		tag.on('before-unmount', function() {
			tag.refs["button"].removeEventListener('click', clickHandler, false);
			tag.refs["button"].removeEventListener('focus', focusHandler, false);
			tag.refs["button"].removeEventListener('blur', blurHandler, false);
		});
		tag.click = function() {
			tag.refs["button"].click();
		};
		tag.enable = function() {
			tag.disabled = false;
			tag.refs["button"].MaterialButton.enable();
			tag.update();
		};
		tag.disable = function() {
			tag.disabled = true;
			tag.refs["button"].MaterialButton.disable();
			tag.update();
		};
		tag.focus = function() {
			tag.refs["button"].focus();
		};
		tag.blur = function() {
			tag.refs["button"].blur();
		};
		tag.toggle = function() {
			tag.toggled = !tag.toggled;
			if (tag.toggled) {
				tag.refs["button"].classList.add("toggled");
			} else {
				tag.refs["button"].classList.remove("toggled");
			}
			tag.update();
		};
		tag.isToggled = function() {
			return tag.toggled;
		};
		tag.setToggle = function(status) {
			if (tag.toggled != status) {
				tag.toggle();
			}
		};
		tag.isHidden = function() {
			return tag.root.classList.contains("hidden");
		};
		tag.hide = function() {
			tag.root.classList.add("hidden");
		};
		tag.show = function() {
			tag.root.classList.remove("hidden");
		};
		tag.setText = function(value, append) {
			if (tag.icon != null && !append) {
				var index = (tag.refs["button"].childNodes[0].nodeType == Node.TEXT_NODE) ? 3 : 2;
				tag.refs["button"].childNodes[index].textContent = " " + value + " ";
			} else if (tag.icon != null) {
				var element = document.createTextNode(value);
				tag.refs["button"].appendChild(element);
			} else if (!!append) {
				tag.refs["button"].innerHTML = tag.refs["button"].innerHTML + " " + value;
			} else {
				tag.refs["button"].innerHTML = value;
			}	
		};
	</script>
</guf-button>