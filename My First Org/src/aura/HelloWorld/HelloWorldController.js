({
	add : function(component) {
		var addSum = component.get("v.num1")+component.get("v.num2");
        component.set("v.sum",addSum);
        alert("addSum "+addSum)
	}
})