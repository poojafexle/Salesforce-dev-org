/**
 *  Description     :  Creating after triggers on contact. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
trigger Trigger_Contact on Contact (after insert, after update, after delete, after undelete) {
    //Checking trigger is for after
    if (Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete || Trigger.isDelete) {
            //Calling trigger to update toal active and inActive fields if status of any contact is updated
            ContactTriggerHelper.updateAccountField(Trigger.new, Trigger.oldMap);
        }
    }
}