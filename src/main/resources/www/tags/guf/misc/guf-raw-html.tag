<guf-raw-html>
	<style type="dcss">
		:scope.ellipsis {
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			word-break: break-all;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.content = guf.param.string(opts.content, '');
		tag.escaped = guf.param.booleanExpr(opts, "escaped", true);
		tag.links = guf.param.booleanExpr(opts, "links", false);
		tag.emojis = guf.param.booleanExpr(opts, "emojis", false);
		tag.highlight = guf.param.string(opts.highlight, null);
		tag.mentions = guf.param.booleanExpr(opts, "mentions", false);
		tag.ellipsis = guf.param.booleanExpr(opts, "ellipsis", false);
		tag.parseOnUpdate = guf.param.booleanExpr(opts, "parseOnUpdate", true);
		tag.hasMentions = false;
		tag.autoId = guf.getAutoId();

		tag.parseMentions = parseMentions;

		tag.mixin("mdl");

		tag.setContent = function(content) {
			tag.escaped = false;
			tag.highlight = opts.highlight;
			tag.content = content;
			tag.content = populateTag();
			tag.update();
		};

		var _SPACES_REGEXP = new RegExp("&nbsp;|\\s", "g");
		var _PARSED = "parsed";
		var _UNPARSED = "unparsed";
		var _HALFPARSED = "halfparsed";
		var _BOLD_REGEXP = /\*([^\*]*[^\*\s][^\*]*)\*/g;
		var _CURSIVE_REGEXP = /\_([^\_]*[^\_\s][^\_]*)\_/g;
		var _UNDERSCORE_REGEXP = /\+([^\+]*[^\+\s][^\+]*)\+/g;
		var _CODE_REGEXP = /\{\{([^\}]*[^\}\s][^\}]*)\}\}/g;
		var _BEFORE_EMPH_REGEXP = /\W|\_/;
		var _AFTER_EMPH_REGEXP = /\W|\_/;

		var _globalSplittedText = [];

		function parseURLs(splittedText) {
			return applyRegExpToParts(splittedText, /((http(s?):(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+|(?:www\.|[\-;:&=\+\$,\w\.]+@)[A-Za-z0-9\.\-]+)(?:\:[0-9]+)?((?:\/[\+~%\/\.\w\-]*)?\??(?:[\-\+=&;%@\.\w]*)#?(?:[\-\+~%\(\)\.\!\/\\\w]*))/g, 
				function (match) {
					if (match.indexOf('http') == 0 || match.indexOf('ftp') == 0) {
						if (match.charAt(match.length - 1)==="_") {
							return '<a onclick="cordova.InAppBrowser.open(\'' + match.substring(0, match.length-1) + '\', \'_system\')">' + match.substring(0, match.length-1) + '</a>_';
						} else {
							return '<a onclick="cordova.InAppBrowser.open(\'' + match + '\', \'_system\')">' + match + '</a>';
						}
					} else {
						var re = /^[a-zA-Z0-9\._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
						if (re.test(String(match).toLowerCase())) {
							return '<a href="mailto: '+ match + '">' + match + '</a>';
						} else if (match.charAt(match.length - 1)==="_") {
							return '<a onclick="cordova.InAppBrowser.open(\'http://' + match.substring(0, match.length-1) + '\', \'_system\')">' + match.substring(0, match.length-1) + '</a>_';
						} else {
							return '<a onclick="cordova.InAppBrowser.open(\'http://' + match + '\', \'_system\')">' + match + '</a>';
						}
					}
				});
		}

		function parseMentions(regExp, filterFn) {
			_globalSplittedText = applyRegExpToParts(_globalSplittedText, regExp, function(match) {
				var found = filterFn(match);
				if (!!found) {
					return '<a onclick="guf.trigger(\'mention-clicked\', \'' + found + '\', \'' + tag.autoId + '\')">' + match + '</a>';
				} else {
					return match;
				}
			});
			tag.content = flattenParts(_globalSplittedText);
			tag.content = tag.content.replace(/\xa0/g,"&nbsp;");
			tag.root.innerHTML = tag.content;
		}

		function parseRichText(splittedText) {
			splittedText = applyRegExpToParts(splittedText, _BOLD_REGEXP, "<b>$1</b>", true, _BEFORE_EMPH_REGEXP, _AFTER_EMPH_REGEXP);
			splittedText = applyRegExpToParts(splittedText, _CURSIVE_REGEXP, "<em>$1</em>", true, _BEFORE_EMPH_REGEXP, _AFTER_EMPH_REGEXP);
			splittedText = applyRegExpToParts(splittedText, _UNDERSCORE_REGEXP, "<ins>$1</ins>", true, _BEFORE_EMPH_REGEXP, _AFTER_EMPH_REGEXP);
			splittedText = applyRegExpToParts(splittedText, _CODE_REGEXP, "<tt>$1</tt>", false, _BEFORE_EMPH_REGEXP, _AFTER_EMPH_REGEXP);
			return applyRegExpToParts(splittedText, /(\b|^)\-\-\-\-(\b|$)/g, "<hr/>");
		}

		function mentionClicked(mention, tagId) {
			if (tagId === tag.autoId) {
				tag.trigger('mention-click', mention, tag);
			}
		}

		function applyRegExpToParts(splittedText, regExp, fnOrText, noSplit, beforeRegex, afterRegex) {
			var splittedResult = [];
			for (var i = 0; i < splittedText.length; i++) {
				var splittedPart = splittedText[i];
				if (splittedPart.type != _PARSED) {
					var result;
					var lastIndex = 0;
					var noSplitResult = [];
					var currentResult = noSplit ? noSplitResult : splittedResult;
					while ((result = regExp.exec(splittedPart.text)) !== null) {
						var newIndex = result.index;
						var applyMatch = true;
						if (beforeRegex) {
							if (newIndex > 0) {
								var previousCharString = splittedPart.text.substring(newIndex - 1, newIndex);
								if (!beforeRegex.test(previousCharString)) {
									applyMatch = false;
								}
							}
						}
						if (afterRegex) {
							var endOfMatchIndex = newIndex + result[0].length;
							if (endOfMatchIndex < splittedPart.text.length) {
								var nextCharString = splittedPart.text.substring(endOfMatchIndex, endOfMatchIndex + 1);
								if (!afterRegex.test(nextCharString)) {
									applyMatch = false;
								}
							}
						}
						if (applyMatch) {
							if (newIndex != lastIndex) {
								currentResult.push({
									type: _UNPARSED,
									text: splittedPart.text.substring(lastIndex, newIndex)
								});
							}
							newIndex = regExp.lastIndex;
							currentResult.push({
								type: _PARSED,
								text: result[0].replace(regExp, fnOrText)
							});
							regExp.lastIndex = newIndex;
							lastIndex = newIndex;
						}
					}
					if (lastIndex < splittedPart.text.length) {
						currentResult.push({
							type: _UNPARSED,
							text: splittedPart.text.substring(lastIndex, splittedPart.text.length)
						});
					}
					if (noSplit) {
						splittedResult.push({
							type: _HALFPARSED,
							text: flattenParts(noSplitResult)
						});
					}
				} else {
					splittedResult.push(splittedPart);
				}
			}
			return flattenUnparsedParts(splittedResult);
		}

		function flattenUnparsedParts(splittedText) {
			var splittedResult = [];
			var currentUnparsed = {
				type: _UNPARSED,
				text: ""
			};
			for (var i = 0; i < splittedText.length; i++) {
				var splittedPart = splittedText[i];
				if (splittedPart.type != _PARSED) {
					if (splittedPart.type != _HALFPARSED) {
						currentUnparsed.type = _HALFPARSED;
					}
					currentUnparsed.text += splittedPart.text;
				} else {
					if (currentUnparsed.text != "") {
						splittedResult.push(currentUnparsed);
						currentUnparsed = {
							type: _UNPARSED,
							text: ""
						};
					}
					splittedResult.push(splittedPart);
				}
			}
			if (currentUnparsed.text != "") {
				splittedResult.push(currentUnparsed);
			}
			return splittedResult;
		}

		function flattenParts(splittedText) {
			var result = "";
			for (var i=0; i<splittedText.length; i++) {
				result += splittedText[i].text;
			}
			return result;
		}

		function populateTag() {
			if (tag.ellipsis) {
				tag.content = tag.content.replace(new RegExp("\\n", "g"), " ");
				tag.content = tag.content.replace(new RegExp("\\r", "g"), " ");
			}
			if (tag.escaped) {
				var tmp = document.createElement("DIV");
				tmp.innerText = tag.content;
				tag.content = tmp.innerHTML;
			}
			tag.content = tag.content.replace(/&nbsp;/g,"\xa0");
			if (tag.highlight) {
				tag.content = guf.utils.removeDiacritics(tag.content);				
			}
			if (tag.emojis) {
				tag.content = guf.emoji.replace(tag.content);
			}
			var splittedText = [{
				type: _UNPARSED,
				text: tag.content
			}];
			if (tag.highlight) {
				var hl = JSON.parse(tag.highlight);
				if (typeof(hl) === 'object') {
					for (var i=0; i<hl.length; i++) {
						splittedText = applyRegExpToParts(splittedText, new RegExp("(" + guf.utils.removeDiacritics(hl[i]) + ")", "gi"), "<span class='guf-highlight'>$1</span>");
					}
				} else {
					splittedText = applyRegExpToParts(splittedText, new RegExp("(" + guf.utils.removeDiacritics(tag.highlight) + ")", "gi"), "<span class='guf-highlight'>$1</span>");
				}
			}
			if (tag.links) {
				splittedText = parseURLs(splittedText);
			}
			if (tag.mentions) {
				tag.hasMentions = true;
			}
			splittedText = parseRichText(splittedText);
			_globalSplittedText = splittedText;
			tag.content = flattenParts(splittedText);
			tag.content = tag.content.replace(/\xa0/g,"&nbsp;");
			tag.root.innerHTML = tag.content;
		}

		tag.on('mount', function() {
			if(tag.ellipsis) {
				tag.root.classList.add("ellipsis");
			} else {
				tag.root.classList.remove("ellipsis");
			}
			populateTag();
			if (tag.mentions && tag.hasMentions) {
				guf.on('mention-clicked', mentionClicked);
			}
		});
		tag.on('before-unmount', function() {
			if (tag.mentions && tag.hasMentions) {
				guf.off('mention-clicked', mentionClicked);
			}
		})
		tag.on("update", function() {
			if(tag.ellipsis) {
				tag.root.classList.add("ellipsis");
			} else {
				tag.root.classList.remove("ellipsis");
			}
			if(tag.parseOnUpdate) {
				tag.content = opts.content;
				populateTag();
			}
		});
	</script>
</guf-raw-html>