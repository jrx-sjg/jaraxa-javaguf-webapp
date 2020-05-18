<sam-login>
	<guf-linear-layout ref="dialog" v-align="center" h-align="center">
		<div class="wrapper">
			<div class="mdl-card mdl-shadow--2dp">
				<div class="mdl-card__title center">
					<guf-linear-layout ref="dialog" v-align="center" h-align="center" orientation="horizontal" class="flex1">
						<guf-image imagesrc="img/sommet-logo-medium.png"></guf-image>
						<div>{guf.i18n.get('app.title')}</div>
					</guf-linear-layout>
				</div>
				<hr></hr>
				<guf-linear-layout ref="content" orientation="vertical" v-align="center" h-align="left" class="content">
					<div class="mdl-card__supporting-text" ref="subject">
						{guf.i18n.get('app.sign_in')}
					</div>
					<guf-input ref="username" placeholder="{guf.i18n.get('app.username')}" autocorrect="on" label="v2-outlined"></guf-input>
					<guf-input ref="password" type="{guf.ancestor(this,'sam-login').passwordVisible ? 'text' : 'password'}" placeholder="{guf.i18n.get('app.password')}" label="v2-outlined" trailing-icon="{guf.ancestor(this,'sam-login').passwordVisible ? 'visibility' : 'visibility_off'}" trailing-icon-fn="{guf.ancestor(this,'sam-login').togglePassword}"></guf-input>
					<guf-combo-box ref="campus" button-type="outline" full-width="true" placeholder="{guf.i18n.get('app.campus')}" item-tag="sam-campus-combo-box-item" label="floating" position="top-left" trailing-icon="arrow_drop_down" disabled="{guf.ancestor(this,'sam-login').campusDisabled}"></guf-combo-box>
					<guf-linear-layout ref="buttons" orientation="horizontal" h-align="right">
						<!--<guf-checkbox ref="rememberme" checked="{guf.ancestor(this, 'sam-login').rememberMe}" disabled="true">{guf.i18n.get('app.keep_me')}</guf-checkbox>-->
						<guf-button ref="login" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled" disabled="true">{guf.i18n.get('app.login')}</guf-button>
					</guf-linear-layout>
				</guf-linear-layout>
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
			background: @background; 
		}

		:scope > [ref="dialog"] {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			overflow-y: auto;
		}

		:scope > [ref="dialog"] > .wrapper {
			max-height: 100%;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card {
			overflow: visible;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > guf-linear-layout > * {
			width:100%;
		}

		:scope .center {
			justify-content: center;
		}

		:scope .mdl-card {
			border-radius: 5px;
			padding: 24px 0;
		}

		@media(min-width: 480px) {
			:scope .mdl-card {
				width: 450px;
			}
		}

		:scope hr {
			color: @lines;
		}

		:scope .mdl-card__supporting-text {
			padding: 0px;
			font-weight: 600;
			font-size: 18px;
			margin-top: 10px;
			margin-bottom: 20px;
			color: @darktext;
			text-transform: uppercase;
		}

		:scope div.label {
			width:100%;
			padding-left:0;
			padding-right:0;
		}

		:scope .mdl-card__title-text {
			min-height: 38px;
			font-weight: 400;
			font-size: 26px;
			color: rgba(0, 0, 0, 0.56);
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card {
			margin: 24px 0;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > .mdl-card__title > guf-linear-layout > div {
			color: @titleColor;
			font-size: 38px;
			font-weight: 300;
			text-transform: uppercase;
		}

		@media screen and (max-width: 500px) {
			:scope > [ref="dialog"] > .wrapper > .mdl-card > .mdl-card__title > guf-linear-layout > div {
				font-size: 24px;
			}
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > .mdl-card__title > guf-linear-layout > * {
			padding-left: 10px;
			padding-right: 10px;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > .content {
			margin:0 24px;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > [ref="content"] > [ref="buttons"] {
			width: 100%;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > [ref="content"] > [ref="buttons"] > [ref="rememberme"] {
			width: 100%;
		}

		:scope > [ref="dialog"] > .wrapper > .mdl-card > [ref="content"] > [ref="forgot-container"] > guf-button {
			padding: 4px 0px;
		}

	</style>
	<script>
		var tag = this;
		/* Login */
		var usernameInput = null;
		var passwordInput = null;
		var campusCombo = null;
		var loginBtn = null;
		var manualLogin = false;
		var campusId = null;
		var campuses = null;

		tag.passwordVisible = false;
		tag.campusDisabled = true;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"titleColor": "@primary",
			"lines": "@lines",
			"darktext": "@darktext",
			"background": "@background"
		};
		tag.mixin('mdl');

		function updateButtonsStatus() {
			if (usernameInput.getValue().length > 0 && 
				(passwordInput.getValue().length > 0 || passwordInput.isAutoFilled()) &&
				campusId != null) {
				loginBtn.enable();
			} else {
				loginBtn.disable();
			}
		}

		function login(username, password, campus, type, manual) {
			isConnecting = true;
			loginBtn.disable();
			app.ajax.post("api/login", {
				"email": username,
				"password": password,
				"campus": campus,
				"type": type
			}, function(data, xhr) {
				guf.storage.setItem(guf.storage.CURRENT, "username", username);
				guf.storage.setItem(guf.storage.CURRENT, "campus", campus);
				guf.storage.setItem(guf.storage.CURRENT, "wasLogged", true);
				me(manual);
			}, function(data, xhr) {
				loginBtn.enable();
				usernameInput.enable();
				passwordInput.enable();
				tag.campusDisabled = false;
				guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");
				app.clearMe();
				guf.createSnackbar(guf.i18n.get('app.invalid_username_or_password'), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				tag.update();
			});
		}

		function me(manual) {
			app.ajax.get("api/me", {
			}, function(data, xhr) {
				app.setMe(data.data);
				tag.trigger("logged");
			}, function(data, xhr) {
				loginBtn.enable();
				usernameInput.enable();
				passwordInput.enable();
				campusCombo.enable();
				guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");
				app.clearMe();
				guf.createSnackbar(guf.i18n.get('app.session_expired'), null, null, 2000);
				tag.update();
			});
		}

		// Events
		function passwordKeyupHandler(value, evt) {
			manualLogin = true;
			if (value.length>0 && evt.keyCode === 13 && usernameInput.getValue().length > 0 && campusId != null) {
				loginBtn.trigger('click');
			}
		}

		function loginButtonClickHandler(evt) {
			login(usernameInput.getValue(), passwordInput.getValue(), campusId, "manager", "manager", true);
		}

		function usernameKeyupHandler(value, evt) {
			if (value.length>0 && evt.keyCode === 13) {
				if (passwordInput.getValue().length > 0) {
					loginBtn.trigger('click');
				} else {
					passwordInput.focus();
				}
			}
		}

		function campusComboMenuClickHandler(itemTag) {
			campusId = itemTag.id;
			campusCombo.setText(itemTag.group + " - " + itemTag.campus);
			updateButtonsStatus();
		}

		function setCampusValue() {
			for (var i = 0; i < campuses.length; i++) {
				if (campuses[i].id == campusId) {
					campusCombo.setText(campuses[i].group + " - " + campuses[i].campus);
				}
			}
		}

		function initEvents() {
			passwordInput.on('input', updateButtonsStatus);
			passwordInput.on('keyup', passwordKeyupHandler);
			passwordInput.on('auto-fill', updateButtonsStatus);
			
			loginBtn.on('click', loginButtonClickHandler);
			usernameInput.on('input', updateButtonsStatus);
			usernameInput.on('keyup', usernameKeyupHandler);
			usernameInput.on('auto-fill', updateButtonsStatus);

			campusCombo.on("menu-click", campusComboMenuClickHandler);
		}

		function removeEvents() {
			passwordInput.off('input', updateButtonsStatus);
			passwordInput.off('keyup', passwordKeyupHandler);
			passwordInput.off('auto-fill', updateButtonsStatus);
			
			loginBtn.off('click', loginButtonClickHandler);
			usernameInput.off('input', updateButtonsStatus);
			usernameInput.off('keyup', usernameKeyupHandler);
			usernameInput.off('auto-fill', updateButtonsStatus);

			campusCombo.off("menu-click", campusComboMenuClickHandler);
		}

		tag.on('mount', function() {
			var content = tag.refs.dialog.refs.content;
			usernameInput = content.refs.username;
			passwordInput = content.refs.password;
			campusCombo = content.refs.campus;
			loginBtn = content.refs.buttons.refs.login;
			initEvents();
			app.ajax.get("api/campus", {
			}, function(data, xhr) {
				campuses = data.data;
				campusCombo.setOptions(data.data);
				tag.campusDisabled = false;
				campusId = guf.storage.getItem(guf.storage.CURRENT, "campus", null);
				if (campusId != null) {
					setCampusValue();
				}
				tag.update();
			}, function(data, xhr) {
			});			
		});

		tag.on('before-unmount', function() {
			removeEvents();
		});

		tag.togglePassword = function() {
			tag.passwordVisible = !tag.passwordVisible;
			passwordInput.update();
		}

	</script>
</sam-login>