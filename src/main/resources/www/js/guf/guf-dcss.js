(function(){

	// DCSS stuff
	
	var scopedRegExp = /@scoped\s*=\s*no/gi;
	guf.dcss = {};
	guf.dcss.tags = {};
	riot.parsers.css.dcss = function(tag,css,parserOpts,url) {
		try {
			guf.dcss.tags[tag] = {
				unparsed: css,
				parsed: {},
				last: 0
			};
		} catch (e) {
			guf.console.error(e);
		}
		return '';
	};
	guf.dcss.theme = {
		primary: '#5d709c',
		primaryDark: '#3b507a',
		accent: '#bf9000',
		disabled: 'rgba(0,0,0,0.26)',
		textDefault: '#000',
		textPrimary: '#fff',
		textAccent: '#fff'
	};
	guf.dcss.overrideTheme = function(theme) {
		for (var prop in theme) {
			guf.dcss.theme[prop] = theme[prop];
		}
	};
	guf.dcss.parse = function(css, params) {
		var result = css;
		for (var param in params) {
			result = result.replace(new RegExp('@' + param + '\\b', 'g'), params[param]);
		}
		return result;
	};
	guf.dcss.styleManager = (function() {
		var createStyleNode = function (previousNode) {
			// create a new style element with the correct type
			var newNode = document.createElement('style');
			newNode.setAttribute('type', 'text/css');
			if (typeof previousNode != 'undefined') {
				document.getElementsByTagName('head')[0].insertBefore(newNode, previousNode);
			} else {
				document.getElementsByTagName('head')[0].appendChild(newNode);
			}
			return newNode;
		};
		var styleNode = createStyleNode();

		// Create cache and shortcut to the correct property
		var cssTextProp = styleNode.styleSheet,
			stylesToInject = '';

		// Expose the style node in a non-modificable property
		guf.dcss.styleNode = styleNode;
	
		// Define inside so we can access all the private stuff
		guf.dcss.changeTheme = function(newTheme) {
			guf.dcss.theme = newTheme;
			var previousStyleNode = styleNode;
			var previousCssTextProp = cssTextProp,
				previousStylesToInject = stylesToInject;
			styleNode = createStyleNode(previousStyleNode);
			cssTextProp = styleNode.styleSheet,
			stylesToInject = '';
			for (var tagName in guf.dcss.tags) {
				// Adjust defaults
				var currentTagDcss = guf.dcss.tags[tagName];
				dcssMapDefaults(currentTagDcss);
				for (var dcssId in currentTagDcss.parsed) {
					var dcssOverride = JSON.parse(dcssId);
					dcssCalculateCss(currentTagDcss, tagName, dcssId, dcssOverride, true);
				}
			}
			document.getElementsByTagName('head')[0].removeChild(previousStyleNode);
		};

		return {
			add: function(css) {
				stylesToInject += css
			},
			inject: function() {
				if (stylesToInject) {
					if (cssTextProp) {
						cssTextProp.cssText += stylesToInject;
					} else {
						styleNode.innerHTML += stylesToInject;
					}
					stylesToInject = '';
				}
			}
		};
	})();

	guf.getDcssOverride = function(tag) {
		var ret = {};
		for (var param in tag.opts) {
			if (param.indexOf('dcss') == 0) {
				var name = param.substring(4,5).toLowerCase() + param.substring(5);
				ret[name] = tag.opts[param];
			}
		}
		return ret;
	};

	guf.dcss.getRiotTagName = function(tag) {
		var dom = tag.root;
		var result = dom.tagName.toLowerCase();
		if (dom.getAttribute("data-is")) {
			result = dom.getAttribute("data-is");
		} else if (dom.getAttribute("riot-tag")) {
			result = dom.getAttribute("riot-tag");
		}
		return result;
	}
	
	function dcssMapDefaults(tagDcss) {
		if (tagDcss.defaultDcssMapping) {
			for (var prop in tagDcss.defaultDcssMapping) {
				tagDcss.defaultDcssMapped[prop] = guf.dcss.parse(tagDcss.defaultDcssMapping[prop], guf.dcss.theme);
			}
		}
	}
	
	function dcssCalculateCss(tagDcss, tagName, dcssId, dcssOverride, update) {
		if (update || !tagDcss.parsed[dcssId]) {
			var isOverriding = dcssId !== '{}';
			var parsedDcssOverride = JSON.parse(guf.dcss.parse(JSON.stringify(dcssOverride), guf.dcss.theme));
			var dcssObject = guf.extend(tagDcss.defaultDcssMapped, parsedDcssOverride);
			// Current style combination is not registered
			// Replace DCSS variables with given values
			var parsedCss = guf.dcss.parse(tagDcss.unparsed, dcssObject);
			// Assign a custom tag name
			var customTagName = tagName;
			if (update) {
				customTagName = tagDcss.parsed[dcssId].tagName;
			} else if (isOverriding) {
				customTagName = tagName + tagDcss.last;
				tagDcss.last++;
			}
			// Check for scoped directive
			var scoped = true;
			if (scopedRegExp.test(parsedCss)) {
				scoped = false;
				parsedCss = parsedCss.replace(scopedRegExp, "");
			}
			// Compile CSS with Riot so it is properly scoped
			var compiledCss = riot.compiler.compileCSS(parsedCss, scoped ? {tagName: customTagName} : {});
			if (isOverriding) {
				// Current style is not the default one, so use a HTML attribute for selecting it
				var tempTagName = '_________guf';
				compiledCss = compiledCss.replace(new RegExp('\\[riot-tag\\=\\"' + customTagName + '\\"\\]', 'g'), '[riot-tag="' + tagName + '"][dcssVar="' + tempTagName + '"]');
				compiledCss = compiledCss.replace(new RegExp('\\[data-is\\=\\"' + customTagName + '\\"\\]', 'g'), '[data-is="' + tagName + '"][dcssVar="' + tempTagName + '"]');
				compiledCss = compiledCss.replace(new RegExp(customTagName, 'g'), tagName + '[dcssVar="' + tempTagName + '"]');
				compiledCss = compiledCss.replace(new RegExp(tempTagName, 'g'), customTagName);
			}
			// Save results into global structure
			if (!update) {
				tagDcss.parsed[dcssId] = {};
				tagDcss.parsed[dcssId].tagName = customTagName;
			}
			tagDcss.parsed[dcssId].css = compiledCss;
			// Add CSS into HTML
			guf.dcss.styleManager.add(compiledCss);
			guf.dcss.styleManager.inject();
		}
	}
	
	// Mixins

	riot.mixin('mdl', {
		init: function(opts) {

			var self = this;

			function _dcssUpdate() {
				// Get DOM nodes
				var riotTag = self.root;
				var mdlDomTag = self.root.childNodes[0];
				var tagName = guf.dcss.getRiotTagName(self);
				// Apply Dynamic-CSS stylesheet
				var currentTagDcss = guf.dcss.tags[tagName];
				if (typeof(currentTagDcss.defaultDcssMapped) !== "object") {
					// Calculate current tag DCSS default values based on theme
					currentTagDcss.defaultDcssMapped = {};
					currentTagDcss.defaultDcssMapping = self.defaultDcss;
					dcssMapDefaults(currentTagDcss);
				}
				// Add DCSS override from tag instantiation
				var dcssOverride = guf.getDcssOverride(self);
				var dcssId = JSON.stringify(dcssOverride);
				var isOverriding = dcssId !== '{}';				
				dcssCalculateCss(currentTagDcss, tagName, dcssId, dcssOverride, false);
				if (isOverriding) {
					// Assign the HTML attribute for selecting CSS style
					riotTag.setAttribute('dcssVar', currentTagDcss.parsed[dcssId].tagName)
				}
				// Upgrade MDL behaviour
				try{
					componentHandler.upgradeElement(self.root.childNodes[0]);
				} catch (e) {}
			};

			self.on('mount', function() {
				// Get DOM nodes
				var riotTag = self.root;
				var mdlDomTag = self.root.childNodes[0];
				var tagName = guf.dcss.getRiotTagName(self);
				// Additional CSS classes
				if (self.mdlClasses) {
					for (var param in self.mdlClasses) {
						if (self.opts[param]) {
							var definition = self.mdlClasses[param];
							for (var value in definition) {
								if (self.opts[param] == value) {
									var valueDefinition = definition[value];
									for (var elementName in valueDefinition) {
										var elm = mdlDomTag;
										if (elementName != 'root') {
											elm = self[elementName];
										}
										for (var i = 0; i < valueDefinition[elementName].length; i++) {
											elm.classList.add(valueDefinition[elementName][i]);
										}
									}
								}
							}
						}
					}
				}
				// Apply Dynamic-CSS stylesheet
				_dcssUpdate();
			});

			self.on('unmount', function() {
				self = null;
			});

			self.dcssUpdate = function() {
				self.one('updated', _dcssUpdate);
				self.update();
			};
		}
	});

})();