global with sharing class QuizPlayer {
    @AuraEnabled
    global Id id { get; set; }
    @AuraEnabled
    global String name { get; set; }
    @AuraEnabled
    global Decimal score { get; set; }
    @AuraEnabled
    global Decimal rank { get; set; }
    @AuraEnabled
    global Decimal TotalQuizPoints { get; set; }


    global QuizPlayer() {
    }

    global QuizPlayer(Quiz_Player__c player) {
        this.id = player.Id;
        this.name = player.Name;
        this.score = player.Score__c;
        this.rank = player.Ranking__c;
    }
    
    global QuizPlayer(User player, boolean x){
        this.id = player.Id;
        this.name = player.Name;
        this.TotalQuizPoints = player.Total_Quiz_Points__c;
    }

    global static List<QuizPlayer> fromRecordListallTime(
        List<User> records
    ) {
        List<QuizPlayer> players = new List<QuizPlayer>();
        for (User record : records) {
            players.add(new QuizPlayer(record, false));
        }
        return players;
    }

    global static List<QuizPlayer> fromRecordList(
        List<Quiz_Player__c> records
    ) {
        List<QuizPlayer> players = new List<QuizPlayer>();
        for (Quiz_Player__c record : records) {
            players.add(new QuizPlayer(record));
        }
        return players;
    }
}