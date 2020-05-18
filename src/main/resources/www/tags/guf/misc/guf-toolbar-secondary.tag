<guf-toolbar-secondary>
    <guf-toolbar class="secondary-toolbar" toolbar-title="{opts.toolbarTitle}" elevation="{opts.elevation}" back="{opts.back}">
       <yield/>
    </guf-toolbar>

    <style scoped type="dcss">
        :scope {
            height: 48px;
        }

        :scope .secondary-toolbar {
            height: inherit;
        }

        :scope .secondary-toolbar .mdl-layout__header {
            min-height: 48px;
            height: inherit;
        }


        :scope .mdl-layout__header-color .mdl-layout__header-row {
            background-color: @background;
            padding: 0 16px;
        }

        :scope .mdl-layout__header-color .mdl-layout__header-row .mdl-layout-title {
            color: @textColor;
        }

        :scope .mdl-layout__header-row {
            height: inherit;
            background-color: white;
        }

        :scope .mdl-layout__header-no-color .mdl-layout__header {
            background-color: white;
        }

        :scope .mdl-layout__header-no-color .mdl-layout__header-row {
            color: rgba(0, 0, 0, 0.87);
            padding: 0 16px;
        }

        :scope .mdl-layout__header-no-color .mdl-layout__header-row .mdl-layout-title {
            color: @lightColorText;
        }

        :scope .mdl-layout__header-noelevation {
            box-shadow: none;
        }

    </style>

    <script type="text/javascript">
        var tag = this;
        tag.back = guf.param.boolean(opts.back, false);
        tag.elevation = guf.param.boolean(opts.elevation, false);
        tag.color = guf.param.string(opts.color, false);

        tag.mdlClasses = {
            "color" : {
                "true" : {
                    "root": ["mdl-layout__header-color"]
                },
                "false": {
                    "root": ["mdl-layout__header-no-color"]
                }
            }
        };
        tag.defaultDcss = {
            "background": "@primary",
            "textColor": "white",
            "lightColorText": "rgb(0, 0, 0)"
        };
        tag.mixin('mdl');

        tag.on("mount", function() {
            initEvents();
        });

        tag.on("before-unmount", function() {
            removeEvents();
        })

        function screenSizeChangedHandler() {
            tag.back = guf.param.boolean(opts.back, false);
            tag.update();
        }

        function initEvents() {
            tag.tags["guf-toolbar"].on("back-clicked", function() {
                tag.trigger("back-clicked");
            }); 
            guf.on("screen-size-changed", screenSizeChangedHandler);
        }

        function removeEvents() {
            guf.off("screen-size-changed", screenSizeChangedHandler);
        }
    </script>
</guf-toolbar-secondary>