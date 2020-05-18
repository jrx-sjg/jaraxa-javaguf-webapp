<guf-textarea>
	<div class="{mdl-textfield:1, mdl-js-textfield:1, mdl-chars: opts.limit!=undefined}">
		<div class="textfield-background"></div>
		<textarea class="{mdl-textfield__input:1, mdl-textfield__resizable: resizable}" ref="textfield" type="text" rows= "{rows}" id="{ inputId }" resizable="{ resizable }" readonly="{ readonly }"></textarea>
		<label class="mdl-textfield__label" for="{ inputId }"><span>{ opts.placeholder }</span></label>
		<span if="{ opts.pattern || type == 'email' }" class="mdl-textfield__error">{ opts.invalid }</span>
		<guf-linear-layout class="chars-count" ref="chars-wrapper" if="{opts.limit!=undefined}" h-align="right">{parent.chars}</guf-linear-layout>
	</div>
	
	<style scoped type="dcss">
		:scope {
			-webkit-flex:1;
			-ms-flex:1;
			flex: 1;
		}

		:scope textarea:not(.mdl-textfield__resizable) {
			resize: none;
		}

		.mdl-textfield {
			width:100%;
		}

		.mdl-chars {
			padding-bottom: 0px;
		}

		.mdl-textfield__label::after {
			background-color:@background;
		}

		.mdl-chars .mdl-textfield__label::after {
			bottom: 0px;
		}

		.mdl-textfield--floating-label.is-dirty.is-focused .mdl-textfield__label, 
		.mdl-textfield--floating-label.is-focused .mdl-textfield__label {
			color:@background;
		}

		.mdl-textfield--floating-label.is-dirty .mdl-textfield__label,
		.mdl-textfield--floating-label.has-placeholder .mdl-textfield__label {
			color:@placeholderColor;
		}

		:scope .chars-count {
			height: 16px;
			font-size: @charsCountFontSize;
			padding: 0px 8px;
			color: @placeholderColor;
		}

		.limit-exceeded {
			color: @errorLabelColor;
			font-weight: 400;
		}

		/* Outline V2 */
		/* textfield v2 */
		:scope > div.mdl-textfield-v2-outlined {
			padding: 10px 0px;
			margin-bottom: 20px;
		}
		:scope > div.mdl-textfield-v2-outlined > div.textfield-background {
			position: absolute;
			bottom: 0px;
			top: 0px;
			left: 0;
			right: 0;
			pointer-events: none;
			border: 1px solid @outlineColor;
			border-radius: 4px;
		}

		:scope:hover > div.mdl-textfield-v2-outlined:not(.is-focused):not(.is-invalid):not(.is-disabled) > div.textfield-background {
			border-color: @outlineHover;
		}

		:scope > div.mdl-textfield-v2-outlined.is-focused > div.textfield-background {
			border: 2px solid @background;
		}

		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.textfield-background {
			border-color: @errorLabelColor;
		}
		:scope > div.mdl-textfield-v2-outlined > textarea.mdl-textfield__input {
			box-sizing: border-box;
			z-index: 1;
			padding: 4px 20px 10px;
			border-bottom: 0px;
		}
		:scope > div.mdl-textfield-v2-outlined > label.mdl-textfield__label {
			width: initial;
			padding: 0 16px;
			top: 14px;
		}
		:scope > .mdl-textfield-v2-outlined.is-focused .mdl-textfield__label,
		:scope > .mdl-textfield-v2-outlined.is-dirty .mdl-textfield__label,
		:scope > .mdl-textfield-v2-outlined.has-placeholder .mdl-textfield__label {
			top: -10px;
		}
		:scope > .mdl-textfield-v2-outlined .mdl-textfield__label span,
		:scope > .mdl-textfield-v2-outlined.is-focused .mdl-textfield__label span,
		:scope > .mdl-textfield-v2-outlined.is-dirty .mdl-textfield__label span,
		:scope > .mdl-textfield-v2-outlined.has-placeholder .mdl-textfield__label span {
			border-radius: 4px;
			background: @outlinedBackground;
			padding: 0px 4px;
			height: 20px;
		}
		:scope > .mdl-textfield-v2-outlined.is-focused .mdl-textfield__label span {
			border: 0px;
		}
		:scope > .mdl-textfield-v2-outlined.is-invalid .mdl-textfield__label {
			color: @errorLabelColor;
		}
		:scope > .mdl-textfield-v2-outlined > span.mdl-textfield__error {
			box-sizing: border-box;
			padding: 0 20px;
		}
		:scope > .mdl-textfield-v2-outlined.is-disabled .mdl-textfield__input,
		:scope > .mdl-textfield-v2-outlined.is-disabled .mdl-textfield__label {
			color: rgba(0,0,0,0.26);
		}

		:scope > div.mdl-textfield-v2-outlined.is-disabled > div.textfield-background {
			border-color: rgba(0,0,0,0.26);
		}

		:scope > .mdl-textfield-v2-outlined.is-invalid textarea.mdl-textfield__input {
			border-bottom: 0px;
		}
		:scope > .mdl-textfield-v2-outlined .mdl-textfield__label:after,
		:scope > .mdl-textfield-v2-outlined.is-invalid .mdl-textfield__label:after {
			transition-duration: 0s;
			transition-timing-function: unset;
			background-color: transparent;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.inputId = guf.getAutoId();
		tag.pattern = opts.pattern;
		tag.disabled = opts.disabled;
		tag.type = opts.type;
		tag.autocapitalize = guf.param.string(opts.autocapitalize,'none');
		tag.autocorrect = guf.param.string(opts.autocorrect,'off');
		tag.autocomplete = guf.param.string(opts.autocomplete,'off');
		tag.resizable = guf.param.booleanExpr(opts, "resizable", false);
		tag.rows = guf.param.number(opts.rows, 3);
		tag.limit = guf.param.number(opts.limit, null);
		tag.readonly = opts.readonly;

		tag.mdlClasses = {
			"label" : {
				"floating" : {
					"root" : ["mdl-textfield--floating-label"]
				},
				"v2-outlined": {
					"root" : ["mdl-textfield--floating-label", "mdl-textfield-v2-outlined"]
				}
			}
		};
		tag.defaultDcss = {
			"background": "@primary",
			"errorLabelColor": "#d50000",
			"outlinedBackground": "#ffffff",
			"placeholderColor": "rgba(0,0,0,.6)",
			"charsCountFontSize": "12px",
			"outlineColor": "rgba(0,0,0,.24)",
			"outlineHover": "rgba(0,0,0,.87)"
		};
		tag.mixin('mdl');
		
		// Behaviour
		tag.on('mount', function() {
			if (tag.limit!=null) {
				updateCharsCount();
			}
			tag.refs.textfield.addEventListener('input', inputHandler, false);
			tag.refs.textfield.addEventListener('keydown', keydownHandler, false);
			tag.refs.textfield.addEventListener('keyup', keyupHandler, false);
		});

		tag.on('before-unmount', function() {
			tag.refs.textfield.removeEventListener('input', inputHandler, false);
			tag.refs.textfield.removeEventListener('keydown', keydownHandler, false);
			tag.refs.textfield.removeEventListener('keyup', keyupHandler, false);
		});

		function inputHandler(evt) {
			tag.trigger('input', evt);
			updateCharsCount();
		}

		function keydownHandler(event) {
			if (((event.key!==null && event.key.toLowerCase()==="enter") || event.keyCode===13) && !event.shiftKey) {
				event.preventDefault();
			}
			tag.trigger('keydown', tag.getValue(), event);
		}

		function keyupHandler(evt) {
			tag.trigger('keyup', tag.getValue(), evt);
		}

		tag.getValue = function() {
			return tag.refs.textfield.value;
		}
		tag.setValue = function(value) {
			tag.refs.textfield.parentNode.MaterialTextfield.change(value);
			updateCharsCount();
		}
		tag.enable = function() {
			tag.refs.textfield.parentNode.MaterialTextfield.enable();
		}
		tag.disable = function() {
			tag.refs.textfield.parentNode.MaterialTextfield.disable();
		}
		tag.focus = function() {
			tag.refs.textfield.focus();
		}
		tag.markAsInvalid = function(invalid) {
			if (!invalid) {
				tag.refs.textfield.parentNode.classList.remove('is-invalid');
				tag.refs["textfield"].setCustomValidity('');
			} else {
				tag.refs.textfield.parentNode.classList.add('is-invalid');
				tag.refs["textfield"].setCustomValidity('Invalid value');
			}
		}
		tag.isValid = function () {
			if (tag.limit !== undefined) {
				return tag.getValue().length <= tag.limit;
			}
			return tag.refs["textfield"].parentNode.MaterialTextfield.input_.validity.valid;
		}
		
		function updateCharsCount() {
			if (tag.limit != null) {
				tag.chars = tag.getValue().length + " / " + tag.limit;
				if (tag.getValue().length > tag.limit) {
					tag.refs["chars-wrapper"].root.classList.add("limit-exceeded");
					tag.markAsInvalid(true);
				} else {
					tag.refs["chars-wrapper"].root.classList.remove("limit-exceeded");
					tag.markAsInvalid(false);
				}
				tag.refs["chars-wrapper"].update();
			}
		}
	</script>
</guf-textarea>