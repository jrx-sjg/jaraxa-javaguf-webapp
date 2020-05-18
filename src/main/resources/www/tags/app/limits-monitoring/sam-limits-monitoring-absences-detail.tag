<sam-limits-monitoring-absences-detail>
	<sam-class-title>{guf.ancestor(this, 'sam-limits-monitoring-absences-detail').courseTitle}</sam-class-title>
	<div class="list-container">
		<sam-limits-monitoring-absences-detail-list-header></sam-limits-monitoring-absences-detail-list-header>
		<sam-limits-monitoring-absences-detail-list-row each={item in guf.ancestor(this, 'sam-limits-monitoring-absences-detail').item.absencesByPeriod}></sam-limits-monitoring-absences-detail-list-row>
	</div>
	<sam-limits-monitoring-absences-detail-list-footer data={guf.ancestor(this, 'sam-limits-monitoring-absences-detail').item}></sam-limits-monitoring-absences-detail-list-footer>
	<div if="{guf.ancestor(this, 'sam-limits-monitoring-absences-detail').item.programMaxLimits != null}"  class="program-total-absences">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail').totalAbsencesInProgramMessage}</div>
	<style scoped type="dcss">
		:scope {
			display: block;
		}
		:scope > .list-container {
			border: 1px solid @lines;
			border-bottom: 0;
			border-top-left-radius: 10px;
			border-top-right-radius: 10px;
		}
		:scope > .list-container > sam-limits-monitoring-absences-detail-list-header {
			border-bottom: 1px solid @lines;
		}
		:scope > .list-container > sam-limits-monitoring-absences-detail-list-row {
			border-bottom: 1px solid @background;
		}
		:scope > sam-limits-monitoring-absences-detail-list-footer {
			border: 1px solid @lines;
			border-top: 0;
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
		:scope > .program-total-absences {
			color: @primary;
			margin: 5px;
			text-align: right;
		}

		@media screen and (max-width: 600px) {
			:scope > .list-container {
				overflow-x: auto;
				overflow-y: hidden;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.selectedView = tag.opts.view;
		tag.programMaxLimits = tag.item.programMaxLimits;
		tag.totalAbsencesInProgramMessage = guf.i18n.get("app.total_absences_in_program", tag.item.program) 
			+ ":  " + tag.item.totalAbsencesInProgram + " / " + tag.programMaxLimits ;
		
		tag.courseTitle = tag.item.program + " / " + tag.item.course + " / " + guf.i18n.get("app.max_absences_allowed").toUpperCase() + ": " + tag.item.courseMaxLimits;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');

	</script>
</sam-limits-monitoring-absences-detail>