/**
 *  Description     :  Fetching contacts, opportunities, cases data related to account. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  26-04-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class dataController {
    
    /**
     *   
     *   @description    :   Fetching Contacts.
     *
     *   @args           :   none
     *
     *   @return         :   List<Contact>
     *
     *   @revision Log   :   V1.0 - Created  - 26-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [
            SELECT Id, Name
            FROM Contact
            WHERE AccountId = '0015j00000WV12iAAD'
            LIMIT 10
        ];
    }
    
    /**
     *   
     *   @description    :   Fetching Opportunities.
     *
     *   @args           :   none
     *
     *   @return         :   List<Opportunity>
     *
     *   @revision Log   :   V1.0 - Created  - 26-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunityList() {
        return [
            SELECT Id, Name
            FROM Opportunity
            WHERE AccountId = '0015j00000WV12iAAD'
            LIMIT 10
        ];
    }
    
	/**
     *   
     *   @description    :   Fetching Cases.
     *
     *   @args           :   none
     *
     *   @return         :   List<Case>
     *
     *   @revision Log   :   V1.0 - Created  - 26-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesList() {
        return [
            SELECT Id, CaseNumber
            FROM Case
            WHERE AccountId = '0015j00000WV12iAAD'
            LIMIT 10
        ];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList1(){
        return [SELECT Id, AccountId, Name, Email, Phone, Title, Department, Birthdate, PhotoUrl FROM Contact];
    }
    
}