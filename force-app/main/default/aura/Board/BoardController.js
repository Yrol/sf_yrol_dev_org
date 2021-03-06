({
    doInit : function(component, event, helper) {

        //getting the current game mode
        const gameMode = component.get('v.gameMode');

        let columns = helper.getColumns(gameMode);

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

        helper.resetBoard(component);
    },

    blockClickHandler : function(component, event, helper) {

        let clickCount = component.get("v.clickCount") +  1;

        //getting the value that comes from BlockController.js - compEvent.setParam (the one we passed as JSON)
        const value = event.getParam("value");

        if(value === component.get("v.WinWord")){
            //user has won
            component.set("v.result", "YOU WIN");
            helper.disableBoard(component);
            console.log('You won');
            helper.fireResultEvent('win');
        } else if(clickCount === 3) {
            console.log('You lost');
            helper.disableBoard(component);
            component.set("v.result", "YOU LOST");
            helper.fireResultEvent('lost');
        }

        component.set("v.clickCount", clickCount)
    },

    reshuffleBoard: function(component, event, helper) {
        const gameMode = component.get('v.gameMode');
        let columns = helper.getColumns(gameMode);
        const words = helper.getWords(columns * columns);
        let winWord = helper.getWinWord(words);
        component.set('v.RandomWords', words)
        component.set('v.WinWord',winWord)
        helper.resetBoard(component);
    },

    doRender : function(component, event, helper) {
        console.log("Render completed");
    }
})
