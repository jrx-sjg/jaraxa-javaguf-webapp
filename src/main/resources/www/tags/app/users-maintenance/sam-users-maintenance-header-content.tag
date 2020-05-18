<sam-users-maintenance-header-content>
	<div class="header">{guf.i18n.get("app.users_maintenance")}</div>
	<div class="flex1"></div>
	<guf-button ref="add-user-button" type="flat" color="true" icon="person_add" icon-outlined="true" dcss-border="1px solid @lines">{guf.i18n.get('app.add_user')}</guf-button>
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
		}
		:scope > div.header {
			color: @primary;
			font-family: chronicle-deck, serif;
			font-size: 22px;
			height: 24px;
			font-weight:600;
		}
	</style>
	<script>
		var tag = this;
		tag.users = [{}];
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function addUserClickHandler() {
			tag.trigger("add-user-click", tag);
		}

		function initEvents() {
			tag.refs["add-user-button"].on("click", addUserClickHandler);
		}

		function removeEvents() {
			tag.refs["add-user-button"].off("click", addUserClickHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-users-maintenance-header-content>