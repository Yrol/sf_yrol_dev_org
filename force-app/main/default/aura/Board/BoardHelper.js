({
    getWords : function(count) {
        if(count >  100 ) return;

        let words = ["expansion",
                    "grandfather",
                    "nappy",
                    "oranges",
                    "beds",
                    "quack",
                    "achiever",
                    "yell",
                    "hospital",
                    "winter",
                    "understood",
                    "squalid",
                    "merciful",
                    "reaction",
                    "wipe",
                    "fearless",
                    "tiresome",
                    "introduce",
                    "planes",
                    "drum",
                    "muddle",
                    "capable",
                    "canvas",
                    "route",
                    "enchanted",
                    "quirky",
                    "switch",
                    "apparatus",
                    "loss",
                    "agreement",
                    "substance",
                    "back",
                    "oafish",
                    "expand",
                    "aromatic",
                    "quarrelsome",
                    "free",
                    "useful",
                    "raspy",
                    "drown",
                    "ring",
                    "lush",
                    "numberless",
                    "embarrass",
                    "shrill",
                    "rice",
                    "ice",
                    "crow",
                    "pumped",
                    "sparkle",
                    "instruct",
                    "girl",
                    "glass",
                    "frog",
                    "murky",
                    "impolite",
                    "crabby",
                    "pin",
                    "grade",
                    "upbeat",
                    "linen",
                    "flaky",
                    "side",
                    "unknown",
                    "cactus",
                    "round",
                    "busy",
                    "grab",
                    "crush",
                    "faithful",
                    "mother",
                    "clean",
                    "unhealthy",
                    "event",
                    "absent",
                    "thoughtless",
                    "icy",
                    "prefer",
                    "charge",
                    "confuse",
                    "clam",
                    "dress",
                    "snake",
                    "evasive",
                    "unit",
                    "flow",
                    "annoying",
                    "gusty",
                    "possessive",
                    "rhetorical",
                    "rule",
                    "frantic",
                    "farm",
                    "poor",
                    "possess",
                    "men",
                    "pleasant",
                    "zoom",
                    "sidewalk",
                    "reply"];

        //returning the requested amount of words
        return words.sort(() => Math.random() - Math.random()).slice(0, count)
    },

    getWinWord: function(wordsArr) {
        const winWord = Math.floor(Math.random() * wordsArr.length);
        return wordsArr[winWord];
    },

    disableBoard: function(component) {
        component.set("v.boardDisabled", true);
    },

    enableBoard: function(component) {
        component.set("v.boardDisabled", false);
    },

    resetBoard: function(component) {

        //re-enable the board
        this.enableBoard(component);

        //reset the counter
        component.set("v.clickCount", 0);

        //reset the results
        component.set("v.result", "");
    }
})
