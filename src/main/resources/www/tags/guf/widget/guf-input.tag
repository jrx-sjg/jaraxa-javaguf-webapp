<guf-input>
	
	<div ref="mdl-textfield" class="{mdl-textfield:1, mdl-js-textfield:1, mdl-chars: !!opts.limit, buttons-show: type==='number' && showButtons, has-prefix: (!!leadingIcon || !!prefix), has-suffix: (!!trailingIcon || !!suffix)}">
		<div class="textfield-background"></div>
		<div class="textfield-input-wrapper">
			<div if="{!!leadingIcon || !!prefix}" class="prefix-container">
				<i if="{!!leadingIcon}" class="{material-icons:1, pointer:!!leadingIconFn}" ref="leading-icon">{leadingIcon}</i>
				<div if="{!!prefix}" class="fixed-text">{prefix}</div>
			</div>
			<input class="mdl-textfield__input" type="{ type }" id="{ inputId }" ref="input" pattern="{ pattern }" disabled="{ disabled }" autocapitalize="{ autocapitalize }" autocorrect="{ autocorrect }" autocomplete="{ autocomplete }" value="{value}" readonly="{ readonly }"></input>
			<div if="{!!trailingIcon || !!suffix}" class="suffix-container">
				<i if="{!!trailingIcon}" class="{material-icons:1, pointer:!!trailingIconFn}" ref="trailing-icon">{trailingIcon}</i>
				<div if="{!!suffix}" class="fixed-text">{suffix}</div>
			</div>
		</div>
		<label if="{opts.label != "v2-outlined"}" class="mdl-textfield__label" for="{ inputId }">{ opts.placeholder }</label>
		<div if="{opts.label == "v2-outlined"}" class="outline-wrapper">
			<div class="leading-outline">
				<i if="{!!leadingIcon}" class="material-icons">{leadingIcon}</i>
				<div if="{!!prefix}" class="fixed-text">{prefix}</div>
			</div>
			<div class="label-outline">
				<label class="mdl-textfield__label" for="{ inputId }">{ opts.placeholder }</label>
			</div>
			<div class="trailing-outline"></div>
		</div>
		<span if="{ pattern || patternFn || type == 'email' }" class="mdl-textfield__error">{ invalid }</span>
	</div>
	<div if="{type==='number' && showButtons}" class="input-wrapper">
		<div class="buttons">
			<guf-button ref="increase" type="icon" color="true" icon="{incrementIcon}"></guf-button>
			<guf-button ref="decrease" type="icon" color="true" icon="{decrementIcon}"></guf-button>
		</div>
	</div>
	<guf-linear-layout class="chars-count" ref="chars-wrapper" if="{!!opts.limit}" h-align="right" v-align="center">{parent.chars}</guf-linear-layout>
	
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			min-height:67px;
			position: relative;
		}

		:scope > div.mdl-textfield {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			width: initial;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
		}

		.mdl-chars {
			padding-bottom: 0px;
		}

		:scope >  div.mdl-textfield > .textfield-input-wrapper {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}

		:scope > div.mdl-textfield > .textfield-input-wrapper > input.mdl-textfield__input {
			color: @textColor;
			border-bottom-color: @textBorderColor;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}

		@-webkit-keyframes autoFillStart {
			from {/**/}
			to {/**/}
		}
		@-moz-keyframes autoFillStart {
			from {/**/}
			to {/**/}
		}
		@keyframes autoFillStart {
			from {/**/}
			to {/**/}
		}

		@-webkit-keyframes autoFillCancel {
			from {/**/}
			to {/**/}
		}
		@-moz-keyframes autoFillCancel {
			from {/**/}
			to {/**/}
		}
		@keyframes autoFillCancel {
			from {/**/}
			to {/**/}
		}

		:scope > div.mdl-textfield > .textfield-input-wrapper > input.mdl-textfield__input:-webkit-autofill {
			-webkit-animation-name: autoFillStart;
			-moz-animation-name: autoFillStart;
			animation-name: autoFillStart;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > input.mdl-textfield__input:not(:-webkit-autofill) {
			-webkit-animation-name: autoFillCancel;
			-moz-animation-name: autoFillCancel;
			animation-name: autoFillCancel;
		}

		:scope > div.mdl-textfield.is-invalid > .textfield-input-wrapper > input.mdl-textfield__input {
			border-bottom-color: @errorLabelColor;
		}

		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container,
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container {
			padding-left: 12px;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container {
			padding-right: 8px;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container > .material-icons,
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container > .material-icons,
		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container > .fixed-text,
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container > .fixed-text {
			color: @placeholderColor;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container > .material-icons {
			padding-right: 8px;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .prefix-container > .fixed-text {
			padding-right: 4px;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container > .material-icons {
			padding-left: 8px;
		}
		:scope > div.mdl-textfield > .textfield-input-wrapper > .suffix-container > .fixed-text {
			padding-left: 4px;
		}
		
		:scope > div > label.mdl-textfield__label {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			color: @placeholderColor;
		}

		:scope > div.buttons-show > label.mdl-textfield__label {
			width: calc(100% - 46px);
		}

		:scope > div > span.mdl-textfield__error {
			bottom: -3px;
			color: @errorLabelColor;
		}

		.mdl-textfield__label::after {
			background-color:@background;
		}

		:scope > .mdl-textfield.is-invalid > .mdl-textfield__label:after {
			background-color: @errorLabelColor;
		}

		.mdl-chars .mdl-textfield__label::after {
			bottom: 0px;
		}

		.mdl-textfield--floating-label.is-focused .mdl-textfield__label,
		.mdl-textfield--floating-label.is-dirty .mdl-textfield__label,
		.mdl-textfield--floating-label.has-placeholder .mdl-textfield__label {
			color:@background;
		}

		:scope .chars-count {
			height: 30px;
			font-size: 14px;
		}

		.limit-exceeded {
			color: rgb(213,0,0);
			font-weight: 400;
		}

		:scope > div.input-wrapper {
			display: flex;
		    flex: 1;
		    position: absolute;
		    align-self: flex-end;
		}

		:scope > div.buttons-show {
			padding-right: 46px;
		}

		:scope > div.input-wrapper > div.buttons {
			display: flex;
		    flex: 1;
		    flex-direction: column;
		}

		/* textfield v2 */
		:scope > div.mdl-textfield-v2 > div.textfield-background {
			background-color: #eeeeee;
			position: absolute;
			bottom: 20px;
			top: 0px;
			left: 0;
			right: 0;
			pointer-events: none;
			border-top-left-radius: 4px;
			border-top-right-radius: 4px;
		}
		:scope > div.mdl-textfield-v2 > .textfield-input-wrapper {
			z-index: 1;
		}
		:scope > div.mdl-textfield-v2 > .textfield-input-wrapper > input.mdl-textfield__input {
			box-sizing: border-box;
			padding: 4px 20px 10px;
		}
		:scope > div.mdl-textfield-v2 > label.mdl-textfield__label {
			width: initial;
			padding: 0 20px;
			top: 16px;
		}
		:scope > .mdl-textfield-v2.is-focused .mdl-textfield__label,
		:scope > .mdl-textfield-v2.is-dirty .mdl-textfield__label,
		:scope > .mdl-textfield-v2.has-placeholder .mdl-textfield__label {
			top: 4px;
		}
		:scope > .mdl-textfield-v2.is-invalid .mdl-textfield__label {
			color: rgb(213,0,0);
		}
		:scope > .mdl-textfield-v2 > span.mdl-textfield__error {
			box-sizing: border-box;
			padding: 0 20px;
		}
		:scope > .mdl-textfield-v2.is-disabled .mdl-textfield__input,
		:scope > .mdl-textfield-v2.is-disabled .mdl-textfield__label {
			color: rgba(0,0,0,0.26);
		}

		/* textfield v2-hidden */
		:scope > div.mdl-textfield-v2-hidden {
			padding: 0px;
		}
		:scope > div.mdl-textfield-v2-hidden > div.textfield-background {
			background-color: @backgroundColor;
			position: absolute;
			bottom: 0px;
			top: 0px;
			left: 0;
			right: 0;
			pointer-events: none;
			border-top-left-radius: 4px;
			border-top-right-radius: 4px;
		}
		:scope > div.mdl-textfield-v2-hidden > .textfield-input-wrapper {
			z-index: 1;
		}
		:scope > div.mdl-textfield-v2-hidden > .textfield-input-wrapper > input.mdl-textfield__input {
			box-sizing: border-box;
			padding: 6px 10px;
		}
		:scope > div.mdl-textfield-v2-hidden > label.mdl-textfield__label {
			width: initial;
			padding: 0px 10px;
			top: 6px;
		}
		:scope > .mdl-textfield-v2-hidden.is-focused .mdl-textfield__label,
		:scope > .mdl-textfield-v2-hidden.is-dirty .mdl-textfield__label,
		:scope > .mdl-textfield-v2-hidden.has-placeholder .mdl-textfield__label {
			top: 6px;
		}
		:scope > .mdl-textfield-v2-hidden.is-invalid .mdl-textfield__label {
			color: rgb(213,0,0);
		}
		:scope > .mdl-textfield-v2-hidden > span.mdl-textfield__error {
			box-sizing: border-box;
			padding: 0 10px;
		}
		:scope > .mdl-textfield-v2-hidden .mdl-textfield__label:after {
			bottom: 0px;
		}

		/* textfield v2-outlined */
		:scope > div.mdl-textfield-v2-outlined {
			padding-top: 8px;
		}
		:scope > div.mdl-textfield-v2-outlined > .textfield-input-wrapper > .suffix-container {
			padding-right: 16px;
		}
		:scope > div.mdl-textfield-v2-outlined > .textfield-input-wrapper > input.mdl-textfield__input {
			padding: 12px 16px;
			line-height: 30px;
			border: none;
			box-sizing: border-box;
		}
		:scope > div.mdl-textfield-v2-outlined.has-prefix > .textfield-input-wrapper > input.mdl-textfield__input {
			padding-left: 0px;
		}
		:scope > div.mdl-textfield-v2-outlined.has-suffix > .textfield-input-wrapper > input.mdl-textfield__input {
			padding-right: 0px;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper,
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper {
			position: absolute;
			top: 8px;
			right: 0px;
			bottom: 20px;
			left: 0px;
			pointer-events: none;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline {
			padding-left: 13px;
			width: auto;
			transition: width 0.2s cubic-bezier(0.4, 0, 0.2, 1);
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline > .material-icons,
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline > .fixed-text {
			visibility: hidden;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline > .material-icons {
			padding-right: 8px;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline > .fixed-text {
			padding-right: 4px;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			position: relative;
			padding: 0px 4px;
			top: 16px;
			left: -4px;
		}
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .label-outline > label.mdl-textfield__label,
		:scope > div.mdl-textfield-v2-outlined.is-dirty > div.outline-wrapper > .label-outline > label.mdl-textfield__label,
		:scope > div.mdl-textfield-v2-outlined.has-placeholder > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			top: -10px;
			left: 0px;
		}
		:scope > div.mdl-textfield-v2-outlined.is-dirty > div.outline-wrapper > .label-outline > label.mdl-textfield__label,
		:scope > div.mdl-textfield-v2-outlined.has-placeholder > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			color: @placeholderColor;
		}
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			color: @background;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .label-outline > label.mdl-textfield__label:after {
			content: none;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .trailing-outline {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .trailing-outline {
			border: 1px solid @outlineColor;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .leading-outline {
			border-right: none;
			border-top-left-radius: 4px;
			border-bottom-left-radius: 4px;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .label-outline {
			border-right: none;
			border-left: none;
		}
		:scope > div.mdl-textfield-v2-outlined > div.outline-wrapper > .trailing-outline {
			border-left: none;
			border-top-right-radius: 4px;
			border-bottom-right-radius: 4px;
		}
		:scope > div.mdl-textfield-v2-outlined:not(.is-focused):not(.is-invalid):not(.is-disabled) > .textfield-input-wrapper:hover + div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined:not(.is-focused):not(.is-invalid):not(.is-disabled) > .textfield-input-wrapper:hover + div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined:not(.is-focused):not(.is-invalid):not(.is-disabled) > .textfield-input-wrapper:hover + div.outline-wrapper > .trailing-outline {
			border-color: @outlineHover;
		}
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined.has-placeholder > div.outline-wrapper > .leading-outline {
			padding-left: 12px;
			width: 0px;
		}
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined.is-dirty > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined.has-placeholder > div.outline-wrapper > .label-outline {
			border-top: none;
		}
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined.is-focused > div.outline-wrapper > .trailing-outline {
			border-color: @background;
			border-width: 2px;
		}
		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.outline-wrapper > .trailing-outline {
			border-color: @errorLabelColor;
			border-width: 2px;
		}
		:scope > div.mdl-textfield-v2-outlined.is-invalid > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			color: @errorLabelColor;
		}
		:scope > div.mdl-textfield-v2-outlined.is-disabled > div.outline-wrapper > .leading-outline,
		:scope > div.mdl-textfield-v2-outlined.is-disabled > div.outline-wrapper > .label-outline,
		:scope > div.mdl-textfield-v2-outlined.is-disabled > div.outline-wrapper > .trailing-outline {
			border-color: rgba(0,0,0,0.26);
		}
		:scope > div.mdl-textfield-v2-outlined.is-disabled > div.outline-wrapper > .label-outline > label.mdl-textfield__label {
			color: rgba(0,0,0,0.26);
		}

		:scope .pointer {
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.inputId = guf.param.string(opts.menuid, guf.getAutoId());
		tag.disabled = opts.disabled;
		tag.value = guf.param.string(opts.riotValue, '');
		tag.invalid = opts.invalid;
		updateFromOpts();
		
		tag.mdlClasses = {
			"label" : {
				"floating" : {
					"root" : ["mdl-textfield--floating-label"]
				},
				"v2": {
					"root" : ["mdl-textfield--floating-label", "mdl-textfield-v2"]
				},
				"v2-hidden": {
					"root" : ["mdl-textfield-v2-hidden"]
				},
				"v2-outlined": {
					"root" : ["mdl-textfield--floating-label", "mdl-textfield-v2-outlined"]
				}
			}
		};
		tag.defaultDcss = {
			"background": "@primary",
			"backgroundColor": "transparent",
			"textColor": "inherit",
			"textBorderColor": "rgba(0,0,0, 0.12)",
			"placeholderColor": "rgba(0,0,0,.6)",
			"errorLabelColor": "#d50000",
			"outlineColor": "rgba(0,0,0,.24)",
			"outlineHover": "rgba(0,0,0,.87)"
		};
		tag.mixin('mdl');

		function updateFromOpts() {
			tag.pattern = typeof opts.pattern === "function" ? undefined : opts.pattern;
			tag.type = opts.type;
			tag.autocapitalize = guf.param.string(opts.autocapitalize,'none');
			tag.autocorrect = guf.param.string(opts.autocorrect,'off');
			tag.autocomplete = guf.param.string(opts.autocomplete,'off');
			tag.readonly = guf.param.booleanExpr(opts, "readonly", false);
			tag.rows = guf.param.number(opts.rows, 3);
			tag.limit = guf.param.number(opts.limit, null);
			tag.patternFn = typeof opts.pattern === "function" ? opts.pattern : undefined;
			tag.showButtons = guf.param.boolean(opts.showButtons, false);
			tag.incrementIcon = guf.param.string(opts.incrementIcon, "arrow_drop_up");
			tag.decrementIcon = guf.param.string(opts.decrementIcon, "arrow_drop_down");
			tag.leadingIcon = guf.param.string(opts.leadingIcon, null);
			tag.leadingIconFn = typeof opts.leadingIconFn === "function" ? opts.leadingIconFn : null;
			tag.prefix = guf.param.string(opts.prefix, null);
			tag.trailingIcon = guf.param.string(opts.trailingIcon, null);
			tag.trailingIconFn = typeof opts.trailingIconFn === "function" ? opts.trailingIconFn : null;
			tag.suffix = guf.param.string(opts.suffix, null);			
		}
		
		// Events
		function inputHandler(evt) {
			checkPatternFn();
			updateCharsCount();
			tag.trigger('input', evt);
		}

		function clickHandler(evt) {
			evt.stopPropagation();
			tag.trigger('click', tag, evt);
		}

		function keyupHandler(evt) {
			tag.trigger('keyup', tag.getValue(), evt);
		}

		function focusHandler(evt) {
			evt.stopPropagation();
			tag.trigger('focus', tag, evt);
		}

		function blurHandler(evt) {
			evt.stopPropagation();
			tag.trigger('blur', tag, evt);
		}

		function animationStartHandler(evt) {
			if (evt.animationName && evt.animationName == 'autoFillStart') {
				tag.refs["mdl-textfield"].classList.add('is-dirty');
				tag.trigger('auto-fill', tag, evt);
			} else if (evt.animationName && evt.animationName == 'autoFillCancel') {
				if (!tag.getValue() || tag.getValue().length == 0) tag.refs["mdl-textfield"].classList.remove('is-dirty');
			}
		}

		function initEvents() {
			tag.refs["input"].addEventListener('input', inputHandler, false);
			tag.refs["input"].addEventListener('click', clickHandler, false);
			tag.refs["input"].addEventListener('keyup', keyupHandler, false);
			tag.refs["input"].addEventListener('focus', focusHandler);
			tag.refs["input"].addEventListener('blur', blurHandler);
			tag.refs["input"].addEventListener('webkitanimationstart', animationStartHandler);
			tag.refs["input"].addEventListener('mozanimationstart', animationStartHandler);
			tag.refs["input"].addEventListener('animationstart', animationStartHandler);

			if (tag.showButtons && tag.type==="number") {
				tag.refs.increase.on('click', increaseHandler);
				tag.refs.decrease.on('click', decreaseHandler);
			}
		}

		function removeEvents() {
			tag.refs["input"].removeEventListener('input', inputHandler, false);
			tag.refs["input"].removeEventListener('click', clickHandler, false);
			tag.refs["input"].removeEventListener('keyup', keyupHandler, false);
			tag.refs["input"].removeEventListener('focus', focusHandler);
			tag.refs["input"].removeEventListener('blur', blurHandler);
			tag.refs["input"].removeEventListener('webkitanimationstart', animationStartHandler);
			tag.refs["input"].removeEventListener('mozanimationstart', animationStartHandler);
			tag.refs["input"].removeEventListener('animationstart', animationStartHandler);

			if (tag.showButtons && tag.type==="number") {
				tag.refs.increase.off('click', increaseHandler);
				tag.refs.decrease.off('click', decreaseHandler);
			}
		}

		function initOptionalEvents() {
			if (tag.refs["leading-icon"] && !!tag.leadingIconFn) {
				tag.refs["leading-icon"].addEventListener("click", tag.leadingIconFn);
			}
			if (tag.refs["trailing-icon"] && !!tag.trailingIconFn) {
				tag.refs["trailing-icon"].addEventListener("click", tag.trailingIconFn);
			}
		}

		function removeOptionalEvents() {
			if (tag.refs["leading-icon"] && !!tag.leadingIconFn) {
				tag.refs["leading-icon"].removeEventListener("click", tag.leadingIconFn);
			}
			if (tag.refs["trailing-icon"] && !!tag.trailingIconFn) {
				tag.refs["trailing-icon"].removeEventListener("click", tag.trailingIconFn);
			}
		}

		tag.on('mount', function() {
			updateCharsCount();
			initEvents();
			checkPatternFn();
			initOptionalEvents();
		});

		tag.on('before-unmount', function () {
			removeEvents();
			removeOptionalEvents();
		});

		tag.on("update", function() {
			removeOptionalEvents();
			updateFromOpts();
		});

		tag.on("updated", function() {
			initOptionalEvents();
		});

		// Behaviour
		tag.getValue = function() {
			return tag.refs["input"].value;
		}
		tag.setValue = function(value) {
			tag.refs["mdl-textfield"].MaterialTextfield.change(value);
			checkPatternFn();
			updateCharsCount();
			tag.update();
		}
		tag.enable = function() {
			tag.disabled = false;
			tag.refs["mdl-textfield"].MaterialTextfield.enable();
		}
		tag.disable = function() {
			tag.disabled = true;
			tag.refs["mdl-textfield"].MaterialTextfield.disable();
		}
		tag.focus = function() {
			tag.refs["input"].focus();
		}
		tag.click = function() {
			tag.refs["input"].click();
		};
		tag.markAsInvalid = function(invalid, message) {
			if (!invalid) {
				var newInvalid = message ? message : opts.invalid;
				if (newInvalid != tag.invalid) {
					tag.invalid = newInvalid;
					tag.update();
				}
				tag.refs["mdl-textfield"].classList.remove('is-invalid');
				tag.refs["input"].setCustomValidity('');
			} else {
				var newInvalid = message ? message : opts.invalid;
				if (newInvalid != tag.invalid) {
					tag.invalid = newInvalid;
					tag.update();
				}
				tag.refs["mdl-textfield"].classList.add('is-invalid');
				tag.refs["input"].setCustomValidity('Invalid value');
			}
		}
		tag.isValid = function () {
			return tag.refs["mdl-textfield"].MaterialTextfield.input_.validity.valid;
		}

		tag.isAutoFilled = function () {
			if (guf.device.normalizedName == "chrome" || guf.device.normalizedName == "safari") {
				 return tag.refs["input"].webkitMatchesSelector(':-webkit-autofill');
			}
			return false;
		}

		tag.setReadonly = function (value) {
			tag.readonly = value;
			tag.update();
		};
		
		tag.cleanInput = function () {
			tag.refs["input"].value = '';
			tag.value = '';
		};

		function updateCharsCount() {
			if (tag.limit) {
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

		function checkPatternFn() {
			if (tag.patternFn) {
				tag.markAsInvalid(!tag.patternFn(tag.getValue()));
			}
		}

		function increaseHandler() {
			tag.trigger('input-increase', tag);
		}

		function decreaseHandler() {
			tag.trigger('input-decrease', tag);	
		}
	</script>
</guf-input>