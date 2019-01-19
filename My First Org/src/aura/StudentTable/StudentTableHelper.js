({
    SearchHelper: function(component, event) {
        var action = component.get("c.fetchStudent");
        action.setParams({
            'searchboxstring': component.get("v.searchboxstring")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if storeResponse size is 0 ,display no record found message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                // set numberOfRecord attribute value with length of return value from server
                component.set("v.numberOfRecord", storeResponse.length);
                // set searchResult list with return value from server.
                component.set("v.searchResult", storeResponse);
            }
        });
        $A.enqueueAction(action);
    },
    deleteSelectedHelper: function(component, event, deleteRecordsIds) {
        //call apex class method
        var action = component.get('c.deleteRecords');
        // pass the all selected record's Id's to apex method 
        action.setParams({
            "lstRecordId": deleteRecordsIds
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(state);
               /* if (response.getReturnValue() != '') {
                    // if getting any error while delete the records , then display a alert msg/
                    alert('The following error has occurred. while Delete record-->' + response.getReturnValue());
                } else {
                    alert('check it--> delete successful');
                }*/
                // call the onLoad function for refresh the List view    
                //this.onLoad(component, event);
                component.set("v.searchResult", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
})