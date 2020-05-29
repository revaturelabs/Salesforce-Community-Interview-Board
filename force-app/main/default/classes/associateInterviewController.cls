public with sharing class associateInterviewController {
	public class associateMeeting {
		@AuraEnabled
		public Id Id {get; set;}
		@AuraEnabled
		public String Name {get; set;}
		@AuraEnabled
		public Datetime Schedule {get; set;}
		@AuraEnabled
		public String Interviewers {get; set;}
	}

	@AuraEnabled
    public static List<associateMeeting> associateSearch(String associateId) {
		// Locate all the meetings which the associate is a participant
		List<Meeting_Participant__c> participants;
		try {
			participants = [SELECT Meeting__c, Meeting__r.Name, Meeting__r.Scheduled__c FROM Meeting_Participant__c WHERE Participant__c = :associateId];
		} catch (QueryException qe) {
			// Return empty list if no records are returned from the query
			return new List<associateMeeting>();
		}

		// Convert participants list to ids
		List<associateMeeting> meetings = new List<associateMeeting>();
		List<Id> meetingIds = new List<Id>();
		{
			associateMeeting meet = new associateMeeting();
			for (Meeting_Participant__c p : participants) {
				meet.Id = p.Meeting__c;
				meet.Name = p.Meeting__r.Name;
				meet.Schedule = p.Meeting__r.Scheduled__c;
				meetings.add(meet);

				meetingIds.add(p.Meeting__c);
			}
		}

		// Locate all interviewers for each of the associate's meetings
		for (Meeting_Participant__c interviewer : [SELECT Meeting__c, Participant__r.Name FROM Meeting_Participant__c WHERE Meeting__c IN :meetingIds AND Participant__r.RecordType.Name = :'Client']) {
			for (associateMeeting meet : meetings) {
				if (meet.Id == interviewer.Meeting__c) {
					if (meet.Interviewers == null) {
						meet.Interviewers = interviewer.Participant__r.Name;
					} else {
						meet.Interviewers += ', ' + interviewer.Participant__r.Name;
					}
				}
			}
		}

		System.debug(meetings);
		System.debug(participants);

		return meetings;
    }
}
