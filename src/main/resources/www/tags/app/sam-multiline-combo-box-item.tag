<sam-multiline-combo-box-item>
	<div>{displayText}</div>
	<style scoped type="dcss">
		:scope {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			align-items: center;
			box-sizing: border-box;
			padding-top: 10px;
			padding-bottom: 10px;
			min-height: 48px;
		}
		:scope > div {
			line-height: 1.2;
			white-space: initial;
			font-size: 14px;
			color: @darktext;
		}
	</style>
	<script>
		var tag = this;
		tag.displayText = opts.data;
		tag.defaultDcss = {
			"darktext": "darktext"
		};
		tag.mixin('mdl');
		tag.relayEvents = ["menu-click"];

		tag.on('mount', function() {
			initEvents();
		});

		tag.on('before-unmount', function() {
			tag.root.removeEventListener('click', onMenuClick);
		});

		function initEvents() {
			tag.root.addEventListener('click', onMenuClick);
		}

		function onMenuClick(event) {
			tag.trigger("menu-click", tag.displayText, tag);
		}		
	</script>
</sam-multiline-combo-box-item>