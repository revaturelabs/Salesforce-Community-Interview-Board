//CLASS STYLE GUIDE
//Do not include 'With Sharing' unless it's required
//Class names should be self commenting about what code they hold
public class Callout {
	
	//a block's logic should be indented with a tab, not spaces
	//comments should wrap so as not to be longer than the display width 
	//(halfscreen prefferable, fullscreen acceptable)
	//There should be an empty line between logic and a following comment
	/*
	 * Non getter/setter methods
	 * should have a block comment above them listing:
	 * LOGIC: description such as, 'Pulls 1000 Account records and changes 
	 * Contact Owner before returning a subset of Account records'
	 * RETURN: description such as, 'Returns a List<String> of all Account 
	 * records starting with Rec'
	 */
	 //methods use camelCase()
	 public static List<String> startCallout(){
		//variable names are lowercase and camelCase
		//variable names must start with a full word and be self commenting
		//related logic can be grouped as below with all the http init logic
		Http protocol = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://www.testapi.com/resource');
		request.setMethod('GET');
		HttpResponse response = protocol.send(request);
		
		//there should be space on either side of comparison operators
		if(response.getStatusCode() == 200){
			//long statements should be wrapped and indented to indicate which
			//line they belong to
			Map<String, Object> responseMap = 
				(Map<String, Object>)JSON.deserializeUntyped(response.getBody());
			List<Object> bodyList = (List<Object>)responseMap.get('results');
			List<String> bodyNames = new List<String>();
			
			//iterator variables should have clear names for what they store
			//or iterate over
			//non obvious control flow statements should have descriptions
			//above them
			//pull out each name from the objects in responseMap
			for(Integer index = 0; index < 10; index++){
				Map<String, Object> objectMap = (Map<String, Object>)bodyList[index];
				bodyNames.add(objectMap.get('name').toString());
			}
			
			//return line should be easily distinguishable from other code
			return bodyNames;
		}
		
		return null;
	 }
}