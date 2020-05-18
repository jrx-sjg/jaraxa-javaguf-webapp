<guf-datetimepicker-button>
	<span 
		if="{label=='floating' && buttonType=='outline'}" 
		class="{mdl-label--floating: 1, mdl-label--floating-colored: currentOption.length>0, mdl-label--floating-empty: currentOption.length==0}">
			{placeholder}
	</span>
	<guf-button 
		ref="current" 
		menuid="{buttonId}" 
		disabled="{disabled}" 
		class="{full-width: fullWidth, mdl-label--border-colored: currentOption.length>0}" 
		type="{buttonType}">
			<span 
				class="selected-text flex1">
					{currentOption}
			</span>
			<span 
				if="{parent.trailingIcon}" 
				class="trailing-icon">
					<i 
						class="{material-icons: !parent.trailingIconOutlined, material-icons-outlined: parent.trailingIconOutlined}">
						{parent.trailingIcon}
				</i>
			</span>
	</guf-button>
	<style scoped type="dcss">
		:scope {
			display: flex;
			position: relative;
			padding-top: @paddingTop;
			padding-bottom: @paddingBottom;
		}

		/*************** Floating Label ***************/
		:scope > .mdl-label--floating {
			position: absolute;
		    background: @labelBackground;
		    top: -4px;
		    left: 16px;
		    z-index: 2;
		    padding: 0px 4px;
		    box-sizing: border-box;
		    font-size: 12px;
		    font-weight: 400;
		    color: @outlineLabelColor;
		    white-space: nowrap;
		    -webkit-transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
			-moz-transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
			-o-transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
			-ms-transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
			transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
		}

		:scope > .mdl-label--floating-empty {
		    position: absolute;
		    top: 25px;
		    font-size: 16px;
		    left: 12px;
		    z-index: 0;
		}

		:scope:hover > .mdl-label--floating {
			color: @outlineHover;
		}
		
		:scope > .mdl-label--floating-colored {
			color: @outlineColoredLabelColor;
		}
		/*************** End Floating Label ***************/



		/*************** Button ***************/
		:scope > guf-button[ref="current"] > .mdl-button {
			font-size: @fontSize;
			color: @fontColor;
			font-weight: @fontWeight;
			text-transform: none;
			border-radius: @borderRadius;
			border: @border;
			line-height: @fontSize;
			padding: 0 4px;
			height: @height;
		}

		:scope > guf-button[ref="current"][type="outline"] > .mdl-button {
			height: 53px;
			padding-left: 16px;
    		font-size: 16px;
    		font-weight: 400; 
		}

		:scope > guf-button[ref="current"] > .mdl-button > .selected-text {
			text-align: @textAlignment;
		}
		:scope > guf-button[ref="current"] > .mdl-button > .trailing-icon {
			margin-left: 8px;
		}

		:scope > guf-button[ref="current"] > .mdl-button[disabled="true"] {
			border-color: @disabledColor;
		}

		/* Outline */
		:scope > guf-button[ref="current"] > .mdl-button.mdl-button--outline {
			border: 1px solid @outlineColor;
			border-radius: 4px;
			padding: 2px 8px 2px 16px;
		}
		:scope > guf-button[ref="current"].mdl-label--border-colored > .mdl-button.mdl-button--outline {
			border-color: @outlineColoredLabelColor;
		}
		:scope > guf-button[ref="current"] > .mdl-button.mdl-button--outline:active, 
		:scope > guf-button[ref="current"] > .mdl-button.mdl-button--outline:hover {
			background: @hoverBackground;
		}
		:scope:hover > guf-button[ref="current"] > .mdl-button.mdl-button--outline {
			border-color: @outlineHover;
		}

		

		/* Full Width */
		:scope > guf-button[ref="current"].full-width {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
		    -ms-flex: 1;
		    flex: 1;
		    margin-left: 0px;
		}
		:scope > guf-button[ref="current"].full-width > .mdl-button {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
		    -ms-flex: 1;
		    flex: 1;
		    align-items: center;
		}
		:scope > guf-button[ref="current"].full-width > .mdl-button > .material-icons {
			right: 8px;
    		position: absolute;
		}

		:scope[disabled="true"] > .mdl-label--floating {
			color: @disabledColor;
		}
		:scope:hover > guf-button[disabled="true"] > .mdl-button.mdl-button--outline,
		:scope > guf-button[disabled="true"] > .mdl-button.mdl-button--outline,
		:scope > guf-button[disabled="true"].mdl-label--border-colored > .mdl-button.mdl-button--outline {
			border-color: @disabledColor;
		}
		/*************** End Button ***************/
	</style>
	<script type="text/javascript">
		var tag = this;
		var currentValue = "";

		tag.label = guf.param.string(opts.label, null);
		tag.placeholder = guf.param.string(opts.placeholder, null);
		tag.buttonType = guf.param.string(opts.buttonType, "flat");
		tag.fullWidth = guf.param.boolean(opts.fullWidth, false);
		tag.buttonId = guf.getAutoId();
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.comboOptions = [];
		tag.currentOption = "";
		tag.menuPosition = guf.param.string(opts.position, "bottom-right");
		tag.overflow = guf.param.boolean(opts.overflow, false);
		tag.itemTag = guf.param.string(opts.itemTag);

		tag.trailingIcon = guf.param.string(opts.trailingIcon, null);
		tag.trailingIconOutlined = guf.param.booleanExpr(opts, "trailingIconOutlined", false);
		tag.focused = false;

		tag.defaultDcss = {
			"fontSize": "14px",
			"fontColor": "black",
			"fontWeight": "300",
			"borderRadius": "0px",
			"border": "0px",
			"borderColor": "@primary",
			"disabledColor": "rgba(0,0,0,.26)",
			"height": "32px",
			"maxHeight": "300px",
			"labelBackground": "#ffffff",
			"outlineColor": "rgba(0,0,0,.24)",
			"outlineHover": "rgba(0,0,0,.87)",
			"outlineLabelColor": "rgba(0, 0, 0, 0.60)",
			"outlineColoredLabelColor": "@primary",
			"hoverBackground": "transparent",
			"textAlignment": "left",
			"paddingTop": tag.buttonType == "outline" ? "8px" : "0px",
			"paddingBottom": tag.buttonType == "outline" ? "20px" : "0px"
		};
		tag.mixin('mdl');

		function initEvents() {
			tag.refs["current"].on("focus", focusHandler);
			tag.refs["current"].on("blur", blurHandler);
			tag.refs["current"].on("click", clickHandler);
		}

		function removeEvents() {
			tag.refs["current"].off("focus", focusHandler);
			tag.refs["current"].off("blur", blurHandler);
			tag.refs["current"].off("click", clickHandler);
		}

		function focusHandler() {
			//FIXME
		}

		function blurHandler() {
			//FIXME
		}

		function clickHandler(e, itemTag) {
			tag.trigger("click", e, itemTag);
		}

		tag.getValue = function() {
			return currentValue;
		};

		tag.setText = function(text) {
			tag.currentOption = text;
			currentValue = text;
			var displayText = text;

			if (!!tag.trailingIcon) {
				var trailingIconElement = '<span class="trailing-icon">';
				if (tag.trailingIconOutlined) {
					trailingIconElement = trailingIconElement + '<i class="material-icons-outlined">';
				} else {
					trailingIconElement = trailingIconElement + '<i class="material-icons">';
				}
				trailingIconElement = trailingIconElement + tag.trailingIcon + '</i></span>';
				displayText = '<span class="selected-text flex1">' + tag.currentOption + '</span>' + trailingIconElement;
			}

			tag.refs["current"].setText(displayText);
			tag.update();
		};

		tag.disable = function() {
			tag.disabled = true;
			tag.refs["current"].disable();
			tag.update();
		}

		tag.enable = function() {
			tag.disabled = false;
			tag.refs["current"].enable();
			tag.update();
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			var previousDisabled = tag.disabled;
			tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
			if (tag.disabled != previousDisabled) {
				if (tag.disabled) {
					tag.refs["current"].disable();
				} else {
					tag.refs["current"].enable();
				}
			}
			removeEvents();
		});

		tag.on("updated", function() {
			initEvents();
		});

	</script>
</guf-datetimepicker-button>