public class AssociateController {
    
	@auraenabled
    public static List<contact> AssociateSearch(String AName){
        AName = String.isBlank(AName) ? '%%' : AName + '%';
        list<contact> Associates = [SELECT Id, Name FROM Contact WHERE Name like :AName];
        return Associates;
    }
}