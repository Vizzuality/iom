function initialize() {
    first_map = new F1.Maker.Map({
        map_id: "37985", 
        dom_id: "map",
        uiLegend:false,
        uiLayers:false,
        onload: function() {
            first_map.swf.addFilter(0, { expression: "$[city] = 'Atlanta'" }); 
        }
    });
};
