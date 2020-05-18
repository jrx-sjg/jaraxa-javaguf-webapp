<guf-slider>
	<input ref="input" class="mdl-slider mdl-js-slider" type="range" min="{min}" max="{max}" step="{step}" value="{value}" tabindex="0"></input>
	<style scoped type="dcss">

		:scope {
			width: 300px;
		}
		
		.mdl-slider.is-upgraded {
			color: @backgroundColor;
		}

		.mdl-slider.is-upgraded::-ms-fill-lower {
      		background: linear-gradient(to right, transparent, transparent 16px, @backgroundColor 16px, @backgroundColor 0); 
      	}

    	.mdl-slider.is-upgraded::-webkit-slider-thumb {
      		background: @backgroundColor;
      	}

    	.mdl-slider.is-upgraded::-moz-range-thumb {
      		background: @backgroundColor;
      	}

    	.mdl-slider.is-upgraded:focus:not(:active)::-webkit-slider-thumb {
      		box-shadow: 0 0 0 10px @backgroundColor; 
      	}
    	
    	.mdl-slider.is-upgraded:focus:not(:active)::-moz-range-thumb {
      		box-shadow: 0 0 0 10px @backgroundColor; 
  		}
    
    	.mdl-slider.is-upgraded:active::-webkit-slider-thumb {
    		background: @backgroundColor;
      	}

      	.mdl-slider.is-upgraded:active::-moz-range-thumb {
      		background: @backgroundColor;
      	}

	    .mdl-slider.is-upgraded::-ms-thumb {
	      	background: @backgroundColor;
	    }

    	.mdl-slider.is-upgraded:focus:not(:active)::-ms-thumb {
      		background: radial-gradient(circle closest-side, @backgroundColor 0%, @backgroundColor 37.5%, @backgroundColor 37.5%, @backgroundColor 100%);
      	}

    	.mdl-slider.is-upgraded:active::-ms-thumb {
      		background: @backgroundColor;
      	}

		:scope .mdl-slider__background-flex .mdl-slider__background-lower {
			background: @backgroundColor;
		}

		.mdl-slider.is-upgraded.is-lowest-value::-webkit-slider-thumb {
			background: transparent;
		}
		
		.mdl-slider.is-upgraded.is-lowest-value::-moz-range-thumb {
      		background: transparent;
      	}

	    .mdl-slider.is-upgraded.is-lowest-value::-ms-thumb {
	      	background: transparent;
	    }

		.hidden {
			display: none;
		}
	</style>
	<script type="text/javascript">
		// Init
		var tag = this;
		var disabled = false;
		tag.value = guf.param.number(opts.value, 0);
		tag.min = guf.param.number(opts.min, 0);
		tag.max = guf.param.number(opts.max, 100);
		tag.step = guf.param.number(opts.step, 1);
		
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"backgroundColor": "@primary"
		};
		tag.mixin('mdl');

		// Behaviour
		tag.on("mount", function() {
			tag.refs["input"].addEventListener("click", clickHandler);
			tag.refs["input"].addEventListener("input", inputHandler);
		});

		tag.on("before-unmount", function() {
			tag.refs["input"].removeEventListener("click", clickHandler);
			tag.refs["input"].removeEventListener("input", inputHandler);
		});
		
		tag.disable = function() {
			tag.refs["input"].setAttribute("disabled", "");
			disabled = true;
		};

		tag.enable = function() {
			tag.refs["input"].removeAttribute("disabled");
			disabled = false;
		};

		tag.isDisabled = function() {
			return disabled;
		};

		tag.hide = function() {
			tag.root.classList.add("hidden");
		};
		tag.show = function() {
			tag.root.classList.remove("hidden");
		};

		tag.setValue = function(newValue) {
			tag.refs["input"].MaterialSlider.change(newValue);
		};

		tag.getValue = function() {
			return tag.refs["input"].value;
		};

		// Private
		function clickHandler(evt) {
			tag.trigger('slider-click', evt, tag);
		}

		function inputHandler(evt) {
			tag.trigger('slider-input', evt, tag);
		}
		
	</script>
</guf-slider>