<sam-users-maintenance-list-row>
	<div class="institution-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').institution}</div>
	<div class="email-column flex1">{guf.ancestor(this, 'sam-users-maintenance-list-row').email}</div>
	<div class="last-name-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').lastName}</div>
	<div class="first-name-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').firstName}</div>
	<div class="roles-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').roles}</div>
	<div class="active-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').active.toUpperCase()}</div>
	<div class="last-connection-column">{guf.ancestor(this, 'sam-users-maintenance-list-row').lastConnection}</div>
	<div class="actions-column">
		<guf-button ref="edit-button" type="icon" color="true" icon="edit" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
		<guf-button ref="delete-button" type="icon" color="true" icon="delete_outline" icon-outlined="true" dcss-text-color="@accent" dcss-text-color-disabled="@lines"></guf-button>
	</div>
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
			height: 50px;
			overflow: hidden;
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
			border-right: 1px solid @background;
			padding: 0 16px;
			color: @lighttext;
			line-height: 1.2;
		}
		:scope > .institution-column {
			width: 80px;
			align-items: center;
		}
		:scope > .email-column {
			word-break: break-word;
			min-width: 100px;
		}
		:scope > .last-name-column {
			width: 100px;
		}
		:scope > .first-name-column {
			width: 100px;
		}
		:scope > .roles-column {
			width: 100px;
		}
		:scope > .active-column {
			width: 50px;
			align-items: center;
		}
		:scope > .last-connection-column {
			width: 140px;
		}
		:scope > .actions-column {
			width: 50px;
			border-right: 0;
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
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		tag.institution = tag.item.campus.group + " - " + tag.item.campus.campus;
		tag.email = tag.item.userEmail;
		tag.lastName = tag.item.lastName;
		tag.firstName = tag.item.firstName;
		tag.roles = createRolesString(tag.item.roles || []);
		tag.active = tag.item.active ? guf.i18n.get("guf.yes") : guf.i18n.get("guf.no");
		tag.lastConnection = tag.item.lastConnectionDate;

		function createRolesString(rolesArray) {
			var result = "";
			for(var i=0; i<rolesArray.length; i++) {
				if(i > 0) {
					result += ", ";
				}
				result += rolesArray[i];
			}
			return result;
		}

		function editClickHandler() {
			tag.trigger("edit-click", tag, tag.item);
		}

		function deleteClickHandler() {
			tag.trigger("delete-click", tag, tag.item);
		}

		function initEvents() {
			tag.refs["edit-button"].on("click", editClickHandler);
			tag.refs["delete-button"].on("click", deleteClickHandler);
		}

		function removeEvents() {
			tag.refs["edit-button"].off("click", editClickHandler);
			tag.refs["delete-button"].off("click", deleteClickHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-users-maintenance-list-row>