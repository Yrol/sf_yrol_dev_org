({
    doInit : function(component, event, helper) {
        //getting the random words
        let words = helper.getWords(6)
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
