@isTest
public class PlayerName_Test {

    @isTest
    public static void getNameTest(){
    
        User testUser = [SELECT Id FROM User WHERE Name = 'Jake Llorrac'];
        
        System.runAs(testUser){
            
          String methodResult = PlayerNameComponentController.getUserName();
          System.assertEquals('Jake Llorrac', methodResult);  
           
        }
        
	}
    
}