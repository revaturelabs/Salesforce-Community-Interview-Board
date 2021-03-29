public with sharing class findSelectedAssociates {

    private final List<Contact> associates;

    public findSelectedAssociates() {
        //Edit later with recordType = associate
        //associates = [SELECT Name, Email FROM User WHERE Date_Selected__c >= :(system.now()).date()-7];
        List<RecordType> RecordTypeList = [SELECT Id, SObjectType, Name FROM RecordType WHERE ( (SObjectType='Contact' 
                                                                                                AND Name='Associate') 
                                                                                                OR (SObjectType='Account' AND Name='Client') ) LIMIT 2];

        RecordType associateRecordType;
        RecordType clientRecordType;

        if (RecordTypeList[0].Name=='Associate'){
            associateRecordType = RecordTypeList[0];
            clientRecordType = RecordTypeList[1];
        } else {
            associateRecordType = RecordTypeList[1];
            clientRecordType = RecordTypeList[0];
        }
        associates = [SELECT Name, Email, Client__r.Name FROM Contact WHERE (RecordTypeId=:associateRecordType.Id 
                                                                            AND Date_Selected__c>= :(system.now()).date()-7 )];
    }

    public List<Contact> getSelectedAssociates(){
        return associates;
    }
}