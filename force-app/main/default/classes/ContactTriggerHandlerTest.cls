@isTest

/**
 * Will be used for testing force-app/main/default/classes/ContactTriggerHandler.cls
 * When we do the "insert" statments it will call the actual triggers for instance AFTER_INSERT in ContactTrigger.trigger and the flow will continue from there.
 */
public with sharing class ContactTriggerHandlerTest {

    @isTest
    /**
     * Testing inactive accounts
     */
    public static void afterInsertHandlerTest1(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        Contact contactTest1 = new Contact(LastName='Yrol', AccountId=testAccounts[0].Id);
        Contact contactTest2 = new Contact(LastName='Damian', AccountId=testAccounts[1].Id);
        Contact contactTest3 = new Contact(LastName='Saman', AccountId=testAccounts[1].Id);
        Contact contactTest4 = new Contact(LastName='Joel', AccountId=testAccounts[0].Id);

        List<Contact> testContacts = new List<Contact>{contactTest1, contactTest2, contactTest3, contactTest4};
        insert testContacts;

        /**
         * Checking for number of accounts above (up to this point we've only 2 accounts 0th and 1st).
         * Checking for the active accounts. We have zero active accounts up to this point (Active accounts need to be marked as active explicitly using the Active__c). So we'll agains the defualt null value.
         */
        List<Account> accounts = [SELECT Id, Active_Contacts__c FROM Account];
        System.assertEquals(2, accounts.size());
        System.assertEquals(null, accounts[0].Active_Contacts__c);
        System.assertEquals(null, accounts[1].Active_Contacts__c);

        //Contacts
        List<Contact> contacts = [SELECT Id from Contact];
        System.assertEquals(4,  contacts.size());
    }


    @isTest
    /**
     * Testing for active accounts
     */
    public static void afterInsertHandlerTest2(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        Contact contactTest1 = new Contact(LastName='Yrol', AccountId=testAccounts[0].Id);
        Contact contactTest2 = new Contact(LastName='Damian', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest3 = new Contact(LastName='Saman', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest4 = new Contact(LastName='Nigel', AccountId=testAccounts[0].Id, Active__c=true);
        Contact contactTest5 = new Contact(LastName='Joel', AccountId=testAccounts[0].Id);

        List<Contact> testContacts = new List<Contact>{contactTest1, contactTest2, contactTest3, contactTest4};
        insert testContacts;

        /**
         * Checking for number of accounts above (up to this point we've only 2 accounts 0th and 1st).
         * Checking for the active accounts. We're marking the above contacts as active.
         */
        List<Account> accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts) {
            if(acc.Name == 'Test 2'){
                System.assertEquals(2, acc.Active_Contacts__c);
            }

            if(acc.Name == 'Test 1'){
                System.assertEquals(1, acc.Active_Contacts__c);
            }
        }

        System.assertEquals(2, accounts.size());

        //Contacts
        List<Contact> contacts = [SELECT Id from Contact];
        System.assertEquals(4,  contacts.size());
    }
}