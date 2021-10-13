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

    @isTest
    /**
     * Testing for active accounts
     * In "Test 1" account we've 1000 active and 2 Inactive contacts. For "Test 2" we've no active contacts.
     */
    public static void afterInsertHandlerBulk(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        List<Contact> testContacts = new List<Contact>();

        /**
         * Adding 1000 records
         */
        for(Integer i = 0; i < 1000; i++){
            testContacts.add(new Contact(LastName = 'Test name' + i, AccountId = testAccounts[0].Id, Active__c=true));   
        }

        testContacts.add(new Contact(LastName = 'Test name Inactive 1', AccountId = testAccounts[0].Id));
        testContacts.add(new Contact(LastName = 'Test name Inactive 2', AccountId = testAccounts[0].Id));
        testContacts.add(new Contact(LastName = 'Test name Inactive 3', AccountId = testAccounts[1].Id));

        insert testContacts;

        List<Account> accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts){
            if(acc.Name == 'Test 1'){
                System.assertEquals(1000, acc.Active_Contacts__c);
                System.assertNotEquals(2, acc.Active_Contacts__c);
            }

            if(acc.Name == 'Test 2'){
                System.assertEquals(null, acc.Active_Contacts__c);
            }
        }
    }

    @isTest
    /**
     * Testing Update handler with by creating the active and inactive contacts (for the accounts "Test 1" and "Test 2")
     */
    public static void afterUpdateHandlerTest1(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        Contact contactTest1 = new Contact(LastName='Yrol', AccountId=testAccounts[0].Id);
        Contact contactTest2 = new Contact(LastName='Damian', AccountId=testAccounts[1].Id);
        Contact contactTest3 = new Contact(LastName='Saman', AccountId=testAccounts[1].Id);
        Contact contactTest4 = new Contact(LastName='Joel', AccountId=testAccounts[0].Id);
        Contact contactTest5 = new Contact(LastName='Nigel', AccountId=testAccounts[0].Id);

        List<Contact> testContacts = new List<Contact>{contactTest1, contactTest2, contactTest3, contactTest4, contactTest5};
        insert testContacts;

        System.assertEquals(5, testContacts.size());

        List<Contact> allContacts = [SELECT Id, LastName FROM Contact];

        for(Contact contact: allContacts) {
            if(contact.LastName == 'Yrol' || contact.LastName == 'Joel'){
                contact.Active__c = true;
            }

            //Switching and activating account IDs
            if(contact.LastName == 'Nigel') {
                contact.AccountId = testAccounts[1].Id;
                contact.Active__c = true;
            }
        }

        //Allocate new set of Governor limits
        Test.startTest();
        update allContacts;
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];
        System.assertEquals(2, accounts.size());

        for(Account acc: accounts) {
            if(acc.Name == 'Test 1'){
                System.assertEquals(2, acc.Active_Contacts__c);
            }

            if(acc.Name == 'Test 2'){
                System.assertEquals(1, acc.Active_Contacts__c);
            }
        }
    }

    @isTest
    /**
     * Testing Update handler with switching the accounts scenario for each contact
     */
    public static void afterUpdateHandlerTest2(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        Contact contactTest1 = new Contact(LastName='Yrol', AccountId=testAccounts[0].Id);
        Contact contactTest2 = new Contact(LastName='Damian', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest3 = new Contact(LastName='Saman', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest4 = new Contact(LastName='Joel', AccountId=testAccounts[0].Id);
        Contact contactTest5 = new Contact(LastName='Nigel', AccountId=testAccounts[0].Id);

        List<Contact> testContacts = new List<Contact>{contactTest1, contactTest2, contactTest3, contactTest4, contactTest5};
        insert testContacts;

        System.assertEquals(5, testContacts.size());

        List<Account> accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts){
            if(acc.Name == 'Test 1'){
                System.assertEquals(null, acc.Active_Contacts__c);
            }

            if(acc.Name == 'Test 2'){
                System.assertEquals(2, acc.Active_Contacts__c);
            }
        }

        List<Contact> contacts = [SELECT Id, LastName FROM Contact];

        //changing the Account Id of a contact and now "Test 1" account will also associated with one contact record
        for(Contact contact: contacts){
            if(contact.LastName == 'Saman'){
                contact.AccountId=testAccounts[0].Id;
            }
        }

        update contacts;

        accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts){
            if(acc.Name == 'Test 1'){
                System.assertEquals(1, acc.Active_Contacts__c);
            }
            
            if(acc.Name == 'Test 2'){
                System.assertEquals(1, acc.Active_Contacts__c);
            }
        }
    }

    @isTest
    /**
     * Testing Update handler with switching the accounts scenario for each contact
     */
    public static void afterDeleteHandlerTest(){

        //creating sample records, adding them to a list and insert them
        Account accTest1 = new Account(Name='Test 1');
        Account accTest2 = new Account(Name='Test 2');

        List<Account> testAccounts = new List<Account>{accTest1, accTest2};
        insert testAccounts;

        Contact contactTest1 = new Contact(LastName='Yrol', AccountId=testAccounts[0].Id);
        Contact contactTest2 = new Contact(LastName='Damian', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest3 = new Contact(LastName='Saman', AccountId=testAccounts[1].Id, Active__c=true);
        Contact contactTest4 = new Contact(LastName='Joel', AccountId=testAccounts[0].Id, Active__c=true);
        Contact contactTest5 = new Contact(LastName='Nigel', AccountId=testAccounts[0].Id, Active__c=true);

        List<Contact> testContacts = new List<Contact>{contactTest1, contactTest2, contactTest3, contactTest4, contactTest5};
        insert testContacts;

        System.assertEquals(5, testContacts.size());

        List<Account> accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts){
            if(acc.Name == 'Test 1'){
                System.assertEquals(2, acc.Active_Contacts__c);
            }

            if(acc.Name == 'Test 2'){
                System.assertEquals(2, acc.Active_Contacts__c);
            }
        }

        List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE Name IN ('Damian', 'Saman', 'Joel')];

        Test.startTest();
        delete contacts;
        Test.stopTest();

        accounts = [SELECT Id, Name, Active_Contacts__c FROM Account];

        for(Account acc: accounts){
            if(acc.Name == 'Test 1'){
                System.assertEquals(1, acc.Active_Contacts__c);
            }
            
            if(acc.Name == 'Test 2'){
                System.assertEquals(0, acc.Active_Contacts__c);
            }
        }

    }
}
