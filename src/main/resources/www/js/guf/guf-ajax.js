(function () {

	// AJAX stuff

	guf.ajax = (function () {

		var cache = false;
		var gufTimeout = 10000;
		var globalRequestId = 1;
		var requests = {};
		var connected = true;
		var _contentType = 'application/json';
		var _withCredentials = false;
		var defaultHeaders = {
			'Content-Type': _contentType
		}

		function initXHRHeaders(xhrObject, headers) {
			for (var header in headers) {
				xhrObject.setRequestHeader(header, headers[header]);
			}
		}

		function bindXHREvents(requestId, xhrObject, successCallback, errorCallback, pendingRetries) {
			xhrObject.onabort = function () {
				delete requests[requestId];
				errorCallback('abort', xhrObject);
			}
			xhrObject.ontimeout = function () {
				if (pendingRetries) {
					retrySend(requestId);
				} else {
					delete requests[requestId];
					errorCallback('timeout', xhrObject);
					if (connected) {
						connected = false;
						guf.trigger("disconnected");
					}
				}
			}
			xhrObject.onerror = function () {
				if (pendingRetries) {
					retrySend(requestId);
				} else {
					delete requests[requestId];
					errorCallback('requestError', xhrObject);
					if (connected) {
						connected = false;
						guf.trigger("disconnected");
					}
				}
			}
			xhrObject.onload = function () {
				delete requests[requestId];
				if (xhrObject.status >= 200 && xhrObject.status <= 204) {
					successCallback(xhrObject.response, xhrObject);
				} else {
					errorCallback('httpError', xhrObject);
				}
				if (!connected) {
					connected = true;
					guf.trigger("connected");
				}
			}
		}

		function setAuthentication(type, content) {
			defaultHeaders['Authorization'] = type + " " + content;
		}

		function removeAuthentication() {
			delete defaultHeaders['Authorization'];
		}

		function parametrize(object) {
		    var encodedString = '';
		    for (var prop in object) {
		        if (object.hasOwnProperty(prop)) {
		            if (encodedString.length > 0) {
		                encodedString += '&';
		            }
		            encodedString += encodeURIComponent(prop) + '=' + encodeURIComponent(object[prop]);
		        }
		    }
		    if (encodedString != '') {
		    	encodedString = '?' + encodedString;
		    }
		    return encodedString;
		}

		function oneTimeSend(requestId, url, method, headers, data, successCallback, errorCallback, timeout, pendingRetries) {
			var cmd = null;
			if (!!data && !!data.cmd) {
				cmd = data.cmd;
				delete data.cmd;
			}
			
			var xhr = new XMLHttpRequest();
			requests[requestId] = {
				xhr: xhr,
				url: url,
				method: method,
				headers: headers,
				data: data,
				cmd: cmd,
				successCallback: successCallback,
				errorCallback: errorCallback,
				timeout: timeout,
				pendingRetries: pendingRetries
			};
			var multipart = false;
			if (data && data.fileUpload) {
				multipart = true;
			}
			
			var isGet = method.toLowerCase() == 'get';
			var isDelete = method.toLowerCase() == 'delete';
			if (isGet || isDelete) {
				url = url + (guf.utils.isEmptyObject(data) ? '' : parametrize(data)) + (cache ? '' : (guf.utils.isEmptyObject(data) ? '?' : '&') + '_=' + (new Date()).getTime());
			}
			xhr.open(method, url);
			if (_withCredentials) {
				xhr.withCredentials = true;
			}
			if (multipart) {
				xhr.timeout = null;
				if(!data.auth) {
					headers = [];
					headers['Content-Type'] = data.content_type;
				} else {
					delete headers['Content-Type'];
				}
				// headers['Content-Disposition'] = "form-data";
				data = data.body;
				xhr.upload.addEventListener("progress", function(e) {
					var pc = parseInt((e.loaded / e.total * 100));
				}, false);
			} else if (timeout !== undefined && timeout>=0) {
				xhr.timeout = timeout;
			} else {
				xhr.timeout = gufTimeout;
			}
			initXHRHeaders(xhr, headers);
			bindXHREvents(requestId, xhr, successCallback, errorCallback, pendingRetries);

			if (isGet) {
				xhr.send();
			} else {
				if (multipart) {
					xhr.send(data);
				} else if (guf.utils.isEmptyObject(data)) {
					data = {};
					xhr.send(JSON.stringify(data));
				} else {
					switch (headers["Content-Type"]) {
						case "application/json":
							xhr.send(JSON.stringify(data));
							break;
						case "application/x-www-form-urlencoded":
							xhr.send(guf.utils.isEmptyObject(data) ? '' : parametrize(data).substring(1));
							break;
					}
				}
			}
			return requestId;
		}

		function send(url, method, headers, data, successCallback, errorCallback, timeout) {
			var requestId = globalRequestId++;
			return oneTimeSend(requestId, url, method, headers, data, successCallback, errorCallback, timeout, 2);
		}

		function retrySend(requestId) {
			var request = requests[requestId];
			delete requests[requestId];
			oneTimeSend(requestId, request.url, request.method, request.headers, request.data, request.successCallback, request.errorCallback, request.timeout * 2, request.pendingRetries - 1);
		}

		function httpGet(url, data, successCallback, errorCallback, timeout) {
			return send(url, 'GET', defaultHeaders, data, successCallback, errorCallback, timeout);
		}

		function httpPost(url, data, successCallback, errorCallback, timeout) {
			return send(url, 'POST', defaultHeaders, data, successCallback, errorCallback, timeout);
		}

		function httpPut(url, data, successCallback, errorCallback, timeout) {
			return send(url, 'PUT', defaultHeaders, data, successCallback, errorCallback, timeout);
		}

		function httpDelete(url, successCallback, errorCallback, timeout) {
			return send(url, 'DELETE', defaultHeaders, null, successCallback, errorCallback, timeout);
		}

		function activateCaching() {
			cache = true;
		}

		function deactivateCaching() {
			cache = false;
		}

		function cancel(requestId) {
			if (requests[requestId]) {
				var xhr = requests[requestId].xhr;
				delete requests[requestId];
				xhr.abort();
			}
		}

		function getXhrObject(requestId) {
			return (requests[requestId])?requests[requestId].xhr:null;
		}

		function getDefaultHeaders() {
			return guf.utils.cloneObject(defaultHeaders);
		}

		function setContentType(contentType) {
			_contentType = contentType;
			defaultHeaders["Content-Type"] = _contentType;
		}

		function setWithCredentials(withCredentials) {
			_withCredentials = withCredentials;
		}

		return {
			send: send,
			get: httpGet,
			post: httpPost,
			put: httpPut,
			delete: httpDelete,
			activateCaching: activateCaching,
			deactivateCaching: deactivateCaching,
			setAuthentication: setAuthentication,
			removeAuthentication: removeAuthentication,
			cancel: cancel,
			getDefaultHeaders: getDefaultHeaders,
			getXhr: getXhrObject,
			parametrize: parametrize,
			setContentType: setContentType,
			setWithCredentials: setWithCredentials
		}

	})();
	riot.observable(guf.ajax);
	
})();