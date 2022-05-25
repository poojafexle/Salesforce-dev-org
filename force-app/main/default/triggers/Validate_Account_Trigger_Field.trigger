trigger Validate_Account_Trigger_Field on Account (before insert, before update) {
	if(Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ValidateAccountFieldTriggerHelper.ValidateAccountFieldFunction(Trigger.new, Trigger.oldMap);
        }
    }
}