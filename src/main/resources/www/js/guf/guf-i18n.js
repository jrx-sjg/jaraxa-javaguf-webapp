(function(){
	
	guf.i18n = (function(){

		var _SHORT = {length: "short"};
		var _PLURAL = {number: "plural"};

		var _keys = {};
		var _languages = [];

		function getTranslation(key, options) {
			for (var i = 0; i < _languages.length; i++) {
				var language = _languages[i];
				if (_keys[language]) {
					if (options.length == "short" && _keys[language][key + "__short"]) {
						return _keys[language][key + "__short"];
					} else if (options.number == "plural" && _keys[language][key + "__plural"]) {
						return _keys[language][key + "__plural"];
					} else if(_keys[language][key]) {
						return _keys[language][key];
					}
				}
			}
			return ":" + key;
		}

		function has(param1) {
			for (var i = 0; i < _languages.length; i++) {
				var language = _languages[i];
				if (_keys[language] && _keys[language][param1]) {
					return true;
				}
			}
			return false;
		}

		function get(param1, param2) {
			var hasOptions = typeof(param1) === "object";
			var key = hasOptions ? param2 : param1;
			var options = hasOptions ? param1 : {};
			var params = Array.isArray(arguments[1]) ? arguments[1] : Array.prototype.slice.call(arguments, (hasOptions ? 2 : 1)); 
			var pattern = new RegExp("{([0-9]+)}", "g");
			var translation = getTranslation(key, options);
			return String(translation).replace(pattern, function(match, index) {
				if (params.length > index) {
					return params[index];
				} else {
					return match;
				}
			}); 			
		}

		function add(language, module, translations) {
			if (typeof(_keys[language]) === "undefined") {
				_keys[language] = {};
			}
			for (var key in translations) {
				var completeKey = (module ? module + "." : "") + key;
				_keys[language][completeKey] = translations[key];
			}
		}

		function filterLanguages(filterLanguages) {
			var languages = [];
			for (var i=0; i < _languages.length; i++) {
				if (filterLanguages.indexOf(_languages[i]) != -1 || _languages[i] == "en") {
					languages.push(_languages[i]);
				}
			}
			_languages = languages;
		}

		function getLanguages() {
			return _languages;
		}

		function getLanguagesWithoutLocale() {
			return languagesWithoutLocale;
		}

		// Init

		// Language param
		var languagesWithoutLocale = [];
		if (typeof(guf.urlParams.lang) !== "undefined") {
			var language = guf.urlParams.lang;
			var localizedLanguage = language;
			var isLocalized = false;
			if (language.indexOf("-") != -1) {
				language = language.substring(0, language.indexOf("-"));
				isLocalized = true;
			}
			_languages.push(localizedLanguage);
			if (isLocalized) {
				languagesWithoutLocale.push(language);
			}
		}
		// Browser languages
		if (navigator.language || navigator.languages) {
			var languagesToCheck = Array.isArray(navigator.languages) && navigator.languages.length > 0 ? navigator.languages : [navigator.language];
			for (var i = 0; i < languagesToCheck.length; i++) {
				var language = languagesToCheck[i];
				var localizedLanguage = language;
				var isLocalized = false;
				if (language.indexOf("-") != -1) {
					language = language.substring(0, language.indexOf("-"));
					isLocalized = true;
				}
				if (_languages.indexOf(localizedLanguage) == -1) {
					_languages.push(localizedLanguage);
				}
				if (isLocalized && languagesWithoutLocale.indexOf(language) == -1) {
					languagesWithoutLocale.push(language);
				}
			}
		}
		// Languages without locale
		for (var i = 0; i < languagesWithoutLocale.length; i++) {
			var language = languagesWithoutLocale[i];
			if (_languages.indexOf(language) == -1) {
				_languages.push(language);
			}
		}
		// English as default language
		if (_languages.indexOf("en") == -1) {
			_languages.push("en");
		}
		guf.console.log("Languages for i18n: ", _languages);

		return {
			get: get,
			add: add,
			has: has,
			filterLanguages: filterLanguages,
			getLanguages: getLanguages,
			getLanguagesWithoutLocale: getLanguagesWithoutLocale,
			SHORT: _SHORT,
			PLURAL: _PLURAL
		}
	})();
	
})();