public with sharing class PlayerNameComponentController {

    @AuraEnabled
    public static String getUserName(){
        Map<String,String> session = Auth.SessionManagement.getCurrentSession();
        String userId = session.get('UsersId');
        User u = [Select Name From User Where Id=:userId];
        String playerName = u.Name;
           
        return playerName;
    }
}