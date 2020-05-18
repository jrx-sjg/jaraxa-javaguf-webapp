<sam-users-maintenance-header>
	<sam-users-maintenance-header-content ref="content"></sam-users-maintenance-header-content>
	<sam-users-maintenance-list-header if="{guf.ancestor(this, 'sam-users-maintenance-header').opts.data.length > 0}"></sam-users-maintenance-list-header>
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
		:scope > sam-users-maintenance-header-content {
			margin-top: 26px;
			margin-bottom: 26px;
		}
	</style>
	<script>
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
		};
		tag.mixin('mdl');

		function addUserClickHandler(aTag) {
			tag.trigger("add-user-click", aTag);
		}

		function initEvents() {
			tag.refs["content"].on("add-user-click", addUserClickHandler);
		}

		function removeEvents() {
			tag.refs["content"].off("add-user-click", addUserClickHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-users-maintenance-header>