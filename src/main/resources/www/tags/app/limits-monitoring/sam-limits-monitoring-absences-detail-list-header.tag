<sam-limits-monitoring-absences-detail-list-header>
	<div class="date-column">{guf.i18n.get('app.date').toUpperCase()}</div>
	<div class="week-column">{guf.i18n.get('app.week').toUpperCase()}</div>
	<div class="teacher-column">{guf.i18n.get('app.teacher_or_academics').toUpperCase()}</div>
	<div class="comment-column flex1">{guf.i18n.get('app.comment').toUpperCase()}</div>
	<div class="period-column">1</div>
	<div class="period-column">2</div>
	<div class="period-column">3</div>
	<div class="period-column">4</div>
	<div class="period-column">5</div>
	<div class="period-column">6</div>
	<div class="period-column">7</div>
	<div class="period-column">8</div>
	<div class="period-column">9</div>
	<div class="period-column">10</div>
	<div class="period-column">11</div>
	<div class="period-column">12</div>
	<div class="period-column">13</div>
	<div class="period-column">14</div>
	<div class="period-column">15</div>
	<div class="period-column">16</div>
	<div class="period-column">17</div>
	<div class="period-column">18</div>
	<div class="period-column">19</div>
	<div class="period-column">20</div>
	<div class="total-column">{guf.i18n.get('app.total').toUpperCase()}</div>
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
			height: 40px;
		}
		:scope > div {
			color: @primary;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			justify-content: center;
			font-size: 14px;
			padding-left: 10px;
			padding-right: 10px;
			border-right: 1px solid @background;
		}
		:scope > .date-column {
			width: 80px;
			min-width: 80px;
		}
		:scope > .week-column {
			width: 40px;
			min-width: 40px;
			text-align: center;
		}
		:scope > .teacher-column {
			width: 150px;
			min-width: 150px;
		}
		:scope > .comment-column {
			min-width: 120px;
		}
		:scope > .period-column {
			width: 16px;
			min-width: 16px;
			padding: 0 4px;
			text-align: center;
		}
		:scope > .total-column {
			width: 40px;
			min-width: 40px;
			text-align: center;
			border-right: 0px;
		}

		@media screen and (max-width: 600px) {
			:scope {
				min-width: 726px;
			}
			:scope > div {
				font-size: 12px;
				padding-left: 6px;
				padding-right: 6px;
			}
			:scope > .date-column {
				width: 60px;
				min-width: 60px;
				position: -webkit-sticky;
				position: sticky;
				left: 0;
				background: @lightestbackground;
				border-top-left-radius: 10px;
			}
			:scope > .week-column {
				width: 30px;
				min-width: 30px;
				position: -webkit-sticky;
				position: sticky;
				left: 73px;
				background: @lightestbackground;
			}
			:scope > .teacher-column {
				min-width: 80px;
				max-width: 80px;
				position: -webkit-sticky;
				position: sticky;
				left: 116px;
				background: @lightestbackground;
			}
			:scope > .period-column {
				width: 10px;
				min-width: 10px;
				padding: 0 2px;
			}
			:scope > .period-column.absence {
			}
			:scope > .total-column {
				width: 35px;
				min-width: 35px;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');
	</script>
</sam-limits-monitoring-absences-detail-list-header>