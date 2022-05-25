public class MapMethods {

    public static void mapFunction() {
        
        //Add items in map
        Map<Integer, String> map1 = new Map<Integer, String>();
		map1.put(1, 'First item');
		map1.put(2, 'Second item');
        System.debug(map1);

		// The map elements of m2 are copied from m1        
        Map<Integer, String> map2 = new Map<Integer, String>(map1);
		System.debug(map2);
        
        //Delete all elements from map
        map1.clear();
        System.debug(map1);
        
		//Clone from another map
		Map<Integer, String> map3 = new Map<Integer, String>();
		map3 = map2.clone();
		System.debug(map3);

        //Check if map has a certain key use .containsKey(key)
        System.debug(map3.containsKey(2));
        
        //Check if maps are equal use .equals(map2)
        System.debug(map3.equals(map2));
        
        //To get value of key use .get(key)
        System.debug(map3.get(2));
        
        //To remove a key value pair use .remove(key)
        map3.remove(2);
        System.debug(map3);
        
        //To get all the values of map use .values()
        map3.put(2, 'Second item');
        map3.put(3, 'Third item');
        map3.put(4, 'Fourth item');
        map3.put(5, 'Fifth item');
        System.debug(map3);
    	
        //To get size of map use .size()
        System.debug(map3.size());
        
        //Returns the string representation of the map. toString()
        System.debug(map3.toString());
        
        //Returns hashCode of the map. hashCode()
        System.debug(map3.hashCode());
    }
    
}