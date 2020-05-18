<guf-floating-action-button>
	<div id="{containerId}" class="mdl-button--fab_flinger-container">
	    
	    <button id="{autoId}" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	      	<i class="material-icons">{opts.icon}</i>
	    </button>
	    <div class="mdl-button--fab_flinger-options">
		    <yield/>
	    </div>
  	</div>

  	<style scoped type="dcss">

  		:scope {
  			display: -webkit-box;
		  	display: -webkit-flex;
		  	display: -ms-flexbox;
		  	display: flex;
		  	align-self: flex-end;
		  	height: 0px;
  		}

  		.mdl-button--fab.mdl-button--colored,
		.mdl-button--fab.mdl-button--colored:hover,
		.mdl-button--fab.mdl-button--colored:active,
		.mdl-button--fab.mdl-button--colored:focus:not(:active),
 		.mdl-button--raised.mdl-button--colored,
		.mdl-button--raised.mdl-button--colored:hover,
		.mdl-button--raised.mdl-button--colored:active,
		.mdl-button--raised.mdl-button--colored:focus:not(:active) {
			background-color:@background;
		}

		.mdl-button--colored-accent > .mdl-button--fab,
		.mdl-button--colored-accent > .mdl-button--fab:hover,
		.mdl-button--colored-accent > .mdl-button--fab:active,
		.mdl-button--colored-accent > .mdl-button--fab:focus:not(:active) {
			background-color:@backgroundToggled;
			color: @textColor;
		}

		.mdl-button--fab.mdl-button--colored[disabled],
		.mdl-button--fab.mdl-button--colored[disabled]:hover,
		.mdl-button--fab.mdl-button--colored[disabled]:active,
		.mdl-button--fab.mdl-button--colored[disabled]:focus:not(:active),
		.mdl-button--raised.mdl-button--colored[disabled],
		.mdl-button--raised.mdl-button--colored[disabled]:hover,
		.mdl-button--raised.mdl-button--colored[disabled]:active,
		.mdl-button--raised.mdl-button--colored[disabled]:focus:not(:active),
		.mdl-button--colored-accent > .mdl-button--fab[disabled],
		.mdl-button--colored-accent > .mdl-button--fab[disabled]:hover,
		.mdl-button--colored-accent > .mdl-button--fab[disabled]:active,
		.mdl-button--colored-accent > .mdl-button--fab[disabled]:focus:not(:active){
			background-color:@backgroundDisabled;
		}

  		.mdl-button--fab_flinger-container {
		  	position: relative;
		    bottom: 72px;
		    right: 32px;
		}
		.mdl-button--fab_flinger-container.is-showing-options > guf-button i,
		.mdl-button--fab_flinger-container.is-showing-options > button i {
		  	-webkit-transition: -webkit-transform 0.1s linear;
		    transition: transform 0.1s linear;
		  	-webkit-transform: translate(-12px, -12px) rotate(45deg);
		    -ms-transform: translate(-12px, -12px) rotate(45deg);
		    transform: translate(-12px, -12px) rotate(45deg);
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options {
		  display: -webkit-box;
		  display: -webkit-flex;
		  display: -ms-flexbox;
		  display: flex;
		  -webkit-box-orient: vertical;
		  -webkit-box-direction: reverse;
		  -webkit-flex-direction: column-reverse;
		      -ms-flex-direction: column-reverse;
		          flex-direction: column-reverse;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button {
		  display: block;
		  -webkit-animation-name: enter;
		          animation-name: enter;
		  -webkit-animation-fill-mode: forwards;
		          animation-fill-mode: forwards;
		  -webkit-animation-duration: 0.1s;
		          animation-duration: 0.1s;
		  -webkit-transform-origin: bottom center;
		      -ms-transform-origin: bottom center;
		          transform-origin: bottom center;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(1) {
		  -webkit-animation-delay: 0.1s;
		          animation-delay: 0.1s;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(2) {
		  -webkit-animation-delay: 0.2s;
		          animation-delay: 0.2s;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(3) {
		  -webkit-animation-delay: 0.3s;
		          animation-delay: 0.3s;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(4) {
		  -webkit-animation-delay: 0.4s;
		          animation-delay: 0.4s;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(5) {
		  -webkit-animation-delay: 0.5s;
		          animation-delay: 0.5s;
		}
		.mdl-button--fab_flinger-container.is-showing-options .mdl-button--fab_flinger-options guf-button:nth-of-type(6) {
		  -webkit-animation-delay: 0.6s;
		          animation-delay: 0.6s;
		}
		.mdl-button--fab_flinger-container .mdl-button--fab_flinger-options button {
			background: rgba(255, 255, 255, 1);
			color: rgba(0, 0, 0, 0.87);
			box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.5);
		}
		.mdl-button--fab_flinger-container .mdl-button--fab_flinger-options {
		  position: absolute;
		  bottom: 100%;
		  margin-bottom: 10px;
		}
		.mdl-button--fab_flinger-container .mdl-button--fab_flinger-options guf-button {
		  -webkit-transform: scale(0);
		      -ms-transform: scale(0);
		          transform: scale(0);
		  display: none;
		}
		@-webkit-keyframes enter {
		  from {
		    -webkit-transform: scale(0);
		            transform: scale(0);
		  }
		  to {
		    -webkit-transform: scale(0.8);
		            transform: scale(0.8);
		  }
		}
		@keyframes enter {
		  from {
		    -webkit-transform: scale(0);
		            transform: scale(0);
		  }
		  to {
		    -webkit-transform: scale(0.8);
		            transform: scale(0.8);
		  }
		}
  	</style>

  	<script type="text/javascript">
  		var tag = this;
  		tag.type = opts.type;
  		tag.icon = opts.icon;
  		tag.autoId = guf.getAutoId();
  		tag.containerId = guf.getAutoId();

  		tag.mdlClasses = {
			"color" : {
				"true" : {
					"root": ["mdl-button--colored"]
				},
				"accent" : {
					"root": ["mdl-button--colored-accent"]
				}
			}
  		};
		tag.defaultDcss = {
			"background": "@primary",
			"backgroundDisabled": "@disabled",
			"backgroundToggled": "@accent",
			"textColor": "@textPrimary"
		};

		tag.mixin('mdl');

		tag.on("mount", function() {
			initEvents();
		});

		tag.hide = function() {
			tag.root.classList.add("hidden");
		}

		tag.show = function() {
			tag.root.classList.remove("hidden");
		}

		function initEvents() {
			var VISIBLE_CLASS = 'is-showing-options',
	        fab_btn  = document.getElementById(tag.autoId),
	        fab_ctn  = document.getElementById(tag.containerId),
	        showOpts = function(e) {
	          	var processClick = function (evt) {
	            	if (e !== evt) {
	              		fab_ctn.classList.remove(VISIBLE_CLASS);
	              		fab_ctn.IS_SHOWING = false;
	              		document.removeEventListener('click', processClick);
	            	}
	          	};
	          	if (!fab_ctn.IS_SHOWING) {
	            	fab_ctn.IS_SHOWING = true;
	            	fab_ctn.classList.add(VISIBLE_CLASS);
	            	document.addEventListener('click', processClick);
	          	}
	        };
	    	fab_btn.addEventListener('click', showOpts);
		}
  	</script>
</guf-floating-action-button>