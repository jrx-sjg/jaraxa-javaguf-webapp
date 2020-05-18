<guf-snackbar>
	<div ref="snackbar" class="mdl-js-snackbar mdl-snackbar">
		<div class="mdl-snackbar__text mdl-padding-bottom guf-safe-padding-bottom">{opts.content}</div>
		<button ref="action" class="mdl-snackbar__action mdl-padding-bottom guf-safe-padding-bottom" type="button" if="{opts.btnText}">{opts.btnText}</button>
	</div>
	<style scoped type="dcss">
		:scope > div[ref="snackbar"].mdl-snackbar {
			-webkit-transform: translate(0,100%);
			transform: translate(0,100%);
			opacity: 0;
			position: static;
			will-change: transform, opacity;
			transition: -webkit-transform 0.25s cubic-bezier(0.4, 0, 1, 1), opacity 0.25s cubic-bezier(0.4, 0, 1, 1);
			transition: transform 0.25s cubic-bezier(0.4, 0, 1, 1), opacity 0.25s cubic-bezier(0.4, 0, 1, 1);
			transition: transform 0.25s cubic-bezier(0.4, 0, 1, 1), -webkit-transform 0.25s cubic-bezier(0.4, 0, 1, 1), opacity 0.25s cubic-bezier(0.4, 0, 1, 1);
		}

		:scope > div[ref="snackbar"].mdl-snackbar--active {
			-webkit-transform: translate(0,0);
			transform: translate(0,0);
			opacity: 1;
			transition: -webkit-transform 0.25s cubic-bezier(0, 0, 0.2, 1), opacity 0.25s cubic-bezier(0, 0, 0.2, 1);
			transition: transform 0.25s cubic-bezier(0, 0, 0.2, 1), opacity 0.25s cubic-bezier(0, 0, 0.2, 1);
			transition: transform 0.25s cubic-bezier(0, 0, 0.2, 1), -webkit-transform 0.25s cubic-bezier(0, 0, 0.2, 1), opacity 0.25s cubic-bezier(0, 0, 0.2, 1);
		}

		:scope > div[ref="snackbar"].mdl-snackbar > .mdl-padding-bottom {
			padding-bottom: 14px; /* original padding-bottom to be set if guf-safe-padding-bottom is 0 */
		}
	</style>
	<script type="text/javascript">
		var tag = this;	

		tag.mdlClasses = {};
		tag.defaultDcss = {
		};
		tag.mixin('mdl');
		var timeout = null;
		var closing = false;

		function clickHandler() {
			tag.trigger("action", tag);
		}

		tag.close = function() {
			if (closing) {
				return;
			}
			closing = true;
			if (timeout != null) {
				guf.clearTimeout(timeout);
				timeout = null;
			}
			if (opts.btnText) {
				tag.refs.action.removeEventListener("click", clickHandler);
			}
			tag.refs.snackbar.classList.remove("mdl-snackbar--active");
			guf.setTimeout(function() {
				tag.unmount();
			},250);
		}

		tag.on("mount", function() {
			guf.setTimeout(function() {
				if (opts.timeout) {
					timeout = guf.setTimeout(function() {
						timeout = null;
						tag.close();
					}, opts.timeout);
				}
				if (opts.btnText) {
					tag.refs.action.addEventListener("click", clickHandler);
				}
				if (opts.btnText) {
					tag.refs.action.removeAttribute("aria-hidden");
				}
				tag.refs.snackbar.classList.add("mdl-snackbar--active");
			}, 10);
		});
	</script>
</guf-snackbar>