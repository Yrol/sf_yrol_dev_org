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

    doRender : function(component, event, helper) {
        console.log("Render completed");
    }
})
