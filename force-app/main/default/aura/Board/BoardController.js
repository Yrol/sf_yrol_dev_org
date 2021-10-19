({
    doInit : function(component, event, helper) {
        console.log(helper.getWords(6));
    },

    doRender : function(component, event, helper) {
        console.log("Render completed");
    }
})
