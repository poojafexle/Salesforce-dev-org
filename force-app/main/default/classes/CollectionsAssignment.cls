/**
 *  Description     :  Assign values to various collections in static and dynamic ways.                                                                                  
 *                     
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  31-01-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 * 
 **/
public class CollectionsAssignment {
    
    /**
     *   
     *   @description    :   This method will populate static values using predefined methods and with .add() method.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 31-01-2022 - Pooja Hemrajani
     * 
     **/
    public static void staticValuePopulation() {
        
        //Initializing List, Set, Map with values
        List<String> listStrings = new List<String>{'a', 'b', 'c', 'd', 'e'};
		Set<String> setStrings = new Set<String>{'a', 'b', 'c', 'd', 'e'};
		Map<String, String> mapStrings = new Map<String, String>{'a' => 'apple', 'b' => 'boy', 'c' => 'cat', 'd' => 'dog', 'e' => 'egg'};
            
        //Debugging List, Set, Map
        System.debug(listStrings);
        System.debug(setStrings);
        System.debug(mapStrings);
        
        //Initializing List and adding values to it using .add() method
        List<String> listStringsWithAddMethod = new List<String>();
        listStringsWithAddMethod.add('f');
        listStringsWithAddMethod.add('g');
        listStringsWithAddMethod.add('h');
        listStringsWithAddMethod.add('i');
        listStringsWithAddMethod.add('j');
        
        //Initializing Set and adding values to it using .add() method
		Set<String> setStringsWithAddMethod = new Set<String>();
        setStringsWithAddMethod.add('f');
        setStringsWithAddMethod.add('g');
        setStringsWithAddMethod.add('h');
        setStringsWithAddMethod.add('i');
        setStringsWithAddMethod.add('j');
        
        //Initializing Map and adding values to it using .add() method
		Map<String, String> mapStringsWithAddMethod = new Map<String, String>();
        mapStringsWithAddMethod.put('f', 'fan');
        mapStringsWithAddMethod.put('g', 'girl');
        mapStringsWithAddMethod.put('h', 'hen');
        mapStringsWithAddMethod.put('i', 'ink');
        mapStringsWithAddMethod.put('j', 'joker');
        
        //Debugging List, Set, Map
        System.debug(listStringsWithAddMethod);
        System.debug(setStringsWithAddMethod);
        System.debug(mapStringsWithAddMethod);
    }
    
    /**
     *   
     *   @description    :   This method will populate over dynamic values.
     *
     *   @args           :   List<String>, Integer.
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 31-01-2022 - Pooja Hemrajani
     * 
     **/
    public static void dynamicValuesPopulation (List<String> collectionTypes, Integer totalValues) {
        
        //Check if collection is blank
        if (collectionTypes.size() > 0) {
            
            //Check if value is not null or negative
            if (totalValues >= 0) {
                //Looping over collections we need to create
        		for (Integer i=0;i<collectionTypes.size();i++) {

            		//Checking collection is of type List
            		if (collectionTypes[i].capitalize() == 'List') {
                		//Initializing List
                		List<String> listStringsNew = new List<String>();
                		for (Integer j=1;j<=totalValues;j++) {
                    		//Inserting values to list
                    		listStringsNew.add(String.valueOf(j));
                		}
                		//Debugging List
                		System.debug(listStringsNew);
            		}

            		//Checking collection is of type Set
            		else if (collectionTypes[i].capitalize() == 'Set') {
                		//Initializing Set
                		Set<String> setStringsNew = new Set<String>();
                		for (Integer j=1;j<=totalValues;j++) {
                    		//Inserting values to set
                    		setStringsNew.add(String.valueOf(j));
                		}
                		//Debugging Set
                		System.debug(setStringsNew);
            		}

            		//Checking collection is of type Map
            		else if (collectionTypes[i].capitalize() == 'Map') {
                		//Initializing Map
                		Map<String, String> mapStringsNew = new Map<String, String>();
                		for (Integer j=1;j<=totalValues;j++) {
                    		//Inserting values to map
                    		mapStringsNew.put(String.valueOf(j), String.valueOf(j+10));
                		}
                		//Debugging Map
                		System.debug(mapStringsNew);
            		}

            		//Checking invalid collection type
            		else {
                		System.debug('Invalid Collection type ' + collectionTypes[i]);
            		}
        		}
            }
            //Through message if value is null or negative
            else {
                System.debug('Provide correct integer value. Value should not be null or less than 0');
            }
            
        }
        //Through message if collection is blank
        else {
            System.debug('CollectionType is blank or null');
        }

    }

}