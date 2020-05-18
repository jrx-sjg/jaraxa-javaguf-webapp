<sam-class-combo-box-item>
	<div><guf-checkbox ref="checkbox"></guf-checkbox><span>{displayText}</span></div>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			box-sizing: border-box;
			padding-top: 10px;
			padding-bottom: 10px;
			min-height: 48px;
		}
		:scope > div {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			align-items: center;
			line-height: 1.4;
		}
		:scope > div > guf-checkbox {
			display: inline-block;
			min-width: 24px;
		}
		:scope > div > span {
			font-size: 14px;
			color: @darktext;
			white-space: initial;
		}
	</style>
	<script>
		var tag = this;
		tag.displayText = opts.data;
		tag.defaultDcss = {
			"darktext": "darktext"
		};
		tag.mixin('mdl');
		tag.relayEvents = ["option-select", "option-deselect"];

		tag.toggle = function() {
			if(tag.refs["checkbox"].isChecked()) {
				tag.refs["checkbox"].uncheck();
			} else {
				tag.refs["checkbox"].check();
			}
		};

		tag.maybeSetSelectedOption = function(options) {
			if (options.indexOf(tag.displayText) != -1) {
				tag.refs["checkbox"].check();
			}
		};

		tag.on('mount', function() {
			initEvents();
		});

		tag.on('before-unmount', function() {
			tag.root.removeEventListener('click', onMenuClick);
			tag.refs["checkbox"].off("checkbox-click", onCheckboxClick);
		});

		function initEvents() {
			tag.root.addEventListener('click', onMenuClick);
			tag.refs["checkbox"].on("checkbox-click", onCheckboxClick);
		}

		function onMenuClick(event) {
			event.stopPropagation();
			if(event.target != tag.refs["checkbox"].root && !tag.refs["checkbox"].root.contains(event.target)) {
				tag.toggle();
				if(tag.refs["checkbox"].isChecked()) {
					tag.trigger("option-select", tag.displayText, tag);
				} else {
					tag.trigger("option-deselect", tag.displayText, tag);
				}
			}
		}

		function onCheckboxClick(checkboxTag) {
			if(tag.refs["checkbox"].isChecked()) {
				tag.trigger("option-select", tag.displayText, tag);
			} else {
				tag.trigger("option-deselect", tag.displayText, tag);
			}
		}
	</script>
</sam-class-combo-box-item>