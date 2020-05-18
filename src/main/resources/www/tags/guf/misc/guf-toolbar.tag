<guf-toolbar>
    <header class="{mdl-layout__header:1, mdl-layout__header-noelevation:!elevation} mdl-layout--no-drawer-button">
        <div class="mdl-layout__header-row">
            <guf-button if="{back}" ref="back-button" icon="arrow_back" type="icon" ripple="true"></guf-button>
            <span ref="ttitle" class="{mdl-layout-title: 1, back-margin: back}">{opts.toolbarTitle}</span>
            <div class="mdl-layout-spacer"></div>
            <yield/>
        </div>
    </header>

    <style scoped type="dcss">
        :scope {
        }

        :scope .mdl-layout__header {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            flex: 1;
            -webkit-flex:1;
            -ms-flex:1;
            min-width: 0;
            background-color: @background;
        }

        :scope .mdl-layout__header-row {
            color: @textColor;
            background-color: @background;
        }

        :scope .mdl-layout__header-row > .mdl-layout-title {
            color: @textColor;
        }

        :scope .mdl-layout__header-noelevation {
            box-shadow: none;
        }

        :scope > header > div > span[ref="ttitle"] {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            min-width: 0px;
            flex: 1;
            flex-basis: 100%;
            line-height: normal;
        }

        :scope.noTitle > header > div > span[ref="ttitle"],
        :scope.noTitle > header > div > div.mdl-layout-spacer {
            display:none;
        }

        :scope > .mdl-layout__header > .mdl-layout__header-row > .back-margin {
            margin-left: 8px;
        }

    </style>

    <script type="text/javascript">
        var tag = this;
        tag.elevation = guf.param.boolean(opts.elevation, false);
        tag.back = guf.param.boolean(opts.back, false);

        tag.defaultDcss = {
            "background": "@primary",
            "textColor": "white"
        };
        tag.mixin('mdl');

        tag.on("mount", function() {
            initEvents();
        });

        tag.on("before-unmount", function() {
            removeEvents();
        });

        tag.setText = function(value) {
            tag.refs.ttitle.innerHTML = value;
        };

        function screenSizeChangedHandler() {
            var reAddEvent = tag.back != guf.param.boolean(opts.back, false);
            tag.back = guf.param.boolean(opts.back, false);
            tag.update();
            if (tag.back && reAddEvent) {
                tag.refs["back-button"].on("click", function() {
                    tag.trigger("back-clicked");
                });
            }
        }

        function initEvents() {
            if (tag.back) {
                tag.refs["back-button"].on("click", function() {
                    tag.trigger("back-clicked");
                });
            }
            guf.on("screen-size-changed", screenSizeChangedHandler);
        }

        function removeEvents() {
            guf.off("screen-size-changed", screenSizeChangedHandler);
        }
    </script>
</guf-toolbar>