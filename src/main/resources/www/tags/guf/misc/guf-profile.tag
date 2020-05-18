<guf-profile>
	<guf-button menuid="{buttonid}" class="profile_button" type="flat" ripple="true">
		<guf-avatar letter="{ parent.getLetter() }" imagesrc="{ parent.imagesrc }" type="circle" size="24" class="{hidden: !parent.hasAvatar}"></guf-avatar>
		<span class="{profile_name:1, mdl-layout--large-screen-only:!nameWhenSmall}">{ parent.getName() }</span>
		<i class="{material-icons:1, hidden: !parent.largeLayout}">keyboard_arrow_down</i>
		<i class="{material-icons:1, hidden: parent.largeLayout}">more_vert</i>
	</guf-button>
	<yield/>
	<style scoped type="dcss">
		:scope {
			position: relative;
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
		}

		:scope .profile_button > * {
			display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			align-items: center;
		}

		:scope .profile_button guf-avatar {
			margin-right:5px;
		}

		.guf-screen-narrow :scope .profile_button > button {
			min-width: 0px;
			padding: 0px 6px;
		}

		:scope .profile_name {
			margin: 0px;
			white-space: nowrap;
    		text-overflow: ellipsis;
    		overflow: hidden;
    		max-width: 250px;
    		line-height:24px
		}

		:scope .dark-button-color .profile_name,
		:scope .dark-button-color .material-icons {
			color: @darkButtonColor;
		}

		:scope .light-button-color .profile_name,
		:scope .light-button-color .material-icons {
			color: @lightButtonColor;
		}

	</style>
	<script type="text/javascript">
		var tag = this;

		tag.buttonid = guf.param.string(opts.buttonid, guf.getAutoId());
		tag.imagesrc = guf.param.string(opts.imagesrc, false);
		tag.user = guf.param.string(opts.user, "");
		tag.hasAvatar = guf.param.boolean(opts.hasavatar, true);
		tag.nameWhenSmall = guf.param.booleanExpr(opts, "nameWhenSmall", true);
		tag.largeLayout = document.body.clientWidth > 1023 || tag.hasAvatar;
		tag.mdlClasses = {
			"theme": {
				"dark": {
					"root": ["dark-button-color"]
				},
				"light": {
					"root": ["light-button-color"]
				}
			}
		};
		tag.defaultDcss = {
			"darkButtonColor": "white",
			"lightButtonColor": "rgba(0, 0, 0, 0.87);"
		};
		tag.mixin("mdl");
		tag.mixin("after-mount");

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("after-mount", function() {
			upgrade(tag.root);
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		function initEvents() {
			window.addEventListener('resize', checkLayout);
		}

		function removeEvents() {
			window.removeEventListener('resize', checkLayout);
		}

		function checkLayout() {
			tag.largeLayout = document.body.clientWidth > 1023 || tag.hasAvatar;
			tag.update();
		}

		function upgrade(element) {
			for (var i=0; i<element.childNodes.length; i++) {
				var node = element.childNodes[i];
				upgrade(node);
			}
			if (element.childNodes.length!=0) {
				componentHandler.upgradeElement(element);
			}
		}

		tag.getName = function() {
			return tag.user;
		}

		tag.getLetter = function() {
			return tag.user.substring(0, 1).toUpperCase();
		}

		tag.on("update", function() {
			tag.buttonid = guf.param.string(opts.buttonid, guf.getAutoId());
			tag.imagesrc = guf.param.string(opts.imagesrc, false);
			tag.user = guf.param.string(opts.user, "");
			tag.hasAvatar = guf.param.boolean(opts.hasavatar, true);
			tag.nameWhenSmall = guf.param.booleanExpr(opts, "nameWhenSmall", true);

			if (tag.imagesrc !== false) {
				tag.tags["guf-button"].tags["guf-avatar"].setImage(tag.imagesrc);
			} else {
				tag.tags["guf-button"].tags["guf-avatar"].setLetter(tag.getLetter());
			}
		});

	</script>
</guf-profile>