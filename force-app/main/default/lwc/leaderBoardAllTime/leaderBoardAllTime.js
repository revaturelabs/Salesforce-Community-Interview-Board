import { LightningElement, track} from 'lwc';
import getPlayersSortedByAllTimeScore from '@salesforce/apex/QuizController.getPlayersSortedByAllTimeScore';
import { reduceErrors } from 'c/errorUtils';

export default class LeaderBoardAllTime extends LightningElement {
    error;
    @track players = [];
    @track playerarray = [];

    connectedCallback() {
        getPlayersSortedByAllTimeScore({ maxFetchCount: 3 }) //maxFetchCount = # of players shown on leaderboard    
        .then((players) => {
                this.error = undefined;
                this.displayPlayers(players);
            })
            .catch((error) => {
                this.error = reduceErrors(error+'ERROR ON LINE 18');
                players = undefined;
            });
    }
    
    displayPlayers(players) {
        const playersToDisplay = JSON.parse(JSON.stringify(players));
        this.playerarray = [];

        
       const intervalId = setInterval(() => {
            if (playersToDisplay.length > 0) {
                const player = playersToDisplay.shift();
                this.playerarray.push(player);
            } else {
                clearInterval(intervalId);
            }
        }, 100);
  
    }        
}