({
    doInit: function(component, event, helper) {
       // this function call on the component load first time     
       // get the page Number if it's not define, take 1 as default
       var page = component.get("v.page") || 1;
       // get the select option (drop-down) values.   
       var recordToDisply = component.find("recordSize").get("v.value");
       // call the helper function   
       helper.getBatchData(component, page, recordToDisply);
  
    },
  
    navigate: function(component, event, helper) {
       // this function call on click on the previous page button  
       var page = component.get("v.page") || 1;
       // get the previous button label  
       var direction = event.getSource().get("v.label");
       // get the select option (drop-down) values.  
       var recordToDisply = component.find("recordSize").get("v.value");
       // set the current page,(using ternary operator.)  
       page = direction === "Previous Page" ? (page - 1) : (page + 1);
       // call the helper function
       helper.getBatchClient(component, page, recordToDisply);
  
    },
  
    onSelectChange: function(component, event, helper) {
       // this function call on the select opetion change,	 
       var page = 1
       var recordToDisply = component.find("recordSize").get("v.value");
       helper.getBatchClient(component, page, recordToDisply);
    },

    batchSelect: function(component, event, helper) {
     // get the page Number if it's not define, take 1 as default
     var page = component.get("v.page") || 1;
     // get the select option (drop-down) values.   
     var recordToDisply = component.find("recordSize").get("v.value");
     
     // call the helper function   
     helper.getBatchClient(component, page, recordToDisply);
   },
  
 })