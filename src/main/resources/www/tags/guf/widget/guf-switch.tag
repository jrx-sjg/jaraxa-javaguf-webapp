<guf-switch>
	<label ref="switch" class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="{inputId}">
    	<input type="checkbox" ref="input" id="{inputId}" class="mdl-switch__input" disabled="{disabled}" checked="{checked}">
      	<span class="mdl-switch__label"><yield/></span>
    </label>

	<style scoped type="dcss">
		
		:scope label .mdl-switch__ripple-container .mdl-ripple {
			background: @backgroundRipple;
		}

		:scope .mdl-switch.mdl-switch-mono .mdl-switch__thumb {
			background: @backgroundColor;
		}

		:scope .mdl-switch.mdl-switch-mono .mdl-switch__track {
			background: @backgroundColor;
			opacity: 0.5;
		}
		:scope .mdl-switch.is-checked .mdl-switch__thumb,
		:scope .mdl-switch.keep-color .mdl-switch__thumb {
			background: @backgroundColor;
		}

		:scope .mdl-switch.is-checked .mdl-switch__track,
		:scope .mdl-switch.keep-color .mdl-switch__track {
			background: @backgroundColor;
			opacity: 0.5;
		}

		:scope .mdl-switch.is-disabled .mdl-switch__thumb {
			background: #ccc;
		}

		:scope .mdl-switch.is-disabled .mdl-switch__track {
			background: @disabled;
			opacity: 1;
		}
		
		.hidden {
			display: none;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.checked = guf.param.booleanExpr(opts, "checked", false);
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.inputId = guf.getAutoId();
		tag.keepColor = guf.param.booleanExpr(opts, "keepColor", false);
		
		tag.mdlClasses = {
			"type" : {
				"mono-color" : {
					"root": ["mdl-switch-mono"]
				}
			}
		};
		tag.defaultDcss = {
			"backgroundRipple": "@primary",
			"backgroundColor": "@primary",
			"disabled": "@disabled"
		};
		tag.mixin('mdl');

		// Behaviour
		tag.on("mount", function() {
			tag.root.addEventListener("click", switchClickListener);
			if (tag.keepColor) {
				tag.refs.switch.classList.add("keep-color")
			}
		});

		tag.on("unmount", function() {
			tag.root.removeEventListener("click", switchClickListener);
		});
		
		tag.disable = function() {
			tag.disabled = true;
			tag.refs.switch.MaterialSwitch.disable();
		}

		tag.enable = function() {
			tag.disabled = false;
			tag.refs.switch.MaterialSwitch.enable();
		}

		tag.isToggled = function() {
			return tag.refs.switch.MaterialSwitch.inputElement_.checked;
		}
		
		tag.setToggle = function(status) {
			if (status) {
				tag.refs.switch.MaterialSwitch.on();
			} else {
				tag.refs.switch.MaterialSwitch.off();
			}
			if (tag.keepColor) {
				tag.refs.switch.classList.add("keep-color")
			}
		}

		tag.hide = function() {
			tag.root.classList.add("hidden");
		}

		tag.show = function() {
			tag.root.classList.remove("hidden");
		}

		// Private
		function switchClickListener(evt) {
			evt.stopPropagation();
			guf.setTimeout(function() {
				if(evt.target == tag.refs.input) {
					tag.trigger("switch-click", tag);
					if (tag.keepColor) {
						tag.refs.switch.classList.add("keep-color")
					}
				}
			}, 1);
		}
	</script>
</guf-switch>