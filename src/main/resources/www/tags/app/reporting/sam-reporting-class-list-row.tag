<sam-reporting-class-list-row>
	<guf-linear-layout ref="main-level" orientation="horizontal">
		<div class="expand-column"><i ref="expand" class="material-icons noselect">keyboard_arrow_right</i></div>
		<div class="course-column flex1">{guf.ancestor(this, 'sam-reporting-class-list-row').course}</div>
		<div class="total-column">{guf.ancestor(this, 'sam-reporting-class-list-row').total}</div>
		<div class="tail-column"></div>
	</guf-linear-layout>
	<div if="{guf.ancestor(this, 'sam-reporting-class-list-row').expanded}" class="nested-container">
		<sam-reporting-class-list-row-nested-level-1 ref="row" each={item in guf.ancestor(this, 'sam-reporting-class-list-row').item.courseClassesDetails} period="{guf.ancestor(this, 'sam-reporting-class-list-row').opts.period}"></sam-reporting-class-list-row-nested-level-1>
	</div>
	<style scoped type="dcss">
		:scope {
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
			border: 1px solid @lines;
			border-top: 0;
		}
		:scope > guf-linear-layout[ref="main-level"] {
			height: 40px;
		}
		:scope > guf-linear-layout[ref="main-level"] > div {
			color: @darktext;
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
			border-right: 1px solid transparent;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column {
			color: @primary;
			width: 20px;
			min-width: 20px;
			border-color: @background;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i {
			transition: transform 0.2s;
			transform: rotate(0deg);
			cursor: pointer;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i.expanded {
			transform: rotate(90deg);
		}
		:scope > guf-linear-layout[ref="main-level"] > .course-column {
			min-width: 584px;
		}
		:scope > guf-linear-layout[ref="main-level"] > .total-column {
			width: 60px;
			min-width: 60px;
			text-align: center;
			color: @lighttext;
		}
		:scope > guf-linear-layout[ref="main-level"] > .tail-column {
			width: 499px;
			min-width: 499px;
			padding: 0px;
			border-right: 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.expanded = false;

		tag.course = guf.i18n.get("app.course_with_max_abs", tag.item.course, tag.item.maxAbsences);
		tag.total = tag.item.total;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext",
			"darktext": "@darktext"
		};
		tag.mixin('mdl');

		function expandClickHandler() {
			tag.expanded = !tag.expanded;
			if(tag.expanded) {
				tag.refs["main-level"].refs["expand"].classList.add("expanded");
			} else {
				tag.refs["main-level"].refs["expand"].classList.remove("expanded");
			}
			tag.update();
		}

		function initListEvents() {
			var items = [];
			items = guf.tagsAsArray(tag.refs["row"]);
			for (var i = 0; i < items.length; i++) {
				items[i].on("student-details-click", studentDetailsClickHandler);
			}
		}

		function removeListEvents() {
			var items = [];
			items = guf.tagsAsArray(tag.refs["row"]);
			for (var i = 0; i < items.length; i++) {
				items[i].off("student-details-click", studentDetailsClickHandler);
			}
		}		

		function studentDetailsClickHandler(semester, studentId, year) {
			tag.trigger("student-details-click", semester, studentId, year);
		}


		function initEvents() {
			tag.refs["main-level"].refs["expand"].addEventListener("click", expandClickHandler);
			initListEvents();
		}

		function removeEvents() {
			tag.refs["main-level"].refs["expand"].removeEventListener("click", expandClickHandler);
			removeListEvents();
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			removeListEvents();
		});

		tag.on("updated", function() {
			initListEvents();
		});


	</script>
</sam-reporting-class-list-row>