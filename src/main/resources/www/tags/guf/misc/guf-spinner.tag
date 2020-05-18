<guf-spinner>
	<div ref="spinner" class="mdl-spinner mdl-js-spinner is-active"></div>
	<span class="spinner-text"><yield/></span>

	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			align-items: center;
		}

		:scope .mdl-spinner--single-color .mdl-spinner__layer-1,
		:scope .mdl-spinner--single-color .mdl-spinner__layer-2,
		:scope .mdl-spinner--single-color .mdl-spinner__layer-3,
		:scope .mdl-spinner--single-color .mdl-spinner__layer-4 {
			border-color: @spinnerColor;
		}

		:scope .spinner-text {
			padding-left: 20px;
		}
	</style>

	<script type="text/javascript">
		var tag = this;
		tag.color = guf.param.boolean(opts.color, false);
		
		tag.mdlClasses = {
			"color" : {
				"true" : {
					"root": ["mdl-spinner--single-color"]
				}
			}
		};
		tag.defaultDcss = {
			"spinnerColor": "@primary"
		};
		tag.mixin('mdl');

		tag.show = function() {
			tag.refs["spinner"].classList.add('is-active');
			tag.update();
		};

		tag.hide = function() {
			tag.refs["spinner"].classList.remove('is-active');
			tag.update();
		};
	</script>
</guf-spinner>