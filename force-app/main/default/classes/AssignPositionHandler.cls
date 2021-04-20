public class AssignPositionHandler {
    
    public static void setsPosition(List<Position__c> positions){
        
        List<String> posId = new List<String>();
        for(Position__c pos : positions){
            posId.add(pos.Position_External_ID__c);
        }
        
        List<Job_Application__c> applications = [SELECT Job_Position__c, Web_Position_External_ID__c FROM Job_Application__c WHERE Web_Position_External_ID__c IN:posId];
        for(Position__c newPOs : positions){
            for(Job_Application__c app : applications){
                if(app.Job_Position__c == null){
                    app.Job_Position__c = newPos.Id;
                }
            } 
        }
        update applications;
    }
    
    
    public static void assignActivePosition(List<Position__c> positions){
        List<String> posId = new List<String>();
        for(Position__c pos : positions){
            posId.add(pos.Position_External_ID__c);
        }
        
        List<Job_Application__c> applications = [SELECT Web_Position_External_ID__c FROM Job_Application__c WHERE Web_Position_External_ID__c IN:posId];
        for(Position__c pos : positions){
            for(Job_Application__c app : applications){
                if(pos.Position_External_ID__c == app.Web_Position_External_ID__c && pos.Active_position__c == true){
                    app.Job_Position__c = pos.Id;
                }
            } 
        }
        update applications;

    }
}