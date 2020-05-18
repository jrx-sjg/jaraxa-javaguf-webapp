(function(){
	
	guf.l10n = (function(){

		var hourMode = calculateHourMode();
		var locale = window.navigator.userLanguage || window.navigator.language;

		moment.locale(locale);

		function calculateHourMode() {
			var result = true;
			try {
				var date = new Date("1/1/1980 23:59:00");
				var dateString = date.toLocaleString(getBrowserLocale());
				return dateString.indexOf("23:59:00") != -1;
			} catch (e) {
				guf.console.error(e);
			}
			return result;
		}

		function getHourMode() {
			return hourMode;
		}

		function getBrowserLocale() {
			var language = "";
			if (typeof(guf.urlParams.lang) !== "undefined") {
				language = guf.urlParams.lang;
			} else if (Array.isArray(navigator.languages) && navigator.languages.length > 0) {
				language = navigator.languages[0];
			} else {
				language = navigator.language;
			}
			return language;
		}

		function to24HourMode(time) {
			var halfIndicator = time.trim().split(" ");
			if (halfIndicator.length == 2) {
				var timeParts = halfIndicator[0].split(":");
				if (halfIndicator[1].toUpperCase() == "PM") {
					if (timeParts[0] != "12") {
						timeParts[0] = (parseInt(timeParts[0]) + 12).toString();
					}
				} else if (timeParts[0] == "12") {
					timeParts[0] = "00";
				}
				var result = "";
				for (var i = 0; i < timeParts.length; i++) {
					if (result != "") {
						result += ":";
					}
					result += timeParts[i];
				}
				return result;
			} else {
				return time;
			}
		}

		function toLocaleMode(time) {
			var timeParts = time.split(":");
			var hour = parseInt(timeParts[0]);
			var isPm = time >= "12:00:00".substring(0, time.length);
			if (isPm) {
				hour -= 12;
			}
			if (hour == 0) {
				hour = 12;
			}
			var result = hour < 10 ? "0" + hour : hour;
			for (var i = 1; i < timeParts.length; i++) {
				result += ":" + timeParts[i];
			}
			result += " " + (isPm ? "PM" : "AM");
			return result;
		}

		function localizedDayAndMonthFormat() {
			var locale = getBrowserLocale().substring(0, 2);
			switch (locale) {
				case "es":
					return "D [de] MMM";
				default:
					return "MMM Do";
			}
		}


		return {
			getHourMode : getHourMode,
			to24HourMode : to24HourMode,
			toLocaleMode : toLocaleMode,
			getBrowserLocale: getBrowserLocale,
			localizedDayAndMonthFormat: localizedDayAndMonthFormat
		};

	})();
	
})();