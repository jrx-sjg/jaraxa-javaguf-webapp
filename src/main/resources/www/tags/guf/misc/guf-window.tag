<guf-window>
	<dialog ref="dialog" class="{mdl-dialog: !fullscreen, mdl-dialog--fullscreen: fullscreen}">
		<div if="{fullscreen}" class="mdl-dialog--fullscreen__title">
			<h4 if="{ opts.windowTitle }" class="mdl-dialog__title flex1">{ opts.windowTitle }</h4>
			<guf-button ref="close_button" type="icon" ripple="true" icon="close"></guf-button>
		</div>
		<h4 if="{ opts.windowTitle && !fullscreen }" class="mdl-dialog__title">{ opts.windowTitle }</h4>
		<div class="mdl-dialog__content">
			<yield/>
		</div>
		<guf-linear-layout if="{opts.nok!=undefined || opts.ok!=undefined}" class="mdl-dialog__buttons" ref="actions" orientation="horizontal" h-align="right">
			<guf-button ref="nok" type="flat" ripple="true" color="true" if="{ parent.opts.nok }">{ parent.parent.opts.nok }</guf-button>
			<guf-button ref="ok" type="flat" ripple="true" color="true" if="{ parent.opts.ok }">{ parent.parent.opts.ok }</guf-button>
		</guf-linear-layout>
	</dialog>
	<style scoped type="dcss">

		:scope .mdl-dialog__content {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			flex: 1;
			-webkit-flex:1;
			-ms-flex:1;
			-ms-box-orient: vertical;
            -webkit-flex-flow: column;
            -moz-flex-flow: column;
			-ms-flex-flow: column;
            flex-flow: column;
            min-height: 0px;
		}

		:scope .mdl-dialog {
			min-width: @defaultMinWidth;
			/*border-radius: 3px;
			z-index: 10;
			padding: 0px;
			margin: 0px;
			margin-right: 16px;*/
		}

		:scope .mdl-dialog--fullscreen {
			min-width: 100px;
			z-index: 10;
			border: 0px;
			right: 0px;
			margin-left: auto;
			margin-right: 0px;
			padding: 0px;
			/*height: 100%;*/
			display: flex;
    		flex-direction: column;
		}

		body.guf-screen-narrow :scope .mdl-dialog--fullscreen {
			width: 100% !important;
			height: 100%;
		}

		:scope .mdl-dialog .mdl-dialog__title,
		:scope .mdl-dialog--fullscreen .mdl-dialog__title {
			font-size: 20px;
			padding: 16px 16px 0;
		}

		:scope .mdl-dialog--fullscreen__title {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
		}

		:scope .mdl-dialog--fullscreen__title .mdl-dialog__title {
			flex: 1;
			-webkit-flex:1;
			-ms-flex:1;
		}

		:scope .mdl-dialog--fullscreen__title guf-button {
			padding: 16px;
		}

		:scope .mdl-dialog__content {
			padding: 0px;
		}

		:scope .mdl-dialog--fullscreen .mdl-dialog__content {
			padding: 0px;
			flex: 1;
		}

		:scope .mdl-dialog__buttons {
			padding: 0 16px 16px;
		}

		guf-button {
			margin-left: 10px;
		}

		h4 {
			white-space: nowrap;
  			overflow: hidden;
  			text-overflow: ellipsis;
  			font-size:2.5rem;
  			line-height:3rem;
		}

		@media(min-width: 333px) and (max-width: 432px) {
			:scope .mdl-dialog {
				min-width: initial;
			}
		}

		@media(max-width: 332px) {
			:scope .mdl-dialog {
				min-width: 300px;
				margin: auto;
			}
		}
	</style>
	<script>
		var tag = this;
		tag.center = guf.param.boolean(opts.center, false);
		tag.fullscreen = guf.param.boolean(opts.fullscreen, false);
		tag.offset = guf.param.number(opts.offset, 16);
		tag.modal = guf.param.boolean(opts.modal, false);
		tag.minWidth = 400;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"defaultMinWidth": tag.minWidth + "px"
		};

		tag.on("mount", function() {
			if (!tag.center) {
			
			if (tag.fullscreen) {
				tag.refs.dialog.style.width = (guf.device.isDesktop) ? ((opts.width) +  "px"):"100%";
				tag.refs.dialog.style.top = (opts.top) + "px";
				tag.refs.dialog.style.left = (opts.left) +  "px";
				tag.refs.dialog.style.right = (opts.right) + "px";
				tag.refs.dialog.style.bottom = (opts.bottom) + "px";
				tag.refs.dialog.style.height = "100%";
			} else {
				tag.refs.dialog.style.top = ((parseInt(opts.top) + parseInt(tag.offset))) +  "px";
				if (window.innerWidth>432) {
					if (window.innerWidth < ((parseInt(opts.left) + parseInt(tag.offset))) + tag.minWidth) {
						tag.refs.dialog.style.left = "auto";
					} else {
						tag.refs.dialog.style.left = (parseInt(opts.left) + parseInt(tag.offset)) +  "px";	
					}
				} else if (window.innerWidth > 332) {
					tag.refs.dialog.style.left = "initial";
				}
			}			
			}
		});	
		tag.mixin('mdl');

		function okHandler(e) {
			tag.refs.dialog.close();
			tag.trigger("ok", e);
			tag.unmount();			
		}

		function nokHandler(e) {
			tag.refs.dialog.close();
			tag.trigger("nok", e);
			tag.unmount();			
		}

		function closeHandler(e) {
			tag.refs.dialog.close();
			tag.trigger('close', e);
			tag.unmount();			
		}

		tag.closeDialog = function() {
			tag.refs.dialog.close();
		};

		tag.enableOkButton = function() {
			tag.refs.actions.refs.ok.enable();
		};

		tag.disableOkButton = function() {
			tag.refs.actions.refs.ok.disable();
		};

		tag.enableNokButton = function() {
			tag.refs.actions.refs.nok.enable();
		};

		tag.disableNokButton = function() {
			tag.refs.actions.refs.nok.disable();
		};

		tag.on('mount', function() {
			if (! tag.refs.dialog.showModal) {
				dialogPolyfill.registerDialog(tag.refs.dialog);
			}
			if (!tag.modal) {
				tag.refs.dialog.show();
			} else {
				tag.refs.dialog.showModal();
			}
			
			if (tag.fullscreen) {
				tag.refs["close_button"].one('click', closeHandler);
			}
			if (opts.ok) {
				tag.refs.actions.refs.ok.one('click', okHandler);
			}
			if (opts.nok) {
				tag.refs.actions.refs.nok.one('click', nokHandler);
			}
		});
		tag.on('before-unmount', function() {
			tag.refs.dialog.setAttribute("open", "false");
			if (tag.fullscreen) {
				tag.refs["close_button"].off('click', closeHandler);
			}
			if (opts.ok) {
				tag.refs.actions.refs.ok.off('click', okHandler);
			}
			if (opts.nok) {
				tag.refs.actions.refs.nok.off('click', nokHandler);
			}
		});

	</script>

</guf-window>