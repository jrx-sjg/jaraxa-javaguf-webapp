<guf-list>
	<div class="mdl-list">
		<yield />
	</div>
	<style scoped type="css">
		:scope {
			display: block;
			overflow-y: auto;
		}
		.guf-device-ios :scope > div.mdl-list {
			-webkit-transform: translate3d(0,0,0);
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.mixin("relay-events");
	</script>
</guf-list>