public class ListMethods {

    public static void listFunction() {
        //Create a list and Add two integers to the list using add() method
		List<Integer> myList = new List<Integer>();
		myList.add(1);
		myList.add(2);
        System.debug(myList);
        
        //Delete all elements of list using clear() method
        List<String> myListOne = new List<String>{'a','b'};
        System.debug(myListOne);
        myListOne.clear();
        System.debug(myListOne);
       
        //Copy elements from one list to another
        List<Integer> myListTwo = new List<Integer>(myList);
		System.debug(myListTwo);// DEBUG|(1, 2)
        
        //Create a list and Add elements to the list on an index using add() method
        List<Integer> myListThree = new List<Integer>{2,1,2,3};
		myListThree.add(2,5);
        System.debug(myListThree);
        
        //contains(listElement)
        System.debug(myListThree.contains(5));
        System.debug(myListThree.contains(7));
        
        //equals(list2)
        System.debug(myListThree.equals(myListTwo));
        
        //hashCode()
        System.debug(myListThree.hashCode());
        
        //indexOf(listElement)
        List<String> myStrings = new List<String>{'a', 'b', 'a'};
		Integer result = myStrings.indexOf('a');
		System.debug(result);
        
        //iterator()
        System.debug(myListThree.iterator());
        
        //isEmpty()
        System.debug(myListThree.isEmpty());
        
        //remove(index)
        System.debug(myStrings.remove(0));
        System.debug(myStrings);
        
        //set(index, listElement)
        List<Integer> myListNew = new Integer[6];
		myListNew.set(0, 47);
		myListNew.set(1, 52);
        System.debug(myListNew);
        
		//size()
        System.debug(myStrings.size());
        
		//sort()
		List<Integer> q1 = new Integer[3];
		q1[0] = 10;
		q1[1] = 5;
		q1.sort();
        q1[0] = 8;
        System.debug(q1);
        
		//toString()
        System.debug(q1.toString());
    }
    
}