<guf-editable>
	<input if="{guf.device.isIos || guf.device.normalizedName == 'safari'}" ref="blur-input" type="text" class="blur-input">
	<guf-raw-html ref="input" id="{ inputId }" content="{opts.riotValue ? opts.riotValue : ''}" contenteditable="{ !disabled }" emojis="true" id="{ inputId }" parse-on-update="false" class="{textarea: opts.textarea, no-border: !border}"></guf-raw-html>
	<guf-linear-layout class="chars-count" ref="chars-wrapper" if="{limit || countFn}" h-align="right" v-align="center"><guf-raw-html id="{parent.opts.charsCounterId}" content="{parent.chars}" parse-on-update="true" escaped="false" v-align="center"></guf-raw-html></guf-linear-layout>
	<label ref="label" class="mdl-textfield__label {textarea: opts.textarea, no-border: !border}" for="{ inputId }">{ opts.placeholder }</label>
	<style scoped type="dcss">
		:scope {
			display: block;
			position:relative;
			padding-top:10px;
			color: @textColor;
		}
		:scope > .blur-input {
			display: none;
		}
		:scope > guf-raw-html {
			display:block;
			top:0;
			left:0;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			outline: none;
			overflow: hidden;
			min-height:19px;
			padding-top:6px;
			padding-bottom:4px;
			line-height:normal;
			border-bottom: 1px solid rgba(0,0,0,.12);
			word-wrap: break-word;
			word-break: break-word;
		}
		:scope > guf-raw-html.textarea {
			height: calc(100%  - 30px);
			overflow-y: auto;
			-webkit-overflow-scrolling: auto;
		}
		:scope > guf-raw-html.no-border {
			border-bottom: none;
		}
		:scope > label.mdl-textfield__label {
			position:absolute;
			height:24px;
			top:16px;
		}
		:scope > label.mdl-textfield__label.textarea {
			height: calc(100% - 35px);
		}
		:scope > label.mdl-textfield__label:after {
			background-color: @background;
			bottom:0;
		}
		:scope > label.mdl-textfield__label.is-focused:after {
			left:0;
			visibility:visible;
			width:100%;
		}
		:scope[limit] > label.mdl-textfield__label:after {
			bottom:0px;
		}
		:scope > label.mdl-textfield__label.no-border:after,
		:scope > label.mdl-textfield__label.is-focused.no-border:after {
			visibility: hidden;
			width: 0;
		}

		:scope .chars-count {
			height: 30px;
			font-size: 14px;
			color: @textColor;
		}

		.limit-exceeded {
			color: rgb(213,0,0);
			font-weight: 400;
		}

	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		tag.inputId = guf.getAutoId();
		tag.disabled = guf.param.booleanExpr(opts, "disabled", false);
		tag.border = guf.param.booleanExpr(opts, "border", true);
		tag.limit = guf.param.number(opts.limit, null);
		tag.countFn = opts.countFn;
		tag.minLines = guf.param.number(opts.minLines, 1);
		tag.maxLines = guf.param.number(opts.maxLines, 1);
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": "@primary",
			"textColor": "#000"
		};
		tag.mixin("mdl");

		var input = null;
		var label = null;
		var pastedText = "";
		var afterPaste = false;
		var lastValue = "";
		var checkForEmojisTimeout = null;
		var lineHeight = 19;
		var labelBase = 24;
		var keepLineBreaksOnPaste = guf.param.booleanExpr(opts, "keepLineBreaksOnPaste", false);

		function replaceEmojis(node, currentPosition) {
			currentPosition = currentPosition || 0;
			var i = 0;
			var dirty = false;
			var newCaretPosition = 0;
			while (i < node.childNodes.length) {
				switch (node.childNodes[i].nodeType) {
					case Node.TEXT_NODE:
						var childNode = node.childNodes[i];
						var childText = childNode.data;
						var textWithEmojis = guf.emoji.replace(childText);
						if (textWithEmojis != childText) {
							var calculateCaret = !dirty;
							if (calculateCaret) {
								newCaretPosition = currentPosition;
							}
							dirty = true;
							var dom = document.createElement("div");
							dom.innerHTML = textWithEmojis;
							while (dom.hasChildNodes()) {
								if (calculateCaret) {
									if (dom.childNodes[0].nodeType == Node.TEXT_NODE) {
										newCaretPosition += dom.childNodes[0].data.length;
									} else if (guf.emoji.isEmojiNode(dom.childNodes[0])) {
										newCaretPosition += guf.emoji.getEmojiNodeLength(dom.childNodes[0]);
										calculateCaret = false;
									}
								}
								node.insertBefore(dom.childNodes[0], childNode);
							}
							node.removeChild(childNode);
						}
						currentPosition += childNode.data.length;
						i++;
						break;
					case Node.ELEMENT_NODE:
						if (guf.emoji.isEmojiNode(node.childNodes[i])) {
							currentPosition += guf.emoji.getEmojiNodeLength(node.childNodes[i]);
						} else {
							currentPosition = replaceEmojis(node.childNodes[i], currentPosition);
						}
						i++;
						break;
					default:
						if (guf.emoji.isEmojiNode(node.childNodes[i])) {
							currentPosition += guf.emoji.getEmojiNodeLength(node.childNodes[i]);
						} else {
							currentPosition += node.childNodes[i].innerText.length;
						}
						i++;
						break;
				}
			}
			if (dirty) {
				setCaretPosition(input, newCaretPosition);				
			}
			return currentPosition;
		}

		function pasteHandler(evt) {
			evt.preventDefault();
			var clipboardData = evt.clipboardData || window.clipboardData;
			var text = clipboardData.getData("Text");
			if(keepLineBreaksOnPaste) {
				text = text.replace(/\r?\n/g, '<br />');
			}
			if (guf.device.isIos && (text == "" || text.length <= 0)) text = clipboardData.getData("public.plain-text") || clipboardData.getData("public.text");
			document.execCommand("insertHTML", false, text);
			/* C4-89 inputHandler(evt);*/
		}

		function inputHandler(evt) {
			checkLabelHeight();
			if (checkForEmojisTimeout != null) {
				guf.clearTimeout(checkForEmojisTimeout);
			}
			checkForEmojisTimeout = guf.setTimeout(function() {
				replaceEmojis(input);
				checkForEmojisTimeout = null;
				checkLabelHeight();
				checkInput();
				tag.trigger('input', evt);
			},10);
		}

		function keydownHandler(event) {
			if (((event.key!==null && event.key==="enter") || event.keyCode === 13) && (event.ctrlKey || event.altKey)) {
				document.execCommand("insertParagraph", false);
				//TODO: Take caret position into account
				input.scrollTop = input.scrollHeight;
			}
			tag.trigger('keydown', tag.getValue(), event);
		}

		function textInputHandler(evt) {
			tag.trigger('textInput', tag.getValue(), evt);
		}

		function keyupHandler(evt) {
			tag.trigger('keyup', tag.getValue(), evt);
		}

		function focusHandler(evt) {
			label.classList.add("is-focused");
			tag.trigger('focus', tag, evt);
		}

		function blurHandler(evt) {
			webkitBlurWorkaround();
			label.classList.remove("is-focused");
			tag.trigger('blur', tag, evt);
		}

		function webkitBlurWorkaround(event) {
			if (guf.device.isIos || guf.device.normalizedName == 'safari') {
				tag.refs["blur-input"].setSelectionRange(0, 0);
				tag.root.blur();
			}
		}

		function iosSingleBreak(node) {
			return (guf.device.isIos && node.tagName == "DIV" && node.childNodes && node.childNodes.length == 1 && node.childNodes[0].tagName == "BR");
		}

		function setCaretPosition(element, position){
			// Loop through all child nodes
			for (var i = 0; i < element.childNodes.length; i++) {
				var node = element.childNodes[i];
				if (node.nodeType == Node.TEXT_NODE) { // we have a text node
					if(node.length >= position){
						// finally add our range
						var range = document.createRange(),
							sel = window.getSelection();
						range.setStart(node,position);
						range.collapse(true);
						sel.removeAllRanges();
						sel.addRange(range);
						return -1; // we are done
					}else{
						position -= node.length;
					}
				} else if (guf.emoji.isEmojiNode(node)) {
					position -= guf.emoji.getEmojiNodeLength(node);
					if (position == 0) {
						var range = document.createRange(),
							sel = window.getSelection();
						range.setStartAfter(node);
						range.collapse(true);
						sel.removeAllRanges();
						sel.addRange(range);
						return -1;
					}
				} else {
					position = setCaretPosition(node,position);
					if(position == -1){
						return -1; // no need to finish the for loop
					}
				}
			}
			return position; // needed because of recursion stuff
		}

		function updateCharsCount() {
			if (tag.limit) {
				tag.chars = tag.countFn(tag.getValue()) + " / " + tag.limit;
				if (tag.countFn(tag.getValue()) > tag.limit) {
					tag.refs["chars-wrapper"].root.classList.add("limit-exceeded");
					tag.markAsInvalid(true);
				} else {
					tag.refs["chars-wrapper"].root.classList.remove("limit-exceeded");
					tag.markAsInvalid(false);
				}
				tag.refs["chars-wrapper"].update();
			} else if (tag.countFn) {
				tag.chars = tag.countFn(tag.getValue());
				tag.refs["chars-wrapper"].update();				
			}
		}

		function checkInput() {
			if (tag.getValue() == "") {
				label.classList.remove("invisible");
			} else {
				label.classList.add("invisible");
			}
			updateCharsCount();
		}

		function checkLabelHeight() {
			var inputHeight = window.getComputedStyle(input, null).height;
			var inputHeight = Math.round(parseFloat(inputHeight.substring(0, inputHeight.length - 2)));
			var lines = inputHeight / lineHeight;
			var labelHeight = (labelBase + (lines - 1) * lineHeight) + "px";
			label.style.height = labelHeight;
		}

		function getNodeValue(node) {
			var result = "";
			for (var i=0; i<node.childNodes.length; i++) {
				switch (node.childNodes[i].nodeType) {
					case Node.TEXT_NODE:
						var text = node.childNodes[i].data;
						result += text;
						break;
					default:
						if (guf.emoji.isEmojiNode(node.childNodes[i])) {
							result += guf.emoji.getEmojiNodeText(node.childNodes[i]);
						} else if (node.childNodes[i].tagName == "BR" || iosSingleBreak(node.childNodes[i])) {
							result += "\n";
						} else if (node.childNodes[i].tagName == "DIV") {
							result += "\n" + getNodeValue(node.childNodes[i]);
						} else {
							result += "\n" + node.childNodes[i].innerText;
						}
						break;
				}
			}
			return result;
		}

		tag.blur = function() {
			input.blur();
		}

		tag.focus = function() {
			input.focus();
		};

		tag.isFocused = function () {
			return label.classList.contains("is-focused");
		};

		tag.getValue = function() {
			var result = "";
			var isFirst = true;
			for (var i=0; i<input.childNodes.length; i++) {
				switch (input.childNodes[i].nodeType) {
					case Node.TEXT_NODE:
						var text = input.childNodes[i].data;
						if (!isFirst || text.trim() !== "") {
							result += text;
						}
						break;
					default:
						if (guf.emoji.isEmojiNode(input.childNodes[i])) {
							result += guf.emoji.getEmojiNodeText(input.childNodes[i]);
						} else if (input.childNodes[i].tagName == "BR" || iosSingleBreak(input.childNodes[i])) {
							result += "\n";
						} else if (guf.device.isIos && input.childNodes[i].tagName == "DIV") {
							result += "\n" + getNodeValue(input.childNodes[i]);
						} else {
							result += "\n" + input.childNodes[i].innerText;
						}
						break;
				}
				isFirst = false;
			}
			return result.replace(/\r/gi,"").replace(/\n$/gi,"");
		};

		tag.setValue = function(value) {
			input.innerText = value;
			/* C4-89 tag.refs["input"].setContent(value); */
			replaceEmojis(input);
			checkLabelHeight();
			checkInput();
		};

		tag.setCaretPosition = function (position) {
			if (tag.refs["input"]) setCaretPosition(tag.refs["input"].root, position);
		};

		tag.enable = function() {
			tag.disabled = false;
			tag.update();
		}

		tag.disable = function() {
			tag.disabled = true;
			tag.update();
		}

		tag.markAsInvalid = function(invalid) {
			if (!invalid) {
				tag.root.classList.remove('is-invalid');
			} else {
				tag.root.classList.add('is-invalid');
			}
		}

		tag.isValid = function() {
			return !tag.root.classList.contains('is-invalid');
		}

		tag.refreshInput = function() {
			replaceEmojis(input);
			checkInput();
		}

		tag.on("mount",function() {
			input = tag.refs["input"].root;
			label = tag.refs["label"];
			updateCharsCount();
			input.addEventListener("textInput", textInputHandler);
			input.addEventListener("input", inputHandler);
			input.addEventListener("keyup", keyupHandler);
			input.addEventListener("keydown", keydownHandler);
			input.addEventListener("paste", pasteHandler);
			input.addEventListener("focus", focusHandler);
			input.addEventListener("blur", blurHandler);
			input.style.minHeight = (lineHeight * tag.minLines) + "px";
			input.style.maxHeight = (lineHeight * tag.maxLines) + "px";
			window.addEventListener("resize", checkLabelHeight);
			if (document.activeElement && document.activeElement.id == input.id) {
				focusHandler();
			}
		});
		tag.on("updated", function() {
			checkLabelHeight();
		});
		tag.on("before-unmount",function() {
			input.removeEventListener("textInput", textInputHandler);
			input.removeEventListener("input", inputHandler);
			input.removeEventListener("keyup", keyupHandler);
			input.removeEventListener("keydown", keydownHandler);
			input.removeEventListener("paste", pasteHandler);
			input.removeEventListener("focus", focusHandler);
			input.removeEventListener("blur", blurHandler);
			window.removeEventListener("resize", checkLabelHeight);
		});
	</script>
</guf-editable>