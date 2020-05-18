<sam-users-maintenance>
	<guf-linear-layout ref="container" orientation="vertical" class="{container: 1, empty: guf.ancestor(this, 'sam-users-maintenance').users.length == 0}">
		<div class="scrollable-content">
			<sam-users-maintenance-header ref="sticky" data="{guf.ancestor(this, 'sam-users-maintenance').users}" content="{guf.ancestor(this, 'sam-users-maintenance').users != null}"></sam-users-maintenance-header>
			<sam-empty if="{guf.ancestor(this, 'sam-users-maintenance').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-users-maintenance').loading && guf.ancestor(this, 'sam-users-maintenance').users.length == 0}" class="flex1" icon="person" text="{guf.i18n.get('app.users_maintenance_empty_text')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-users-maintenance').users.length > 0}">
				<sam-users-maintenance-list-row each={item in guf.ancestor(this, 'sam-users-maintenance').users}></sam-users-maintenance-list-row>
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
		.guf-device-old-ios :scope > guf-linear-layout:not(.empty) {
			min-width: 1024px;
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
		:scope > guf-linear-layout > div.scrollable-content > sam-users-maintenance-header {
			margin: 0 26px;
			position: -webkit-sticky;
			position: sticky;
			top: 0;
			background: @lightestbackground;
			z-index: 1;
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
			margin-bottom: 20px;
		}
		body.guf-rendering-engine-webkit :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-gecko :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-msedge :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-msie :scope > guf-linear-layout > div.scrollable-content > div[ref="content"] {
			margin-bottom: 0px;
			padding-bottom: 20px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > * {
			margin: 0 26px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-users-maintenance-list-row {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-users-maintenance-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script>
		var tag = this;
		tag.users = [];
		tag.campus = [];
		tag.roles = [];
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');
		tag.loading = false;

		function getCampusForId(campusId) {
			for(var i=0; i<tag.campus.length; i++) {
				if(tag.campus[i].id === campusId) {
					return tag.campus[i];
				}
			}
		}

		function createDisplayData(serverData) {
			var result = [];
			for(var i=0; i<serverData.length; i++) {
				var item = guf.utils.cloneObject(serverData[i]);
				item.campus = getCampusForId(item.campus);
				result.push(item);
			}
			return result;
		}

		function deleteUser(userId) {
			var index = -1;
			for(var i=0; i<tag.users.length; i++) {
				if(tag.users[i].id === userId) {
					index = i;
					break;
				}
			}
			if(index != -1) {
				tag.users.splice(index, 1);
				tag.update();
			}
		}

		function loadUsers() {
			tag.loading = true;
			var campusPromise = new Promise(function(resolve, reject) {
				app.ajax.get("api/campus", {
				}, function(data, xhr) {
					resolve(data.data);
				}, function(data, xhr) {
					resolve([]);
				});
			});
			var rolesPromise = new Promise(function(resolve, reject) {
				app.ajax.get("api/role", {
				}, function(data, xhr) {
					resolve(data.data);
				}, function(data, xhr) {
					resolve([]);
				});
			});
			var usersPromise = new Promise(function(resolve, reject) {
				app.ajax.get("api/users", {
				}, function(response, xhr) {
					resolve(response.data);
				}, function(response, xhr) {
					resolve([]);
				});
			});
			Promise.all([campusPromise, rolesPromise, usersPromise]).then(function(result) {
				tag.loading = false;
				tag.campus = result[0];
				tag.roles = result[1];
				tag.users = createDisplayData(result[2]);
				tag.update();
			});
			tag.update();
		}

		function addUserClickHandler() {
			tag.trigger("add-user-click", tag);
		}

		function editClickHandler(itemTag, itemData) {
			tag.trigger("edit-user-click", tag, itemTag, itemData);
		}

		function deleteClickHandler(itemTag, itemData) {
			guf.createDialog(guf.i18n.get('guf.warning'), guf.i18n.get('app.delete_user_confirm'), guf.i18n.get('guf.yes'), guf.i18n.get('guf.no'),
				function () {
					app.ajax.delete("api/users/" + itemData.id, {}
					, function(response, xhr) {
						if(response.success) {
							deleteUser(itemData.id);
						} else {
							guf.console.error("Error deleting user", response);
						}
					}, function(response, xhr) {
						guf.console.error("Error deleting user", response);
					});
				},
				function () {
				}
			);
		}

		function initListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-users-maintenance-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].on("edit-click", editClickHandler);
				items[i].on("delete-click", deleteClickHandler);
			}
		}

		function removeListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-users-maintenance-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].off("edit-click", editClickHandler);
				items[i].off("delete-click", deleteClickHandler);
			}
		}

		function initEvents() {
			tag.refs["container"].refs["sticky"].on("add-user-click", addUserClickHandler);
			initListEvents();
		}

		function removeEvents() {
			tag.refs["container"].refs["sticky"].off("add-user-click", addUserClickHandler);
			removeListEvents();
		}

		tag.refreshData = function() {
			loadUsers();
		};

		tag.on("mount", function() {
			initEvents();
			loadUsers();
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
</sam-users-maintenance>