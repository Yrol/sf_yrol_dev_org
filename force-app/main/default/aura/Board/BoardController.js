({
    doInit : function(component, event, helper) {

        //getting the current game mode
        const gameMode = component.get('v.gameMode');

        let columns = 0;

        //determining the number of columns
        if(gameMode && gameMode === 'medium'){
            columns = 4;
        } else if(gameMode && gameMode === 'hard'){
            columns = 6;
        } else {
            columns = 3;
        }

        //getting the grid size (12 is the horizontal number of maximum columns in Aura framework)
        let blockSize = 12/columns;
        console.log('block size: ' + blockSize)
        component.set('v.blockSize', blockSize);

        //getting the random words
        let words = helper.getWords(columns * columns)
        console.log(words);

        //getting the win word
        let winWord = helper.getWinWord(words);
        console.log(winWord)

        component.set('v.RandomWords', words)
        component.set('v.WinWord',winWord)
    },

    blockClickHandler : function(component, event, helper) {

        let clickCount = component.get("v.clickCount") +  1;

        //getting the value that comes from BlockController.js - compEvent.setParam (the one we passed as JSON)
        const value = event.getParam("value");

        if(value === component.get("v.WinWord")){
            //user has won
            component.set("v.result", "YOU WIN");
            console.log('You won');
        } else if(clickCount === 3) {
            console.log('You lost');
            component.set("v.result", "YOU LOST");
        }

        component.set("v.clickCount", clickCount)
    },

    doRender : function(component, event, helper) {
        console.log("Render completed");
    }
})
