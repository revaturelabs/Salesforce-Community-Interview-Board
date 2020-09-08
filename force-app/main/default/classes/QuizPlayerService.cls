public class QuizPlayerService extends QuizAbstractDataService {
    public Quiz_Player__c getFromId(Id playerId) {
        return (Quiz_Player__c) getSingleRecord(
            'Quiz_Player__c',
            [
                SELECT Id, Name, Score__c, Ranking__c
                FROM Quiz_Player__c
                WHERE Id = :playerId
            ]
        );
    }

    public Quiz_Player__c getFromName(String name) {
        return (Quiz_Player__c) getSingleRecord(
            'Quiz_Player__c',
            [SELECT Id FROM Quiz_Player__c WHERE Name = :name]
        );
    }

    public List<Quiz_Player__c> getPlayersSortedByScore(Integer maxFetchCount) {
        String query = 'SELECT Id, Name, Score__c, Ranking__c FROM Quiz_Player__c ORDER BY Score__c DESC';
        if (maxFetchCount != null) {
            query += ' LIMIT ' + maxFetchCount;
        }
        return Database.query(query);
    }

    public List<User> getPlayersSortedByAllTimeScore(Integer maxFetchCount) {
        String query = 'SELECT Id, Name, Total_Quiz_Points__c FROM User WHERE Total_Quiz_Points__c != null ORDER BY Total_Quiz_Points__c DESC';
        if (maxFetchCount != null){
            query += ' LIMIT ' + maxFetchCount;
        }
        return Database.query(query);
    }

    public Map<Id, Quiz_Player__c> getPlayers() {
        return new Map<Id, Quiz_Player__c>(
            [SELECT Id, Score__c FROM Quiz_Player__c]
        );
    }

    public void deleteAnswersAndPlayers() {
        updateUserScore();
        delete [SELECT Id FROM Quiz_Answer__c];
        delete [SELECT Id FROM Quiz_Player__c];
    }
    
    public void updateUserScore(){
        List<User> users = new List<User>();
        List<Quiz_Player__c> players = [SELECT Id, Name, Score__c, User__c, Total_Quiz_Points__c FROM Quiz_Player__c WHERE User__c != ''];
        if(players != null && players.size() > 0){
            for(Quiz_Player__c p : players){
                User u = new User();
                u.Id = p.User__c;
                u.Total_Quiz_Points__c = p.Total_Quiz_Points__c + p.Score__c;
                users.add(u);
            }
            update users;
        }
    }

    public void assignRanking() {
        List<Quiz_Player__c> players = getPlayersSortedByScore(null);
        Decimal lastScore = 9223372036854775807L; // Long max value
        Integer rank = 0;
        for (Quiz_Player__c player : players) {
            // if previous score is larger than current score, increment rank
            if (lastScore > player.Score__c) {
                rank++;
            }
            player.Ranking__c = rank;
            lastScore = player.Score__c;
        }
        update players;
    }
}