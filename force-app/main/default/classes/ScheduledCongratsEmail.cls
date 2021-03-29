global class ScheduledCongratsEmail implements Schedulable {

    global void execute(SchedulableContext SC) {



        List<Id> uids = new List<Id>();

        List<User> recipientList = [SELECT id FROM User WHERE UserRoleId in (SELECT id FROM UserRole WHERE Name = 'instructor')];

        for(User u:recipientList)
        {
            uids.add(u.id);
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		//Passing in the required target object Id
        message.setTargetObjectId(uids[0]);
		//passing in the rest of the list of to addresses; automatcally removes any potential duplicates with target object Id
		message.setToAddresses(uids);
        message.setSenderDisplayName('Interview Board'); 

        message.setBccSender(false);
        message.setSaveAsActivity(false);

       EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'AssociateCongratulationsEmail'];

       message.setTemplateID(emailTemplate.Id);

       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });

    }
}
