global class ScheduledCongratsEmail implements Schedulable {

    global void execute(SchedulableContext SC) {

        List<Id> uids = new List<Id>();

        List<User> recipientList = [SELECT id FROM User WHERE UserRoleId in (SELECT id FROM UserRole WHERE Name = 'instructor')];

        for(User u:recipientList)
        {
            uids.add(u.id);
        }

        Messaging.MassEmailMessage message = new Messaging.MassEmailMessage();

        message.setTargetObjectIds(uids);
        message.setSenderDisplayName('Interview Board'); 

        message.setBccSender(false);
        message.setSaveAsActivity(false);

       EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'AssociateCongratulationsEmail'];

       message.setTemplateID(emailTemplate.Id);

       Messaging.sendEmail(new Messaging.MassEmailMessage[] { message });
    }
}
