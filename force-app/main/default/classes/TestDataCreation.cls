public with sharing class TestDataCreation {
    
    // Easily repopulate list of integers from 0-99 inclusive (used to keep track of used indexes)
    private static final List<Integer> NUMLIST = new List<Integer>{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99};

    // List of 100 random Company (Client Account) names
    private static final List<String> aName = new List<String> {'Accentcloud', 'Allico', 'Alligator Solutions', 'Answer Technologies', 'Apex Co.', 'Aprico', 'Aurarts', 'Bear Paw Productions', 'Bluebeat', 'Bluetronics', 'Bridgemart', 'Brisk Security', 'Bullwell', 'Bumblebee Corp', 'Cannonbridge', 'Cave Limited', 'Cavologies', 'Cliffforce', 'Cliffoods', 'Cloverprises', 'Crystalstone', 'Delugation', 'Desertex', 'Diamond Corporation', 'Dinomedia', 'Dragonman', 'Dreamair', 'Dreambridge', 'Dreamcloud', 'Dynamic Brews', 'Dynamicway', 'Enigmotors', 'Essensecurity', 'Firetronics', 'Flowergold', 'Fluke Corporation', 'Ghosttime', 'Globalshack', 'Gold', 'Greenwalk', 'Griffindustries', 'Hatchbank', 'Hercules Enterprises', 'Honeydustries', 'Honeyscape', 'Hummingbirdustries', 'Icebergarts', 'Imagine Entertainment', 'Irontime', 'Jewelectrics', 'Lagoonavigations', 'Leopardworks', 'Lifoods', 'Lionetworks', 'Lucky Entertainment', 'Lucky Media', 'Melon Industries', 'Moon Motors', 'Moonlightings', 'Moonlimited', 'Moonlit Corp', 'Moonnetworks', 'Mountain Records', 'Mysticorps', 'Neroductions', 'Nimble Motors', 'Odin Systems', 'Orco', 'Oyster Brews', 'Peachco', 'Peachtime', 'Petalimited', 'Pinkorps', 'Primemart', 'Prodigy Arts', 'Ridgeco', 'Ridgestones', 'Robinair', 'Rootscape', 'Rose Electronics', 'Rushcorp', 'Saturn Corp', 'Shrubrews', 'Smartwheels', 'Smilecast', 'Spherecords', 'Starecords', 'Stormmart', 'Summit Records', 'Summit Technologies', 'Tortoise', 'Trekords', 'Tucanterprises', 'Tulipbank', 'Tundracoustics', 'Valkyrecords', 'Void Networks', 'Vortex Media', 'Witchystems', 'Wizard Softwares'};

    // List of 100 random First Names
    private static final List<String> fName = new List<String> {'Adam', 'Alberta', 'Allison', 'Ana', 'Andres', 'Angelina', 'Anita', 'Antonio', 'Aubrey', 'Barbara', 'Barry', 'Beverly', 'Bradley', 'Brent', 'Brooke', 'Carmen', 'Caroline', 'Cheryl', 'Christian', 'Christina', 'Christy', 'Clifton', 'Daniel', 'Danielle', 'Debbie', 'Dominic', 'Donnie', 'Elias', 'Eric', 'Fred', 'Flora', 'Forrest', 'Garry', 'Gertrude', 'Ginger', 'Gladys', 'Grant', 'Hubert', 'Ignacio', 'Ira', 'Isaac', 'Jaime', 'Jeannie', 'Jimmy', 'Joel', 'Josh', 'Juan', 'Kathleen', 'Kelvin', 'Kenneth', 'Kim', 'Kristine', 'Lana', 'Laura', 'Laverne', 'Leland', 'Leona', 'Levi', 'Lillian', 'Loren', 'Lori', 'Lorraine', 'Lyle', 'Lynda', 'Mandy', 'Marco', 'Marianne', 'Marlon',  'Mary', 'Mattie', 'Maurice','Meghan', 'Nelson', 'Nicole', 'Ramon', 'Ramona', 'Reene', 'Rene', 'Rita', 'Roland', 'Rosalie', 'Rose', 'Rosemary', 'Sally', 'Salvatore', 'Sharon', 'Silvia', 'Stephen', 'Steven', 'Ted', 'Teri', 'Thelma', 'Tommie', 'Traci', 'Troy', 'Tyler', 'Vivian', 'Wade', 'Wilbur', 'Zachary'};
    
    // List of 100 random Last Names
    private static final List<String> lName = new List<String> {'Aguilar', 'Alexander', 'Allen', 'Alvarado', 'Ball', 'Barton', 'Bass', 'Berry', 'Bowen', 'Brady', 'Byrd', 'Cain', 'Cannon', 'Carlson', 'Copeland', 'Cortez', 'Cox', 'Daniel', 'Day', 'Delgado', 'Doyle', 'Edwards', 'Erickson', 'Estrada', 'Farmer', 'Fernandez', 'Fletcher', 'Ford', 'Frazier', 'Garrett', 'Gibbs', 'Gonzalez', 'Greene', 'Griffin', 'Guzman', 'Hale', 'Hammond', 'Hansen', 'Hardy', 'Harvey', 'Hayes', 'Henderson', 'Higgins', 'Hogan', 'Horton', 'Howell', 'Hubbard', 'Hughes', 'Hunt', 'Hunter', 'Jefferson', 'Knight', 'Lawson', 'Lopez', 'Love', 'Lowe', 'Marsh', 'Martinez', 'May', 'Mcdaniel', 'Mcguire', 'Mitchell', 'Moody', 'Nichols', 'Nunez', 'Parks', 'Patrick', 'Pena', 'Perez', 'Peterson', 'Phelps', 'Pope', 'Porter', 'Powell', 'Powers', 'Reed', 'Robbins', 'Roberson', 'Robinson', 'Rogers', 'Roy', 'Sanders', 'Saunders', 'Schmidt', 'Shaw', 'Simmons', 'Sims', 'Soto', 'Stephens', 'Sullivan', 'Taylor', 'Tucker', 'Turner', 'Valdez', 'Vaughn', 'Vega', 'Wallace', 'Walters', 'Watts', 'Wong'};
    
    // List of 5 common email endings
    private static List<String> email = new List<String> {'@gmail.com', '@hotmail.com', '@outlook.com', '@yahoo.com', '@live.com'};

    // Map of First Names to List of Last Names
    private static Map<String, List<String>> nameMap = new Map<String, List<String>>();
    private static List<String> locations = new List<String> {'Zoom', 'Google Meetings', 'Office'};
    private static Map<Id, Boolean> graduated = new Map<Id, Boolean>();
    
    // Method to setup nameMap
    private static void setup()
    {
        for(String s : fName)
            nameMap.put(s, lName.clone());
    }

    // Method to reset all test data records
    public static void reset()
    {
        clear();
        setup();
        contacts(5, 1, 3, 10, 10, 20);
        participants();
    }

    // Method to clear current records for objects used in the project
    public static void clear()
    {
        List<List<sObject>> objs = new List<List<sObject>>();

        objs.add([SELECT Id FROM Interview_Question__c]);
        objs.add([SELECT Id FROM Meeting_Participant__c]);
        objs.add([SELECT Id FROM Meeting__c]);
        objs.add([SELECT Id FROM Contact]);
        objs.add([SELECT Id FROM Batch_Client__c]);
        objs.add([SELECT Id FROM Account]);
        objs.add([SELECT Id FROM Question__c]);

        for(List<sObject> obj : objs)
            Database.delete(obj, false);
    }

    // Method to make cnt random Client Accounts, up to 100
    public static List<Account> clientAccount(Integer cnt)
    {
        if(cnt > 100) cnt = 100;
        List<Account> accts = new List<Account>();
        List<Integer> nums = NUMLIST.clone();

        RecordType rt = [SELECT Id FROM RecordType WHERE Name='Client' AND RecordType.SObjectType='Account'];

        Account a = null;

        for(integer i = 0; i < cnt; i++)
        {
            a = new Account();
            // Getting a random, unused name from the Account Names list
            a.Name = aName.get(nums.remove(randInt(nums.size())));
            a.Phone = randPhone();
            a.RecordTypeId = rt.Id;

            accts.add(a);
        }

        insert accts;
        return accts;
    }

    // Method to make cnt random Batch Accounts
    public static List<Account> batchAccount(Integer cnt)
    {
        List<Account> batch = new List<Account>();
        String strBatch = 'Batch-', temp = '000';

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Batch' AND RecordType.SObjectType = 'Account'];

        Account b = null;

        for(integer i = 1; i <= cnt; i++)
        {
            b = new Account();

            if(i == 10 || i == 100)
                temp = temp.subString(1);
            b.Name = 'Batch-' + temp + i;
            b.RecordTypeId = rt.Id;

            batch.add(b);
        }

        insert batch;

        for(Account bat : batch)
            graduated.put(bat.Id, (randBool() || randBool()));

        return batch;
    }

    // Method to generate aMin to aMax Client Contacts per Client Account (number of Accounts = aCnt)
    // as well as generate bMin to bMax Associate Contacts per Batch Account (number of Accounts = bCnt)
    public static List<Contact> contacts(Integer aCnt, Integer aMin, Integer aMax, Integer bCnt, Integer bMin, Integer bMax)
    {
        List<Account> accts = clientAccount(aCnt);
        List<Account> batch = batchAccount(bCnt);

        batchClient(batch, accts);

        List<Contact> conts = new List<Contact>();
        List<Integer> nums = NUMLIST.clone();

        RecordType rt = [SELECT Id FROM RecordType WHERE Name = 'Client' AND RecordType.SObjectType = 'Contact' LIMIT 1];

        Contact c = null;

        for(Account a : accts)
        {
            integer r = randInt(aMin, aMax);
            for(integer i = 0; i < r; i++)
            {
                c = new Contact();

                Integer rand = randInt(nums.size());
                c.FirstName = fName.get(nums.get(rand));
                c.LastName = nameMap.get(c.FirstName).remove(randInt(nameMap.get(c.FirstName).size()));
                if(nameMap.get(c.FirstName).size() == 0)
                    nums.remove(rand);
                c.MobilePhone = randPhone();
                c.HomePhone = randPhone();
                c.RecordTypeId = rt.Id;
                c.AccountId = a.Id;
                c.Phone = a.Phone;

                conts.add(c);
            }
        }

        rt = [SELECT Id FROM RecordType WHERE Name = 'Associate' AND RecordType.SObjectType = 'Contact' LIMIT 1];

        for(Account b : batch)
        {
            integer r = randInt(bMin, bMax);
            for(integer i = 0; i < r; i++)
            {
                c = new Contact();

                Integer rand = randInt(nums.size());
                c.FirstName = fName.get(nums.get(rand));
                c.LastName = nameMap.get(c.FirstName).remove(randInt(nameMap.get(c.FirstName).size()));
                if(nameMap.get(c.FirstName).size() == 0)
                    nums.remove(rand);
                c.MobilePhone = randPhone();
                c.HomePhone = randPhone();
                c.RecordTypeId = rt.Id;
                c.AccountId = b.Id;

                conts.add(c);
            }
        }

        insert conts;
        return conts;
    }

    // Method to generate random number of Batch Client relationships
    public static void batchClient(List<Account> bat, List<Account> cli)
    {
        Integer[] cnt = new Integer[50];
        for(integer i = 0; i < 50; i++)
            cnt[i] = 0;
        List<Batch_Client__c> bcl = new List<Batch_Client__c>();

        Batch_Client__c bc = null;

        // Randomly assigning clients to batches
        for(Account b : bat)
        {
            bc = new Batch_Client__c();

            bc.Batch__c = b.Id;
            integer i = randInt(cli.size());
            bc.Interested_Client__c = cli.get(i).Id;
            cnt[i]++;
            bc.Name = cli.get(i).Name.toUpperCase() + '-' + b.Name.toUpperCase();

            bcl.add(bc);
        }

        // Assigning any missed Clients to a batch
        for(integer i = 0; i < cli.size(); i++)
        {
            if(cnt[i] != 0)
                continue;

            bc = new Batch_Client__c();

            integer j = randInt(bat.size());
            bc.Batch__c = bat.get(j).Id;
            bc.Interested_Client__c = cli.get(i).Id;
            bc.Name = cli.get(i).Name.toUpperCase() + '-' + bat.get(j).Name.toUpperCase();

            bcl.add(bc);
        }

        for(Account c : cli)
        {
            bc = new Batch_Client__c();

            integer j = randInt(bat.size());
            bc.Batch__c = bat.get(j).Id;
            bc.Interested_Client__c = c.Id;
            bc.Name = c.Name.toUpperCase() + '-' + bat.get(j).Name.toUpperCase();

            bcl.add(bc);
        }

        insert bcl;
    }

    // Method to generate Meetings (1-2 full batch to client, 3-6 1 on 1)
    public static List<List<sObject>> meeting()
    {
        List<List<sObject>> meets = new List<List<sObject>>();
        meets.add(new List<Meeting__c>());
        meets.add([SELECT Id, Batch__c, Interested_Client__c FROM Batch_Client__c]);

        List<RecordType> rts = new List<RecordType>();

        rts.add([SELECT Id FROM RecordType WHERE RecordType.Name = 'Intervention 1-1' AND RecordType.SObjectType = 'Meeting__c']);
        rts.add([SELECT Id FROM RecordType WHERE RecordType.Name = 'Intervention Batch' AND RecordType.SObjectType = 'Meeting__c']);
        rts.add([SELECT Id FROM RecordType WHERE RecordType.Name = 'Interview 1-1' AND RecordType.SObjectType = 'Meeting__c']);
        rts.add([SELECT Id FROM RecordType WHERE RecordType.Name = 'Interview Batch' AND RecordType.SObjectType = 'Meeting__c']);

        DateTime now = DateTime.now();

        Meeting__c m = null;
        Integer j = 1, k;

        for(integer i = 0; i < meets.get(1).size(); i++)
        {
            k = randInt(1, 2);
            for(integer l = 0; l < k; l++)
            {
                m = new Meeting__c();

                m.Name = 'Meeting ' + j++ + ' - Full';
                m.Batch__c = ((Batch_Client__c)meets.get(1).get(i)).Batch__c;

                Id rt = null;

                if(graduated.get(((Batch_Client__c)meets.get(1).get(i)).Batch__c))
                    rt = rts.get(3).Id;
                else
                    rt = rts.get(1).Id;

                m.RecordTypeId = rt;

                /*if(randBool())
                {
                    m.Meeting_Status__c = 'Scheduled';
                    m.Scheduled__c = DateTime.now().addDays(randInt(1,14));
                }
                else */if(randBool())
                {
                    m.Meeting_Status__c = 'Completed';
                    m.Scheduled__c = randDate();
                    m.Completed_Date__c = m.Scheduled__c;
                }
                else if(randBool())
                {
                    m.Meeting_Status__c = 'Cancelled';
                    m.Scheduled__c = DateTime.now().addDays(randInt(1,14));
                }
                else
                {
                    m.Meeting_Status__c = 'Cancelled';
                    m.Scheduled__c = randDate();
                }
                m.Location__c = locations.get(randInt(locations.size()));

                meets.get(0).add(m);
            }

            k = randInt(3, 6);
            for(integer l = 0; l < k; l++)
            {
                m = new Meeting__c();

                m.Name = 'Meeting ' + j++;
                m.Batch__c = ((Batch_Client__c)meets.get(1).get(i)).Batch__c;

                Id rt = null;

                if(graduated.get(((Batch_Client__c)meets.get(1).get(i)).Batch__c))
                    rt = rts.get(2).Id;
                else
                    rt = rts.get(0).Id;

                m.RecordTypeId = rt;

                /*if(randBool())
                {
                    m.Meeting_Status__c = 'Scheduled';
                    m.Scheduled__c = DateTime.now().addDays(randInt(1,14));
                }
                else*/ if(randBool())
                {
                    m.Meeting_Status__c = 'Completed';
                    m.Scheduled__c = randDate();
                    m.Completed_Date__c = m.Scheduled__c;
                }
                else if(randBool())
                {
                    m.Meeting_Status__c = 'Cancelled';
                    m.Scheduled__c = DateTime.now().addDays(randInt(1,14));
                }
                else
                {
                    m.Meeting_Status__c = 'Cancelled';
                    m.Scheduled__c = randDate();
                }
                m.Location__c = locations.get(randInt(locations.size()));

                meets.get(0).add(m);
            }
        }

        insert meets.get(0);
        return meets;
    }

    public static void participants()
    {
        List<List<sObject>> objs = meeting();
        List<Meeting__c> meets = (List<Meeting__c>)objs.get(0);
        List<Batch_Client__c> baCli = (List<Batch_Client__c>)objs.get(1);
        List<Meeting_Participant__c> parts = new List<Meeting_Participant__c>();

        List<Account> cliAc = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE RecordType.Name = 'Client'];
        List<Account> batAc = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE RecordType.Name = 'Batch'];

        Map<Id, List<Contact>> cliMap = new Map<Id, List<Contact>>();
        Map<Id, List<Contact>> batMap = new Map<Id, List<Contact>>();

        for(Account a : cliAc)
            cliMap.put(a.Id, a.Contacts);
        for(Account a : batAc)
            batMap.put(a.Id, a.Contacts);

        //questions(meets);

        integer j = 0, k = 1, l;
        boolean s = true;

        Meeting_Participant__c p = null;

        for(integer i = 0; i < meets.size(); i++)
        {
            String mn = meets.get(i).Name;
            if(mn.subString(mn.length()-1).equals('l'))
            {
                if(!s) j++;
                s = true;
                meets.get(i).Batch__c = baCli.get(j).Batch__c;

                l = randInt(cliMap.get(baCli.get(j).Interested_Client__c).size());

                p = new Meeting_Participant__c();

                p.Meeting__c = meets.get(i).Id;
                p.Participant__c = cliMap.get(baCli.get(j).Interested_Client__c).get(l).Id;

                parts.add(p);

                for(Contact c : batMap.get(baCli.get(j).Batch__c))
                {
                    p = new Meeting_Participant__c();

                    p.Meeting__c = meets.get(i).Id;
                    p.Participant__c = c.Id;

                    parts.add(p);
                }
            }
            else
            {
                s = false;

                meets.get(i).Batch__c = baCli.get(j).Batch__c;

                p = new Meeting_Participant__c();

                
                l = randInt(cliMap.get(baCli.get(j).Interested_Client__c).size());
                p.Meeting__c = meets.get(i).Id;
                p.Participant__c = cliMap.get(baCli.get(j).Interested_Client__c).get(l).Id;

                parts.add(p);

                p = new Meeting_Participant__c();
                
                l = randInt(batMap.get(baCli.get(j).Batch__c).size());
                p.Meeting__c = meets.get(i).Id;
                p.Participant__c = batMap.get(baCli.get(j).Batch__c).get(l).Id;

                parts.add(p);
            }
        }

        insert parts;

        List<Contact> cliCo = [SELECT Id, Contact.RecordType.Name FROM Contact WHERE RecordType.Name = 'Client'];
        Map<Id, Contact> cMap = new Map<Id, Contact>();
        for(Contact c : cliCo)
            cMap.put(c.Id, c);
        Map<Id, List<Meeting_Participant__c>> mepa = new Map<Id, List<Meeting_Participant__c>>();
        for(Meeting_Participant__c mp : parts)
        {
            if(mepa.get(mp.Meeting__c) == null)
                mepa.put(mp.Meeting__c, new List<Meeting_Participant__c>());
            mepa.get(mp.Meeting__c).add(mp);
        }

        for(integer i = 0; i < meets.size(); i++)
        {
            for(Meeting_Participant__c mp : mepa.get(meets.get(i).Id))
            {
                if(cMap.get(mp.Participant__c).RecordType.Name == 'Client')
                {
                    meets.get(i).Participating_Client__c = mp.Id;
                    break;
                }
            }
        }

        update meets;
    }

    /*public static void questions(List<Meeting__c> meets)
    {
        //List<Interview_Question__c> ques = new List<Interview_Question__c>();

        Interview_Question__c q = null;
        StaticResource defaultResource = [Select  s.Body From StaticResource s where s.Name LIKE 'testQuestions%'];
        blob tempB = defaultResource.Body;
       	String contentFile = tempB.toString();
       	String[] filelines = contentFile.split('\n');
    	List<Question__c> quests = new List<Question__c>();
       	for (Integer i=1;i<filelines.size();i++)
        {
        	Question__c temp = new Question__c();
            String[] inputvalues = filelines[i].split(',');
        	temp.Stack__c = inputValues[0];
        	temp.Type__c = inputValues[1];
            temp.Body__c = inputValues[2];
        	//temp.Interviewer__c = inputValues[3];
        	quests.add(temp);	
        }

        insert quests;

        List<Interview_Question__c> iQuests = new List<Interview_Question__c>();
        for(Meeting__c m : meets)
        {
            List<Question__c> tempQList = quests.clone();
            for(integer i = 1; i <= 4; i++)
            {
                integer randQuestion = randInt(0, tempQList.size()-1);
                Interview_Question__c interviewQ = new Interview_Question__c();
                interviewQ.Meeting_md__c = m.Id;
                interviewQ.Question__c = tempQList.get(randQuestion).Id;
                tempQList.remove(randQuestion);
                iQuests.add(interviewQ);
            }
        }

        System.debug(iQuests);
        insert iQuests;
    }

    // Method to generate random phone number
    private static String randPhone()
    {
        String s = '(';
        for(integer i = 0; i < 3; i++)
            s += randInt(10);
        s += ') ';
        for(integer i = 0; i < 3; i++)
            s += randInt(10);
        s += '-';
        for(integer i = 0; i < 4; i++)
            s += randInt(10);
        
        return s;
    }
    // Method to generate random boolean value
    private static boolean randBool()
    {
        return (Math.mod((Integer)(Math.random()*10),2)==0);
    }
    // Method to generate random integer value
    private static Integer randInt(Integer i)
    {
        return Integer.valueOf(Math.random() * (i-1));
    }
    // Method to generate random integer value in range: min - max
    private static Integer randInt(Integer min, Integer max)
    {
        if(min > max)
            return Integer.valueOf(Math.random() * (min-max+1) + max);
        else
            return Integer.valueOf(Math.random() * (max-min+1) + min);
    }
    private static DateTime randDate()
    {
        DateTime now = DateTime.now();
        integer year = randInt(now.year() - 5, now.year()),
                month = randInt(1, 12),
                day = randInt(1, 31),
                hour = randInt(9, 17),
                minute = randInt(4) * 15,
                second = 0;
        
        if(year == now.year() && month > now.month())
            month = randInt(1, now.month());
        
        switch on month {
            when 4, 6, 9, 11 {
                if(day == 31)
                    day = randInt(1, 30);
            }
            when 2 {
                if(day > 28)
                {
                    if(Math.mod(year, 4) == 0 && !(Math.mod(year, 100) == 0 && Math.mod(year, 400) != 0))
                        day = randInt(1, 29);
                    else
                        day = randInt(1, 28);
                }
            }
        }

        return DateTime.newInstance(year, month, day, hour, minute, second);
    }
}