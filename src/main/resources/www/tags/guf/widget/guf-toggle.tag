<guf-toggle>
	<div if="{type=='icon'}" ref="icon" class="{wrapper:1, icon: 1, unchecked:!checked, checked:checked}">
		<i class="noselect material-icons {opts.size}">{content}</i>
	</div>
	<div if="{type=='text'}" ref="text" class="{wrapper:1, text: 1, unchecked:!checked, checked:checked}">
		<yield/>
	</div>
	<style scoped type="dcss">
		:scope .material-icons.md-18 {font-size: 18px;}
		:scope .material-icons.md-24 {font-size: 24px;}
		:scope .material-icons.md-36 {font-size: 36px;}
		:scope .material-icons.md-48 {font-size: 48px;}

		:scope {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
		    -webkit-box-pack: center;
		    -webkit-justify-content: center;
		    -ms-flex-pack: center;
			justify-content: center;
		}

		:scope .wrapper {
		    display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
			display: flex;
			align-items: center;
		    -webkit-box-pack: center;
		    -webkit-justify-content: center;
		    -ms-flex-pack: center;
			justify-content: center;
		}

		:scope .icon.wrapper {
			border-radius: 50%;
        }

        :scope .icon.checked {
			border: none;
			background-color: @background;
			width: 48px;
			height: 48px;
		}

		:scope .icon.unchecked {
			border: 2px solid @background;
			background-color: transparent;
			width: 44px;
			height: 44px;
		}

		:scope .text.wrapper {
			font-weight: 600;
    		font-size: 14px;
			margin: 2px 4px;
			text-transform: uppercase;
			cursor: pointer;
        }
        :scope .text.checked {
        	color: @selectedColor;
        }
		:scope .text.unchecked {
        	color: @unselectedColor;
        }		

		.noselect {
			-webkit-touch-callout: none; /* iOS Safari */
			-webkit-user-select: none; /* Chrome/Safari/Opera */
			-khtml-user-select: none; /* Konqueror */
			-moz-user-select: none; /* Firefox */
			-ms-user-select: none; /* Internet Explorer/Edge */
			user-select: none; /* Non-prefixed version, currently
			                      not supported by any browser */
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		
		tag.type = guf.param.string(opts.type, 'icon');
		
		var unchecked = opts.unchecked || "";
		var checked = opts.checked || "check";
		tag.checked = false;
		
		if (tag.type=='icon') {
			tag.content = unchecked;
		} else {
			tag.content = opts.content;
		}
		
		tag.defaultDcss = {
			"background": "@accent",
			"unselectedColor": "#cccccc",
			"selectedColor": "@primary"
		};
		tag.mixin("mdl");
		tag.on("mount", function() {
			if (tag.type === 'icon') {
				tag.refs["icon"].addEventListener("click", toggleHandler);
			} else {
				tag.refs["text"].addEventListener("click", toggleHandler);
			}
		});
		
		tag.isChecked = function() {
			return tag.checked;
		};
		
		tag.toggle = function() {
			if(tag.checked) {
				tag.content = unchecked;
				tag.checked = false;
			} else {
				tag.content = checked;
				tag.checked = true;
			}
			tag.trigger("checkbox-clicked", tag);
			tag.update();
		};
		
		function toggleHandler(event) {
			event.stopPropagation();
			if (tag.type == 'icon') {
				if(tag.refs["icon"].contains(event.target)) {
					guf.setTimeout(tag.toggle, 0);
				}
			} else {
				if(tag.refs["text"].contains(event.target)) {
					guf.setTimeout(tag.toggle, 0);
				}
			}
		}
	</script>
</guf-toggle>