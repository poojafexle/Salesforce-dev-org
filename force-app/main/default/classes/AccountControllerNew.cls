public with sharing class AccountControllerNew {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name,Rating,Phone  FROM Account];
    }
    
}