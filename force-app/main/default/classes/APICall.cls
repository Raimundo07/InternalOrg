@RestResource(urlMapping='/api/JobApp/*')
Global with sharing class APICall {
    
    @HttpPost
    global static String doPost(String leadSource, String name, String position, String email, String phone, String pId, String attachment, Id recordType){
        
        //Instance of the metadata type
        
        Job_Application__c jobApp = new Job_Application__c();
        jobApp.Web_Applicant_Name__c = name;
        jobApp.Web_Lead_Source__c = leadSource;
        jobApp.Web_Email__c = email;
        jobApp.Web_Phone_Number__c = phone;
        jobApp.Web_Position__c = position;
        jobApp.Web_Position_External_ID__c = pId;
        jobApp.Web_Attachment__c = attachment;
        jobApp.RecordTypeId = recordType;
        
        insert jobApp;
        return 'Submitted successfully';
    }

}