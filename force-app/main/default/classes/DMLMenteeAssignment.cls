/**
 *  Description     :  Starting with DML operations.                                                                                  
 *                     
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  09-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 * 
 **/
public class DMLMenteeAssignment {

       /**
     	*   
     	*   @description    :   This method will insert data into database using insert of DML.
     	*
     	*   @args           :   none
     	*
     	*   @return         :   void
     	*
     	*   @revision Log   :   V1.0 - Created  - 09-02-2022 - Pooja Hemrajani
     	* 
     	**/
	    public static void firstDMLMethod() {
            //Creating account instance and adding one record to account
            Account acct1 = new Account(Name = 'New Tester', AccountSource = 'Web');
            insert acct1;
            
            //Creating list of opportunities
            List<Opportunity> listOfOpportunity = new List<Opportunity>();
            
            //Creating opportunity instance and adding fives opportunity record to above inserted record of account
            Opportunity oppr1 = new Opportunity(Name = 'Opportunity1', StageName = 'Qualification', CloseDate = Date.today().addDays(1), AccountId=acct1.Id);
            Opportunity oppr2 = new Opportunity(Name = 'Opportunity2', StageName = 'Qualification', CloseDate = Date.today().addDays(2), AccountId=acct1.Id);
            Opportunity oppr3 = new Opportunity(Name = 'Opportunity3', StageName = 'Qualification', CloseDate = Date.today().addDays(3), AccountId=acct1.Id);
            Opportunity oppr4 = new Opportunity(Name = 'Opportunity4', StageName = 'Qualification', CloseDate = Date.today().addDays(4), AccountId=acct1.Id);
            Opportunity oppr5 = new Opportunity(Name = 'Opportunity5', StageName = 'Qualification', CloseDate = Date.today().addDays(5), AccountId=acct1.Id);
            List<Opportunity> listOfOpportunityInstances = new List<Opportunity>{oppr1, oppr2, oppr3, oppr4, oppr5};
            for (Integer i=0; i<5; i++) {
           		listOfOpportunity.add(listOfOpportunityInstances[i]);
            }
            insert listOfOpportunity;
            
            //Creating list of student
            List<Student__c> listOfStudents = new List<Student__c>();
            
            //Adding two student record all five opportunity records of New Tester account
            for (Integer j=0; j<5; j++) {
                for (Integer i=0; i<2; i++) {
	                Student__c stu = new Student__c(Name = ('Tester Student' + i), OpportunityId__c=listOfOpportunityInstances[j].Id);
                    listOfStudents.add(stu);
                }
            }
            insert listOfStudents;
        }
    	
    
}