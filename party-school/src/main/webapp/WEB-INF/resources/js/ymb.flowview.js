/**
 * Created by john on 15/9/24.
 */
(function($) {
    var flowViewRender = function(element, options) {
        var defaults = {
            data:null,
            showpanel:function(){},
            iconcomplete:'http://img1.yiminbang.com/2015/10/8/47f64729-e4fb-4b0b-9b4f-b20d73f880bb.png',
            iconnotice:'http://img1.yiminbang.com/2015/10/8/33d20ff2-d851-4297-b941-2bc65af6fd32.png',
            iconprocess:'http://img1.yiminbang.com/2015/10/8/4e6fbf68-a9da-4516-a467-43e897fb3b7d.png',
            iconwait:'http://img1.yiminbang.com/2015/10/8/6360e41b-fd47-41ca-b57b-312143a80abe.png'
        };
        this._container = element;
        this._graph = new mxGraph(element);
        this._setting = $.extend({}, defaults, options);
        this._graph.showpanel = this._setting.showpanel;
        this._vertexArray = new Array();
        this.initialize();
    };

    flowViewRender.prototype = {
        initialize: function () {
            this.render();
            this.eventHandler();
        },
        eventHandler: function () {
            var data = this._setting.data;
            this._graph.addListener(mxEvent.CLICK, function (sender, evt) {
                var cell = evt.getProperty('cell');
                if(cell && cell.isVertex()){
                    var b = cell.getId();
                    var para={"cell":cell,"graph":this};
                    this.showpanel(data,b,false,para);
                }

            });
        },
        render: function () {
            // Checks if the browser is supported
            if (!mxClient.isBrowserSupported()) {
                // Displays an error message if the browser is not supported.
                mxUtils.error('Browser is not supported!', 200, false);
            }
            else {
                var graph = this._graph;
                // Disables the built-in context menu
                mxEvent.disableContextMenu(this._container);

                //disable drag
                graph.setEnabled(false);
                // Enables rubberband selection
                new mxRubberband(graph);

                // Gets the default parent for inserting new cells. This
                // is normally the first child of the root (ie. layer 0).
                var parent = graph.getDefaultParent();

                // Adds cells to the model in a single step
                graph.getModel().beginUpdate();

                this.registStyle();

                graph.getStylesheet().putDefaultVertexStyle(mxStyleRegistry.getValue("defaultVertex"));

                // Creates the default style for edges
                graph.getStylesheet().putDefaultEdgeStyle(mxStyleRegistry.getValue("defaultEdge"));

                var layout = new mxCompactTreeLayout(graph);

                try {
                    //var cell=new Cell(graph);
                    if(this._setting.data==null) throw "参数有误！";

                    //draw vertex
                    for(var i=0;i<this._setting.data.length;i++){
                        var vertex = this.createVertex(this._setting.data[i]);
                        this.addOverlay(graph,vertex);
                        this._vertexArray.push(vertex);
                    }
                    //从1开始，首个节点没有入度
                    //draw edge
                    for(var j=1;j<this._vertexArray.length;j++){
                        var vertex = this._vertexArray[j];
                        var preVertex = this._vertexArray[this._setting.data[j].preTaskIdx -1];
                        this.createEdge(preVertex,vertex);
                    }

                    layout.execute(graph.getDefaultParent());

                }
                finally {
                    // Updates the display
                    graph.getModel().endUpdate();
                }


            }
        },
        registStyle:function(){
            var defaultVertex = [];
            defaultVertex[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_RECTANGLE;
            defaultVertex[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
            defaultVertex[mxConstants.STYLE_ROUNDED] = true;
            defaultVertex[mxConstants.STYLE_FILLCOLOR] = '#999';//'#127AAE';//E1790F
            defaultVertex[mxConstants.STYLE_FONTCOLOR] = '#FFFFFF';
            defaultVertex[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
            defaultVertex[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
            defaultVertex[mxConstants.STYLE_FONTSIZE] = '13';
            defaultVertex[mxConstants.STYLE_FONTSTYLE] = 1;
            mxStyleRegistry.putValue("defaultVertex",defaultVertex);

            var defaultEdge = [];
            defaultEdge[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_CONNECTOR;
            defaultEdge[mxConstants.STYLE_STROKECOLOR] = '#666';
            defaultEdge[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
            defaultEdge[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
            defaultEdge[mxConstants.STYLE_EDGE] = mxEdgeStyle.ElbowConnector;
            defaultEdge[mxConstants.STYLE_ENDARROW] = mxConstants.ARROW_BLOCK;
            mxStyleRegistry.putValue("defaultEdge",defaultEdge);
        },
        addOverlay:function(cell,png){

            var overlay = new mxCellOverlay(new mxImage(png, 24, 24), '');
            overlay.cursor = 'hand';
            overlay.align = mxConstants.ALIGN_RIGHT;
            overlay.verticalAlign = mxConstants.ALIGN_MIDDLE;
            //图标绑定点击事件
            //overlay.addListener(mxEvent.CLICK, mxUtils.bind(this, function(sender, evt)
            //{
            //}));
            this._graph.addCellOverlay(cell, overlay);
        },
        createVertex:function(item) {
            var index = item.taskIdx - 1;
            var name = item.taskName;
            var _vertex = this._graph.insertVertex(this._graph.getDefaultParent(), null, name, 0, 0, 100, 40);
            _vertex.setId(index);
            var style = '';
            var png = '';
            switch (item.flowStatus) {
                case 1:
                    if(item.appointedPaymentTime && new Date(item.appointedPaymentTime) < new Date()){
                        style = this.noticeStyle;
                        png = this._setting.iconnotice;
                    }else{
                        png = this._setting.iconwait;
                    }
                    break;
                case 2:
                    style = this.processStyle;
                    png = this._setting.iconprocess;
                    if(item.appointedStartTime && new Date(item.appointedStartTime) < new Date()){
                        style = this.noticeStyle;
                        png = this._setting.iconnotice;
                    }
                    break;
                case 3:
                    style = this.processStyle;
                    png = this._setting.iconprocess;
                    if(item.appointedCompleteTime && new Date(item.appointedCompleteTime) < new Date()){
                        style = this.noticeStyle;
                        png = this._setting.iconnotice;
                    }
                    break;
                case 4:
                    style = this.completeStyle;
                    png = this._setting.iconcomplete;
                    break;
                default :
                    style = "";
            }
            _vertex.setStyle(style);
            if (png)
                this.addOverlay(_vertex, png);
            return _vertex;
        },
        createEdge:function(vertex1,vertex2){
            var _edge = this._graph.insertEdge(this._graph.getDefaultParent(), null, '',vertex1, vertex2);
        },
        completeStyle:"fillColor=#4dd4fd",
        noticeStyle:"fillColor=#fec060;",
        processStyle:"fillColor=#9ad268"

    };

    $.fn.flowView = function (options) {
        return this.each(function (key, value) {
            var element = $(this);
            // Return early if this element already has a plugin instance
            if (element.data('flowView')) return element.data('flowView');
            // Pass options to plugin constructor
            var flowView = new flowViewRender(this, options);
            // Store plugin object in this element's data
            element.data('flowView', flowView);
        });
    };
})(jQuery);