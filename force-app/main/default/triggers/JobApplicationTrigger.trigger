trigger JobApplicationTrigger on Job_Application__c (before insert, before update) {
    
    if(trigger.isInsert){
        JobApplicationHandler.createNewCandidate(Trigger.new);
        
        JobApplicationHandler.updateCandidate(Trigger.new);
    }
}