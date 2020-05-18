<guf-linear-layout>
    <yield/>
	<style scoped type="css">
        :scope {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
        }

        :scope[orientation='horizontal'] {
			-ms-box-orient: horizontal;
            -webkit-flex-direction: row;
            -moz-flex-direction: row;
			-ms-flex-direction: row;
            flex-direction: row;
        }

        :scope[orientation='vertical'] {
			-ms-box-orient: vertical;
            -webkit-flex-flow: column;
            -moz-flex-flow: column;
			-ms-flex-flow: column;
            flex-flow: column;
        }
		
		/* alignment configurations */
		:scope[v-align='top']:not([orientation]) {
			-ms-flex-align: start;
			-webkit-box-align: start;
			-webkit-align-items: flex-start;
			align-items: flex-start;
		}
		
		:scope[v-align='bottom']:not([orientation]) {
			-ms-flex-align: end;
			-webkit-box-align: end;
			-webkit-align-items: flex-end;
			align-items: flex-end;
		}

		:scope[v-align='center']:not([orientation]) {
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
		}

		:scope[h-align='left']:not([orientation]) {
			-webkit-box-pack: start;
			-webkit-justify-content: flex-start;
			-moz-justify-content: flex-start;
			-ms-flex-pack: start;
			justify-content: flex-start;
		}
		
		:scope[h-align='right']:not([orientation]) {
			-webkit-box-pack: end;
			-webkit-justify-content: flex-end;
			-moz-justify-content: flex-end;
			-ms-flex-pack: end;
			justify-content: flex-end;
		}
		
		:scope[h-align='center']:not([orientation]) {
			-webkit-box-pack: center;
			-webkit-justify-content: center;
			-moz-justify-content: center;
			-ms-flex-pack: center;
			justify-content: center;
		}

		:scope[orientation='horizontal'][v-align='top'] {
			-ms-flex-align: start;
			-webkit-box-align: start;
			-webkit-align-items: flex-start;
			align-items: flex-start;
		}
		
		:scope[orientation='vertical'][v-align='top'] {
			-webkit-box-pack: start;
			-webkit-justify-content: flex-start;
			-moz-justify-content: flex-start;
			-ms-flex-pack: start;
			justify-content: flex-start;
		}
		
		:scope[orientation='horizontal'][v-align='bottom'] {
			-ms-flex-align: end;
			-webkit-box-align: end;
			-webkit-align-items: flex-end;
			align-items: flex-end;
		}

		:scope[orientation='vertical'][v-align='bottom'] {
			-webkit-box-pack: end;
			-webkit-justify-content: flex-end;
			-moz-justify-content: flex-end;
			-ms-flex-pack: end;
			justify-content: flex-end;
		}
		
		:scope[orientation='horizontal'][v-align='center'] {
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
		}

		:scope[orientation='vertical'][v-align='center'] {
			-webkit-box-pack: center;
			-webkit-justify-content: center;
			-moz-justify-content: center;
			-ms-flex-pack: center;
			justify-content: center;
		}

		:scope[orientation='horizontal'][h-align='left'] {
			-webkit-box-pack: start;
			-webkit-justify-content: flex-start;
			-moz-justify-content: flex-start;
			-ms-flex-pack: start;
			justify-content: flex-start;
		}
		
		:scope[orientation='vertical'][h-align='left'] {
			-ms-flex-align: start;
			-webkit-box-align: start;
			-webkit-align-items: flex-start;
			align-items: flex-start;
		}
		
		:scope[orientation='horizontal'][h-align='right'] {
			-webkit-box-pack: end;
			-webkit-justify-content: flex-end;
			-moz-justify-content: flex-end;
			-ms-flex-pack: end;
			justify-content: flex-end;
		}
		
		:scope[orientation='vertical'][h-align='right'] {
			-ms-flex-align: end;
			-webkit-box-align: end;
			-webkit-align-items: flex-end;
			align-items: flex-end;
		}
		
		:scope[orientation='horizontal'][h-align='center'] {
			-webkit-box-pack: center;
			-webkit-justify-content: center;
			-moz-justify-content: center;
			-ms-flex-pack: center;
			justify-content: center;
		}

		:scope[orientation='vertical'][h-align='center'] {
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
		}

    </style>
    <script>
		//this.mixin('marginMixin', 'elementSizeMixin');
		this.on("mount", function() {
			//this.adjustCommonProperties(opts);
		});
    </script>
</guf-linear-layout>