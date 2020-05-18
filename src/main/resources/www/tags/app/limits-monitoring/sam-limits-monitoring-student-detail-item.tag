<sam-limits-monitoring-student-detail-item>
	<div class="item-bullet"></div>
	<div class="item-title">{opts.itemTitle}:</div>
	<div class="item-content">{opts.itemContent}</div>
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
			font-size: 14px;
			line-height: 1.4;
		}
		:scope > .item-bullet {
			color: @primary;
			font-size: 54px;
			line-height: 14px;
			margin-right: 5px;
			height: 14px;
		}
		:scope > .item-bullet:before {
			content: "·";
		}
		:scope > .item-title {
			color: @primary;
			margin-right: 5px;
		}
		:scope > .item-content {
			color: @lighttext;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');
	</script>
</sam-limits-monitoring-student-detail-item>