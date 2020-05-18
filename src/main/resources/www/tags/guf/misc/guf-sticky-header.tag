<guf-sticky-header>
	<div ref="sticky">
		<div ref="fixed">
			<yield from="fixed"/>
		</div>
		<div ref="optional">
			<yield from="optional"/>
		</div>
		<div ref="fader" show="{guf.param.booleanExpr(opts,'showFader',true)}">
		</div>
	</div>
	<div ref="spacer">
	</div>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}

		:scope > div[ref="sticky"] {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: block;
		}

		:scope > div[ref="sticky"].sticky {
			position:fixed;
			top:64px;
			z-index:1;
		}

		:scope > div[ref="sticky"].sticky > div[ref="fixed"] {
			padding-top:4px;
			background:@background;
		}

		:scope > div[ref="sticky"].sticky > div[ref="optional"] {
			background:@background;
		}

		:scope > div[ref="sticky"].sticky > div[ref="fader"] {
			background: @backgroundPrefix,1);
			background: -moz-linear-gradient(top, @backgroundPrefix,1) 0%, @backgroundPrefix,0.8) 60%, @backgroundPrefix,0) 100%);
			background: -webkit-gradient(left top, left bottom, color-stop(0%, @backgroundPrefix,1)), color-stop(60%, @backgroundPrefix,0.8)), color-stop(100%, @backgroundPrefix,0)));
			background: -webkit-linear-gradient(top, @backgroundPrefix,1) 0%, @backgroundPrefix,0.8) 60%, @backgroundPrefix,0) 100%);
			background: -o-linear-gradient(top, @backgroundPrefix,1) 0%, @backgroundPrefix,0.8) 60%, @backgroundPrefix,0) 100%);
			background: -ms-linear-gradient(top, @backgroundPrefix,1) 0%, @backgroundPrefix,0.8) 60%, @backgroundPrefix,0) 100%);
			background: linear-gradient(to bottom, @backgroundPrefix,1) 0%, @backgroundPrefix,0.8) 60%, @backgroundPrefix,0) 100%);
			height:20px;
		}

		@media screen and (max-width: 1023px) {
			:scope > div[ref="sticky"].sticky {
				top:56px;
			}
		}

		@media screen and (min-width: 1600px) {
			guf-canvas > .mdl-layout__container.cardWhenBig :scope > div[ref="sticky"].sticky {
				top:80px;
			}
		}

		:scope > div[ref="sticky"] > * {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}

		:scope > div[ref="spacer"] {
			display:none;
		}

		:scope > div[ref="spacer"].sticky {
			display: block;
		}
	</style>
	<script>
		var tag = this;
		//var boundingClientRect = null;
		var offsetLimit = 0;
		var sticky = false;
		var optionalTag = null;
		var leftCorrection = opts.leftCorrection ? parseInt(opts.leftCorrection, 10) : 0;
		tag.stickyWidth = 0;
		tag.stickyHeight = 0;
		tag.bottomOpacity = 1;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": opts.background ? opts.background : "rgb(255,255,255)",
			"backgroundPrefix": opts.backgroundPrefix ? opts.backgroundPrefix : "rgba(255,255,255"
		};
		tag.mixin('mdl', 'after-mount');

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("after-mount", function() {
			tag.init();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.init = function() {
			offsetLimit = tag.root.offsetTop;
			tag.stickyHeight = tag.refs["fixed"].offsetHeight;
		};

		tag.refreshWidth = function() {
			tag.stickyWidth = tag.root.offsetWidth;
		};

		tag.refreshHeight = function() {
			tag.stickyHeight = tag.refs["fixed"].offsetHeight;
			if (sticky) {
				tag.refs["spacer"].style.height = tag.stickyHeight + "px";
			}
		};

		tag.setBottomOpacity = function(opacity) {
			if (opacity != tag.bottomOpacity) {
				tag.bottomOpacity = opacity;
				tag.refs["optional"].style.opacity = opacity;
				tag.refs["fader"].style.opacity = opacity;
			}
		};

		tag.getStickyHeight = function() {
			if (sticky) {
				return tag.refs["sticky"].offsetHeight;
			} else {
				tag.refs["sticky"].classList.add("sticky");
				tag.trigger("enable-optional");
				var result = tag.refs["sticky"].offsetHeight;
				tag.trigger("disable-optional");
				tag.refs["sticky"].classList.remove("sticky");
				return result;
			}
		};

		function initEvents() {
			guf.on("scroll", scrollHandler);
			window.addEventListener("resize", resizeHandler);
			tag.root.addEventListener("wheel", wheelHandler);
		}

		function removeEvents() {
			guf.off("scroll", scrollHandler);
			window.removeEventListener("resize", resizeHandler);
			tag.root.removeEventListener("wheel", wheelHandler);
		}

		function scrollHandler(column, scrollTop, scrollLeft, e) {
			if (scrollTop > offsetLimit && !sticky) {
				sticky = true;
				tag.refs["sticky"].classList.add("sticky");
				tag.refs["sticky"].style.width = tag.stickyWidth + "px";
				tag.refs["spacer"].classList.add("sticky");
				tag.refs["spacer"].style.height = tag.stickyHeight + "px";
			} else if (scrollTop <= offsetLimit && sticky) {
				sticky = false;
				tag.refs["sticky"].classList.remove("sticky");
				tag.refs["sticky"].style.width = "";
				tag.refs["spacer"].classList.remove("sticky");
				tag.refs["spacer"].style.height =  "";
			}
			if (scrollLeft > 0) {
				tag.refs["sticky"].style.left = (leftCorrection - scrollLeft) + "px";
			} else {
				tag.refs["sticky"].style.left = "";
			}
		}

		function resizeHandler(e) {
			tag.refreshWidth();
			if (sticky) {
				tag.refs["sticky"].style.width = tag.stickyWidth + "px";
			}
		}

		function wheelHandler(evt) {
			var delta = evt.deltaY;
			switch (evt.deltaMode) {
				case 1: // DOM_DELTA_LINE
					delta *= 33;
					break;
				case 2: // DOM_DELTA_PAGE
					delta *= 800;
					break;
			}
			tag.trigger("scroll-delta", delta);
		}

	</script>
</guf-sticky-header>