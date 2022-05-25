/**
 *  Description     :  Creating collection statically, dynamically with data type as salesforce objects.                                                                                  
 *                     
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  04-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 * 
 **/
public class SObjectWithCollections {
    
    /**
     *   
     *   @description    :   This method will Create static collection with data type as salesforce objects.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    
    public static void staticSobjectsWithCollection() {
        
    	//List collections
    	
	  	//List<Account>
	  	List<Account> listOfAccount = new List<Account>();
        for (Integer i=0; i<5; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding account record to list
            listOfAccount.add(accountInfo);
        }
        System.debug(listOfAccount);
	  	
        //List<List<Contact>>
        List<List<Contact>> nestedListOfContact = new List<List<Contact>>();
        for (Integer j=0; j<5; j++) {
	        List<Contact> listOfContact = new List<Contact>();
            for (Integer i=0; i<5; i++) {
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
            	//adding account record to list
            	listOfContact.add(contactInfo);
        	}
            nestedListOfContact.add(listOfContact);
        }
        System.debug(nestedListOfContact);
        
        List<Contact> myList = new List<Contact>();
        myList = nestedListOfContact[2];
        System.debug(nestedListOfContact[2][2].AssistantName);
        
	  	//List<List<List<Account>>>
        List<List<List<Account>>> nestedNestedListOfAccount = new List<List<List<Account>>>();
        for (Integer i=0; i<5; i++) {
            List<List<Account>> nestedListOfAccount = new List<List<Account>>();
            for (Integer j=0; j<5; j++) {
                List<Account> newListOfAccount = new List<Account>();
        		for (Integer k=0; k<5; k++) {
            		//Create instance of account
            		Account accountInfo = new Account();
            		//add data to instance 
            		accountInfo.Name = 'Test ' + i;
            		accountInfo.AccountSource = 'Web';
            		//adding account record to list
            		newListOfAccount.add(accountInfo);
                }
           		nestedListOfAccount.add(newListOfAccount);
            }
            nestedNestedListOfAccount.add(nestedListOfAccount);
        }
        //System.debug(nestedNestedListOfAccount);
        
    	//Map collections
    	
	  	//Map<String, Account>
	  	Map<String, Account> mapOfAccount = new Map<String, Account>();
        for (Integer i=0; i<5; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding string and account record to map
            mapOfAccount.put(('Account ' + i), accountInfo);
        }
        //System.debug(mapOfAccount);
        
        //Map<Account, Account>
        Map<Account, Account> mapOfAccountOne = new Map<Account, Account>();
        for (Integer i=0; i<5; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding account, account record to map
            mapOfAccountOne.put(accountInfo, accountInfo);
        }
        System.debug(mapOfAccountOne);
        
	  	//Map<Account, Contact>
        Map<Account, Contact> mapOfAccountTwo = new Map<Account, Contact>();
        for (Integer i=0; i<5; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //Create instance of contact
            Contact contactInfo = new Contact();
            //add data to instance 
            contactInfo.AssistantName = 'Test ' + i;
            contactInfo.Email = 'Web';
            //adding account, conatct record to map
            mapOfAccountTwo.put(accountInfo, contactInfo);
        }
        System.debug(mapOfAccountTwo);
        Integer counter = 1;
        for (Account acct: mapOfAccountTwo.keyset()){
            if (counter == 3) {
            	System.debug(mapOfAccountTwo.get(acct).Email);
            }
            counter = counter + 1;
        }
        String tempVar = mapOfAccountTwo.values()[2].Email;
        System.debug(tempVar);
        
	  	//Map<String, List<Account>>
	  	Map<String, List<Account>> mapOfAccountThree = new Map<String, List<Account>>();
        for (Integer i=0; i<5; i++) {
            List <Account> listOfAccountOne = new List<Account>();
            for (Integer j=0; j<5; j++) {
                //Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
                listOfAccountOne.add(accountInfo);
            }
            //adding string and account record list to map
            mapOfAccountThree.put(('Account ' + i), listOfAccountOne);
        }
        mapOfAccountThree.get('Account 2').get(2).Name = 'Test';
        System.debug(mapOfAccountThree.get('Account 2').get(2));
	  	
	  	//Map<String, Set<Contact>>
	  	Map<String, Set<Contact>> mapOfStringAndContact = new Map<String, Set<Contact>>();
        for (Integer i=0; i<5; i++) {
            Set<Contact> setOfContact = new Set<Contact>();
            for (Integer j=0; j<5; j++) {
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
                setOfContact.add(contactInfo);
            }
            //adding string and contact record list to map
            mapOfStringAndContact.put(('Contact ' + i), setOfContact);
        }
        System.debug(mapOfStringAndContact);
        
	  	//Map<String, Map<Account, Contact>>
	  	Map<String, Map<Account, Contact>> mapOfOneLevelNesting = new Map<String, Map<Account, Contact>>();
        for (Integer i=0; i<5; i++) {
            Map<Account, Contact> mapOfAccountAndContact = new Map<Account, Contact>(); 
            for (Integer j=0; j<5; j++) {
            	//Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
            	//adding account, conatct record to map
            	mapOfAccountAndContact.put(accountInfo, contactInfo);
            }
            //adding string and map to map
            mapOfOneLevelNesting.put(('Map ' + i), mapOfAccountAndContact);
        }
        System.debug(mapOfOneLevelNesting);
        Map<Account, Contact> newMap = new Map<Account, Contact>();
        Account acct1 = new Account();
        acct1.Name = 'NehaTestAcct';
        acct1.AccountSource = 'Web';
        Contact contact1 = new Contact();
        contact1.AssistantName = 'Neha';
        contact1.Email = 'Web';
        newMap.put(acct1, contact1);
        mapOfOneLevelNesting.put('Neha', new Map<Account, Contact>());
        //fill the map
        System.debug(mapOfOneLevelNesting.get('Neha'));
        
	  	//Map<Map<String, Account>, Map<String, Map<Account, Account>>>
	  	Map<Map<String, Account>, Map<String, Map<Account, Account>>> mapOfMaps = new Map<Map<String, Account>, Map<String, Map<Account, Account>>>();
        for (Integer i=0; i<5; i++) {
            Map<String, Account> mapOfStringAndAccount = new Map<String, Account>();
        	for (Integer j=0; j<5; j++) {
            	//Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
            	//adding string and account record to map
            	mapOfStringAndAccount.put(('Account ' + i), accountInfo);
        	}
            Map<String, Map<Account, Account>> mapOfStringAndAccounts = new Map<String, Map<Account, Account>>();
        	for (Integer j=0; j<5; j++) {            
                Map<Account, Account> mapOfAccounts = new Map<Account, Account>();
        		for (Integer k=0; k<5; k++) {
        			//Create instance of account 1
            		Account accountInfoOne = new Account();
            		//add data to instance 
            		accountInfoOne.Name = 'Test ' + i;
            		accountInfoOne.AccountSource = 'Web';
                    //Create instance of account 2
            		Account accountInfoTwo = new Account();
            		//add data to instance 
            		accountInfoTwo.Name = 'Test ' + i;
            		accountInfoTwo.AccountSource = 'Web';
                    mapOfAccounts.put(accountInfoOne, accountInfoTwo);
        		}
                mapOfStringAndAccounts.put(('Accounts ' + i), mapOfAccounts);
        	}	
            mapOfMaps.put(mapOfStringAndAccount, mapOfStringAndAccounts);
        }
        System.debug(mapOfMaps);
        
	  	//Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>> 
        Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>>> mapOfSooMAnyMaps = new Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>>>();
        
        for (Integer a=0; a<5; a++) {
            
        	Map<String, Map<String, Account>> mapOneStart = new Map<String, Map<String, Account>>();
        	for (Integer i=0; i<5; i++) {
            	Map<String, Account> mapOfStringAndAccount = new Map<String, Account>(); 
            	for (Integer j=0; j<5; j++) {
            		//Create instance of account
            		Account accountInfo = new Account();
            		//add data to instance 
            		accountInfo.Name = 'Test ' + i;
            		accountInfo.AccountSource = 'Web';
            		//adding account, conatct record to map
            		mapOfStringAndAccount.put(('Account ' + i), accountInfo);
            	}
            	//adding string and map to map
            	mapOneStart.put(('Map ' + i), mapOfStringAndAccount);
        	}
        
        	Map<String, Map<Account, Map<Account, List<Contact>>>> mapOne = new Map<String, Map<Account, Map<Account, List<Contact>>>>();
        	for (Integer i=0; i<5; i++) {
            	Map<Account, Map<Account, List<Contact>>> mapOfAccountAndMap = new Map<Account, Map<Account, List<Contact>>>();
        		for (Integer j=0; j<5; j++) {
                	//Create instance of account 1
                	Account accountInfoForMapOfAccountAndMap = new Account();
                	//add data to instance 
                	accountInfoForMapOfAccountAndMap.Name = 'Test ' + i;
                	accountInfoForMapOfAccountAndMap.AccountSource = 'Web';
                	Map<Account, List<Contact>> mapOfAccountAndListContact = new Map<Account, List<Contact>>();
            		for (Integer k=0; k<5; k++) {
                    	//Create instance of account 1
            			Account accountInfoOne = new Account();
            			//add data to instance 
            			accountInfoOne.Name = 'Test ' + i;
            			accountInfoOne.AccountSource = 'Web';
                    	List<Contact> listOfContact = new List<Contact>();
            			for (Integer l=0; l<5; l++) {
            				//Create instance of contact
            				Contact contactInfo = new Contact();
            				//add data to instance 
            				contactInfo.AssistantName = 'Test ' + i;
            				contactInfo.Email = 'Web';
            				//adding account record to list
            				listOfContact.add(contactInfo);
        				}
                    	mapOfAccountAndListContact.put(accountInfoOne, listOfContact);
        			}
                	mapOfAccountAndMap.put(accountInfoForMapOfAccountAndMap, mapOfAccountAndListContact);
        		}  
            	mapOne.put(('String ' + i), mapOfAccountAndMap);
        	}
        	mapOfSooMAnyMaps.put(mapOneStart, mapOne);
    	}
        System.debug(mapOfSooMAnyMaps);
    
    }
    
    /**
     *   
     *   @description    :   This method will Create dynamic collection with data type as salesforce objects.
     *
     *   @args           :   Integer
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    
    public static void dynamicSobjectsWithCollection(Integer noOfvalue) {
  	      
        //List collections
    	
	  	//List<Account>
	  	List<Account> listOfAccount = new List<Account>();
        for (Integer i=0; i<noOfvalue; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding account record to list
            listOfAccount.add(accountInfo);
        }
        System.debug(listOfAccount);
	  	
        //List<List<Contact>>
        List<List<Contact>> nestedListOfContact = new List<List<Contact>>();
        for (Integer j=0; j<noOfvalue; j++) {
	        List<Contact> listOfContact = new List<Contact>();
            for (Integer i=0; i<noOfvalue; i++) {
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
            	//adding account record to list
            	listOfContact.add(contactInfo);
        	}
            nestedListOfContact.add(listOfContact);
        }
        System.debug(nestedListOfContact);
        
	  	//List<List<List<Account>>>
        List<List<List<Account>>> nestedNestedListOfAccount = new List<List<List<Account>>>();
        for (Integer i=0; i<noOfvalue; i++) {
            List<List<Account>> nestedListOfAccount = new List<List<Account>>();
            for (Integer j=0; j<noOfvalue; j++) {
                List<Account> newListOfAccount = new List<Account>();
        		for (Integer k=0; k<noOfvalue; k++) {
            		//Create instance of account
            		Account accountInfo = new Account();
            		//add data to instance 
            		accountInfo.Name = 'Test ' + i;
            		accountInfo.AccountSource = 'Web';
            		//adding account record to list
            		newListOfAccount.add(accountInfo);
                }
           		nestedListOfAccount.add(newListOfAccount);
            }
            nestedNestedListOfAccount.add(nestedListOfAccount);
        }
        System.debug(nestedNestedListOfAccount);
        
    	//Map collections
    	
	  	//Map<String, Account>
	  	Map<String, Account> mapOfAccount = new Map<String, Account>();
        for (Integer i=0; i<noOfvalue; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding string and account record to map
            mapOfAccount.put(('Account ' + i), accountInfo);
        }
        System.debug(mapOfAccount);
        
        //Map<Account, Account>
        Map<Account, Account> mapOfAccountOne = new Map<Account, Account>();
        for (Integer i=0; i<noOfvalue; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //adding account, account record to map
            mapOfAccountOne.put(accountInfo, accountInfo);
        }
        System.debug(mapOfAccountOne);
        
	  	//Map<Account, Contact>
	  	Map<Account, Contact> mapOfAccountTwo = new Map<Account, Contact>();
        for (Integer i=0; i<noOfvalue; i++) {
            //Create instance of account
            Account accountInfo = new Account();
            //add data to instance 
            accountInfo.Name = 'Test ' + i;
            accountInfo.AccountSource = 'Web';
            //Create instance of contact
            Contact contactInfo = new Contact();
            //add data to instance 
            contactInfo.AssistantName = 'Test ' + i;
            contactInfo.Email = 'Web';
            //adding account, conatct record to map
            mapOfAccountTwo.put(accountInfo, contactInfo);
        }
        System.debug(mapOfAccountTwo);
        
	  	//Map<String, List<Account>>
	  	Map<String, List<Account>> mapOfAccountThree = new Map<String, List<Account>>();
        for (Integer i=0; i<noOfvalue; i++) {
            List <Account> listOfAccountOne = new List<Account>();
            for (Integer j=0; j<noOfvalue; j++) {
                //Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
                listOfAccountOne.add(accountInfo);
            }
            //adding string and account record list to map
            mapOfAccountThree.put(('Account ' + i), listOfAccountOne);
        }
        System.debug(mapOfAccountThree);
	  	
	  	//Map<String, Set<Contact>>
	  	Map<String, Set<Contact>> mapOfStringAndContact = new Map<String, Set<Contact>>();
        for (Integer i=0; i<noOfvalue; i++) {
            Set<Contact> setOfContact = new Set<Contact>();
            for (Integer j=0; j<noOfvalue; j++) {
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
                setOfContact.add(contactInfo);
            }
            //adding string and contact record list to map
            mapOfStringAndContact.put(('Contact ' + i), setOfContact);
        }
        System.debug(mapOfStringAndContact);
        
	  	//Map<String, Map<Account, Contact>>
	  	Map<String, Map<Account, Contact>> mapOfOneLevelNesting = new Map<String, Map<Account, Contact>>();
        for (Integer i=0; i<noOfvalue; i++) {
            Map<Account, Contact> mapOfAccountAndContact = new Map<Account, Contact>(); 
            for (Integer j=0; j<noOfvalue; j++) {
            	//Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
            	//Create instance of contact
            	Contact contactInfo = new Contact();
            	//add data to instance 
            	contactInfo.AssistantName = 'Test ' + i;
            	contactInfo.Email = 'Web';
            	//adding account, conatct record to map
            	mapOfAccountAndContact.put(accountInfo, contactInfo);
            }
            //adding string and map to map
            mapOfOneLevelNesting.put(('Map ' + i), mapOfAccountAndContact);
        }
        System.debug(mapOfOneLevelNesting);
        
	  	//Map<Map<String, Account>, Map<String, Map<Account, Account>>>
	  	Map<Map<String, Account>, Map<String, Map<Account, Account>>> mapOfMaps = new Map<Map<String, Account>, Map<String, Map<Account, Account>>>();
        for (Integer i=0; i<noOfvalue; i++) {
            Map<String, Account> mapOfStringAndAccount = new Map<String, Account>();
        	for (Integer j=0; j<noOfvalue; j++) {
            	//Create instance of account
            	Account accountInfo = new Account();
            	//add data to instance 
            	accountInfo.Name = 'Test ' + i;
            	accountInfo.AccountSource = 'Web';
            	//adding string and account record to map
            	mapOfStringAndAccount.put(('Account ' + i), accountInfo);
        	}
            Map<String, Map<Account, Account>> mapOfStringAndAccounts = new Map<String, Map<Account, Account>>();
        	for (Integer j=0; j<noOfvalue; j++) {            
                Map<Account, Account> mapOfAccounts = new Map<Account, Account>();
        		for (Integer k=0; k<noOfvalue; k++) {
        			//Create instance of account 1
            		Account accountInfoOne = new Account();
            		//add data to instance 
            		accountInfoOne.Name = 'Test ' + i;
            		accountInfoOne.AccountSource = 'Web';
                    //Create instance of account 2
            		Account accountInfoTwo = new Account();
            		//add data to instance 
            		accountInfoTwo.Name = 'Test ' + i;
            		accountInfoTwo.AccountSource = 'Web';
                    mapOfAccounts.put(accountInfoOne, accountInfoTwo);
        		}
                mapOfStringAndAccounts.put(('Accounts ' + i), mapOfAccounts);
        	}	
            mapOfMaps.put(mapOfStringAndAccount, mapOfStringAndAccounts);
        }
        System.debug(mapOfMaps);
        
	  	//Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>> 
        Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>>> mapOfSooMAnyMaps = new Map<Map<String, Map<String,Account>>, Map<String, Map<Account, Map<Account, List<Contact>>>>>();
        
        for (Integer a=0; a<noOfvalue; a++) {
            
        	Map<String, Map<String, Account>> mapOneStart = new Map<String, Map<String, Account>>();
        	for (Integer i=0; i<noOfvalue; i++) {
            	Map<String, Account> mapOfStringAndAccount = new Map<String, Account>(); 
            	for (Integer j=0; j<noOfvalue; j++) {
            		//Create instance of account
            		Account accountInfo = new Account();
            		//add data to instance 
            		accountInfo.Name = 'Test ' + i;
            		accountInfo.AccountSource = 'Web';
            		//adding account, conatct record to map
            		mapOfStringAndAccount.put(('Account ' + i), accountInfo);
            	}
            	//adding string and map to map
            	mapOneStart.put(('Map ' + i), mapOfStringAndAccount);
        	}
        
        	Map<String, Map<Account, Map<Account, List<Contact>>>> mapOne = new Map<String, Map<Account, Map<Account, List<Contact>>>>();
        	for (Integer i=0; i<noOfvalue; i++) {
            	Map<Account, Map<Account, List<Contact>>> mapOfAccountAndMap = new Map<Account, Map<Account, List<Contact>>>();
        		for (Integer j=0; j<noOfvalue; j++) {
                	//Create instance of account 1
                	Account accountInfoForMapOfAccountAndMap = new Account();
                	//add data to instance 
                	accountInfoForMapOfAccountAndMap.Name = 'Test ' + i;
                	accountInfoForMapOfAccountAndMap.AccountSource = 'Web';
                	Map<Account, List<Contact>> mapOfAccountAndListContact = new Map<Account, List<Contact>>();
            		for (Integer k=0; k<noOfvalue; k++) {
                    	//Create instance of account 1
            			Account accountInfoOne = new Account();
            			//add data to instance 
            			accountInfoOne.Name = 'Test ' + i;
            			accountInfoOne.AccountSource = 'Web';
                    	List<Contact> listOfContact = new List<Contact>();
            			for (Integer l=0; l<noOfvalue; l++) {
            				//Create instance of contact
            				Contact contactInfo = new Contact();
            				//add data to instance 
            				contactInfo.AssistantName = 'Test ' + i;
            				contactInfo.Email = 'Web';
            				//adding account record to list
            				listOfContact.add(contactInfo);
        				}
                    	mapOfAccountAndListContact.put(accountInfoOne, listOfContact);
        			}
                	mapOfAccountAndMap.put(accountInfoForMapOfAccountAndMap, mapOfAccountAndListContact);
        		}  
            	mapOne.put(('String ' + i), mapOfAccountAndMap);
        	}
        	mapOfSooMAnyMaps.put(mapOneStart, mapOne);
    	}
        System.debug(mapOfSooMAnyMaps);
        
    }
    
    public static void newFunc() {
        Map<String, String> newMap = new Map<String, String>{'a' => 'a'};
        Map<String, String> newMap1 = newMap.clone();
        System.debug(newMap1);                     
    } 

}