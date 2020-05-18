<sam-users-maintenance-list-header>
	<div class="institution-column">{guf.i18n.get('app.institution').toUpperCase()}</div>
	<div class="email-column flex1">{guf.i18n.get('app.email').toUpperCase()}</div>
	<div class="last-name-column">{guf.i18n.get('app.last_name').toUpperCase()}</div>
	<div class="first-name-column">{guf.i18n.get('app.first_name').toUpperCase()}</div>
	<div class="roles-column">{guf.i18n.get('app.roles').toUpperCase()}</div>
	<div class="active-column">{guf.i18n.get('app.active').toUpperCase()}</div>
	<div class="last-connection-column">{guf.i18n.get('app.last_connection').toUpperCase()}</div>
	<div class="actions-column"></div>
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
			border: 1px solid @lines;
			border-top-left-radius: 10px;
			border-top-right-radius: 10px;
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
			color: @primary;
		}
		:scope > .institution-column {
			width: 80px;
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
		}
		:scope > .last-connection-column {
			width: 140px;
		}
		:scope > .actions-column {
			width: 50px;
			border-right: 0;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines"
		};
		tag.mixin('mdl');
	</script>
</sam-users-maintenance-list-header>