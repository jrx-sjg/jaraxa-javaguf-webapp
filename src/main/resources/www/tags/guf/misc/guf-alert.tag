<guf-alert>
	<guf-dialog dialog-title="{title}" ok="{ok}" nok="{nok}" dcss-max-width="308px" dcss-content-padding="{contentPadding}">
		<p if="{guf.ancestor(this,'guf-alert').content}" class="alert-paragraph">{guf.ancestor(this,'guf-alert').content}</p>
		<div if="{guf.ancestor(this,'guf-alert').html}" ref="html"></div>
	</guf-dialog>
	<style scoped type="text/dcss">
		:scope {
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > guf-dialog .alert-paragraph {
			margin: 0;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		// Properties
		tag.title = guf.param.string(opts.title, null);
		tag.ok = guf.param.string(opts.ok, null);
		tag.nok = guf.param.string(opts.nok, null);
		tag.content = guf.param.string(opts.content, null);
		tag.html = opts.html || null;
		tag.contentPadding = tag.title ? "0 24px 24px 24px" : "24px";

		// Mixins
		tag.mixin('mdl', 'after-mount');

		// Private
		function initHtml() {
			if (tag.html) tag.tags["guf-dialog"].content().refs["html"].innerHTML = tag.html;
		}

		// Events
		function okHandler() {
			tag.trigger('ok');
			tag.unmount();
		}

		function nokHandler() {
			tag.trigger('nok');
			tag.unmount();
		}

		function initEvents() {
			tag.tags["guf-dialog"].on('ok', okHandler);
			tag.tags["guf-dialog"].on('nok', nokHandler);
			if (guf.device.isAndroid) {
				document.addEventListener("backbutton", nokHandler, false);
			}
		}

		function removeEvents() {
			tag.tags["guf-dialog"].off('ok', okHandler);
			tag.tags["guf-dialog"].off('nok', nokHandler);
			if (guf.device.isAndroid) {
				document.removeEventListener("backbutton", nokHandler, false);
			}
		}

		tag.on('after-mount', function () {
			initHtml();
			initEvents();
		});

		tag.on('before-unmount', function () {
			removeEvents();
		});
	</script>
</guf-alert>