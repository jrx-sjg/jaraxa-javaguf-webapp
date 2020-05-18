<guf-datetimepicker>
	<guf-datetimepicker-button if="{isButton}" label="{opts.label}" button-type="{opts.buttonType}" full-width="{opts.fullWidth}" trailing-icon="{opts.trailingIcon}" placeholder="{opts.placeholder}" disabled="{opts.disabled}"></guf-datetimepicker-button>
	<guf-input if="{isInput}" type="text" id="{autoId}" disabled="{opts.disabled}" placeholder="{opts.placeholder}" label="{opts.label}" pattern="{opts.pattern}" invalid="{opts.invalid}" trailing-icon="{opts.trailingIcon}" trailing-icon-fn="{trailingIconFn}" readonly="{readonly}"></guf-input>
	<guf-button if="{!isInput && !isButton}" type="icon" icon="{icon}" ripple="{ripple}" color="{color}"></guf-button>

	<style type="dcss">
		@scoped=no

		html body .mddtp-picker .mddtp-picker__header {
			background-color: @backgroundColor;
		}

		html body .mddtp-picker__selection span {
			background-color: @backgroundColor;
		}

		html body .mddtp-button {
			color: @backgroundColor;
		}

		html body .mddtp-picker__body .mddtp-picker__viewHolder .mddtp-picker__grid .mddtp-picker__tr span.mddtp-picker__cell:hover {
			background-color: @backgroundColor;
		}

		html body .mddtp-picker__body .mddtp-picker__viewHolder .mddtp-picker__grid span.mddtp-picker__cell--today {
			color: @backgroundColor;
			background-color: white;
		}

		html body .mddtp-picker__body .mddtp-picker__viewHolder .mddtp-picker__grid span.mddtp-picker__cell--selected {
			background-color: @backgroundColor;
			color: #fff;
		}

		html body .mddtp-picker__years .mddtp-picker__li--current {
			color: @backgroundColor;
		}

		html body .mddtp-picker-time .mddtp-picker__header .mddtp-picker__subtitle {
			text-transform: uppercase;
		}

		html body .mddtp-picker__overlay {
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			background-color: rgba(0, 0, 0, 0.3);
			z-index: 1;
		}
	</style>

	<script type="text/javascript">
		var tag = this;
		tag.picker = undefined;
		tag.autoId = guf.getAutoId();
		tag.inputtype = guf.param.string(opts.inputtype, 'button');
		tag.icon = opts.icon;
		tag.color = opts.color;
		tag.ripple = guf.param.booleanExpr(opts, "ripple", false);
		tag.type = guf.param.string(opts.type, 'time');
		tag.mode = guf.param.booleanExpr(opts, "mode", guf.isDefined("guf.l10n") ? guf.l10n.getHourMode() : true);
		tag.readonly = guf.param.string(opts.readonly, "readonly");
		tag.disabled = opts.disabled;
		tag.end = guf.param.booleanExpr(opts, "end", false);
		tag.ok = guf.param.string(opts.ok, null);
		tag.cancel = guf.param.string(opts.cancel, null);
		tag.isInput = tag.inputtype === 'input';
		tag.isButton = tag.inputtype === 'button';
		tag.pastDate = opts.pastDate || null;
		tag.futureDate = opts.futureDate || null;
		tag.validRanges = opts.validRanges || null;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"backgroundColor": "@primary",
			"todayColor": "@primary"
		};
		tag.mixin('mdl');
		tag.mixin('after-mount');

		var autoClose = guf.param.booleanExpr(opts, "autoclose", false);
		var format = guf.param.string(opts.format, 'L');
		var overlay = null;
		var deferredValue = null, deferredMoment = undefined;
		var afterMounted = false;
		var clickElement = null;
		var clickEvent = "click";

		function showOverlay() {
			if(!overlay) {
				overlay = document.createElement("div");
				overlay.classList.add("mddtp-picker__overlay");
				document.body.appendChild(overlay);
			}
		}

		function hideOverlay() {
			if(overlay) {
				overlay.remove();
				overlay = null;
			}
		}

		function toggleOverlay() {
			if(overlay) {
				hideOverlay();
			} else {
				showOverlay();
			}
		}

		tag.on('before-unmount', function() {
			removeEvents();
			if (tag.picker) {
				tag.picker.hide();
			}
		})

		tag.on("mount", function() {
			
		});

		tag.on('after-mount', function() {
			if (tag.type == 'time') {
				var m = undefined;
				if (tag.isInput && !tag.isButton && tag.tags["guf-input"].getValue()!=null && tag.tags["guf-input"].getValue().length>0 && tag.tags["guf-input"].getValue().indexOf(':')!=-1) {
					var initialHourString = tag.tags["guf-input"].getValue();
					if (!tag.mode) {
						initialHourString = guf.l10n.to24HourMode(initialHourString);
					}
					var initialHour = initialHourString.split(":");
					var m = moment();
					m.set({
						hour: initialHour[0],
						minute: initialHour[1]
					});
				}
				
				var params = {
					type: 'time',
					autoClose: autoClose,
					mode: tag.mode,
					init: m
				};
				if (tag.ok) {
					params["ok"] = tag.ok;
				}
				if (tag.cancel) {
					params["cancel"] = tag.cancel;
				}
				tag.picker = new mdDateTimePicker.default(params);
			} else {
				var initialDateString = tag.isInput ? tag.tags["guf-input"].getValue() : null;
				if (!!initialDateString) {
					m = moment(initialDateString);
				}
				var params = {
					type: 'date',
					init: m,
					autoClose: autoClose
				};
				if (tag.pastDate!==null) {
					params["past"] = tag.pastDate;
				}
				if (tag.futureDate!==null) {
					params["future"] = tag.futureDate;
				} else {
					params["future"] = moment(new Date()).add(21, 'years');
				}
				if (tag.validRanges!==null) {
					params["validRanges"] = tag.validRanges;
				}
				if (tag.ok) {
					params["ok"] = tag.ok;
				}
				if (tag.cancel) {
					params["cancel"] = tag.cancel;
				}
				tag.picker = new mdDateTimePicker.default(params);
			}

			initEvents();
			afterMounted = true;
			if(deferredValue !== null) {
				tag.setValue(deferredValue, deferredMoment);
			}
		});

		tag.setValidRanges = function(validRanges) {
			if(afterMounted) {
				tag.picker.setValidRanges(validRanges);
			} else {
				tag.validRanges = validRanges;
			}
		};

		tag.setPastDate = function(pastDate) {
			if(afterMounted) {
				tag.picker.setPast(pastDate);
			} else {
				tag.pastDate = pastDate;
			}
		};

		tag.setFutureDate = function(futureDate) {
			if(afterMounted) {
				tag.picker.setFuture(futureDate);
			} else {
				tag.futureDate = futureDate;
			}
		};

		tag.setValue = function(value, moment) {
			if(afterMounted) {
				if (!tag.mode && tag.type == 'time') {
					value = guf.l10n.toLocaleMode(value);
				}
				if (tag.isInput) {
					tag.tags["guf-input"].setValue(value);
				} else if(!tag.isButton) {
					tag.tags["guf-button"].value = value;
				} else {
					tag.tags["guf-datetimepicker-button"].setText(value);
				}
				if (typeof(moment) !== "undefined") {
					tag.picker.time = moment;
				}
			} else {
				deferredValue = value;
				deferredMoment = moment;
			}
		}

		tag.getValue = function() {
			var result = tag.isInput ? tag.tags["guf-input"].getValue() : (tag.isButton ? tag.tags["guf-datetimepicker-button"].getValue() : tag.tags["guf-button"].value);
			if (!tag.mode && tag.type == 'time') {
				result = guf.l10n.to24HourMode(result);
			}
			return result;
		}
		tag.isValid = function() {
			if(tag.isInput) {
				return tag.tags["guf-input"].isValid();
			} else {
				return true;
			}
		}
		tag.markAsInvalid = function(invalid) {
			if (tag.isInput) {
				tag.tags["guf-input"].markAsInvalid(invalid);
			}
		}
		tag.enable = function() {
			tag.disabled = false;
			if (tag.isInput) {
				tag.tags["guf-input"].enable();
			} else if(!tag.isButton) {
				tag.tags["guf-button"].enable();
			} else {
				tag.tags["guf-datetimepicker-button"].enable();
			}
		}
		tag.disable = function() {
			tag.disabled = true;
			if (tag.isInput) {
				tag.tags["guf-input"].disable();
			} else if(!tag.isButton) {
				tag.tags["guf-button"].disable();
			} else {
				tag.tags["guf-datetimepicker-button"].disable();
			}
		}

		tag.trailingIconFn = function() {
			togglePicker();
		}

		function togglePicker() {
			if (!tag.disabled) {
				toggleOverlay();
				tag.picker.toggle();
			}
		}

		function cancelHandler() {
			hideOverlay();
		}

		function okHandler() {
			if (tag.type == 'time') {
				var hour = ((tag.picker.time._d.getHours()<10)?"0":"") + tag.picker.time._d.getHours();
				var minute = ((tag.picker.time._d.getMinutes()<10)?"0":"") + tag.picker.time._d.getMinutes();
				tag.setValue(hour + ':' + minute);
				tag.trigger("time-change", tag.getValue(), tag);
			} else {
				var dateString = moment(tag.picker.time._d.getTime()).format(format);
				tag.setValue(dateString);
				tag.trigger("date-change", tag.getValue(), tag);
			}
			hideOverlay();
		}

		function initEvents() {
			if (tag.isInput) {
				clickElement = tag.tags["guf-input"];
				clickEvent = opts.trailingIcon ? null : "click";
				tag.picker.trigger = document.getElementById(tag.tags["guf-input"].inputId);
			} else if(!tag.isButton) {
				clickElement = tag.tags["guf-button"];
				tag.picker.trigger = document.getElementById(tag.tags["guf-button"].buttonId);
			} else {
				clickElement = tag.tags["guf-datetimepicker-button"];
				tag.picker.trigger = document.getElementById(tag.tags["guf-datetimepicker-button"].buttonId);
			}
			if (!!clickEvent) {
				clickElement.on(clickEvent, togglePicker);
			}
			tag.picker.trigger.addEventListener('onCancel', cancelHandler);
			tag.picker.trigger.addEventListener('onOk', okHandler);
		}

		function removeEvents() {
			if (!!clickEvent) {
				clickElement.off(clickEvent, togglePicker);
			}
			tag.picker.trigger.removeEventListener('onCancel', cancelHandler);
			tag.picker.trigger.removeEventListener('onOk', okHandler);
		}
	</script>
</guf-datetimepicker>