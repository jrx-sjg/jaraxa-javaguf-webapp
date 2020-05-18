<sam-empty>
	<guf-linear-layout ref="container" orientation="vertical" v-align="center" h-align="center" class="flex1">
		<guf-linear-layout orientation="horizontal" v-align="center" class="content-wrapper">
			<div class="icon"><i class="material-icons" if="{guf.ancestor(this, 'sam-empty').opts.icon}">{guf.ancestor(this, 'sam-empty').opts.icon}</i><guf-image if="{guf.ancestor(this, 'sam-empty').opts.src}" imagesrc="{guf.ancestor(this, 'sam-empty').opts.src}"/></div>
			<div class="text">{guf.ancestor(this, 'sam-empty').opts.text}</div>
		</guf-linear-layout>
	</guf-linear-layout>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > guf-linear-layout > .content-wrapper {
			background-color: @background;
			border-radius: 8px;
			max-width: 350px;
			padding: 10px;
		}
		:scope > guf-linear-layout > .content-wrapper > .icon {
			background-color: white;
			border-radius: 50%;
			width: 50px;
			min-width: 50px;
			height: 50px;
			display: flex;
			justify-content: center;
			align-items: center;
			margin-right: 16px;
		}
		:scope > guf-linear-layout > .content-wrapper > .icon > i.material-icons {
			color: @primary;
			font-size: 32px;
		}
		:scope > guf-linear-layout > .content-wrapper > .text {
			font-family: chronicle-deck, serif;
			color: @lighttext;
		}
	</style>
	<script>
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');
	</script>
</sam-empty>