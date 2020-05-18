<guf-card>
	<div class="mdl-card mdl-shadow--2dp">
		<yield/>
	</div>

	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope .mdl-card {
			min-width: 200px;
			min-height: 50px;
			-webkit-flex:1;
			-ms-flex:1;
			flex: 1;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {};
		tag.mixin("mdl");
		
		tag.hide = function() {
			tag.root.classList.add("hidden");
		}

		tag.show = function() {
			tag.root.classList.remove("hidden");
		}
	</script>
</guf-card>