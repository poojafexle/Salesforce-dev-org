public class SetMethods {

    public static void setFunction() {
        //Create a Set and Add two integers to the Set using add() method
		Set<Integer> mySet = new Set<Integer>();
		mySet.add(1);
		mySet.add(2);
        System.debug(mySet);
        
        //Delete all elements of Set using clear() method
        Set<String> mySetOne = new Set<String>{'a','b'};
        System.debug(mySetOne);
        mySetOne.clear();
        System.debug(mySetOne);
       
        //Copy elements from one Set to another
        Set<Integer> mySetTwo = new Set<Integer>(mySet);
		System.debug(mySetTwo);// DEBUG|(1, 2)
        
        //Create a Set and Add elements to the Set on an index using add() method
        Set<Integer> mySetThree = new Set<Integer>{2,1,3};
		mySetThree.add(5);
        System.debug(mySetThree);
        
        //contains(SetElement)
        System.debug(mySetThree.contains(5));
        System.debug(mySetThree.contains(7));
        
        //equals(Set2)
        System.debug(mySetThree.equals(mySetTwo));
        
        //hashCode()
        System.debug(mySetThree.hashCode());
        
        Set<String> myStrings = new Set<String>{'a', 'b'};
        //iterator()
        System.debug(mySetThree.iterator());
        
        //isEmpty()
        System.debug(mySetThree.isEmpty());
        
        //remove(index)
        System.debug(myStrings.remove('a'));
        System.debug(myStrings);
        
		//size()
        System.debug(myStrings.size());
        
		//toString()
		Set<Integer> q1 = new Set<Integer>{1, 2};
        System.debug(q1.toString());
    }
    
}