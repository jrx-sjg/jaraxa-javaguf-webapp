<sam-limits-monitoring-absences-detail-list-footer>
	<div class="footer-title">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-footer').footerTitle}</div>
	<div class="footer-value">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-footer').footerValue}</div>
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
			align-items: center;
			justify-content: flex-end;
			font-size: 14px;
			color: @lighttext;
			height: 35px;
			border: 1px solid @lines;
			border-top: 0;
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
			padding-right: 10px;
		}
		:scope > .footer-value {
			color: @primary;
			margin-left: 5px;
		}

		@media screen and (max-width: 600px) {
			:scope {
				border: 0px;
				font-size: 12px;
				line-height: 1.4;
				padding-left: 6px;
				position: -webkit-sticky;
				position: sticky;
				left: 0;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.footerTitle = guf.i18n.get("app.total_absences_in_course", opts.data.course) + ":";
		tag.footerValue = opts.data.totalAbsencesInCourse + "/" + opts.data.courseMaxLimits;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');
	</script>
</sam-limits-monitoring-absences-detail-list-footer>