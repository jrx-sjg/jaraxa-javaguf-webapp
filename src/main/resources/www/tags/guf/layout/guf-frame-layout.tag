<guf-frame-layout>
    <yield/>
	<style scoped type="css">
        :scope {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
			position: relative;
        }
		
		:scope > * {
			position:absolute;
		}
    </style>
    <script>
		//this.mixin('marginMixin', 'elementSizeMixin');
		this.on("mount", function() {
			//this.adjustCommonProperties(opts);
		});
    </script>
</guf-frame-layout>