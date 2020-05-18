<guf-checkbox>
	<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect selection-checkbox" for="{ inputId }">
		<input type="checkbox" id="{ inputId }" ref="input" class="mdl-checkbox__input" disabled="{ disabled }" checked="{ checked }">
		<span class="mdl-checkbox__label"><yield/></span>
	</label>
	<style scoped type="dcss">
		:scope {
			display: block;
		}

		.mdl-checkbox.is-checked .mdl-checkbox__box-outline {
			border-color: @background;
		}

		.mdl-checkbox.is-focused.is-checked .mdl-checkbox__focus-helper {
			box-shadow: 0 0 0px 8px rgba(128,128,128,0.26);
			background-color: rgba(128,128,128,0.26);
		}

		.mdl-checkbox.is-checked .mdl-checkbox__tick-outline {
			background: @background url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjxzdmcKICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIgogICB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiCiAgIHhtbG5zOnN2Zz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgdmVyc2lvbj0iMS4xIgogICB2aWV3Qm94PSIwIDAgMSAxIgogICBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWluWU1pbiBtZWV0Ij4KICA8cGF0aAogICAgIGQ9Ik0gMC4wNDAzODA1OSwwLjYyNjc3NjcgMC4xNDY0NDY2MSwwLjUyMDcxMDY4IDAuNDI5Mjg5MzIsMC44MDM1NTMzOSAwLjMyMzIyMzMsMC45MDk2MTk0MSB6IE0gMC4yMTcxNTcyOSwwLjgwMzU1MzM5IDAuODUzNTUzMzksMC4xNjcxNTcyOSAwLjk1OTYxOTQxLDAuMjczMjIzMyAwLjMyMzIyMzMsMC45MDk2MTk0MSB6IgogICAgIGlkPSJyZWN0Mzc4MCIKICAgICBzdHlsZT0iZmlsbDojZmZmZmZmO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTpub25lIiAvPgo8L3N2Zz4K"); 
		}

		.mdl-checkbox__ripple-container .mdl-ripple {
			background: @background;
		}

		:scope > label.mdl-checkbox > .mdl-checkbox__label {
			color: @textColor;
		}

		:scope > .mdl-checkbox > .mdl-checkbox__box-outline {
			background: @backgroundUnchecked;
			border-color: @background;
		}
		:scope > .mdl-checkbox.is-checked:not(.is-disabled) .mdl-checkbox__box-outline {
			border-color: @checkedColor;
		}
		:scope > .mdl-checkbox.is-checked:not(.is-disabled) .mdl-checkbox__box-outline .mdl-checkbox__tick-outline {
			background-color: @checkedColor;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.checked = guf.param.booleanExpr(opts, "checked", false);
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.inputId = guf.getAutoId();
		tag.defaultDcss = {
			"background": "@primary",
			"backgroundUnchecked": "rgba(255, 255, 255, 0.3)",
			"textColor": "inherit",
			"checkedColor": "@primary"
		};
		tag.on("mount", function() {
			tag.root.addEventListener("click", function(evt) {
				if (tag.refs["input"].disabled) {
					evt.stopPropagation();
				}
			}, true);
			tag.refs["input"].addEventListener("change", function(evt) {
				tag.trigger("checkbox-click", tag);
			}, true);
		});
		tag.mixin("mdl");
		
		tag.isChecked = function() {
			return tag.refs["input"].checked;
		};

		tag.enable = function() {
			tag.disabled = false;
			tag.refs["input"].parentNode.MaterialCheckbox.enable();
			tag.update();
		};

		tag.disable = function() {
			tag.disabled = true;
			tag.refs["input"].parentNode.MaterialCheckbox.disable();
			tag.update();
		};

		tag.check = function() {
			tag.checked = true;
			tag.refs["input"].parentNode.MaterialCheckbox.check();
			tag.update();
		};

		tag.uncheck = function() {
			tag.checked = false;
			tag.refs["input"].parentNode.MaterialCheckbox.uncheck();
			tag.update();
		};

	</script>
</guf-checkbox>