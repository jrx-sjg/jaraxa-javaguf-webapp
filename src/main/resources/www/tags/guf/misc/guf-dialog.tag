<guf-dialog>
	<button ref="focus-gain" autofocus="true" class="focus-gain"></button>
	<div if="{fullscreen && guf.device.isIos}" class="ios-statusbar guf-safe-height-top"></div>
	<guf-linear-layout ref="horizontal-wrapper" orientation="horizontal" h-align="{center: !guf.ancestor(this,'guf-dialog').fullscreen}" class="horizontal-wrapper {fullscreen: fullscreen, scrollable: scrollable, ellipsis: ellipsis}">
		<div if="{!guf.ancestor(this,'guf-dialog').fullscreen}" class="overlay"></div>
		<guf-linear-layout ref="vertical-wrapper" orientation="vertical" v-align="{center: !guf.ancestor(this,'guf-dialog').fullscreen}" class="vertical-wrapper">
			<guf-linear-layout ref="dialog" orientation="vertical" class="dialog">
				<header if="{guf.ancestor(this,'guf-dialog').fullscreen}" class="mdl-layout__header">
					<div class="mdl-layout__header-row">
						<guf-button if="{guf.ancestor(this,'guf-dialog').nok}" ref="nok" type="icon" icon="close" ripple="true" color="true" dcss-background="{guf.ancestor(this,'guf-dialog').fsActionsColor}" class="close">
						</guf-button>
						<span class="mdl-layout-title dialog-title">{guf.ancestor(this,'guf-dialog').dialogTitle}</span>
						<div class="mdl-layout-spacer"></div>
						<guf-button if="{guf.ancestor(this,'guf-dialog').ok}" ref="ok" type="flat" ripple="true" color="true" dcss-background="{guf.ancestor(this,'guf-dialog').fsActionsColor}">
							{guf.ancestor(this,'guf-dialog').ok}
						</guf-button>
					</div>
				</header>
				<div if="{!guf.ancestor(this,'guf-dialog').fullscreen && guf.ancestor(this,'guf-dialog').dialogTitle}" class="dialog-title">
					{guf.ancestor(this,'guf-dialog').dialogTitle}
				</div>
				<guf-linear-layout ref="content" orientation="vertical" class="content">
					<yield/>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'guf-dialog').actionButtons}" ref="action-buttons" orientation="horizontal" h-align="right" class="action-buttons">
					<guf-button if="{guf.ancestor(this,'guf-dialog').nok}" ref="nok" type="flat" ripple="true" color="true">
						{guf.ancestor(this,'guf-dialog').nok}
					</guf-button>
					<guf-button if="{guf.ancestor(this,'guf-dialog').ok}" ref="ok" type="flat" ripple="true" color="true">
						{guf.ancestor(this,'guf-dialog').ok}
					</guf-button>
				</guf-linear-layout>
			</guf-linear-layout>
		</guf-linear-layout>
	</guf-linear-layout>
	<style scoped type="text/dcss">
		:scope {
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			z-index: 999999997;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-flow: column;
			-moz-flex-flow: column;
			-ms-flex-flow: column;
			flex-flow: column;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .focus-gain {
			opacity: 0;
			position: absolute;
			top: -90000px;
		}
		.guf-device-ios :scope > .horizontal-wrapper:not(.fullscreen),
		.guf-device-ios :scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content,
		.guf-device-ios :scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .content {
			-webkit-overflow-scrolling: touch;
		}
		.guf-device-ios :scope > div.ios-statusbar {
			display: block;
			background-color: @headerBackground;
			z-index: 101;
		}
		:scope,
		:scope > .horizontal-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			min-width: 0;
			min-height: 0;
		}
		:scope > .horizontal-wrapper.fullscreen,
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable,
		:scope > .horizontal-wrapper > .vertical-wrapper,
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog,
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .horizontal-wrapper:not(.fullscreen) {
			padding: 24px;
			position: relative;
		}
		:scope > .horizontal-wrapper:not(.fullscreen):not(.scrollable) {
			-webkit-flex: 1 0 auto;
			-ms-flex: 1 0 auto;
			flex: 1 0 auto;
		}
		:scope > .horizontal-wrapper > .overlay {
			position: fixed;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			z-index: 999999998;
			background-color: @overlayColor;
		}
		.guf-device-ios :scope > .horizontal-wrapper > .overlay {
			position: absolute;
		}
		:scope > .horizontal-wrapper:not(.fullscreen) > .vertical-wrapper {
			max-width: @maxWidth;
			min-width: @minWidth;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog {
			background-color: @background;
			z-index: 999999999;
		}
		:scope > .horizontal-wrapper:not(.fullscreen) > .vertical-wrapper > .dialog {
			-webkit-border-radius: 2px;
			-moz-border-radius: 2px;
			border-radius: 2px;
			box-shadow: 0 9px 46px 8px rgba(0,0,0,.14), 0 11px 15px -7px rgba(0,0,0,.12), 0 24px 38px 3px rgba(0,0,0,.2);
		}
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable > .vertical-wrapper > .dialog {
			max-height: 100%;
			min-height: @minHeight;
			-webkit-flex: 0 1 auto;
			-ms-flex: 0 1 auto;
			flex: 0 1 auto;
		}
		:scope > .horizontal-wrapper:not(.fullscreen):not(.scrollable) > .vertical-wrapper > .dialog {
			-webkit-flex: 0 0 auto;
			-ms-flex: 0 0 auto;
			flex: 0 0 auto;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			background-color: @headerBackground;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row {
			padding-left: 40px;
		}
		.guf-screen-narrow :scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row {
			padding-left: 16px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row > .close {
			margin-right: 16px;
		}
		:scope > .horizontal-wrapper.ellipsis > .vertical-wrapper > .dialog .dialog-title {
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			word-break: break-all;
			line-height: normal;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row > .dialog-title {
			-webkit-flex: 0 1 auto;
			-ms-flex: 0 1 auto;
			flex: 0 1 auto;
			color: @fsHeaderColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .dialog-title {
			padding: @headerPadding;
			font-size: 20px;
			line-height: 28px;
			color: @headerColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			color: @contentColor;
		}
		:scope > .horizontal-wrapper:not(.fullscreen) > .vertical-wrapper > .dialog > .content {
			padding: @contentPadding;
		}
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content,
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable > .vertical-wrapper > .dialog > .content {
			overflow-y: auto;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons {
			padding: 8px 8px 8px 24px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons > guf-button:not(:first-child) {
			margin-left: 8px;
		}
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable > .vertical-wrapper > .dialog > .dialog-title,
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content > *,
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable > .vertical-wrapper > .dialog > .content > *,
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable > .vertical-wrapper > .dialog > .action-buttons {
			flex-shrink: 0;
		}
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable.top-scroll-divider > .vertical-wrapper > .dialog > .dialog-title {
			border-bottom: 1px solid #dcdcdc;
		}
		:scope > .horizontal-wrapper:not(.fullscreen).scrollable.bottom-scroll-divider > .vertical-wrapper > .dialog > .action-buttons {
			border-top: 1px solid #dcdcdc;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		/*
		 * Parameters:
		 * 	boolean: 	opts.fullscreen
		 *	boolean: 	opts.scrollable
		 * 	boolean: 	opts.headerEllipsis
		 * 	string: 	opts.ok
		 * 	string: 	opts.nok
		 *	string: 	opts.dialogTitle
		 * 	boolean: 	opts.dismissible
		 */

		// Properties
		tag.fullscreen = guf.param.booleanExpr(opts, "fullscreen", false);
		tag.scrollable = guf.param.booleanExpr(opts, "scrollable", false) && !tag.fullscreen;
		tag.ellipsis = guf.param.booleanExpr(opts, "headerEllipsis", false);
		tag.ok = !!opts.ok ? guf.param.string(opts.ok, null) : null;
		tag.nok = !!opts.nok ? guf.param.string(opts.nok, null) : null;
		tag.dialogTitle = guf.param.string(opts.dialogTitle, null);
		tag.dismissible = guf.param.booleanExpr(opts, "dismissible", false);
		tag.actionButtons = !tag.fullscreen && (tag.ok || tag.nok);

		// Dcss
		tag.defaultDcss = {
			// - material default values
			"overlayColor": "rgba(0, 0, 0, 0.15)",
			"minWidth": "168px",
			"minHeight": "190px",
			"background": "#fff",
			"headerBackground": "@primary",
			"headerPadding": "24px 24px 20px 24px",
			"headerColor": "#000",
			"fsHeaderColor": "#fff",
			"contentColor": "rgba(0,0,0,.54)",
			"contentPadding": "0 24px 24px 24px",
			// - custom
			"maxWidth": "600px"
		};
		tag["actionsColor"] = guf.param.string(opts.dcssActionsColor, null);
		tag["fsActionsColor"] = guf.param.string(opts.dcssFsActionsColor, "white");

		// Mixins
		tag.mixin('mdl');

		// Methods
		tag.content = function () {
			return content;
		};

		tag.enableOkButton = function() {
			if (okButton) okButton.enable();
		};

		tag.disableOkButton = function() {
			if (okButton) okButton.disable();
		};

		tag.enableNokButton = function() {
			if (nokButton) nokButton.enable();
		};

		tag.disableNokButton = function() {
			if (nokButton) nokButton.disable();
		};

		tag.updateScrollBorders = function () {
			if (content) {
				var container = content.root;
				if (container.scrollTop > 0) tag.refs["horizontal-wrapper"].root.classList.add('top-scroll-divider');
				else tag.refs["horizontal-wrapper"].root.classList.remove('top-scroll-divider');
				if ((container.offsetHeight + container.scrollTop )< container.scrollHeight) tag.refs["horizontal-wrapper"].root.classList.add('bottom-scroll-divider');
				else tag.refs["horizontal-wrapper"].root.classList.remove('bottom-scroll-divider');
			}
		};

		// References
		var dialog = null;
		var content = null;
		var okButton = null;
		var nokButton = null;

		function initReferences() {
			dialog = tag.refs["horizontal-wrapper"].refs["vertical-wrapper"].refs["dialog"];
			content = dialog.refs["content"];
			if (tag.ok) okButton = tag.fullscreen ? dialog.refs["ok"] : dialog.refs["action-buttons"].refs["ok"];
			if (tag.nok) nokButton = tag.fullscreen ? dialog.refs["nok"] : dialog.refs["action-buttons"].refs["nok"];
		}

		// Private
		function _safeBlur(element) {
			if (element && element.blur && element != document.body) {
				element.blur();
			}
		}

		function _focusHandler(event) {
			if (!tag.root.contains(event.target)) {
				event.preventDefault();
				event.stopPropagation();
				_safeBlur(event.target);
			}
		}

		function blockDocument() {
			document.body.addEventListener('focus', _focusHandler, true);
		}

		function unblockDocument() {
			document.body.removeEventListener('focus', _focusHandler, true);
		}

		function blurDocument() {
			_safeBlur(document.activeElement);
			tag.refs["focus-gain"].focus();
		}

		function initView() {
			blurDocument();
			if (guf.device.isIos) guf.disableMomentumScrolling(true);
			blockDocument();
		}

		function closeView() {
			if (guf.device.isIos) guf.disableMomentumScrolling(false);
			unblockDocument();
		}

		// Events
		function okButtonClickHandler() {
			tag.trigger("ok", tag);
		}

		function nokButtonClickHandler() {
			tag.trigger("nok", tag);
		}

		function dismissHandler(event) {
			if (!dialog.root.contains(event.target)) nokButtonClickHandler();
		}

		function escPressHandler(event) {
			if ((event.key!==null && event.key.toLowerCase()==="escape") || event.keyCode == 27) {
				event.preventDefault();
				event.stopPropagation();
				nokButtonClickHandler();
			}
		}

		function initEvents() {
			if (okButton) okButton.on('click', okButtonClickHandler);
			if (nokButton) nokButton.on('click', nokButtonClickHandler);
			if (!tag.fullscreen && tag.dismissible) {
				tag.root.addEventListener('click', dismissHandler);
				document.addEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.addEventListener("backbutton", nokButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.addEventListener('scroll', tag.updateScrollBorders);
				window.addEventListener('resize', tag.updateScrollBorders);
			}
		}

		function removeEvents() {
			if (okButton) okButton.off('click', okButtonClickHandler);
			if (nokButton) nokButton.off('click', nokButtonClickHandler);
			if (!tag.fullscreen && tag.dismissible) {
				tag.root.addEventListener('click', dismissHandler);
				document.addEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.addEventListener("backbutton", nokButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.removeEventListener('scroll', tag.updateScrollBorders);
				window.removeEventListener('resize', tag.updateScrollBorders);
			}
		}

		tag.on('mount', function () {
			initView();
			initReferences();
			initEvents();
		});

		tag.on('before-unmount', function () {
			removeEvents();
			closeView();
		});
	</script>
</guf-dialog>