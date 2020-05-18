<sam-pending-class-records-list-row>
	<div class="year-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.year}</div>
	<div class="semester-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.semester}</div>
	<div class="program-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.program}</div>
	<div class="course-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.course}</div>
	<div class="class-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.className}</div>
	<div class="teacher-column flex1">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.teacher}</div>
	<div class="missing-week-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').item.week}</div>
	<div class="status-column">{guf.ancestor(this, 'sam-pending-class-records-list-row').getDisplayStatus(guf.ancestor(this, 'sam-pending-class-records-list-row').item.status)}</div>
	<div class="actions-column">
		<guf-button ref="ignore-button" id="{'pending-class-records-list-row-ignore-' + guf.ancestor(this, 'sam-pending-class-records-list-row').index}" type="icon" color="true" icon="close" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
		<div class="mdl-tooltip mdl-tooltip--large" for="{'pending-class-records-list-row-ignore-' + guf.ancestor(this, 'sam-pending-class-records-list-row').index}">{guf.i18n.get('app.pending_ignored_tooltip')}</div>
		<guf-button ref="submit-button" id="{'pending-class-records-list-row-submit-' + guf.ancestor(this, 'sam-pending-class-records-list-row').index}" type="icon" color="true" icon="arrow_downward" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
		<div class="mdl-tooltip mdl-tooltip--large" for="{'pending-class-records-list-row-submit-' + guf.ancestor(this, 'sam-pending-class-records-list-row').index}">{guf.i18n.get('app.submit')}</div>
	</div>
	<div class="{overlay: 1, hidden: !guf.ancestor(this, 'sam-pending-class-records-list-row').overlayShown}"></div>
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
			height: 60px;
			overflow: hidden;
			position: relative;
		}
		:scope > div {
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
			padding-left: 16px;
			padding-right: 16px;
			border-right: 1px solid @background;
			color: @lighttext;
			text-align: center;
		}
		:scope > .year-column {
			width: 40px;
		}
		:scope > .semester-column {
			width: 70px;
		}
		:scope > .program-column {
			width: 65px;
		}
		:scope > .course-column {
			width: 300px;
			text-align: left;
		}
		:scope > .class-column {
			width: 60px;
		}
		:scope > .teacher-column {
			min-width: 150px;
			color: @darktext;
			text-align: left;
			word-break: break-word;
		}
		:scope > .missing-week-column {
			width: 40px;
		}
		:scope > .status-column {
			width: 65px;
		}
		:scope > .actions-column {
			width: 50px;
			border-right: 0px;
			-ms-box-orient: horizontal;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			align-items: center;
		}
		.guf-device-old-ios :scope > .actions-column > guf-button {
			min-width: 36px;
		}
		:scope > .overlay {
			position: absolute;
			margin: 0;
			padding: 0;
			border: 0;
			background-color: rgba(0, 0, 0, 0.15);
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var SUBMITTED = 1;
		var ignoreButton;
		tag.overlayShown = false;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"darktext": "@darktext",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		function ignoreClickHandler() {
			tag.trigger("ignore-click", tag, tag.item);
		}

		function submitClickHandler() {
			tag.trigger("submit-click", tag, tag.item);
		}

		function initEvents() {
			tag.refs["ignore-button"].on("click", ignoreClickHandler);
			tag.refs["submit-button"].on("click", submitClickHandler);
		}

		function removeEvents() {
			tag.refs["ignore-button"].off("click", ignoreClickHandler);
			tag.refs["submit-button"].off("click", submitClickHandler);
		}

		function ignoreButtonState() {
			if (tag.item.status === SUBMITTED) {
				tag.refs["ignore-button"].disabled = true;
				tag.update();
			}
		}

		tag.showOverlay = function() {
			tag.overlayShown = true;
			tag.update();
		};

		tag.hideOverlay = function() {
			tag.overlayShown = false;
			tag.update();
		};

		tag.getDisplayStatus = function(status) {
			switch(status) {
				case 1:
					return guf.i18n.get("app.submitted");
				case 2:
					return guf.i18n.get("app.ignored");
				default:
					return guf.i18n.get("app.pending");
			}
		};

		tag.on("mount", function() {
			initEvents();
			ignoreButtonState();
		});

		tag.on("after-mount", function() {
			var nodes = tag.root.querySelectorAll(".mdl-tooltip");
			for(var i=0; i<nodes.length; i++) {
				componentHandler.upgradeElement(nodes[i]);
			}
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-pending-class-records-list-row>