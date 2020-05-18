/**
 * GUF Screen Support
 * 
 * Aims to support modern edge-to-edge screens and other specific screen requirements
 *
 * Dependencies:
 *	- cordova-plugin-device
 *	- guf-screen-support.css
 *	- guf-keyboard.js (adds KEYBOARD_VISIBLE_CSS_CLASS)
 */
(function () {

	guf.screenSupport = (function () {

		var IPHONE_X_CSS_CLASS = "guf-device-iphonex",
			IPAD_PRO_3_CSS_CLASS = "guf-device-ipadpro3";

		var iphoneXModelStrings = ["iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8"],
			ipadProThirdGenModelStrings = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"];
			/* Helpful list of Apple's mobile device code types: https://gist.github.com/adamawolf/3048717 */

		var iosSafeMargins = {
			"iphone": {
				"default": {
					"portrait": {
						"top": "20px",
						"right": "0px",
						"bottom": "0px",
						"left": "0px"
					},
					"landscape": {
						"top": "0px",
						"right": "0px",
						"bottom": "0px",
						"left": "0px"
					}
				},
				"x": {
					"portrait": {
						"top": "44px",
						"right": "0px",
						"bottom": "34px",
						"left": "0px"
					},
					"landscape": {
						"top": "0px",
						"right": "44px",
						"bottom": "21px",
						"left": "44px"
					}
				}
			},
			"ipad": {
				"default": {
					"portrait": {
						"top": "20px",
						"right": "0px",
						"bottom": "0px",
						"left": "0px"
					},
					"landscape": {
						"top": "20px",
						"right": "0px",
						"bottom": "0px",
						"left": "0px"
					}
				},
				"pro3": {
					"portrait": {
						"top": "24px",
						"right": "0px",
						"bottom": "20px",
						"left": "0px"
					},
					"landscape": {
						"top": "24px",
						"right": "0px",
						"bottom": "20px",
						"left": "0px"
					}
				}
			}
		};

		function isIphoneX() {
			if (guf.isDefined("device")) {
				var modelString = device.model;
				return iphoneXModelStrings.indexOf(modelString) != -1;
			} else {
				throw "Cordova plugin cordova-plugin-device is required. Please add it to the project in order to use guf";
			}
		}

		function isIpadProThirdGen() {
			if (guf.isDefined("device")) {
				var modelString = device.model;
				return ipadProThirdGenModelStrings.indexOf(modelString) != -1;
			} else {
				throw "Cordova plugin cordova-plugin-device is required. Please add it to the project in order to use guf";
			}
		}

		return {
			IPHONE_X_CSS_CLASS: IPHONE_X_CSS_CLASS,
			IPAD_PRO_3_CSS_CLASS: IPAD_PRO_3_CSS_CLASS,
			iphoneXModelStrings: iphoneXModelStrings,
			ipadProThirdGenModelStrings: ipadProThirdGenModelStrings,
			isIphoneX: isIphoneX,
			isIpadProThirdGen: isIpadProThirdGen,
			iosSafeMargins: iosSafeMargins
		};

	})();

	guf.one("deviceready", function () {
		if (guf.isDefined("device")) {

			var dcss = {};
			dcss["_safeAreaTopPortrait"] = "0px";
			dcss["_safeAreaRightPortrait"] = "0px";
			dcss["_safeAreaBottomPortrait"] = "0px";
			dcss["_safeAreaLeftPortrait"] = "0px";
			dcss["_safeAreaTopLandscape"] = "0px";
			dcss["_safeAreaRightLandscape"] = "0px";
			dcss["_safeAreaBottomLandscape"] = "0px";
			dcss["_safeAreaLeftLandscape"] = "0px";

			if (guf.device.isIos) {
				var type = guf.device.isTablet ? "ipad" : "iphone";
				var model = "default";
				if (guf.screenSupport.isIphoneX()) {
					model = "x";
					document.body.classList.add(guf.screenSupport.IPHONE_X_CSS_CLASS);
				} else if (guf.screenSupport.isIpadProThirdGen()) {
					model = "pro3";
					document.body.classList.add(guf.screenSupport.IPAD_PRO_3_CSS_CLASS);
				}
				dcss["_safeAreaTopPortrait"] = guf.screenSupport.iosSafeMargins[type][model]["portrait"]["top"];
				dcss["_safeAreaRightPortrait"] = guf.screenSupport.iosSafeMargins[type][model]["portrait"]["right"];
				dcss["_safeAreaBottomPortrait"] = guf.screenSupport.iosSafeMargins[type][model]["portrait"]["bottom"];
				dcss["_safeAreaLeftPortrait"] = guf.screenSupport.iosSafeMargins[type][model]["portrait"]["left"];
				dcss["_safeAreaTopLandscape"] = guf.screenSupport.iosSafeMargins[type][model]["landscape"]["top"];
				dcss["_safeAreaRightLandscape"] = guf.screenSupport.iosSafeMargins[type][model]["landscape"]["right"];
				dcss["_safeAreaBottomLandscape"] = guf.screenSupport.iosSafeMargins[type][model]["landscape"]["bottom"];
				dcss["_safeAreaLeftLandscape"] = guf.screenSupport.iosSafeMargins[type][model]["landscape"]["left"];
			}

			guf.dcss.overrideTheme(dcss);

		} else {
			throw "Cordova plugin cordova-plugin-device is required. Please add it to the project in order to use guf";
		}
	});

})();
