({
    addResultRecord : function(component, gameResult) {

        //accessing the addResult method in force-app/main/default/classes/BoardPanelController.cls
        const action = component.get("c.addResult");
        const gameMode = component.get("v.selectedMode").toUpperCase();

        //set parameters - JSON object
        action.setParams({
            result: gameResult,
            mode: gameMode
        });

        //defining a callback
        action.setCallback(this, function(response) {
            const state = response.getState();

            //Similar to a server response such as 200, 400 & etc
            if(state !== 'SUCCESS') {
                console.log("Error in saving the record");
            }
        });

        //calling the Apex method
        $A.enqueueAction(action);
    }
})
