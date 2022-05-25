/**
 *  Description     :  Creating after triggers on account. 						
 *
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  07-03-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 **/
trigger Trigger_Account on Account (before insert, before update, after insert, after update) {
    //Checking trigger is for before
    if(Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            //Calling helper class for updating account number onchange of rating
            AccountTriggerHelper.setAccountRating(Trigger.new, Trigger.oldMap);
          
            //Calling helper class for adding erile active is falseor on in active reason field if its blank while active is false
            AccountTriggerHelper.ValidateAccountField(Trigger.new, Trigger.oldMap);
        }
    }
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            //Calling class for updating contacts according to data provided in contact details
            //Calling class for moving contacts according to data provided in move to contact
            AccountTriggerHelper.moveContactUnderGivenAccount(Trigger.new, Trigger.oldMap);
        }
    }
}