<sam-class-records-content>
	<guf-linear-layout orientation="horizontal" class="flex1">
		<div class="flex1"></div>
		<guf-button ref="submit-button" type="flat" color="true" icon="arrow_downward" dcss-border="1px solid @lines" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines" disabled="{guf.ancestor(this, 'sam-class-records-content').submitDisabled}">{guf.i18n.get('app.submit')}</guf-button>
	</guf-linear-layout>
	<sam-class-title anchor="false">{guf.ancestor(this, 'sam-class-records-content').getFilterResume(guf.ancestor(this, 'sam-class-records-content').opts.data)}</sam-class-title>
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
		:scope > sam-class-title {
			margin-top: 20px;
		}
		:scope > .selection-type-container {
			padding: 0 26px;
			margin-bottom: 20px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var submitButton;

		tag.submitDisabled = !opts.data.canSubmit;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function submitClickHandler() {
			submitButton.disable();
			tag.trigger("submit-click", tag);
		}

		function initView() {
			submitButton = tag.tags["guf-linear-layout"].refs["submit-button"];
		}

		function initEvents() {
			submitButton.on("click", submitClickHandler);
		}

		function removeEvents() {
			submitButton.off("click", submitClickHandler);
		}

		tag.getFilterResume = function(item) {
			var separator = " / ";
			var result = item.period + separator + item.program + separator + item.course + separator + guf.i18n.get('app.class') + " " + item.className;
			return result;
		};

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

	</script>
</sam-class-records-content>