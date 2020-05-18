<guf-list-item class="padding-{padding} {ripple-effect: ripple===true}">
	<yield />
	<style scoped type="dcss">
		
		:scope.padding-0 {
			padding: 0px 16px;
		}

		:scope.padding-8 {
			padding: 8px 16px;
		}

		:scope:hover {
			background-color: @backgroundHover;
		}

		:scope.selected {
            background: @backgroundSelected;
        }

		:scope.mdl-list__item {
			color: @textColor;
		}

		:scope.mdl-list__item.selected {
			color: @textColorSelected;
		}

		/* Ripple effect */
		@-webkit-keyframes ripple {
		  0% {
		    background-size: 1% 1%;
		    opacity: 0.5;
		  }
		  70% {
		    background-size: 1000% 1000%;
		    opacity: 0.2;
		  }
		  100% {
		    opacity: 0;
		    background-size: 1000% 1000%;
		  }
		}

		@keyframes ripple {
		  0% {
		    background-size: 1% 1%;
		    opacity: 0.5;
		  }
		  70% {
		    background-size: 1000% 1000%;
		    opacity: 0.2;
		  }
		  100% {
		    opacity: 0;
		    background-size: 1000% 1000%;
		  }
		}

		:scope.ripple-effect {
		  	position: relative;
		  	overflow: hidden;
		}

		/* Material style */
		:scope.ripple-effect:active:after{
			position: absolute;
			content: " ";
			height: 100%;
			width: 100%;
			top: 0;
			left: 0;
			pointer-events: none;
			background-image: radial-gradient(circle at center, @rippleColor 0%, @rippleColor 10%, transparent 10.1%, transparent 100%);
			background-position: center center;
			background-repeat: no-repeat;
			background-color: transparent;
			-webkit-animation: ripple 0.3s 0s normal forwards running ease-in;
			animation: ripple 0.3s 0s normal forwards running ease-in;
		}
		  

	</style>
	<script type="text/javascript">
		var tag = this;
		tag.padding = guf.param.number(opts.padding, 16);
		tag.ripple = guf.param.boolean(opts.ripple, false);
		
		tag.defaultDcss = {
			"backgroundSelected": "@accent",
			"textColor": "@textDefault",
			"textColorSelected": "@textAccent",
			"backgroundHover": "none",
			"background": "transparent",
			"rippleColor": "#888"
		};
		tag.mixin('mdl');
		
		tag.on('mount', function() {
			tag.root.classList.add("mdl-list__item");
			tag.root.addEventListener("click", function() {
				tag.trigger("item-clicked", tag);
			});
		});
		
		tag.select = function() {
			tag.root.classList.add('selected');
		};
		
		tag.deselect = function() {
			tag.root.classList.remove('selected');
		};
		
		tag.toggleSelection = function() {
			tag.root.classList.toggle('selected');
		};
		
		tag.isSelected = function() {
			return tag.root.classList.contains('selected');
		}
	</script>
</guf-list-item>