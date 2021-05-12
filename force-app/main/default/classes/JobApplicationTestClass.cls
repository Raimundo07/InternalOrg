@isTest
public class JobApplicationTestClass {
    
    @isTest
    public static void jobApplicationTest(){
        
        Position__c pos = new Position__c();
        pos.Name = 'example';
        pos.Active_position__c = true;
        pos.Name = 'ExamplePos';
        pos.Position_External_ID__c ='0011';
        pos.Position_Life_Cycle__c ='Other';
        pos.Min_Pay__c = 1000;
        pos.Max_Pay__c = 1500; 
        
        insert pos;
        
        Job_Application__c app = new Job_Application__c();
        app.Name = 'Test Application1';
        app.Email_Address__c = 'Emailtesting@gmail.com';
        app.Phone_number__c = '1234-5678';
        app.Job_Position__c = pos.Id;
        
        insert app;
        
        Job_Application__c jobA = new Job_Application__c(
            Web_Applicant_Name__c = 'webName',
            Web_Email__c ='webWmail@gmail.com',
            Web_Phone_Number__c = 'webphone',
            Web_Lead_Source__c = 'webleadsource',
            Web_Attachment__c = 'noAttachment'
        );
        
        insert jobA;
        
    }
}