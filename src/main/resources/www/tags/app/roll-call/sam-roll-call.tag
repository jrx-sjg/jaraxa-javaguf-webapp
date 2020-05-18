<sam-roll-call>
	<guf-linear-layout ref="container" orientation="vertical" v-align="center" class="{container: 1, empty: guf.ancestor(this, 'sam-roll-call').isEmpty}">
		<div class="scrollable-content">
			<div class="header">{guf.i18n.get("app.roll_call")}</div>
			<sam-roll-call-header ref="sticky" content="{guf.ancestor(this, 'sam-roll-call').rollCallData.length > 0}"></sam-roll-call-header>
			<sam-empty if="{!guf.ancestor(this, 'sam-roll-call').filterApplied && !guf.ancestor(this, 'sam-roll-call').loading}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.roll_call_empty_text')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-roll-call').filterApplied && guf.ancestor(this, 'sam-roll-call').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-roll-call').filteredEmpty}" class="flex1" icon="search" text="{guf.i18n.get('app.roll_call_filtered_empty_text')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-roll-call').markedEmpty}" class="flex1" icon="group" text="{guf.i18n.get('app.roll_call_marked_empty_text')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-roll-call').rollCallData.length > 0}">
				<sam-roll-call-filtered-class ref="class" if="{guf.ancestor(this, 'sam-roll-call').activeSelector === app.ROLL_CALL_LIST_SELECTOR.FILTERED}" each={item, index in guf.ancestor(this, 'sam-roll-call').rollCallData} class="{class-container: 1, filter-maximized: guf.ancestor(this, 'sam-roll-call').filterMaximized, advanced-user: app.hasAuthority(app.AUTHORITY.CHANGE_ABSENCE)}"></sam-roll-call-filtered-class>
				<sam-roll-call-marked-class ref="class" if="{guf.ancestor(this, 'sam-roll-call').activeSelector === app.ROLL_CALL_LIST_SELECTOR.MARKED}" each={item, index in guf.ancestor(this, 'sam-roll-call').rollCallDataMarked} class="{class-container: 1, filter-maximized: guf.ancestor(this, 'sam-roll-call').filterMaximized, advanced-user: app.hasAuthority(app.AUTHORITY.CHANGE_ABSENCE)}"></sam-roll-call-marked-class>
			</div>
		</div>
	</guf-linear-layout>
	<style scoped type="dcss">
		:scope {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > guf-linear-layout.container {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: block;
		}
		:scope > guf-linear-layout.empty {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > guf-linear-layout.empty > div.scrollable-content {
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
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > guf-linear-layout > div.scrollable-content > div.header {
			color: @primary;
			font-family: chronicle-deck, serif;
			font-size: 22px;
			height: 24px;
			font-weight:600;
			margin: 26px;
		}
		:scope > guf-linear-layout > div.scrollable-content > sam-roll-call-header {
			position: -webkit-sticky;
			position: sticky;
			top: 0;
			background: @lightestbackground;
			z-index: 2;
		}
		:scope > guf-linear-layout > div.scrollable-content > sam-roll-call-header sam-roll-call-filter {
			margin: 0 26px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] {
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
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > * {
			margin: 0 26px 20px;			
		}
	</style>
	<script>
		var tag = this;
		var search = {
			value: "",
			classIndex: 0,
			studentIndex: -1,
			selector: app.ROLL_CALL_LIST_SELECTOR.FILTERED,
			tag: null
		};
		tag.rollCallData = [];
		tag.rollCallDataMarked = [];
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');
		tag.activeSelector = app.ROLL_CALL_LIST_SELECTOR.FILTERED;
		tag.isEmpty = true;
		tag.loading = false;
		tag.filteredEmpty = false;
		tag.markedEmpty = false;
		tag.filterApplied = false;
		tag.filterMaximized = false;

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			tag.rollCallData = app.rollCall.get();
			tag.rollCallDataMarked = app.rollCall.getMarked();
			switch(tag.activeSelector) {
				case app.ROLL_CALL_LIST_SELECTOR.FILTERED:
					tag.isEmpty = tag.rollCallData.length === 0;
					tag.filteredEmpty = tag.isEmpty && tag.filterApplied;
					tag.markedEmpty = false;
					break;
				case app.ROLL_CALL_LIST_SELECTOR.MARKED:
					tag.isEmpty = tag.rollCallDataMarked.length === 0;
					tag.filteredEmpty = false;
					tag.markedEmpty = tag.isEmpty && tag.filterApplied;
					break;
			}
		});

		tag.getClasses = function() {
			return tag.refs["container"].refs["class"];
		};

		tag.getMarked = function() {
			return tag.rollCallDataMarked;
		}

		function initEvents() {
			tag.refs["container"].tags["sam-roll-call-header"].on("apply", applyFilter);
			tag.refs["container"].tags["sam-roll-call-header"].on("reset", resetFilter);
			tag.refs["container"].tags["sam-roll-call-header"].on("search", searchHandler);
			tag.refs["container"].tags["sam-roll-call-header"].on("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-roll-call-header"].on("selector", selectorHandler);
			tag.refs["container"].tags["sam-roll-call-header"].on("scroll-delta", scrollDeltaHandler);
		}

		function removeEvents() {
			tag.refs["container"].tags["sam-roll-call-header"].off("apply", applyFilter);
			tag.refs["container"].tags["sam-roll-call-header"].off("reset", resetFilter);
			tag.refs["container"].tags["sam-roll-call-header"].off("search", searchHandler);
			tag.refs["container"].tags["sam-roll-call-header"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-roll-call-header"].off("selector", selectorHandler);
			tag.refs["container"].tags["sam-roll-call-header"].off("scroll-delta", scrollDeltaHandler);
		}

		function applyFilter() {
			app.rollCall.init();
			tag.loading = true;
			app.rollCall.load().then(function(data) {
				tag.filterApplied = true;
				tag.activeSelector = app.ROLL_CALL_LIST_SELECTOR.FILTERED;
				tag.loading = false;
				tag.update();
			}).catch(function() {
				tag.filterApplied = true;
				tag.activeSelector = app.ROLL_CALL_LIST_SELECTOR.FILTERED;
				tag.loading = false;
				tag.update();
			});
			tag.update();
		}

		function resetFilter() {
			app.rollCall.release();
			tag.filterApplied = false;
			tag.activeSelector = app.ROLL_CALL_LIST_SELECTOR.FILTERED;
			tag.update();
		}

		function searchHandler(value) {
			if (search.tag != null) {
				search.tag.highlightText(null);
			}
			var searchData = tag.activeSelector == app.ROLL_CALL_LIST_SELECTOR.FILTERED ? tag.rollCallData : tag.rollCallDataMarked;
			if (search.selector != tag.activeSelector || search.value != value) {
				search.value = value;
				search.selector = tag.activeSelector;
				search.classIndex = 0;
				search.studentIndex = -1;
				search.tag = null;
			}
			var found = false;
			var fromBeginning = search.classIndex == 0 && search.studentIndex == -1;
			while (!found && search.classIndex < searchData.length) {
				if (search.studentIndex < searchData[search.classIndex].students.length) {
					search.studentIndex++;
				}
				while (!found && search.studentIndex < searchData[search.classIndex].students.length) {
					found = studentMatchSearch(value, searchData[search.classIndex].students[search.studentIndex]);
					if (!found) {
						search.studentIndex++;
					}
				}
				if (!found) {
					search.classIndex++;
					search.studentIndex = -1;
				}
			}
			if (found) {
				var classes = guf.tagsAsArray(tag.getClasses());
				var classTag = classes[search.classIndex];
				search.tag = classTag.getStudentTag(search.studentIndex);
				search.tag.highlightText(value.toLowerCase());
				search.tag.update();
				tag.trigger("scroll", search.tag.root.offsetTop - tag.refs["container"].refs["sticky"].getStickyHeight());
			} else if (fromBeginning) {
				guf.createDialog(guf.i18n.get("guf.search"), guf.i18n.get("app.search_not_found", value), guf.i18n.get("guf.ok"));
			} else {
				guf.createDialog(guf.i18n.get("guf.search"), guf.i18n.get("app.search_not_found_ask_beginning", value), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
					search.value = value;
					search.selector = tag.activeSelector;
					search.classIndex = 0;
					search.studentIndex = -1;
					search.tag = null;
					searchHandler(value);
				}, function() {
					// Do nothing
				});
			}
		}

		function studentMatchSearch(value, studentData) {
			var lowerValue = value.toLowerCase();
			var lowerFirstName = studentData.firstName.toLowerCase();
			var lowerLastName = studentData.lastName.toLowerCase();
			var lowerPreferredName = !!studentData.preferredName ? studentData.preferredName.toLowerCase() : "";
			var lowerId = (studentData.id + "").toLowerCase();
			return lowerFirstName.indexOf(lowerValue) != -1 || lowerLastName.indexOf(lowerValue) != -1 ||
				lowerPreferredName.indexOf(lowerValue) != -1 || lowerId.indexOf(lowerValue) != -1;
		}

		function filterMinimizedHandler(minimized) {
			tag.filterMaximized = !minimized;
			tag.update();
		}

		function selectorHandler(selector) {
			app.rollCall.initMarked();
			tag.activeSelector = selector;
			tag.update();
		}

		function scrollDeltaHandler(delta) {
			tag.trigger("scroll-delta", delta);
		}

	</script>	
</sam-roll-call>