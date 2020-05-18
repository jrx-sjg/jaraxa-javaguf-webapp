<guf-horizontal-card>
	<div class="root-wrapper">
		<guf-linear-layout if="{!!leadingImage}" ref="leading-container" orientation="horizontal" h-align="center" v-align="center">
			<guf-item-image data="{guf.ancestor(this, 'guf-horizontal-card').leadingImage}" dcss="{guf.ancestor(this, 'guf-horizontal-card').leadingImageDcss}"></guf-item-image>
		</guf-linear-layout>
		<guf-linear-layout ref="middle-container" orientation="vertical" v-align="center" class="{line-break: lineBreak}">
			<div class="headline">{guf.ancestor(this, 'guf-horizontal-card').headline}</div>
			<div if="{!!guf.ancestor(this, 'guf-horizontal-card').firstLine}" class="first-line">{guf.ancestor(this, 'guf-horizontal-card').firstLine}</div>
			<div if="{!!guf.ancestor(this, 'guf-horizontal-card').secondLine}" class="second-line">{guf.ancestor(this, 'guf-horizontal-card').secondLine}</div>
			<div if="{!!guf.ancestor(this, 'guf-horizontal-card').thirdLine}" class="third-line">{guf.ancestor(this, 'guf-horizontal-card').thirdLine}</div>
		</guf-linear-layout>
		<div if="{trailing}" ref="trailing-container">
			<i if="{!!trailingIcon}" class="{trailingIconTheme}">{trailingIcon}</i>
			<yield></yield>
		</div>
		<guf-linear-layout if="{closable}" ref="close-button-container" orientation="horizontal" v-align="center">
			<guf-button type="icon" icon="close" ripple="true" color="true" dcss-background="{guf.ancestor(this, 'guf-horizontal-card').nestedDcss.closeColor}"></guf-button>
		</guf-linear-layout>
	</div>
	<style scoped type="text/dcss">
		:scope,
		:scope > .root-wrapper,
		:scope > .root-wrapper > [ref="trailing-container"] {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope,
		:scope > .root-wrapper,
		:scope > .root-wrapper > [ref="middle-container"] {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			min-width: 0px;
		}
		:scope > .root-wrapper > [ref="leading-container"],
		:scope > .root-wrapper > [ref="trailing-container"],
		:scope > .root-wrapper > [ref="close-button-container"] {
			-webkit-flex: 0 1 auto;
			-ms-flex: 0 1 auto;
			flex: 0 1 auto;
		} 
		:scope > .root-wrapper {
			background: @background;
			border: @border;
			border-radius: @radius;
		}
		:scope > .root-wrapper.clickable {
			cursor: pointer;
		}
		:scope > .root-wrapper > [ref="leading-container"] {
			padding: @paddingLeading;
		}
		:scope > .root-wrapper > [ref="middle-container"] {
			padding: @paddingMiddle;
		}
		:scope > .root-wrapper > [ref="middle-container"] > .headline {
			color: @headlineColor;
			line-height: @headlineHeight;
			font-size: @headlineSize;
			font-weight: @headlineWeight;
		}
		:scope > .root-wrapper > [ref="middle-container"] > .first-line,
		:scope > .root-wrapper > [ref="middle-container"] > .second-line,
		:scope > .root-wrapper > [ref="middle-container"] > .third-line {
			color: @textColor;
			line-height: @textHeight;
			font-size: @textSize;
			font-weight: @textWeight;
		}
		:scope > .root-wrapper > [ref="middle-container"]:not(.line-break) > .headline,
		:scope > .root-wrapper > [ref="middle-container"]:not(.line-break) > .first-line,
		:scope > .root-wrapper > [ref="middle-container"]:not(.line-break) > .second-line,
		:scope > .root-wrapper > [ref="middle-container"]:not(.line-break) > .third-line {
			text-overflow: ellipsis;
			overflow: hidden;
			word-break: break-word;
			min-width: 0px;
			white-space: nowrap;
		}
		:scope > .root-wrapper > [ref="trailing-container"] {
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
			padding: @paddingTrailing;
		}
		:scope > .root-wrapper > [ref="trailing-container"] > i {
			color: @headlineColor;
		}
		:scope > .root-wrapper > [ref="close-button-container"] {
			padding: 16px 8px 16px 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		setContentData();

		// Dcss
		tag.defaultDcss = {
			"background": "white",
			"border": "none",
			"headlineColor": "@primary",
			"headlineHeight": "26px",
			"headlineSize": "14px",
			"headlineWeight": "600",
			"paddingLeading": "16px",
			"paddingMiddle": "12px 16px 12px 0px",
			"paddingTrailing": "16px 10px 16px 0px",
			"radius": "4px",
			"textColor": "@darkGrey",
			"textHeight": "20px",
			"textSize": "12px",
			"textWeight": "400"
		};
		tag.nestedDcss = {
			"closeColor": guf.param.string(opts.dcssCloseColor, "@primary")
		};
		tag.mdlClasses = {
			"clickable": {
				"true": {
					"root": ["clickable"]
				}
			}
		};

		tag.mixin("mdl");

		// References
		var closeButton = null;

		function initReferences() {
			if (tag.closable) closeButton = tag.refs["close-button-container"].tags["guf-button"];
		}

		// Events
		function tagClickHandler(event) {
			tag.trigger("click", tag);
		}

		function closeButtonClickHandler(event, buttonTag) {
			tag.trigger("close", tag);
		}

		function initEvents() {
			if (tag.clickable) tag.root.addEventListener("click", tagClickHandler, false);
			if (tag.closable) closeButton.on("click", closeButtonClickHandler);
		}

		function removeEvents() {
			if (tag.clickable) tag.root.removeEventListener("click", tagClickHandler, false);
			if (tag.closable) closeButton.off("click", closeButtonClickHandler);
		}

		function setContentData() {
			/*
			 * General properties
			 *	opts.clickable	{boolean}
			 *	opts.closable	{boolean}
			 *	opts.cardId		{number}
			 */
			tag.clickable = guf.param.booleanExpr(opts, "clickable", false);
			tag.closable = guf.param.booleanExpr(opts, "closable", false);
			tag.cardId = guf.param.number(opts.cardId, 0);
			/*
			 * Leading properties
			 *	opts.leadingImage		{object}	guf-item-image opts object
			 *	opts.leadingImageDcss	{object}	guf-item-image opts.dcss object
			 */
			tag.leadingImage = opts.leadingImage || null;
			tag.leadingImageDcss = opts.leadingImageDcss || null;
			/*
			 * Middle properties
			 *	opts.headling	{string}	mandatory
			 *	opts.firstLine	{string}
			 *	opts.secondLine	{string}
			 *	opts.thirdLine	{string}
			 *	opts.lineBreak	{boolean}
			 */
			tag.headline = guf.param.string(opts.headline, "");
			tag.firstLine = guf.param.string(opts.firstLine, null);
			tag.secondLine = guf.param.string(opts.secondLine, null);
			tag.thirdLine = guf.param.string(opts.thirdLine, null);
			tag.lineBreak = guf.param.booleanExpr(opts, "lineBreak", false);
			/*
			 * Trailing properties
			 *	opts.trailing			{boolean}	trailing container is present or not
			 *	opts.trailingIcon		{string}
			 *	opts.trailingIconTheme	{string}	Values: filled, outlined, two-tone, round, sharp
			 */
			tag.trailingIcon = guf.param.string(opts.trailingIcon, null);
			var trailingIconTheme = guf.param.string(opts.trailingIconTheme, "outlined");
			tag.trailingIconTheme = trailingIconTheme == "filled" ? "material-icons" : "material-icons-" + trailingIconTheme;
			tag.trailing = guf.param.booleanExpr(opts, "trailing", false) || !!tag.trailingIcon;

			tag.nestedDcss = {
				"closeColor": guf.param.string(opts.dcssCloseColor, "@primary")
			};
		}

		tag.on("mount", function () {
			initReferences();
			initEvents();
		});

		tag.on("before-unmount", function () {
			removeEvents();
		});

		tag.on("update", function () {
			setContentData();
		});
	</script>
</guf-horizontal-card>