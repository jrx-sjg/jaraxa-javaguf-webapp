<sam-app-launcher>
	<sam-canvas ref="canvas" if="{logged}"></sam-canvas>
	<sam-login ref="login" if="{!wasLogged && !logged}"></sam-login>
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
			overflow: auto;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.logged = false;
		tag.wasLogged = !!guf.storage.getItem(guf.storage.CURRENT, "wasLogged", false);
		tag.mixin('mdl');

		function loginHandler() {
			tag.logged = true;
			tag.refs.login.off("logged", loginHandler);
			tag.update();
		}

		function logoutHandler() {
			tag.logged = false;
			tag.wasLogged = false;
			tag.refs.canvas.off("logged", loginHandler);
			tag.update();
		}

		function me(manual) {
			app.ajax.get("api/me", {
			}, function(data, xhr) {
				app.setMe(data.data);
				tag.logged = true;
				window.importDone();
				tag.update();
			}, function(data, xhr) {
				app.clearMe();
				guf.route.to("", undefined, true);
				guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");
				tag.wasLogged = false;
				guf.createSnackbar(guf.i18n.get('app.session_expired'), null, null, 2000);
				window.importDone();
				tag.update();
			});
		}

		function checkAndSetEvents() {
			if (tag.wasLogged) {
				var username = guf.storage.getItem(guf.storage.CURRENT, "username", null);
				var campus = guf.storage.getItem(guf.storage.CURRENT, "campus", null);
				if (tag.wasLogged && username != null && campus != null) {
					me();
				} else {
					guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");
					tag.wasLogged = false;
					tag.update();
				}
			} else {
				window.importDone();
			}
			setEvents();
			app.on("session-expired", function() {
				if (tag.logged) {
					app.clearMe();
					guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");
					logoutHandler();
					guf.route.to("", undefined, true);
					guf.createSnackbar(guf.i18n.get('app.session_expired'), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				}
			});
		}

		function setEvents() {
			if (!tag.wasLogged && !tag.logged) {
				tag.refs.login.on("logged", loginHandler);
			} else if (tag.logged) {
				tag.refs.canvas.on("logged-out", logoutHandler);
			}
		}

		tag.on("updated", setEvents);
		tag.on("mount", checkAndSetEvents);
	</script>
</sam-app-launcher>