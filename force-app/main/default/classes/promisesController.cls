/**
 *  Description     :  Various methods for testing async apex. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  25-04-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class promisesController {

    /**
     *   
     *   @description    :   call method 1.
     *
     *   @args           :   none
     *
     *   @return         :   string
     *
     *   @revision Log   :   V1.0 - Created  - 25-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled
    public static string getMethod1(){
        return 'METHOD-1';
    }
 
    /**
     *   
     *   @description    :   Call method 2.
     *
     *   @args           :   none
     *
     *   @return         :   String
     *
     *   @revision Log   :   V1.0 - Created  - 25-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled
    public static string getMethod2(){
        return 'METHOD-2';
    }
 
    /**
     *   
     *   @description    :   Call method 3.
     *
     *   @args           :   none
     *
     *   @return         :   String
     *
     *   @revision Log   :   V1.0 - Created  - 25-04-2022 - Pooja Hemrajani
     * 
     **/
    @AuraEnabled
    public static string getMethod3(){
        return 'METHOD-3';
    }
    
}