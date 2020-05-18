<guf-radio>
	<label ref="radiolabel" class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="{inputId}">
		<input ref="input" checked="{checked}" disabled="{disabled}" type="radio" id="{inputId}" class="mdl-radio__button" name="{opts.name}" value="{opts.value}">
	  	<span class="mdl-radio__label {label-disabled: disabled}"><yield/></span>
	</label>
	<style scoped type="dcss">
		:scope > label > .mdl-radio__ripple-container > .mdl-ripple {
			background: @backgroundRipple;
		}
		:scope > .mdl-radio.is-checked > .mdl-radio__outer-circle {
			border-color: @backgroundColor;
		}
		:scope > .mdl-radio > .mdl-radio__inner-circle {
			background: @backgroundColor;
		}
		:scope > .mdl-radio > .mdl-radio__label {
			color: @textColor;
			font-size: @fontSize;
		}
		:scope > .mdl-radio > .mdl-radio__label.label-disabled {
			color: @disabledTextColor;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.checked = guf.param.booleanExpr(opts, "checked", false);
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.inputId = guf.getAutoId();
		
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"backgroundRipple": "@primary",
			"backgroundColor": "@primary",
			"textColor": "@primary",
			"fontSize": "16px",
			"disabledTextColor": "rgba(0,0,0, 0.26)"
		};
		tag.mixin('mdl');

		// Behaviour
		tag.on("mount", function() {
			tag.root.addEventListener("click", radioClickListener);
		});

		tag.on("before-unmount", function() {
			tag.root.removeEventListener("click", radioClickListener);
		});
		
		tag.disable = function() {
			tag.refs["radiolabel"].MaterialRadio.disable();
		}

		tag.enable = function() {
			tag.refs["radiolabel"].MaterialRadio.enable();
		}

		tag.isToggled = function() {
			return tag.refs["input"].checked;
		}
		
		tag.setToggle = function(status) {
			if (status) {
				tag.refs["radiolabel"].MaterialRadio.check();
			} else {
				tag.refs["radiolabel"].MaterialRadio.uncheck();
			}
		}

		tag.hide = function() {
			tag.root.classList.add("hidden");
		}
		tag.show = function() {
			tag.root.classList.remove("hidden");
		}

		// Private
		function radioClickListener(evt) {
			evt.stopPropagation();
			if (evt.target == tag.refs["input"]) {
				tag.trigger("radio-click", tag);
			}
		}
	</script>
</guf-radio>