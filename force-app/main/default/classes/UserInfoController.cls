public class UserInfoController {
  @AuraEnabled

    public static String ActiveUser() {
        string name = UserInfo.getFirstName() + ' ' + UserInfo.getLastName();
        return name;
    }
      @AuraEnabled

   public static String ActiveUserImg() {
         User u = [Select u.SmallPhotoUrl, u.FullPhotoUrl 
                    From User u where u.id=:Userinfo.getUserid()];
        String Photolink = u.FullPhotoUrl;
        return Photolink;
    }
    
    

}