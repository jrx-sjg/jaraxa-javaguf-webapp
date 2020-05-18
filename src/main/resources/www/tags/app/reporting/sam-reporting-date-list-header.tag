<sam-reporting-date-list-header>
	<div class="expand-column"></div>
	<div class="id-column">{guf.i18n.get('app.number').toUpperCase()}, {guf.i18n.get('app.name').toUpperCase()}</div>
	<div class="date-column">{guf.i18n.get('app.date_of_absence').toUpperCase()}</div>
	<div class="week-column">{guf.i18n.get('app.week').toUpperCase()}</div>
	<div class="teacher-column flex1">{guf.i18n.get('app.teacher_or_academics').toUpperCase()}</div>
	<div class="total-column">{guf.i18n.get('app.total_absences').toUpperCase()}</div>
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
			border: 1px solid @lines;
			height: 40px;
			border-top-left-radius: 10px;
			border-top-right-radius: 10px;
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
		:scope > .expand-column {
			width: 20px;
			min-width: 20px;
		}
		:scope > .id-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .date-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .week-column {
			width: 50px;
			min-width: 50px;
			text-align: center;
		}
		:scope > .teacher-column {
			min-width: 220px;
		}
		:scope > .total-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .period-column {
			width: 16px;
			min-width: 16px;
			text-align: center;
			padding: 0 4px;
		}
		:scope > .period-column:last-child {
			border-right: 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines"
		};
		tag.mixin('mdl');
	</script>
</sam-reporting-date-list-header>