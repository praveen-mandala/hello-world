({
    trigger: function(cmp, event) {
        // Call an Apex controller that throws an error
        var action = cmp.get("c.throwError");
        action.setCallback(cmp, function(response){
            if (response.getState() === "SUCCESS") {
                alert('success');
            }
            else {
                alert('error');
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log(errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    showSystemError: function(cmp, event) {
        alert('Error');
        // Handle system error
        console.log(cmp);
        console.log(event);
    },
    onRender : function(cmp) {
        alert('onRender');
    },
    
    doInit : function(cmp) {
        alert('Init');
    }
})