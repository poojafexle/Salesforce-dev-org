/**
*  Description     :  This class have two methods that will do the SUM of both the static variables and hold the value in the 3rd static                                                                                  
*                     variable.
*
*  Created By      :  Pooja Hemrajani
*
*  Created Date    :  28-01-2022
*
*  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
*
**/

public class MyFirstApexClass {

    //Initializing static variables
    public static Decimal variableOne = 12.34;
    public static Decimal variableTwo = 12.34;
    public static Decimal variableThree;
    
    /**
    *   
    *   @description    :   This method will do the SUM of both the static variables and hold the value in the 3rd
    *                       static variable.
    *
    *   @args           :   
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 28-01-2022 - Pooja Hemrajani
    * 
    **/
    
    public static void sumOfVariables() {
        //Addition of static variables
        variableThree = variableOne + variableTwo;
    	System.debug('Sum = ' + variableThree);
    }
    
    /**
    *   
    *   @description    :   This method will do the operation on both the input args based on input operator in args and hold the value in 
    *                       the static variable.
    *
    *   @args           :   Decimal, Decimal, String
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.0 - Created  - 28-01-2022 - Pooja Hemrajani
    * 
    **/
    
    public static void sumOfVariablesWithArgs(Decimal varOne, Decimal varTwo, String operator) {
    
        
    	if(String.isNotBlank(operator) && (varOne != NULL || varTwo != NULL)) {
        	//Chck conditions according to the operator
        	if (operator == '+') {
                variableThree = (varOne != NULL && varTwo != NULL ? (varOne + varTwo) : (varOne != NULL ? varOne : varTwo));
                System.debug('Sum = ' + variableThree);
        	}
        	else if (operator == '-') {
                variableThree = (varOne != NULL && varTwo != NULL ? (varOne - varTwo) : (varOne != NULL ? varOne : varTwo));
                System.debug('Difference = ' + variableThree);
        	}
        	else if (operator == '*') {
                variableThree = (varOne != NULL && varTwo != NULL ? (varOne * varTwo) : (varOne != NULL ? varOne : varTwo));
                System.debug('Multiplication = ' + variableThree);
        	}
        	else if (operator == '/') {
        		if (varOne != NULL && varTwo != NULL) {
        			variableThree = varOne / varTwo;
                }
                else if (varOne != NULL && varTwo == NULL) {
        			variableThree = varOne;
                }
                else if (varOne == NULL && varTwo != NULL) {
        			variableThree = varTwo;
                }
                System.debug('Division = ' + variableThree);
        	}
        } else {
            if (varOne == NULL && varTwo == NULL) {
                System.debug('Both variables can not be null');
            }
            else {
            	System.debug('Operator is not passed or may be null');
            }
		}
    }
    
}