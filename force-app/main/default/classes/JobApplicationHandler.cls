public class JobApplicationHandler {
    
    
    //Method to create new job applications and candidates at the same time
    public static void createNewCandidate(List<Job_Application__c> jobApps){
        
        List<String> aplIds = new List<String>();
        for(Job_Application__c newjb : jobApps){
            aplIds.add(newjb.Web_Email__c);
            aplIds.add(newjb.Email_Address__c);
        }
        
        List<String> plusPosList = new List<String>();
        for(Job_Application__c newPs : jobApps){
            plusPosList.add(newPs.Job_Position__c);
        }
        
        List<String> webPlusPosList = new List<String>();
        for(Job_Application__c newPs : jobApps){
            webPlusPosList.add(newPs.Web_Position_External_ID__c);
        }
        
        List<Candidate__c> candidates = [SELECT Email_Address__c FROM Candidate__c WHERE Email_Address__c IN :aplIds];
        List<Candidate__c> newCan = new List<Candidate__c>();   
        List<Position__c> plusPosi = [SELECT Position_Life_Cycle__c FROM Position__c WHERE Id = :plusPosList];
        List<Position__c> webPlusPosi = [SELECT Position_Life_Cycle__c FROM Position__c WHERE Position_External_ID__c = :webPlusPosList];
        
        Id recordType;
        for(Job_Application__c apps : jobApps){
            if(apps.Job_Position__c == null || apps.Web_Position__c == null){
                recordType = Schema.SObjectType.Candidate__c.getRecordTypeInfosByDeveloperName().get('Trainee').getRecordTypeId();
            }
        }
            
        for(Position__c ps : plusPosi){
            if(ps.Position_Life_Cycle__c == 'Trainee'){
                recordType = Schema.SObjectType.Candidate__c.getRecordTypeInfosByDeveloperName().get('Trainee').getRecordTypeId();
            }else{
                recordType = Schema.SObjectType.Candidate__c.getRecordTypeInfosByDeveloperName().get('Other').getRecordTypeId();
            }
        }
        
        for(Position__c ps2 : webPlusPosi){
            if(ps2.Position_Life_Cycle__c == 'Trainee'){
                recordType = Schema.SObjectType.Candidate__c.getRecordTypeInfosByDeveloperName().get('Trainee').getRecordTypeId();
            }else{
                recordType = Schema.SObjectType.Candidate__c.getRecordTypeInfosByDeveloperName().get('Other').getRecordTypeId();
            }
        }   
        
        
        for(Job_Application__c jobA : jobApps){             
            if(jobA.Email_Address__c != null){
                if(candidates.size() > 0){
                    break;
                }else{
                    //Creates new Candidate from CRM APP
                    newCan.add(new Candidate__c(
                        RecordTypeId = recordType,
                        Name = jobA.Name,
                        Email_Address__c = jobA.Email_Address__c,
                        Phone_number__c = jobA.Phone_number__c));  
                }
            }else{
                //Creates new Application from website
                if(candidates.size() > 0){
                    jobA.Name = jobA.Web_Applicant_Name__c;
                    jobA.Email_Address__c = jobA.Web_Email__c;
                    jobA.Phone_number__c = jobA.Web_Phone_Number__c;
                    jobA.Lead_Source__c = jobA.Web_Lead_Source__c;
                    jobA.Attachment__c = jobA.Web_Attachment__c;
                    jobA.Job_Position__c = getPositionId(jobApps);
                }else{
                    //Creates new Application and new Candidate from website
                    jobA.Job_Position__c = getPositionId(jobApps);
                    jobA.Name = jobA.Web_Applicant_Name__c;
                    jobA.Email_Address__c = jobA.Web_Email__c;
                    jobA.Phone_number__c = jobA.Web_Phone_Number__c;
                    jobA.Lead_Source__c = jobA.Web_Lead_Source__c;
                    jobA.Attachment__c = jobA.Web_Attachment__c;
                    newCan.add(new Candidate__c(
                        RecordTypeId = recordType,
                        Name = jobA.Web_Applicant_Name__c,
                        Email_Address__c = jobA.Web_Email__c,
                        Phone_number__c = jobA.Web_Phone_Number__c));
                }
            }
        }
        
        if(newCan.size() > 0){
            insert newCan;
            for(Job_Application__c jobB : jobApps){
                for(Candidate__c cc : newCan){
                    jobB.candidate__c = cc.Id;
                }
            }
        }
    }
    
    
    //Method to update the candidate's details
    public static void updateCandidate(List<Job_Application__c> jobApps){
        List<String> aplIds = new List<String>();
        for(Job_Application__c newjb : jobApps){
            aplIds.add(newjb.Email_Address__c);
            aplIds.add(newjb.Web_Email__c);
        }
        list<Candidate__c> candidates = [SELECT Email_Address__c, Name, Phone_number__c FROM Candidate__c WHERE Email_Address__c IN :aplIds];
        List<Candidate__c> can2 = new List<Candidate__c>();
        
        for(Job_Application__c jobA : jobApps){
            for(Candidate__c can : candidates){
                if(jobA.Email_Address__c == can.Email_Address__c){
                    can.Name = jobA.Name;
                    can.Phone_number__c = jobA.Phone_number__c;
                    can2.add(can);
                    
                }else if(jobA.Web_Email__c == can.Email_Address__c){
                    can.Name = jobA.Web_Applicant_Name__c;
                    can.Phone_number__c = jobA.Web_Phone_Number__c;
                    can2.add(can);
                }  
            }
        }
        update can2;
        for(Job_Application__c jobB : jobApps){
            for(Candidate__c cc : can2){
                jobB.candidate__c = cc.Id;
            }
        }
    }
    
    
    //Method to select the position id
    private static String getPositionId(List<Job_Application__c> jobApps){
        List<String> psIds = new List<String>();
        for(Job_Application__c newPos : jobApps){
            psIds.add(newPos.Web_Position_External_ID__c);    
        }
        
        String positionId;
        String message;
        List<Position__c> ps = [SELECT Position_External_ID__c, Name, Active_position__c FROM Position__c WHERE Position_External_ID__c IN: psIds];    
        
        for(Job_Application__c jbs : jobApps){
            for(Position__c positions : ps){               
                if(jbs.Web_Position_External_ID__c == positions.Position_External_ID__c && jbs.Web_Position__c == positions.Name && positions.Active_position__c == true){
                    positionId = positions.Id;
                }else if(jbs.Web_Position_External_ID__c == positions.Position_External_ID__c && positions.Active_position__c == false){
                    positionId = null;  
                }else{
                    positionId = null;
                }
            }
        }
        return positionId; 
        
    }
}