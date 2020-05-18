<guf-badge>
	<span class="guf-badge">
		{content}
		<i if="{icon && !content}" class="material-icons guf-badge-icon">{icon}</i>
	</span>
	
	<style scoped type="dcss">

		:scope > .guf-badge {
			display: -webkit-flex;
		    display: -ms-flexbox;
		    display: flex;
		    -webkit-flex-direction: row;
		    -ms-flex-direction: row;
		    flex-direction: row;
		    -webkit-flex-wrap: wrap;
		    -ms-flex-wrap: wrap;
		    flex-wrap: wrap;
		    -webkit-justify-content: center;
		    -ms-flex-pack: center;
		    justify-content: center;
		    -webkit-align-content: center;
		    -ms-flex-line-pack: center;
		    align-content: center;
		    -webkit-align-items: center;
		    -ms-flex-align: center;
		    align-items: center;
		    font-family: "Roboto","Helvetica","Arial",sans-serif;
		    font-weight: @textWeight;
		    font-size: 12px;
		    width: 22px;
		    height: 22px;
		    border-radius: 50%;
		    color: @textColor;
		    margin: 0px 8px;
		}

		:scope > .guf-badge:not(.mdl-badge--colored) {
			background: rgba(0, 0, 0, 0.17);
		}

		:scope > .guf-badge.mdl-badge--colored {
			background: @backgroundColor;
		}

		:scope > .guf-badge > .guf-badge-icon {
			font-size: @iconSize;
			color: @textColor;
		}

		:scope:hover > guf-badge {
			background: @backgroundHover;
		}

	</style>
	<script type="text/javascript">
		var tag = this;
		tag.content = opts.content || null;
		tag.icon = guf.param.string(opts.icon, null);
		tag.overridenValue = false;

		tag.mdlClasses = {
			"color" : {
				"true" : {
					"root": ["mdl-badge--colored"]
				}
			}
		};
		tag.defaultDcss = {
			"backgroundColor": "@accent",
			"backgroundHover": "@accent",
			"textColor": "@textPrimary",
			"textWeight": "600",
			"iconSize": "13px"
		};
		tag.mixin('mdl');

		// Behaviour
		tag.on("mount", function() {
			initEvents();
		});

		tag.on("update", function() {
			if (!tag.overridenValue) {
				tag.content = opts.content || null;
			}
			tag.icon = guf.param.string(opts.icon, null);
		});

		tag.on("unmount", function() {
			removeEvents();
		});

		tag.setContent = function(newValue) {
			tag.content = newValue;
			tag.overridenValue = true;
			tag.update();
		}

		tag.hide = function() {
			tag.root.classList.add("hidden");
		}

		tag.remove = function() {
			tag.unmount();
		}

		tag.show = function() {
			tag.root.classList.remove("hidden");
		}

		function onClickHandler(evt) {
			tag.trigger("click", evt, tag);
		}

		function initEvents() {
			tag.root.addEventListener("click", onClickHandler);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", onClickHandler);
		}

	</script> 
</guf-badge>