(function () {

	// Date stuff

	guf.date = (function () {
		var dateLib = moment;
		dateLib.tz.setDefault("GMT");

		/**
		 * Returns an UTC date range ISO8601 compliant
		 * Result example: {start: "2019-04-01T04:00:00Z", end: "2019-05-01T04:00:00Z"}
		 * @param {string} range
		 * @param {string / number} utcOffset: accepts "local" to use the browser timezone offset as well as a number with the desired UTC offset
		 */
		function getUtcDateRange(range, utcOffset) {
			var baseDate, offset, start, end;
			if (utcOffset == "local") offset = dateLib().utcOffset() / 60;
			else if (typeof utcOffset == "number") offset = utcOffset;
			else offset = 0;
			switch (range) {
				case "current_month":
				default:
					baseDate = dateLib().format("YYYY-MM-01");
					start = dateLib(baseDate).utcOffset(offset, true).utc().format();
					end = dateLib(baseDate).add(1, "month").utcOffset(offset, true).utc().format();
					return { "start": start, "end": end };
			}
		}

		dateLib["getUtcDateRange"] = getUtcDateRange;
		dateLib["localTimeZone"] = moment.tz.guess(true);
		return dateLib;
	})();

	guf.one('guf-loaded', function () {
		guf.date.locale(guf.l10n.getBrowserLocale());
	});

})();
