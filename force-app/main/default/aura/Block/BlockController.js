({
    blockClickHandler : function(component, event, helper) {
        const open = component.get("v.open");

        if(!open){
            component.set("v.open", true);

            //getting the label value
            const label = component.get("v.label");

            //fire the block click event
            let compEvent = component.getEvent("onclick");

            //passing as JSON
            compEvent.setParam({value : label});

            compEvent.fire();
        }
    },

    afterScriptsLoaded : function(component, event, helper) {
        const divElement = component.getElement('.board-block');
        fitText(divElement);
    }
})
