<guf-segmented-control>
	<guf-linear-layout ref="wrapper" orientation="horizontal" v-align="center" h-align="center">
		<div each="{guf.ancestor(this, 'guf-segmented-control').segmentedButtons}">
			<guf-button ref="{ref}" type="flat" icon="{icon}" color="false" ripple="true"></guf-button>
		</div>
	</guf-linear-layout>

	<style type="dcss">
		:scope {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			flex-direction: column;
			min-width: 0;
		}

		:scope > guf-linear-layout[ref="wrapper"] {
					
		}

		:scope > guf-linear-layout[ref="wrapper"] > div {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
		}

		/* outline */
		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--outline > div > guf-button > .mdl-button {
			border: 1px solid @borderColor;
			border-radius: 0px;
			color: @buttonTextColor;
			background: @buttonBackground;
			text-transform: capitalize;
			box-sizing: border-box;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--outline > div > guf-button > .mdl-button.mdl-button--selected {
			color: @buttonTextColorSelected;
			background: @buttonBackgroundSelected;	
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--outline > div:first-child > guf-button > .mdl-button {
			border-bottom-left-radius: @borderRadius;
			border-top-left-radius: @borderRadius;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--outline > div:not(:first-child) > guf-button > .mdl-button {
			border-left-width: 0px;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--outline > div:last-child > guf-button > .mdl-button {
			border-bottom-right-radius: @borderRadius;
			border-top-right-radius: @borderRadius;
		}

		/* fill */
		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill {
			background: @backgroundColor;
			border-radius: @borderRadius;
			border: 2px solid @backgroundColor;
			box-sizing: border-box;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill > div > guf-button > .mdl-button {
			border-radius: 0px;
			color: @buttonTextColor;
			background: @buttonBackground;
			text-transform: capitalize;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill > div > guf-button > .mdl-button.mdl-button--selected {
			color: @buttonTextColorSelected;
			background: @buttonBackgroundSelected;	
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill > div > guf-button:first-child > .mdl-button {
			border-bottom-left-radius: @borderRadius;
			border-top-left-radius: @borderRadius;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill > div > guf-button:not(:first-child) > .mdl-button {
			border-left-width: 0px;
		}

		:scope > guf-linear-layout[ref="wrapper"].mdl-segmented--fill > div > guf-button:last-child > .mdl-button {
			border-bottom-right-radius: @borderRadius;
			border-top-right-radius: @borderRadius;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.segmentedButtons = opts.segmentedButtons;
		tag.color = guf.param.boolean(opts.color, false);
		tag.initialSelected = guf.param.number(opts.initialSelected, null);

		tag.unselectAll = unselectAll;

		var tagButtons = undefined;
		var currentSelected = null;

		tag.mdlClasses = {
			"outline" : {
				"true" : {
					"root": ["mdl-segmented--outline"]
				},
				"false" : {
					"root": ["mdl-segmented--fill"]
				}
			}
		};
		tag.defaultDcss = {
			"borderColor": "@primary",
			"borderRadius": "8px",
			"backgroundColor": "rgb(155, 155, 155)",
			"buttonBackground": "transparent",
			"buttonBackgroundSelected": "@primary",
			"buttonTextColor": "@primary",
			"buttonTextColorSelected": "@textPrimary"
		};
		tag.mixin('mdl', 'after-mount');

		tag.on("mount", function() {
			initView();
		});

		tag.on("after-mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			
		});

		tag.select = function(btnRef) {
			selectButtonByRef(btnRef);
		}

		tag.disable = function() {
			tagButtons = tag.refs.wrapper.tags["guf-button"];
			for (var i=0; i<tagButtons.length; i++) {
				tagButtons[i].disable();
			}
		}

		tag.enable = function() {
			tagButtons = tag.refs.wrapper.tags["guf-button"];
			for (var i=0; i<tagButtons.length; i++) {
				tagButtons[i].enable();
			}
		}

		function initView() {
			tagButtons = tag.refs.wrapper.tags["guf-button"];
			for (var i=0; i<tagButtons.length; i++) {
				if (tag.segmentedButtons[i].text) 
					tagButtons[i].setText(tag.segmentedButtons[i].text);
			}
			tag.refs.wrapper.update();
		}

		function initEvents() {
			var btn;
			for (var i=0; i<tagButtons.length; i++) {
				tagButtons[i].on('click', function (event, btnTag) {
					if (!btnTag.refs.button.classList.contains('mdl-button--selected')) {
						var prevSelected = currentSelected;
						selectButton(btnTag);
						tag.trigger('segmented-button-click', btnTag, tag, prevSelected);
					}
				});
			}

			if (tag.initialSelected!==null) 
				selectButton(tagButtons[tag.initialSelected]);
		}

		function selectButton(btnTag) {
			unselectAll();
			btnTag.refs.button.classList.add('mdl-button--selected');
			currentSelected = btnTag.opts.ref;
		}
				
		function selectButtonByRef(btnRef) {
			for (var i=0; i<tagButtons.length; i++) {
				if (tagButtons[i].opts.ref == btnRef) {
					selectButton(tagButtons[i]);
					break;
				}
			}
		}

		function unselectAll() {
			for (var i=0; i<tagButtons.length; i++) {
				tagButtons[i].refs.button.classList.remove('mdl-button--selected');
			}
			currentSelected = null;
		}

	</script>
</guf-segmented-control>