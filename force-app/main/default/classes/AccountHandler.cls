public class AccountHandler {
    public static Account insertNewAccount(String AccountName) {
        try {
    		// This causes an exception because 
    		//   the required Name field is not provided.
    		Account acct = new Account(Name=AccountName);
    		// Insert the account 
    		insert acct;
            return acct;
		} catch (DmlException e) {
    		System.debug('A DML exception has occurred: ' + e.getMessage());
            return NULL;
		}
    }
}