<guf-item-image>
	<div class="root-wrapper">
		<img if="{!!imageSrc}" src="{imageSrc}" />
		<guf-linear-layout if="{!!icon || !!text}" ref="icon-container" h-align="center" v-align="center">
			<i if="{!!guf.ancestor(this, 'guf-item-image').icon}" class="{guf.ancestor(this, 'guf-item-image').iconTheme}">{guf.ancestor(this, 'guf-item-image').icon}</i>
			<div if="{!!guf.ancestor(this, 'guf-item-image').text}" class="text-content">{guf.ancestor(this, 'guf-item-image').text}</div>
		</guf-linear-layout>
	</div>
	<style scoped type="text/dcss">
		:scope,
		:scope > .root-wrapper {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > .root-wrapper {
			background: @background;
			border: @border;
			padding: @padding;
			color: @textColor;
			font-size: @textSize;
			font-weight: @textWeight;
		}
		:scope,
		:scope > .root-wrapper,
		:scope > .root-wrapper > [ref="icon-container"] {
			border-radius: @radius;
			overflow: hidden;
		}
		:scope > .root-wrapper.responsive,
		:scope > .root-wrapper.responsive > img,
		:scope > .root-wrapper > [ref="icon-container"] {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .root-wrapper.responsive > img {
			max-height: 100%;
			max-width: 100%;
			object-fit: cover;
		}
		:scope > .root-wrapper:not(.responsive),
		:scope > .root-wrapper:not(.responsive) > img {
			height: @height;
			width: @width;
		}
		:scope > .root-wrapper:not(.responsive) > img {
			object-fit: contain;
		}
		:scope > .root-wrapper > [ref="icon-container"] > i {
			font-size: @textSize;
			color: @textColor;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		/*
		 * Properties
		 *
		 *	opts.data								{object}	it will be mapped to opts in order to allow passing options as a single object
		 *	opts.dcss								{object}	allows to pass dcss properties as a single object
		 *
		 *	opts.imageSrc	==	opts.data.imageSrc	{string}
		 *	opts.icon		==	opts.data.icon		{string}
		 *	opts.iconTheme	==	opts.data.iconTheme	{string}	Values: filled, outlined, two-tone, round, sharp
		 *	opts.text		==	opts.data.text		{string}
		 *	opts.responsive							{boolean}	see tag.mdlClasses
		 */
		if (!opts.data) {
			opts.data = {};
			opts.data["imageSrc"] = opts["imageSrc"];
			opts.data["icon"] = opts["icon"];
			opts.data["iconTheme"] = opts["iconTheme"];
			opts.data["text"] = opts["text"];
		}
		tag.imageSrc = guf.param.string(opts.data.imageSrc, null);
		tag.icon = guf.param.string(opts.data.icon, null);
		var iconTheme = guf.param.string(opts.data.iconTheme, "outlined");
		tag.iconTheme = iconTheme == "filled" ? "material-icons" : "material-icons-" + iconTheme;
		tag.text = guf.param.string(opts.data.text, null);

		// Dcss
		if (!!opts.dcss) {
			var safePropName;
			for (var prop in opts.dcss) {
				if (prop.indexOf("dcss") == 0) safePropName = prop;
				else safePropName = "dcss" + prop.charAt(0).toUpperCase() + prop.slice(1);
				opts[safePropName] = opts.dcss[prop];
			}
		}
		tag.defaultDcss = {
			"background": "transparent",
			"border": "0px",
			"height": "64px",
			"padding": "0px",
			"radius": "50%",
			"textColor": "@primary",
			"textSize": "24px",
			"textWeight": "600",
			"width": "64px"
		};
		tag.mdlClasses = {
			"responsive": {
				"true": {
					"root": ["responsive"]
				}
			}
		};

		tag.mixin("mdl");

		// Events
		function clickHandler(event) {
			tag.trigger("click", tag);
		}

		function initEvents() {
			tag.root.addEventListener("click", clickHandler, false);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", clickHandler, false);
		}

		tag.on("mount", function () {
			initEvents();
		});

		tag.on("before-unmount", function () {
			removeEvents();
		});
	</script>
</guf-item-image>