({
    doInit : function(component, event, helper) {
        /**
         * Mapping table columns to the actual field name names of the "Word_Shuffle__c" custom object 
         */
        const columns = [
            {label: 'Game number', fieldName: 'Name', type: 'text'},
            {label: 'Game mode', fieldName: 'Mode__c', type: 'text'},
            {label: 'Played On', fieldName: 'CreatedDate', type: 'text'},
            {label: 'Game number', fieldName: 'Result__c', type: 'text'},
        ];

        component.set("v.columns", columns);

        helper.fetchResult(component);
    },

    onResultHandler: function(component, event, helper) {
        helper.fetchResult(component);
    }
})
