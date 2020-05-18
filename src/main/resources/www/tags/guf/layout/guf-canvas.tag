<guf-canvas>
	<div ref="main-layout" class="{mdl-layout:1, mdl-js-layout:1, mdl-card:cardWhenBig, mdl-shadow--2dp:cardWhenBig, mdl-layout--fixed-drawer:fixedDrawer, mdl-layout--fixed-header:fixedHeader, mdl-layout--noelevation: !elevation, hide-top-padding: hideTopPadding}">
		<header ref="main-header" class="mdl-layout__header {guf-safe-padding-top: !hideTopPadding}" if="{ hasHeader }">
			<div class="mdl-layout__header-row">
				<yield from="header-content"/>
			</div>
		</header>
		<div ref="drawer" class="mdl-layout__drawer {guf-safe-margin-top: !hideTopPadding}" if="{ hasDrawer }">
			<span class="mdl-layout-title" if="{ drawerTitle != null}">{ drawerTitle }</span>
			<div ref="drawer-content">
				<yield from ="drawer-content"/>
			</div>
		</div>
		<main class="mdl-layout__content canvas-content">
			<div class="page-content">
				<guf-tripane dcss-left-column-flex="{leftColumnFlex}" dcss-middle-column-flex="{middleColumnFlex}" dcss-right-column-flex="{rightColumnFlex}" dcss-middle-no-right-column-flex="{middleColumnFlex + rightColumnFlex}" left-column-flex-fixed="{leftColumnFlexFixed}" left-column-visible-for-popup="{leftColumnVisibleForPopup}" dcss-left-min-width="{leftMinWidth}" always-narrow="{alwaysNarrow}"></guf-tripane>
			</div>
		</main>
		<guf-snackbar-container></guf-snackbar-container>
	</div>
	<style scoped type="dcss">
		:scope {
			position: relative;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			color: @textDefault;
		}
		:scope > .mdl-layout__container {
			box-sizing: border-box;
		}
		:scope > .mdl-layout__container > div[ref="main-layout"] {
			overflow: hidden;
		}
		:scope > .mdl-layout__container > div[ref="main-layout"].mdl-card {
			width: 100%;
			height: 100%;
			max-width: @cardWidth;
			margin: auto;
			border-radius:0;
			box-shadow: 0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12);
			background: none;
		}
		@media screen and (min-width: @cardWidth) {
			:scope > .mdl-layout__container.cardWhenBig {
				padding: 16px 0;
			}
			:scope > .mdl-layout__container > div[ref="main-layout"].mdl-card {
				border-radius:2px;
			}
		}

		.page-content {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			min-width: 0;
		}
		.page-content guf-tripane {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		.flex1 {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		div[ref="main-layout"] > .mdl-layout__header {
			background-color: @background;
		}
		.guf-orientation-portrait :scope div[ref="main-layout"]:not(.hide-top-padding) header[ref="main-header"] > .mdl-layout__drawer-button {
			padding-top: @safeAreaTopPortrait;
		}
		.guf-orientation-portrait :scope div[ref="main-layout"]:not(.hide-top-padding) .mdl-layout__obfuscator {
			margin-top: @safeAreaTopPortrait;
		}
		.guf-orientation-landscape :scope div[ref="main-layout"]:not(.hide-top-padding) header[ref="main-header"] > .mdl-layout__drawer-button {
			padding-top: @safeAreaTopLandscape;
		}
		.guf-orientation-landscape :scope div[ref="main-layout"]:not(.hide-top-padding) .mdl-layout__obfuscator {
			margin-top: @safeAreaTopLandscape;
		}

		body.guf-screen-narrow :scope div[ref="main-layout"] > header[ref="main-header"] > div.mdl-layout__header-row {
			padding-left: 56px;
		}

		.canvas-content {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
		}
		:scope.maximized .mdl-layout__header {
			display: none;
		}

		:scope .mdl-layout--noelevation > .mdl-layout__header {
			box-shadow: none;
		}
	</style>
	<script>
		var tag = this;
		tag.hasHeader = guf.param.booleanExpr(opts, "header", false);
		tag.hasDrawer = guf.param.booleanExpr(opts, "drawer", false);
		tag.drawerTitle = guf.param.string(opts.drawerTitle, null);
		tag.cardWhenBig = guf.param.booleanExpr(opts, "cardWhenBig", false);
		tag.fixedHeader = guf.param.booleanExpr(opts, "fixedHeader", false);
		tag.fixedDrawer = guf.param.booleanExpr(opts, "fixedDrawer", false);
		tag.elevation = guf.param.booleanExpr(opts, "elevation", false);
		tag.leftColumnFlex = guf.param.float(opts.leftColumnFlex, 1);
		tag.middleColumnFlex = guf.param.float(opts.middleColumnFlex, 3);
		tag.rightColumnFlex = guf.param.float(opts.rightColumnFlex, 1);
		tag.leftMinWidth = guf.param.string(opts.leftMinWidth, "unset");
		tag.leftColumnFlexFixed = guf.param.booleanExpr(opts, "leftColumnFlexFixed", false);
		tag.leftColumnVisibleForPopup = guf.param.booleanExpr(opts, "leftColumnVisibleForPopup", false);
		tag.hideTopPadding = guf.param.booleanExpr(opts, "hideTopPadding", false);
		tag.alwaysNarrow = guf.param.booleanExpr(opts, "alwaysNarrow", false);

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": "@primary",
			"textDefault": "@textDefault",
			"cardWidth": "1600px",
			"safeAreaTopPortrait": "@_safeAreaTopPortrait",
			"safeAreaTopLandscape": "@_safeAreaTopLandscape"
		};
		tag.mixin('mdl', "after-mount");

		tag.on("after-mount", function() {
			if (tag.cardWhenBig) {
				tag.root.children[0].classList.add("cardWhenBig");
			}
		});

		tag.showColumn = function(column, hideOthers, isOpaque) {
			tag.tags['guf-tripane'].showColumn(column, hideOthers, isOpaque);
		};

		tag.hideColumn = function(column) {
			tag.tags['guf-tripane'].hideColumn(column);
		};

		tag.setFullscreenColumn = function(column, fullscreen) {
			tag.tags['guf-tripane'].setFullscreenColumn(column, fullscreen);
		};

		tag.setLeftColumnContent = function(dom, options, configFn) {
			tag.tags['guf-tripane'].setLeftColumnContent(dom, options, configFn);
		};

		tag.setMiddleColumnContent = function(dom, options, configFn, forceShow) {
			tag.tags['guf-tripane'].setMiddleColumnContent(dom, options, configFn, forceShow);
		};

		tag.setRightColumnContent = function(dom, options, configFn) {
			tag.tags['guf-tripane'].setRightColumnContent(dom, options, configFn);
		};

		tag.setPopupColumnContent = function(dom, options, configFn, fullsize, isOpaque) {
			tag.tags['guf-tripane'].setPopupColumnContent(dom, options, configFn, fullsize, isOpaque);
		};

		tag.getLeftColumnContent = function() {
			return tag.tags['guf-tripane'].getLeftColumnContent();
		};

		tag.getMiddleColumnContent = function() {
			return tag.tags['guf-tripane'].getMiddleColumnContent();
		};

		tag.getRightColumnContent = function() {
			return tag.tags['guf-tripane'].getRightColumnContent();
		};

		tag.getPopupColumnContent = function() {
			return tag.tags['guf-tripane'].getPopupColumnContent();
		};

		tag.isRightColumnVisible = function() {
			return tag.tags['guf-tripane'].isRightColumnVisible();
		}

		tag.scrollColumn = function(column, offset) {
			tag.tags['guf-tripane'].scrollColumn(column, offset);	
		}

		tag.scrollDeltaColumn = function(column, offset) {
			tag.tags['guf-tripane'].scrollDeltaColumn(column, offset);	
		}

	</script>
</guf-canvas>