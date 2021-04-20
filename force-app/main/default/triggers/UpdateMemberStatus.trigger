trigger UpdateMemberStatus on Trainee_Group_Member__c (before update) {
    
    for(Trainee_Group_Member__c member : trigger.new){
        if(member.Training_Progress__c == 'Completed'){
            member.Member_Status__c = 'Successful';
            member.Progress_Notes__c = member.Completion_Comments__c;           
        }else{
            member.Member_Status__c = 'Unsuccessful';
        }
        
        if(member.Training_Progress__c == 'Trailhead'){
            member.Progress_Notes__c =  member.Trailhead_Comments__c;
            
        }else if(member.Training_Progress__c == 'Abandon'){
            member.Progress_Notes__c = member.Abandon_Reasons__c;
            
        }else if(member.Training_Progress__c == 'Removed'){
            member.Progress_Notes__c = member.Removal_Reasons__c;
            
        }else if(member.Training_Progress__c == 'Study Guides FOF'){
            member.Progress_Notes__c = member.Study_Guides_Comments__c;
            
        }else if(member.Training_Progress__c == 'Practice test FOF'){
            member.Progress_Notes__c = member.Practice_Exams_Comments__c;
            
        }else if(member.Training_Progress__c == 'Mock Test'){
            member.Progress_Notes__c = member.Mock_Comments__c;
            
        }else if(member.Training_Progress__c == 'Certification Exam'){
            member.Progress_Notes__c = member.Certification_Comments__c;
        }else{
            member.Progress_Notes__c = null;
        }
    }
}