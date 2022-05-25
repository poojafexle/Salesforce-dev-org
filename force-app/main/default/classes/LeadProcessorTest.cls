@isTest
private class LeadProcessorTest {
	@testSetup static void setup() {
        List<Lead> listOfLeads = new List<Lead>();
        // insert 200 accounts
        for (Integer i=0;i<200;i++) {
            listOfLeads.add(new Lead(FirstName = 'Tester', LastName = 'lastname'+i , Company = 'Tester'+i+'Company'));
        }
        insert listOfLeads;
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}