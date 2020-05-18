<guf-chip>
	<span class="{mdl-chip:1, mdl-chip--contact: type=='contact', mdl-chip--deletable: deletable}">
	    <guf-avatar if="{type=='contact'}" class="mdl-chip__contact" size="32" letter="{opts.letter}" imagesrc="{opts.imagesrc}"></guf-avatar>
	    <span class="mdl-chip__text">{opts.text}</span>
	    <button if="{deletable}" ref="deletebtn" type="button" class="mdl-chip__action"><i class="material-icons">cancel</i></button>
	</span>
	<style type="css">
		.mdl-chip__contact img {
			vertical-align: top;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.type = opts.type;
		tag.deletable = guf.param.boolean(opts.deletable, true);

		tag.on("mount", function() {
			if (tag.deletable) {
				tag.refs.deletebtn.addEventListener('click', function(evt) {
					tag.trigger('delete-click', tag);
				},false);
			}
		});
	</script>
</guf-chip>