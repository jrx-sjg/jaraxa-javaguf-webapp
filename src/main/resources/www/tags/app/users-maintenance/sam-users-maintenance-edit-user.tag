<sam-users-maintenance-edit-user>
	<guf-linear-layout ref="container" orientation="vertical" class="container flex1">
		<div class="header">{guf.i18n.get("app.users_maintenance")}</div>
		<div class="content">
			<div class="content-title">{guf.i18n.get("app.edit_user").toUpperCase()}</div>
			<div class="content-body">
				<guf-linear-layout ref="left-column" orientation="vertical" class="flex1">
					<guf-combo-box ref="institution-combo" class="field" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-campus-combo-box-item" placeholder="{guf.i18n.get('app.institution')}"></guf-combo-box>
					<guf-input ref="email" type="email" class="field" placeholder="{guf.i18n.get('app.email')}" autocorrect="off" label="v2-outlined" invalid="{guf.i18n.get('app.email_address_invalid')}"></guf-input>
					<guf-combo-box ref="roles-combo" class="field" position="top-right" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.roles')}" item-tag="sam-class-combo-box-item"></guf-combo-box>
				</guf-linear-layout>
				<guf-linear-layout ref="right-column" orientation="vertical" class="flex1">
					<guf-input ref="last-name" class="field" placeholder="{guf.i18n.get('app.last_name')}" autocorrect="off" label="v2-outlined"></guf-input>
					<guf-input ref="first-name" class="field" placeholder="{guf.i18n.get('app.first_name')}" autocorrect="off" label="v2-outlined"></guf-input>
					<div class="radios-container">
						<guf-radio ref="active" name="edit-user" dcss-text-color="@lighttext">{guf.i18n.get('app.active')}</guf-radio>
						<guf-radio ref="deactivate" name="edit-user" dcss-text-color="@lighttext">{guf.i18n.get('app.deactivate')}</guf-radio>
					</div>
				</guf-linear-layout>
			</div>
			<div class="content-actions">
				<div class="left-action-column flex1">
					<guf-button ref="cancel-button" type="flat" color="true" icon="close" icon-outlined="true" dcss-border="1px solid @lines">{guf.i18n.get('guf.cancel')}</guf-button>
				</div>
				<div class="right-action-column flex1">
					<guf-button ref="save-button" type="flat" color="true" icon="save" icon-outlined="true" dcss-border="1px solid @lines" dcss-background-disabled="@lines" dcss-text-color-disabled="white" disabled="true">{guf.i18n.get('guf.save')}</guf-button>
				</div>
			</div>
		</div>
	</guf-linear-layout>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			background-color: @lightestbackground;
			overflow: auto;
		}
		:scope > guf-linear-layout {
			min-width: 900px;
		}
		:scope > guf-linear-layout > .header {
			color: @primary;
			font-family: chronicle-deck, serif;
			font-size: 22px;
			height: 24px;
			font-weight:600;
			margin: 26px;
		}
		:scope > guf-linear-layout > .content {
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
			border-radius: 10px;
			margin: 0 26px;
		}
		:scope > guf-linear-layout > .content > .content-title {
			color: @primary;
			font-size: 16px;
			border-bottom: 1px solid @lines;
			padding: 16px;
		}
		:scope > guf-linear-layout > .content > .content-body {
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
			border-bottom: 1px solid @lines;
		}
		:scope > guf-linear-layout > .content > .content-body > guf-linear-layout[ref="left-column"] {
			margin: 26px 40px 26px 80px;
		}
		:scope > guf-linear-layout > .content > .content-body > guf-linear-layout[ref="right-column"] {
			margin: 26px 80px 26px 40px;
		}
		:scope > guf-linear-layout > .content > .content-body > guf-linear-layout[ref="right-column"] > .radios-container {
			margin-top: 20px;
		}
		:scope > guf-linear-layout > .content > .content-body > guf-linear-layout[ref="right-column"] > .radios-container > guf-radio {
			margin-right: 30px;
		}
		:scope > guf-linear-layout > .content > .content-actions {
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
			justify-content: center;
		}
		:scope > guf-linear-layout > .content > .content-actions > div {
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
		}
		:scope > guf-linear-layout > .content > .content-actions > .left-action-column {
			margin: 16px 40px 16px 80px;
			justify-content: flex-end;
		}
		:scope > guf-linear-layout > .content > .content-actions > .right-action-column {
			margin: 16px 80px 16px 40px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var institutionCombo, emailField, rolesCombo, lastNameField, firstNameField;
		var activeRadio, deactivateRadio;
		var cancelButton, saveButton;

		var userData = opts.user;
		var currentInstitution = "", currentRoles;
		var selectedRoles = [], originalRoles = [];

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl', 'after-mount');

		function updateSaveStatus() {
			var saveButtonEnabled = true;
			if(currentInstitution.length <= 0) {
				saveButtonEnabled = false;
			}
			if(emailField.getValue().length <= 0 || !emailField.isValid()) {
				saveButtonEnabled = false;
			}
			if(lastNameField.getValue().length <= 0) {
				saveButtonEnabled = false;
			}
			if(firstNameField.getValue().length <= 0) {
				saveButtonEnabled = false;
			}
			saveButtonEnabled ? saveButton.enable() : saveButton.disable();
		}

		function updateRolesText() {
			var rolesText = "";
			for (var i = 0; i < selectedRoles.length; i++) {
				if (i > 0) {
					rolesText += ", ";
				}
				rolesText += selectedRoles[i];
			}
			currentRoles = rolesText;
		}

		function closeOpenedCombo() {
			institutionCombo.closeMenu();
			rolesCombo.closeMenu();
		}

		function institutionComboClickHandler(itemTag) {
			currentInstitution = itemTag.id;
			institutionCombo.setText(itemTag.group + " - " + itemTag.campus);
			updateSaveStatus();
		}

		function roleSelectHandler(role, itemTag) {
			selectedRoles.push(role);
			selectedRoles = originalRoles.filter(function(e) {
				return selectedRoles.indexOf(e) >= 0;
			});
			updateRolesText();
			rolesCombo.setText(currentRoles);
		}

		function roleDeselectHandler(role, itemTag) {
			var index = selectedRoles.indexOf(role);
			if(index != -1) {
				selectedRoles.splice(index, 1);
			}
			updateRolesText();
			rolesCombo.setText(currentRoles);
		}

		function cancelClickHandler() {
			tag.trigger("cancel-click", tag);
		}

		function saveClickHandler() {
			saveButton.disable();
			var params = guf.utils.cloneObject(userData);
			params.active = activeRadio.isToggled();
			params.campus = currentInstitution;
			params.firstName = firstNameField.getValue();
			params.lastName = lastNameField.getValue();
			params.userEmail = emailField.getValue();
			params.roles = selectedRoles;
			app.ajax.put("api/users/" + userData.id, params
			, function(response, xhr) {
				if(response.success) {
					tag.trigger("saved", tag);
				} else {
					guf.console.error("Error updating user", response);
					saveButton.enable();
				}
			}, function(response, xhr) {
				guf.console.error("Error updating user", response);
				saveButton.enable();
			}, {
				"Content-Type": "application/json"
			});
		}

		function initView() {
			institutionCombo = tag.refs["container"].refs["left-column"].refs["institution-combo"];
			emailField = tag.refs["container"].refs["left-column"].refs["email"];
			rolesCombo = tag.refs["container"].refs["left-column"].refs["roles-combo"];
			lastNameField = tag.refs["container"].refs["right-column"].refs["last-name"];
			firstNameField = tag.refs["container"].refs["right-column"].refs["first-name"];
			activeRadio = tag.refs["container"].refs["right-column"].refs["active"];
			deactivateRadio = tag.refs["container"].refs["right-column"].refs["deactivate"];
			cancelButton = tag.refs["container"].refs["cancel-button"];
			saveButton = tag.refs["container"].refs["save-button"];
		}

		function initEvents() {
			institutionCombo.on("menu-click", institutionComboClickHandler);
			emailField.on("input", updateSaveStatus);
			emailField.on("focus", closeOpenedCombo);
			rolesCombo.on("option-select", roleSelectHandler);
			rolesCombo.on("option-deselect", roleDeselectHandler);
			lastNameField.on("input", updateSaveStatus);
			lastNameField.on("focus", closeOpenedCombo);
			firstNameField.on("input", updateSaveStatus);
			firstNameField.on("focus", closeOpenedCombo);
			activeRadio.on("radio-click", closeOpenedCombo);
			deactivateRadio.on("radio-click", closeOpenedCombo);
			cancelButton.on("click", cancelClickHandler);
			saveButton.on("click", saveClickHandler);
		}

		function removeEvents() {
			institutionCombo.off("menu-click", institutionComboClickHandler);
			emailField.off("input", updateSaveStatus);
			emailField.off("focus", closeOpenedCombo);
			rolesCombo.off("option-select", roleSelectHandler);
			rolesCombo.off("option-deselect", roleDeselectHandler);
			lastNameField.off("input", updateSaveStatus);
			lastNameField.off("focus", closeOpenedCombo);
			firstNameField.off("input", updateSaveStatus);
			firstNameField.off("focus", closeOpenedCombo);
			activeRadio.off("radio-click", closeOpenedCombo);
			deactivateRadio.off("radio-click", closeOpenedCombo);
			cancelButton.off("click", cancelClickHandler);
			saveButton.off("click", saveClickHandler);
		}

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("after-mount", function() {
			institutionCombo.setOptions(opts.campus);
			originalRoles = opts.roles;
			rolesCombo.setOptions(originalRoles);
			currentInstitution = userData.campus.id;
			institutionCombo.setText(userData.campus.group + " - " + userData.campus.campus);
			emailField.setValue(userData.userEmail);
			selectedRoles = guf.utils.cloneObject(userData.roles);
			updateRolesText();
			rolesCombo.setText(currentRoles);
			rolesCombo.setSelectedOptions(selectedRoles);
			lastNameField.setValue(userData.lastName);
			firstNameField.setValue(userData.firstName);
			userData.active ? activeRadio.setToggle(true) : deactivateRadio.setToggle(true);
			updateSaveStatus();
		});
	</script>
</sam-users-maintenance-edit-user>