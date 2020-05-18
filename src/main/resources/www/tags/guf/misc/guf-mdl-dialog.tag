<guf-mdl-dialog>
	<dialog ref="dialog" class="mdl-dialog">
		<h4 class="mdl-dialog__title">{ opts.title }</h4>
		<div class="mdl-dialog__content">
			<p if="{!!opts.content}">{ opts.content }</p>
			<div ref="html" if="{!!opts.html}"></div>
		</div>
		<guf-linear-layout ref="actions" orientation="horizontal" h-align="right">
			<guf-button ref="nok" type="flat" ripple="true" color="true" if="{ parent.opts.nok }">{ parent.parent.opts.nok }</guf-button>
			<guf-button ref="ok" type="flat" ripple="true" color="true">{ parent.parent.opts.ok }</guf-button>
		</guf-linear-layout>
	</dialog>
	<style scoped type="dcss">
		guf-button {
			margin-left: 10px;
		}

		h4 {
			white-space: nowrap;
  			overflow: hidden;
  			text-overflow: ellipsis;
  			font-size:1.8rem;
  			line-height:normal;
		}
	</style>
	<script>
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {};
		tag.mixin('mdl');
		tag.mixin('after-mount');

		function okHandler() {
			tag.trigger('ok');
			tag.refs["dialog"].close();
			tag.unmount();
		}

		function nokHandler() {
			tag.trigger('nok');
			tag.refs["dialog"].close();
			tag.unmount();
		}

		tag.close = function() {
			tag.refs["dialog"].close();
			tag.unmount();
		}

		tag.on('mount', function() {
			if (! tag.refs["dialog"].showModal) {
				dialogPolyfill.registerDialog(tag.refs["dialog"]);
			}
			tag.refs["dialog"].showModal();
			tag.refs.actions.refs.ok.one('click', okHandler);
			if (opts.nok) {
				tag.refs.actions.refs.nok.one('click', nokHandler);
			}
			if (opts.html) {
				tag.refs.html.innerHTML = opts.html;				
			}
			if (guf.device.isIos) guf.disableMomentumScrolling(true);
		});
		tag.on('after-mount', function() {
			if (opts.nok) {
				tag.refs.actions.refs.nok.blur();
			} else {
				tag.refs.actions.refs.ok.blur();
			}
		});
		tag.on('before-unmount', function() {
			tag.refs.actions.refs.ok.off('click', okHandler);
			if (opts.nok) {
				tag.refs.actions.refs.nok.off('click', nokHandler);
			}
			if (guf.device.isIos) guf.disableMomentumScrolling(false);
		});
	</script>
</guf-mdl-dialog>