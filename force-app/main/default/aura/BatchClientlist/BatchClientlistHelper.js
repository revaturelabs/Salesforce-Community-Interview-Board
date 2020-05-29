({
    getBatchClient: function(component, page, recordToDisply) {
      var PicklistValue = component.find("batchName").get("v.value").toString();
       // create a server side action. 
       var action = component.get("c.fetchBatchClient");
       // set the parameters to method 
       action.setParams({
          "pageNumber": page,
          "recordToDisply": recordToDisply,
          "picklistV": PicklistValue
       });
       // set a call back   
       action.setCallback(this, function(a) {
          // store the response return value (wrapper class insatance)  
          var result = a.getReturnValue();
          console.log('result ---->' + JSON.stringify(result));
          // set the component attributes value with wrapper class properties.   
  
          component.set("v.BatchClient", result.BatchClient);
          component.set("v.page", result.page);
          component.set("v.total", result.total);
          component.set("v.pages", Math.ceil(result.total / recordToDisply));
  
       });
       // enqueue the action 
       $A.enqueueAction(action);
    }
 ,
 getBatchData: function(component, page, recordToDisply) {
  
   // create a server side action. 
   var action = component.get("c.LoadData");
   // set the parameters to method 
   action.setParams({
      "pageNumber": page,
      "recordToDisply": recordToDisply
   });
   // set a call back   
   action.setCallback(this, function(a) {
      // store the response return value (wrapper class insatance)  
      var result = a.getReturnValue();
      console.log('result ---->' + JSON.stringify(result));
      // set the component attributes value with wrapper class properties.   

      component.set("v.BatchClient", result.BatchClient);
      component.set("v.page", result.page);
      component.set("v.total", result.total);
      component.set("v.pages", Math.ceil(result.total / recordToDisply));
      component.set("v.Batches", result.BatchList);

   });

 
   // enqueue the action 
   $A.enqueueAction(action);
}
})