<guf-i18n>
	<span>{ value }</span>
	<script type="text/javascript">
		var tag = this;
		var key = opts.key;
		var options = opts.options || {};
		var params = opts.params ? opts.params : [];
		
		tag.value = guf.i18n.get(options, key, params);
	</script>
</guf-i18n>