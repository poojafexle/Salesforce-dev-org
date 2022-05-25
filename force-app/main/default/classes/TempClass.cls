/**
*  Description     :  SOQL QUERY class
*
*  Created By      :  Sakshi Toshniwal
*
*  Created Date    :  10-02-2022
*
*  Revision Logs   :  V1.0 - Created - Sakshi Toshniwal
*				       
*
**/
public without sharing class TempClass {
    
    /**
     * 
     *   @description    :  Perform diffrent SOQL queries
     *
     *   @args           :  none  
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 10-02-2022 Developer Name: Sakshi Toshniwal
     *					     
 	 **/ 
    public static void normalSOQL() {

        List<Account> listofAccount= new List<Account>();
        //Fetch data from Account 
		listofAccount = [Select ID, Name,Active__c,OwnerId, Website From Account Where ((NOT(Name LIKE '%Fexle%')) OR Name !='Test') AND Website != null LIMIT 10 ]; 
		//Fetch all related contact from Fetched account details
        for(Account a:listofAccount){
            List<Contact> con=[Select Account.Id,LastName From contact Where AccountId=:a.id];
            for(Contact c:con){
                if(con.size()>0){
                System.debug('AccountName '+'__'+a.Name+'RelatedContacts '+'__ '+c.LastName+'__'+c.Account.Id);
            }
        }
    } // Update Account_Website__c of Contact with Account's Website field 
        List<Contact> listofContact= new List<Contact>();
        for(Account acct : listofAccount){
            List<Contact> con=[Select ID,Account_Website__c From contact where AccountId=:acct.ID ];
       	    // System.debug(con);
            for(Contact c : con){
            	listofContact.add(new Contact(Account_Website__c= acct.Website,ID =c.ID));
               
            } 
        }
        if(listofContact.size()>0){
           update listofContact; 
          //System.debug(listofContact);
       }
    }
}