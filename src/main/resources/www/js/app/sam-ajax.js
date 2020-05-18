(function () {

	app.ajax = (function () {

		var refreshTokenUrl = null;
		var refreshToken = null;
		var refreshing = false;
		var pendingForRefresh = [];
		var _timeout = 30000;

		function setTimeout(timeout) {
			_timeout = timeout;
		}

		function successCallbackHandler(url, method, headers, data, successCallback, errorCallback, tag, timeout, forRefresh) {
			return function (response, xhrObject) {
				var res = response;
				try {
					res = JSON.parse(response);
				} catch (e) {
				}
				if (res.hasOwnProperty("status") && res.hasOwnProperty("statusCode")) {
					if (res.statusCode == 200) {
						if (!tag || tag.isMounted) {
							if (res.hasOwnProperty("data")) {
								if (res.data.hasOwnProperty("results")) {
									successCallback(res.data.results, xhrObject);
								} else {
									successCallback(res.data, xhrObject);
								}
							} else {
								successCallback({}, xhrObject);
							}
						}
					} else {
						if (!tag || tag.isMounted) {
							errorCallback(res, xhrObject);
						}
					}
				} else {
					if (!tag || tag.isMounted) {
						successCallback(res, xhrObject);
					}
				}
			}
		}

		function errorCallbackHandler(callback, tag) {
			return function (errorMessage, xhrObject) {
				var stMsg = xhrObject.statusText;
				if (errorMessage == 'abort') stMsg = 'Call aborted';
				if (errorMessage == 'timeout') stMsg = 'Call timeout';
				if (errorMessage == 'requestError') stMsg = 'Request error';
				if (!tag || tag.isMounted) {
					callback(
						{
							"success": false,
							"status": errorMessage,
							"statusCode": xhrObject.status,
							"message": stMsg,
							"data": null
						},
						xhrObject
					);
				}
				if (errorMessage == "httpError" && xhrObject.status == 401) {
					app.trigger("session-expired");
				}
			}
		}

		function addHeaders(additionalHeaders) {
			var result = {};
			for (prop in guf.ajax.getDefaultHeaders()) {
				result[prop] = guf.ajax.getDefaultHeaders()[prop];
			}
			if (additionalHeaders) {
				for (prop in additionalHeaders) {
					result[prop] = additionalHeaders[prop];
				}
			}
			return result;
		}

		function send(url, method, headers, data, successCallback, errorCallback, tag, timeout, forRefresh) {
			return guf.ajax.send(app.getBaseUrl() + url, method, headers, data, successCallbackHandler(url, method, headers, data, successCallback, errorCallback, tag, timeout, forRefresh), errorCallbackHandler(errorCallback, tag), timeout);
		}

		function get(url, data, successCallback, errorCallback, additionalHeaders, tag) {
			return send(url, "GET", addHeaders(additionalHeaders), data, successCallback, errorCallback, tag, _timeout);
		}

		function post(url, data, successCallback, errorCallback, additionalHeaders, tag, timeout) {
			return send(url, "POST", addHeaders(additionalHeaders), data, successCallback, errorCallback, tag, typeof timeout === "undefined" ? _timeout : timeout);
		}

		function put(url, data, successCallback, errorCallback, additionalHeaders, tag) {
			return send(url, "PUT", addHeaders(additionalHeaders), data, successCallback, errorCallback, tag, _timeout);
		}

		function _delete(url, data, successCallback, errorCallback, additionalHeaders, tag) {
			return send(url, "DELETE", addHeaders(additionalHeaders), data, successCallback, errorCallback, tag, _timeout);
		}

		return {
			send: send,
			get: get,
			post: post,
			put: put,
			delete: _delete,
			activateCaching: guf.ajax.activateCaching,
			deactivateCaching: guf.ajax.deactivateCaching,
			setAuthentication: guf.ajax.setAuthentication,
			removeAuthentication: guf.ajax.removeAuthentication,
			setUsername: guf.ajax.setUsername,
			setPassword: guf.ajax.setPassword,
			setTimeout: setTimeout,
			cancel: guf.ajax.cancel,
			setContentType: guf.ajax.setContentType,
			setWithCredentials: guf.ajax.setWithCredentials
		}

	})();

	riot.observable(app.ajax);
	
})();