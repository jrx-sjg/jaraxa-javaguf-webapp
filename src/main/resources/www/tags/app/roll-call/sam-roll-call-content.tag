<sam-roll-call-content>
	<guf-linear-layout ref="selector-container" class="selector-container" orientation="horizontal" v-align="center">
		<div class="line flex1"></div>
		<guf-segmented-control ref="list-selector" segmented-buttons="{guf.ancestor(this, 'sam-roll-call-content').segmentedButtons}" outline="true" dcss-border-color="@primary" dcss-button-background="transparent" dcss-button-background-selected="@primary" dcss-button-text-color="@primary" dcss-button-text-color-selected="#fff" dcss-border-radius="5px" initial-selected="0"></guf-segmented-control>
		<div class="line flex1"></div>
	</guf-linear-layout>
	<sam-roll-call-content-filtered ref="active-selector" if="{guf.ancestor(this, 'sam-roll-call-content').activeSelector === app.ROLL_CALL_LIST_SELECTOR.FILTERED}"></sam-roll-call-content-filtered>
	<sam-roll-call-content-marked ref="active-selector" if="{guf.ancestor(this, 'sam-roll-call-content').activeSelector === app.ROLL_CALL_LIST_SELECTOR.MARKED && app.rollCall.getMarked().length > 0}"></sam-roll-call-content-marked>
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
		}
		:scope > .selector-container {
			margin-bottom: 2px;
		}
		:scope > .selector-container > .line {
			height: 1px;
			background-color: @lines;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.segmentedButtons = [{
			ref: app.ROLL_CALL_LIST_SELECTOR.FILTERED,
			text: guf.i18n.get('app.filtered')
		},{
			ref: app.ROLL_CALL_LIST_SELECTOR.MARKED,
			text: guf.i18n.get('app.marked')
		}];
		tag.activeSelector = app.ROLL_CALL_LIST_SELECTOR.FILTERED;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function listSelectorClickHandler(buttonTag, segmentedTag, previousSelected) {
			tag.activeSelector = buttonTag.opts.ref;
			tag.trigger("selector", tag.activeSelector);
		}

		function searchHandler(value) {
			tag.trigger("search", value);
		}

		function initEvents() {
			tag.refs["selector-container"].refs["list-selector"].on("segmented-button-click", listSelectorClickHandler);
			initDynamicEvents();
		}

		function removeEvents() {
			tag.refs["selector-container"].refs["list-selector"].off("segmented-button-click", listSelectorClickHandler);
			removeDynamicEvents();
		}

		function removeDynamicEvents() {
			if (tag.refs["active-selector"]) tag.refs["active-selector"].off("search",searchHandler);
		}

		function initDynamicEvents() {
			if (tag.refs["active-selector"]) tag.refs["active-selector"].on("search",searchHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			removeDynamicEvents();
		});

		tag.on("updated", function() {
			initDynamicEvents();
		});

	</script>
</sam-roll-call-content>