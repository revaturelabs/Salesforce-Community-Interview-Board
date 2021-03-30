//Preforms confetti effects on page load, calls helper for defined confetti patterns.

({ 
    fireUp : function(component, event, helper){
        setTimeout(function() {
        	helper.winnerCelebration(component);
        }, 200);

        var burst = setInterval(function() {
    		helper.basicCannon(component);
		}, 500)
        
        setTimeout(function() {
            clearInterval(burst);
        }, 1750);
        
    	setTimeout(function() {
    		helper.fireworks(component);
		}, 500)
	}
})