public class Testing {

    public static void tempMethod(String State) {
    	Map<String, String> mapOfStates = new Map<String, String>();
		mapOfStates.put('rajasthan', 'jaipur');
		mapOfStates.put('gujrat', 'ahemdabad');
		mapOfStates.put('maharastra', 'mumbai');
        System.debug(mapOfStates.get(State));        
    }
}