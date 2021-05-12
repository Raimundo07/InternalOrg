@isTest
public class AssignPositionTestClass {
    
    @isTest
    public static void AssignPositionTest(){
       
        test.startTest();
        String recordType = Schema.SObjectType.Job_Application__c.getRecordTypeInfosByDeveloperName().get('Not_Referred').getRecordTypeId();
        Job_Application__c ja = new Job_Application__c();
        ja.Name = 'testName';
        ja.Web_Applicant_Name__c = 'testName';
        ja.Web_Email__c = 'newApplication@gmail.com';
        ja.Web_Phone_Number__c = '1234-5678';
        ja.Web_Attachment__c = 'no attachment';
        ja.Web_Position__c = 'newItPosition';
        ja.Web_Position_External_ID__c = '1111';
        ja.Web_Lead_Source__c = 'Facebook';  
        ja.RecordTypeId = recordType;
        insert ja;
        
        String posRecordType = Schema.SObjectType.Position__c.getRecordTypeInfosByDeveloperName().get('Operations_Position').getRecordTypeId();
        Position__c p = new Position__c();
        p.RecordTypeId = posRecordType;
        p.Name = 'newItPosition';
        p.Active_position__c = true;
        p.Position_External_ID__c ='1111';
        p.Position_Life_Cycle__c ='Trainee';
        p.Min_Pay__c = 1000;
        p.Max_Pay__c = 1500;  
        insert p;
        
		//creating inactive position
        Position__c inPos = new Position__c();
        inPos.RecordTypeId = posRecordType;
        inPos.Name = 'InactivePosition';
        inPos.Active_position__c = false;
        inPos.Position_External_ID__c ='1122';
        inPos.Position_Life_Cycle__c ='Trainee';
        inPos.Min_Pay__c = 1000;
        inPos.Max_Pay__c = 1500;    
        insert inPos;
        
        //Job application with inactive position
        Job_Application__c jaInactive = new Job_Application__c();
        jaInactive.Name = 'testName2';
        jaInactive.Web_Applicant_Name__c = 'testName';
        jaInactive.Web_Email__c = 'newApplication2@gmail.com';
        jaInactive.Web_Phone_Number__c = '1234-5678';
        jaInactive.Web_Attachment__c = 'no attachment';
        jaInactive.Web_Position__c = 'InactivePosition';
        jaInactive.Web_Position_External_ID__c = '1122';
        jaInactive.Web_Lead_Source__c = 'Facebook';  
        jaInactive.RecordTypeId = recordType;
        insert jaInactive;

        //updating job Application with active position
        inPos.Active_position__c = true;
        upsert inPos;
        test.stopTest();

    }

}