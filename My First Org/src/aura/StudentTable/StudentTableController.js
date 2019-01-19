({ 
    Search: function(component, event, helper) {
        var searchKeyFld = component.find("searchId");
        var srcValue = searchKeyFld.get("v.value");
        if (srcValue == '' || srcValue == null) {
            // display error message if input value is blank or null
            searchKeyFld.set("v.errors", [{
                message: "Enter Search Keyword."
            }]);
        } else {
            searchKeyFld.set("v.errors", null);
            // call helper method
            helper.SearchHelper(component, event);
        }
    },
    
    deleteSelected: function(component, event, helper) {
        // create var for store record id's for selected checkboxes  
        var delId = [];
        // get all checkboxes 
        var getAllId = component.find("boxPack");
        alert(getAllId.length);
        // play a for loop and check every checkbox values 
        // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
        for (var i = 0; i < getAllId.length; i++) {
            if (getAllId[i].get("v.value") == true) {
                alert(getAllId[i].get("v.text"));
                delId.push(getAllId[i].get("v.text"));
            }
        }
        // call the helper function and pass all selected record id's.    
        helper.deleteSelectedHelper(component, event, delId);
    },
    
    checkboxSelect: function(component, event, helper) {
        // get the selected checkbox value  
        var selectedRec = event.getSource().get("v.value");
        // get the selectedCount attrbute value(default is 0) for add/less numbers. 
        var getSelectedNumber = component.get("v.selectedCount");
        // check, if selected checkbox value is true then increment getSelectedNumber with 1 
        // else Decrement the getSelectedNumber with 1     
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        // set the actual value on selectedCount attribute to show on header part. 
        component.set("v.selectedCount", getSelectedNumber);
    },
    selectAll: function(component, event, helper) {
        //get the header checkbox value  
        var selectedHeaderCheck = event.getSource().get("v.value");
        // get all checkbox on table with "boxPack" aura id (all iterate value have same Id)
        // return the List of all checkboxs element 
        var getAllId = component.find("boxPack");
        if (selectedHeaderCheck == true) {
            for (var i = 0; i < getAllId.length; i++) {
                component.find("boxPack")[i].set("v.value", true);
                component.set("v.selectedCount", getAllId.length);
            }
        } else {
            for (var i = 0; i < getAllId.length; i++) {
                component.find("boxPack")[i].set("v.value", false);
                component.set("v.selectedCount", 0);
            }
        }
    },
})