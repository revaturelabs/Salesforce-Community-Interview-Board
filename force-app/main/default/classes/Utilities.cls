public class Utilities {
    /* This method is derived from the code located here
     * https://glyntalkssalesforce.blogspot.com/2018/08/dependent-picklist-values-in-apex.html
     * We have made changes to it to fit our needs, but the underlying logic is the same.
     * 
     * This method returns the values for the type picklist as a map with the controlling stack values as keys.
     * It's sort of a lot to take in, so I'll give some more detailed comments than usual
     */
    public static Map<String,List<String>> getTypePicklistValues() {
        //This section is all for getting the stack and type picklists
        Schema.DescribeFieldResult questionType = Question__c.Type__c.getDescribe();
        Schema.sObjectField stackToken = questionType.getController();
        if (stackToken == null) return null;
        Schema.DescribeFieldResult stack = stackToken.getDescribe();
        //make sure that it's not a checkbox before getting the values
        List<Schema.PicklistEntry> stackEntries = (stack.getType() == Schema.DisplayType.Boolean ? null
                                                   :stack.getPicklistValues());
    	//controlling fields are encoded in 6 bits which translate to one of these values
    	//ie 000000 = 0 = A 001101 = 13 = N and so on, so a key for a controlling stack could be a string like 'gAAA'
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Map<String,List<String>> typePicklistValues = new Map<String,List<String>>();
        for (Schema.PicklistEntry entry : questionType.getPicklistValues()) if (entry.isActive()) {
            List<String> base64chars =
                String.valueOf(
                    //This is just a trick to get validFor out of entry. It isn't visible by default
                    //But if you parse it into a JSON then into a map, you have access to it
                    ((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')
                ).split('');
            //Remember how stackEntries was set to null for checkboxes? That comes into play a lot here
            for (Integer index = 0; index < (stackEntries != null ? stackEntries.size() : 2); index++ )
            {
                String stackValue = (String)(stackEntries == null ? (Object) (index == 1)
                : (Object) (stackEntries[ index ].isActive() ? stackEntries[ index ].getLabel() : null));
                //bitIndex only movesup every 6 iterations because it's an int
                //bitShift is the amount that 1 should be shifted over. it will range from 0-5 because of the mod 6
                //ie index 13 -> bitShift = 
                Integer bitIndex = index / 6, bitShift = 5 - Math.mod( index, 6 );
                //checkboxes don't get to do the last part of the loop
                //The section with bitShift is creating a bitmap of values 000001-100000 to bitwise & with the base64Map value index
                //short version: it checks to see if the current letter is the right one
                if (stackValue == null || (base64map.indexOf(base64chars[ bitIndex ]) & (1 << bitShift)) == 0) continue;
                //Add in the stackValue and assign the entry to its list
                if (!typePicklistValues.containsKey( stackValue)) {
                    typePicklistValues.put(stackValue, new List<String>());
                }
                typePicklistValues.get(stackValue).add(entry.getLabel());
            }
        }
        System.debug(typePicklistValues);
        return typePicklistValues;
    }

}