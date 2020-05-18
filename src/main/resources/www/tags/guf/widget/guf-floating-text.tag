<guf-floating-text class="new-message">
	<div class="centering-block"></div>
	<guf-button icon="{opts.icon}" type="flat" ripple="true">{parent.text}</guf-button>
	<div class="centering-block"></div>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			position: absolute;
			left: 0;
			right: 0;
			top: @topPosition;
			bottom: @bottomPosition;
			height: 0;
			overflow: visible;
		}
		:scope > .centering-block {
			height: 0;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > guf-button {
			position: relative;
			top: -20px;
		}
		:scope > guf-button > .mdl-button {
			border-radius: 20px;
			height: 40px;
			color: @textColor;
			white-space: nowrap;
			padding: 0px 16px;
			text-transform: none;
		}
		:scope > guf-button > .mdl-button,
		:scope > guf-button > .mdl-button:hover,
		:scope > guf-button > .mdl-button:focus:not(:active),
		:scope > guf-button > .mdl-button:active,
		:scope > guf-button > .mdl-button:visited {
			background-color: @backgroundColor;
		}
		:scope > guf-button > .mdl-button > .mdl-button__ripple-container {
			border-radius: 20px;
		}
		:scope > guf-button > .mdl-button > .material-icons {
			vertical-align: middle;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.text = guf.param.string(opts.text, "");

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"backgroundColor": "@primary",
			"textColor": "white",
			"topPosition": "none",
			"bottomPosition": "96px"
		};
		tag.mixin('mdl');

		tag.setText = function(value) {
			tag.text = value;
			tag.update();
		}

		tag.show = function() {
			tag.tags["guf-button"].show();
		}

		tag.hide = function() {
			tag.tags["guf-button"].hide();
		}

		tag.isHidden = function() {
			return tag.tags["guf-button"].root.classList.contains("hidden");
		}

		function initEvents() {
			tag.tags["guf-button"].on("click", function() {
				tag.trigger("click", tag);
			});
		}

		tag.on("mount", function() {
			initEvents();
		});

	</script>
</guf-floating-text>