trigger AssignPositions on Position__c (after insert, after update) {
    
    if(Trigger.isInsert){
        AssignPositionHandler.setsPosition(trigger.new);
    }
    
    if(Trigger.isUpdate){
        AssignPositionHandler.assignActivePosition(trigger.new);
    }
}