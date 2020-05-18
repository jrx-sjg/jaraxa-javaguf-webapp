<guf-snackbar-container>
	<style type="text/css">
		:scope {
			bottom:0;
			position: absolute;
			display: flex;
			left: 0;
			right: 0;
			z-index:100;
			-ms-box-orient: vertical;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			overflow: hidden;
			pointer-events: none;
		}
		@media screen and (min-width: 480px) {
			/* This is the breakpoint used by MDL for the snackbar's min-width */
			:scope {
				align-items: center;
			}
		}
		:scope > guf-snackbar {
			margin-top: 16px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		if (tag.parent) {
			guf.setSnackbarContainer(tag);
		}
	</script>
</guf-snackbar-container>