({
    createChart : function() {
        config = {
            container: "#tree-simple"
        };
        parent_node = {
            text: { name: "Parent node" }
        };
        first_child = {
            parent: parent_node,
            text: { name: "First child" }
        };
        second_child = {
            parent: parent_node,
            text: { name: "Second child" }
        };
        simple_chart_config = [
            config, parent_node,
            first_child, second_child
        ];
        console.log("before variable");
        var my_chart = new Treant(simple_chart_config);
        console.log("after variable");
        console.log(simple_chart_config);
    }
})
