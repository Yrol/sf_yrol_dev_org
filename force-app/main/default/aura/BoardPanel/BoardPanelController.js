({
    startGame : function(component, event, helper) {

        //Accessing the combo box component
        let gameModeComboBox =  component.find("gameMode");

        //accessing the selected value of the combo box
        let selectedValue = gameModeComboBox.get("v.value");

        const selectedMode = component.get("v.selectedMode");

        if(selectedMode){
            //finding the board component using the ID boardComp
            const boardComp = component.find('boardComp');

            //calling the method "startGame" defined in the child component (in Board.cmp). 
            boardComp.startGame();
        }

        //Setting the value of the selectedMode attribute
        component.set("v.selectedMode", selectedValue);

        //getting the attribute value
        console.log(component.get("v.selectedMode"));
    },

    reshuffleBoard : function(component, event, helper) {
        const boardComp = component.find('boardComp');
        component.set("v.reshuffleDisabled", true)
        boardComp.reshuffleBoard();
    },

    onResultHandler: function(component, event, helper) {
        const result = event.getParam("result");

        if(result === "win") {
            component.set("v.reshuffleDisabled", true);
        } else {
            component.set("v.reshuffleDisabled", false);
        }

        helper.addResultRecord(component, result);
    }
})
