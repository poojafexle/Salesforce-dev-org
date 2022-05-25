/**
 *  Description     :  Create a map.
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  15-02-2022
 *
 *  Revision Logs   :  V1.1 - Created - 15-02-2022 - Pooja Hemrajani
 *
 **/
public class CollectionAssignmentByMentee {
    /**
     *   
     *   @description    :   Collections with sObjects using SOQL.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 15-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void collectionFunc() {
        Map<Map<String, Map<String,Account>>,Map<String,Map<Account,Map<Account,List<Contact>>>>> grandNestedMap = new Map<Map<String, Map<String,Account>>,Map<String,Map<Account,Map<Account,List<Contact>>>>>();
    	Account acc = [Select Id, Name, (Select Id, FirstName, LastName From Contacts) From Account Limit 1];
        
        //Key of map
        Map<String, Map<String,Account>> grandNestedMapKey = new Map<String, Map<String,Account>>();
        Map<String,Account> grandNestedMapKeyValue = new Map<String,Account>();
        grandNestedMapKeyValue.put(acc.Name, acc);
        grandNestedMapKey.put(acc.Name, grandNestedMapKeyValue);
        
        //Value of map
        Map<String,Map<Account,Map<Account,List<Contact>>>> grandNestedMapValue = new Map<String,Map<Account,Map<Account,List<Contact>>>>();
        Map<Account,Map<Account,List<Contact>>> grandNestedMapValueValue = new Map<Account,Map<Account,List<Contact>>>();
        Map<Account,List<Contact>> grandNestedMapValueValueValue = new Map<Account,List<Contact>>();
        List<Contact> listOfContacts = new List<Contact>();
        for (Contact con: acc.Contacts) {
            listOfContacts.add(con);
        }
        grandNestedMapValueValueValue.put(acc, listOfContacts);
        grandNestedMapValueValue.put(acc, grandNestedMapValueValueValue);
        grandNestedMapValue.put(acc.Name, grandNestedMapValueValue);
        
        //Filling top level map
        grandNestedMap.put(grandNestedMapKey, grandNestedMapValue);
        
        System.debug(grandNestedMap);
    }
}