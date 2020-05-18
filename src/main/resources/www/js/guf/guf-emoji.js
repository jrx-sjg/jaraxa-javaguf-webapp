(function () {

	var EMOJI_VARIATION_SELECTOR_16 = "\ufe0f";
	var EMOJI_ZERO_WIDTH_JOINER = "\u200d";
	var EMOJI_FEMALE_SIGN = "\u2640";
	var EMOJI_MALE_SIGN = "\u2642";
	var EMOJI_FITZPATRICK_MODIFIER = getSurrogateRangeRegExp(0x1f3fb,0x1f3ff);
	var EMOJI_GENDER_MODIFIER = EMOJI_ZERO_WIDTH_JOINER + "(" + EMOJI_FEMALE_SIGN + "|" + EMOJI_MALE_SIGN + ")" + EMOJI_VARIATION_SELECTOR_16;
	var EMOJI_RAINBOW = getSurrogatePairRegExp(0x1f308,0x1f308);
	var EMOJI_SKULL_AND_CROSSBONES = "\u2620";
	var EMOJI_LATIN_SMALL_LETER = getSurrogateRangeRegExp(0xe0061, 0xe007a);
	var EMOJI_CANCEL_TAG = getSurrogatePairRegExp(0xe007f);
	var EMOJI_LEFT_SPEECH_BUBBLE = getSurrogatePairRegExp(0x1f5e8);
	var EMOJI_MEDICAL_SYMBOL = "\u2695";
	var EMOJI_BALANCE_SCALE = "\u2696";
	var EMOJI_AIRPLANE = "\u2708";
	var EMOJI_FIRE_ENGINE = getSurrogatePairRegExp(0x1f692);
	var EMOJI_COOKING = getSurrogatePairRegExp(0x1f373);
	var EMOJI_GRADUATION_CAP = getSurrogatePairRegExp(0x1f393);
	var EMOJI_WRENCH = getSurrogatePairRegExp(0x1f527);
	var EMOJI_ARTIST_PALETTE = getSurrogatePairRegExp(0x1f3a8);
	var EMOJI_ROCKET = getSurrogatePairRegExp(0x1f680);
	var EMOJI_FACTORY = getSurrogatePairRegExp(0x1f3ed);
	var EMOJI_BRIEFCASE = getSurrogatePairRegExp(0x1f4bc);
	var EMOJI_COMBINING_ENCLOSING_KEYCAP = "\u20e3";
	var EMOJI_RANGES = [
		// Miscellaneous Symbols
		"\xa9",
		"\xae",
		getEmojiRangeRegExp(0x2600,0x27bf, {skin: true}),
		"[\u2934-\u2935]",
		"[\u2b05-\u2b55]",
		"\u303d",
		"\u3299",
		// Miscellaneous Symbols and Pictographs
		getEmojiRangeRegExp(0x1f300,0x1f3f2, {skin:true, gender:true}),
		// - White flags & rainbow flag variant
		getEmojiRangeRegExp(0x1f3f3,0x1f3f3, {optional: EMOJI_VARIATION_SELECTOR_16 + EMOJI_ZERO_WIDTH_JOINER + EMOJI_RAINBOW}),
		// - Black flags & non-countries flags variants
		getEmojiRangeRegExp(0x1f3f4,0x1f3f4, {optional: [
			// UK nations flags
			"(" + EMOJI_LATIN_SMALL_LETER + ")+" + EMOJI_CANCEL_TAG,
			// Pirate flag
			EMOJI_ZERO_WIDTH_JOINER + EMOJI_SKULL_AND_CROSSBONES + EMOJI_VARIATION_SELECTOR_16
		]}),
		getEmojiRangeRegExp(0x1f3f5,0x1f3ff, {skin:true, gender:true}),
		getEmojiRangeRegExp(0x1f400,0x1f440, {skin:true, gender:true}),
		getEmojiRangeRegExp(0x1f441,0x1f441, {
			// Eye in speech bubble
			optional: EMOJI_VARIATION_SELECTOR_16 + EMOJI_ZERO_WIDTH_JOINER + EMOJI_LEFT_SPEECH_BUBBLE + EMOJI_VARIATION_SELECTOR_16
		}),
		getEmojiRangeRegExp(0x1f442,0x1f467, {skin:true, gender:true}),
		// - Man and woman
		getEmojiRangeRegExp(0x1f468,0x1f469, {
			skin:true,
			// Pilot 
			jobs: [
				EMOJI_MEDICAL_SYMBOL + EMOJI_VARIATION_SELECTOR_16,
				EMOJI_BALANCE_SCALE + EMOJI_VARIATION_SELECTOR_16,
				EMOJI_AIRPLANE + EMOJI_VARIATION_SELECTOR_16,
				EMOJI_FIRE_ENGINE,
				EMOJI_COOKING,
				EMOJI_GRADUATION_CAP,
				EMOJI_WRENCH,
				EMOJI_ARTIST_PALETTE,
				EMOJI_ROCKET,
				EMOJI_FACTORY,
				EMOJI_BRIEFCASE
			]
		}),
		getEmojiRangeRegExp(0x1f46a,0x1f5ff, {skin:true, gender:true}),
		// Emoticons (Unicode block)
		getEmojiRangeRegExp(0x1f600,0x1f64f, {skin:true, gender:true}),
		// Transport and Map Symbols
		getEmojiRangeRegExp(0x1f680,0x1f6ff, {skin:true, gender:true}),
		// Supplemental Symbols and Pictographs
		getEmojiRangeRegExp(0x1f900,0x1f9ff, {skin:true, gender:true}),
		// Regional Indicators
		"(" + getEmojiRangeRegExp(0x1f1e6,0x1f1ff) + "){1,2}",
		// Keycap Symbols
		"(#|\\*|[0-9])" + EMOJI_VARIATION_SELECTOR_16 + EMOJI_COMBINING_ENCLOSING_KEYCAP
	];
	var EMOJI_REGEXP = new RegExp(EMOJI_RANGES.join("|"), "g");
	var SPACES_REGEXP = new RegExp("&nbsp;|\\s", "g");

	function defaultReplace(emoji, className) {
		var sequence = "";
		var index = 0;
		while (emoji.length > index) {
			var codePoint = emoji.codePointAt(index).toString(16);
			if (codePoint.length > 4) {
				index++;
			}
			index++;
			if (sequence != "") {
				sequence += "-";
			}
			sequence += codePoint.toLowerCase();
		}
		return "<img class=\"emoji " + className + "\" src=\"img/emoji/" + sequence + ".png\" alt=\"" + emoji + "\" sequence=\"" + sequence + "\" onerror=\"guf.emoji.fixImageSrc(this)\"/>";
	}

	function fixImageSrc(node) {
		var sequence = node.getAttribute("sequence");
		if (sequence.endsWith("-fe0f")) {
			sequence = sequence.substring(0, sequence.length - 5);
			node.setAttribute("sequence", sequence);
			node.setAttribute("src", "img/emoji/" + sequence + ".png");
		} else {
			node.onerror = null;
			node.setAttribute("src", "img/transparent.png");
			if (node.parentNode) {
				var dom = document.createElement("span");
				dom.innerText = node.getAttribute("alt");
				node.parentNode.insertBefore(dom,node);
				node.parentNode.removeChild(node);
			}
			guf.emoji.trigger("emoji-image-failed", node);
		}
	}

	function replaceEmojis(text, replaceFn) {
		if (typeof(replaceFn) === "undefined") {
			replaceFn = defaultReplace;
		}
		var textWithoutSpaces = text.replace(SPACES_REGEXP, "");
		var hasText = textWithoutSpaces.replace(EMOJI_REGEXP, "").length > 0;
		var emojisCount = 0;
		if (!hasText) {
			emojisCount = textWithoutSpaces.replace(EMOJI_REGEXP, "_").length;
			if (emojisCount > 4) {
				emojisCount = 4;
			}
		}
		var className = (hasText ? "emoji-4" : "emoji-" + emojisCount);
		var translatedText = text.replace(EMOJI_REGEXP, function(emoji) {
			return replaceFn(emoji, className);
		});
		return translatedText;
	}

	function getSurrogatePair(codepoint) {
		var offset = codepoint - 0x10000;
		var lead = 0xd800 + (offset >> 10);
		var trail = 0xdc00 + (offset & 0x3ff);
		return [lead, trail];
	}

	function getSurrogatePairRegExp(codepoint) {
		var pair = getSurrogatePair(codepoint);
		return String.fromCharCode(pair[0]) + String.fromCharCode(pair[1]);
	}

	function getSurrogateRangeRegExp(startCodepoint, endCodepoint) {
		var startPair = getSurrogatePair(startCodepoint);
		var endPair = getSurrogatePair(endCodepoint);
		var startLead = startPair[0];
		var startTrail = startPair[1];
		var endLead = endPair[0];
		var endTrail = endPair[1];
		if (startLead != endLead) {
			throw Error("startCodepoint and endCodepoint must have the same lead surrogate");
		}
		return String.fromCharCode(startLead) + "[" + String.fromCharCode(startTrail) + "-" + String.fromCharCode(endTrail) + "]";
	}

	function getEmojiRangeRegExp(startCodepoint, endCodepoint, options) {
		var surrogateRange = "";
		if (startCodepoint < 0x10000 && endCodepoint < 0x10000) {
			surrogateRange = "[" + String.fromCharCode(startCodepoint) + "-" + String.fromCharCode(endCodepoint) + "]";
		} else if (startCodepoint >= 0x10000 && endCodepoint >= 0x10000) {
			surrogateRange = startCodepoint == endCodepoint ? getSurrogatePairRegExp(startCodepoint) : getSurrogateRangeRegExp(startCodepoint, endCodepoint);
		} else {
			throw Error("startCodepoint and endCodepoint must be either 16-bit or 32-bit");
		}
		var options = options || {};
		var result = "(";
		result += surrogateRange;
		result += "(" + EMOJI_VARIATION_SELECTOR_16 + ")?";
		if (options.skin) {
			result += "(" + EMOJI_FITZPATRICK_MODIFIER + ")?";
		}
		if (options.gender) {
			result += "(" + EMOJI_GENDER_MODIFIER + ")?";
		}
		if (options.jobs) {
			if (Array.isArray(options.jobs)) {
				result += "(";
				for (var i = 0; i < options.jobs.length; i++) {
					if (i > 0) {
						result += "|";
					}
					result += "(" + EMOJI_ZERO_WIDTH_JOINER + options.jobs[i] + ")";
				}
				result += ")?";
			} else {
				result += "(" + EMOJI_ZERO_WIDTH_JOINER + options.jobs + ")?";
			}
		}
		if (options.optional) {
			if (Array.isArray(options.optional)) {
				result += "(";
				for (var i = 0; i < options.optional.length; i++) {
					if (i > 0) {
						result += "|";
					}
					result += "(" + options.optional[i] + ")";
				}
				result += ")?";
			} else {
				result += "(" + options.optional + ")?";
			}
		}
		return result + ")";
	}

	function isEmojiNode(node) {
		return node.nodeType == Node.ELEMENT_NODE && node.tagName === "IMG" && node.classList.contains("emoji");
	}

	function getEmojiNodeText(node) {
		return node.getAttribute("alt");
	}

	function getEmojiNodeLength(node) {
		return getEmojiNodeText(node).length;
	}

	guf.emoji = (function () {
		return {
			replace : replaceEmojis,
			getSurrogateRangeRegExp: getSurrogateRangeRegExp,
			isEmojiNode: isEmojiNode,
			getEmojiNodeText: getEmojiNodeText,
			getEmojiNodeLength: getEmojiNodeLength,
			fixImageSrc: fixImageSrc,
			EMOJI_RANGES: EMOJI_RANGES
		};
	})();

	riot.observable(guf.emoji);
	
})();
