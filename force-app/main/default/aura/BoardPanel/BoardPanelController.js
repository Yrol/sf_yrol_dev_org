({
    startGame : function(component, event, helper) {

        //Accessing the combo box component
        let gameModeComboBox =  component.find("gameMode");

        //accessing the selected value of the combo box
        let selectedValue = gameModeComboBox.get("v.value");

        console.log(selectedValue);
    },

    reshuffleBoard : function(component, event, helper) {
        console.log("Board reshuffle!");
    }
})
