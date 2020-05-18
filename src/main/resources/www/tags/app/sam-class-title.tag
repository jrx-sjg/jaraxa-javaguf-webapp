<sam-class-title>
	<yield/>
	<style scoped type="dcss">
		:scope {
			display: block;
			padding: 6px 0px;
			margin-bottom: 20px;
			color: @primary;
			text-align: center;
			text-transform: uppercase;
			font-size: 14px;
			font-weight: 600;
			border-top: 2px solid @primary;
			border-bottom: 2px solid @primary;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var anchor = guf.param.booleanExpr(opts, "anchor", true);
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl');
		tag.on("mount", function() {
			if (anchor) {
				app.trigger("add-sticky-anchor", tag._riot_id, tag.root.innerText, tag.root.offsetTop);
			}
		});
		tag.on("before-unmount", function() {
			if (anchor) {
				app.trigger("remove-sticky-anchor", tag._riot_id);
			}
		});
		tag.on("update", function() {
			if (anchor) {
				app.trigger("remove-sticky-anchor", tag._riot_id);
			}
		});
		tag.on("updated", function() {
			if (anchor) {
				app.trigger("add-sticky-anchor", tag._riot_id, tag.root.innerText, tag.root.offsetTop);
			}
		});
	</script>
</sam-class-title>