@isTest
private class TestRestrictContactByName {
    @testSetup static void Data() {}
    @isTest static void RestrictContactByName() {
        Test.startTest();
        try{
            List<Contact> listOfContact = new List<Contact>();
            listOfContact.add(new Contact(LastName = 'INVALIDNAME'));
        	listOfContact.add(new Contact(LastName = 'INVALIDNAME2'));
        	insert listOfContact;
    	}
        catch(Exception e) {

            System.Assert(e.getMessage().contains('The Last Name "'+'INVALIDNAME'+'" is not allowed for DML'));

        }
        Test.stopTest();
    }
}