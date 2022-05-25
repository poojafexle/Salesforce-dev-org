/**
 *  Description     :  Checking Origional Contacts and updating values in field Origional Contact and Is Duplicate. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  25-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
public class CheckingOrigionalContact implements Schedulable {
    /**
     *   
     *   @description    :   Checking Origional Contacts and updating values in field Origional Contact and Is Duplicate.
     *
     *   @args           :   SchedulableContext ctx
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 25-03-2022 - Pooja Hemrajani
     * 
     **/
    public void execute(SchedulableContext ctx) {
        // awesome code here
        CheckingOrigionalContactBatchClass myBatchObject = new CheckingOrigionalContactBatchClass();
		Id batchId = Database.executeBatch(myBatchObject);
    }
}