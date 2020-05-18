<guf-top-bar>
	<div ref="message" class="message-container">
		<span each="{part in parsedMessage}" class="{link: part.link}" onclick="{part.link ? linkClickHandler : '' }">{part.content}</span>
	</div>
	<guf-button ref="close" type="icon" ripple="true" icon="close" color="true" dcss-background="{closeButtonColor}" class="{hidden: !closable}"></guf-button>
	<style type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
			background-color: @background;
			height: 32px;
			padding: 8px 16px;
		}
		:scope > .message-container {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			color: @textColor;
			text-align: @textAlign;
			font-size: @textFontSize;
			font-weight: @textFontWeight;
			line-height: normal;
		}
		:scope > .message-container > span.link {
			text-decoration: underline;
			cursor: pointer;
		}
		:scope > guf-button {
			margin-left: 12px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.message = guf.param.string(opts.message, '');
		tag.links = opts.links || {};
		tag.closable = guf.param.boolean(opts.closable, true);
		tag.closeButtonColor = guf.param.string(opts.dcssTextColor, 'white');
		tag.parsedMessage = [];

		tag.defaultDcss = {
			"background": "#669fe0",
			"textColor": "white",
			"textAlign": "center",
			"textFontSize": "15px",
			"textFontWeight": "400"
		};

		tag.mixin('mdl');

		function populateBar() {
			var unparsedMessage = "", index = 0;
			tag.parsedMessage = [];
			if (tag.message) {
				unparsedMessage = tag.message;
				if (tag.links) {
					for (key in tag.links) {
						index = unparsedMessage.indexOf(tag.links[key]);
						if (index > -1) {
							tag.parsedMessage.push({
								"content": unparsedMessage.substring(0, index)
							});
							tag.parsedMessage.push({
								"link": true,
								"key": key,
								"content": tag.links[key]
							});
							unparsedMessage = unparsedMessage.substring(index + tag.links[key].length);
						}
					}
				}
				if (unparsedMessage && unparsedMessage.length > 0) {
					tag.parsedMessage.push({ "content": unparsedMessage });
				}
			}
			tag.update();
		}

		tag.linkClickHandler = function (event) {
			tag.trigger('link-click', event.item.part.key);
		}

		function closeClickHandler() {
			tag.trigger('close-click', tag);
		}

		function initEvents() {
			tag.refs["close"].on('click', closeClickHandler);
		}

		function removeEvents() {
			tag.off('link-click');
			tag.refs["close"].off('click', closeClickHandler);
		}

		tag.on('mount', function () {
			initEvents();
			populateBar();
		});

		tag.on('before-unmount', function () {
			removeEvents();
		});
	</script>
</guf-top-bar>