({
    init: function (cmp) {
        helper.simulateServerRequest(
            $A.getCallback(function handleServerResponse(serverResponse) {
                cmp.set('v.options', serverResponse.colors);

                /**
                 * Targets a race condition in which the options on the component does not reflect the new selected value.
                 * Check section "Generating Options On Initialization" on the documentation tab
                 */
                cmp.set('v.selectedValue', serverResponse.selectedColorId);
            })
        );

        cmp.set("v.options", items);
        // "values" must be a subset of values from "options"
        cmp.set("v.values", ["opt10", "opt5", "opt7"]);

    },


    handleChange: function (cmp, event) {
        // This will contain an array of the "value" attribute of the selected options
        var selectedOptionValue = event.getParam("value");
        alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
    }
});