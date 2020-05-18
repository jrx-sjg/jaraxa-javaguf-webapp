<sam-campus-combo-box-item>
	<div><span>{group} - {campus}</span></div>
	<style scoped type="dcss">
		:scope {
			flex: 1;
		}
		:scope > div > span {
			text-transform: capitalize;
			margin-left: 15px;
			font-size:14px;
			color: @darktext;
		}
	</style>
	<script>
		var tag = this;
		tag.group = opts.data.group;
		tag.campus =  opts.data.campus;
		tag.id = opts.data.id;
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
			tag.trigger("menu-click", tag);
		}		
	</script>
</sam-campus-combo-box-item>