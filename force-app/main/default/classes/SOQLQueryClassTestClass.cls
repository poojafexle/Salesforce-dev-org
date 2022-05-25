/**
*  Description     :  Test Class
*
*  Created By      :  Pooja Hemrajani
*
*  Created Date    :  21-02-2022
*
*  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
*				       
*
**/
@isTest
private without sharing class SOQLQueryClassTestClass {
   /**
    * 
    *   @description    : Test Class function
    *
    *   @args           : None 
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 21-02-2022 Developer Name: Pooja Hemrajani
    *					     
    **/ 
    @testSetup static void makeData(){
        List<Account> listOfAccount = new List<Account>();
        for(Integer i=0; i<3; i++) {
            listOfAccount.add(new Account(Name = 'user'+i, Website = i+'user.com'));   
        }
        listOfAccount.add(new Account(Name = 'user')); 
        insert listOfAccount;
        
        List<Contact> listofContact= new List<Contact>();
        for(Account acc: listOfAccount) {
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'test', LastName = 'test', Email = 'test@gmail.com', Status__c = 'Active'));
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'test', LastName = 'test', Email = 'test@gmail.com', Status__c = 'In-Active'));
            listofContact.add(new Contact(AccountID = acc.ID,FirstName = 'test', LastName = 'test', Email = 'test@gmail.com'));
        }
		insert listofContact;
        
    }
    @isTest static void normalSOQLTest(){
        Test.startTest();
        SOQLQueryClass.normalSOQL();
        //listofAccount = [Select ID, Name,Active__c,OwnerId, Website From Account Where ((NOT(Name LIKE '%Fexle%')) OR Name !='Test') AND Website != null];
        Contact[] con=[Select AccountID, Account.Website, LastName, Account_Website__c From Contact Where ((NOT(Account.Name LIKE '%Fexle%')) OR Account.Name !='Test') AND Account.Website != null];
        System.assertEquals(con[0].Account.Website, con[0].Account_Website__c);
        //for (Contact conn: con){
            //System.assertEquals(conn.Account.Website, strWebsite);
        //}
        Test.stopTest();
    }
    
    @isTest static void inlineSOQLFunctionTest(){
        List<Id> listOfIds = new List<Id>();
        Account[] accounts = [Select Id, Name,Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account];
        for(Account acct: accounts) {
            listOfIds.add(acct.Id);
        }
        Test.startTest();
        SOQLQueryClass.inlineSOQLFunction(listOfIds);
        Account[] acc = [Select Id, Name,Contact_Details__c, (Select Id, FirstName, LastName, Email From Contacts) From Account];
        
        for (Account acct: acc) {
            String str = '';
        	if (acct.Contacts.size() > 0) {
            	for (Contact con: acct.Contacts) {
                	str += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
                	//acct.Contact_Details__c += 'FirstName = ' +con.FirstName + ', LastName = ' +con.LastName + ', Email = ' +con.Email + '\n';
            	}
        	}
            System.assertEquals(str.trim(), acct.Contact_Details__c.trim());
        }
        Test.stopTest();
    }
    
    
    @isTest static void aggregateSOQLTest(){
        Test.startTest();
        SOQLQueryClass.aggregateSOQL();
        
        Account[] listOfAccounts = [Select Id From Account];
        
        for(AggregateResult aR: [SELECT COUNT(Id) totalCount,COUNT(Account.Total_Active_Contacts__c) totalActive, COUNT(Account.Total_In_Active_Contacts__c) totalInActive, Status__c conStatus, AccountId FROM Contact WHERE AccountId IN : listOfAccounts GROUP BY AccountId, Status__c]){
         		                 
            Id accId = (Id) aR.get('AccountId');
            String contactStatus = String.valueof(aR.get('conStatus'));
            Integer conCount = Integer.valueof(aR.get('totalCount'));
            Integer totalActive = Integer.valueof(aR.get('totalActive'));
            Integer totalInActive = Integer.valueof(aR.get('totalInActive'));
                
            if(contactStatus == 'Active'){
                System.assertEquals(totalActive, conCount);
            }
            
            if(contactStatus == 'In-Active'){
                System.assertEquals(totalInActive, conCount);
            }
                
        }
        Test.stopTest();        
    }
}