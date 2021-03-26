public with sharing class findSelectedAssociates {

    private final List<User> associates;

    public findSelectedAssociates() {
        //Edit later with recordType = associate
        associates = [SELECT Name, Email FROM User WHERE Date_Selected__c >= :(system.now()).date()-7];
    }

    public List<User> getSelectedAssociates(){
        return associates;
    }
}
