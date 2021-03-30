//Documentation: https://forcepanda.wordpress.com/2019/07/19/add-confetti-effect-to-lightning-components-and-flows/

({

    launchConfetti : function(component, event, helper){
        var end = Date.now() + (3 * 100);
        
        var interval = setInterval(function() {
            if (Date.now() > end) {
                return clearInterval(interval);
            }
            
            confetti({
                particleCount : 450,
                startVelocity: 30,
                spread: 360,
                ticks: 60,
                origin: {
                    x: Math.random(),
                    // since they fall down, start a bit higher than random
                    y: Math.random() - 0.2
                },
                colors : component.get("v.colors")
            });
        }, 200);
    },
    
    
})