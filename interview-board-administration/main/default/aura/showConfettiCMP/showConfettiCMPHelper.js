//Documentation: https://forcepanda.wordpress.com/2019/07/19/add-confetti-effect-to-lightning-components-and-flows/

({
    basicCannon : function(component, event, helper) {
        confetti({
            particleCount: 200,
            startVelocity: 60,
            spread: 150,
            origin: {
                y: 0.9
            },
            colors : component.get("v.colors")
        });
    },
    
    fireworks : function(component, event, helper){
        var end = Date.now() + (15 * 100);
        
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
    
    confettiShower : function(component, event, helper){
        var end = Date.now() + (15 * 100);
        
        (function frame() {
            confetti({
                particleCount: 10,
                startVelocity: 0,
                ticks: 300,
                origin: {
                    x: Math.random(),
                    // since they fall down, start a bit higher than random
                    y: 0
                },
                colors: component.get("v.colors")
            });
            
            if (Date.now() < end) {
                requestAnimationFrame(frame);
            }
        }());
    },
    
    winnerCelebration : function(component, event, helper) {
        var end = Date.now() + (15 * 100);
        
        (function frame() {
            confetti({
                particleCount: 10,
                angle: 60,
                spread: 25,
                origin: {
                    x: 0,
                    y : 0.65
                },
                colors: component.get("v.colors")
            });
            confetti({
                particleCount: 10,
                angle: 120,
                spread: 25,
                origin: {
                    x: 1,
                    y : 0.65
                },
                colors: component.get("v.colors")
            });
            
            if (Date.now() < end) {
                requestAnimationFrame(frame);
            }
        }());
    },
    
    canvasConfetti : function(component, event, helper){
        debugger;
        var canvas =  document.getElementById("customCanvas"); //component.find("customCanvas");
        
        
        // save this function... we'll save it to the canvas itself for
        // the purpose of this demo
        canvas.confetti = canvas.confetti || confetti.create(canvas, {
            resize: true
        });
        
        canvas.confetti({
            spread: 70,
            origin: {
                y: 1.2
            },
            colors : component.get("v.colors")
        });
    },
    
    busrtMode : function(component, event, helper){
        
        var end = Date.now() + (15 * 75);
        
        // go Buckeyes!
        var colors = ['#610B0B','#FFFF00','#FF00BF','#0040FF','#585858','#00FFBF','#FE642E','#FFBF00','#0101DF','#FF8000','#00FF00','#FF0040','#A901DB','#0B0B3B','#FF0000'];
        
        (function frame() {
            confetti({
                particleCount: 7,
                startVelocity: 25,
                angle: 335,
                spread: 10,
                origin: {
                    x: 0,
                    y: 0,
                },
                colors: colors
            }); 
            confetti({
                particleCount: 7,
                startVelocity: 25,
                angle: 205,
                spread: 10,
                origin: {
                    x: 1,
                    y: 0,
                },
                colors: colors
            });
            
            confetti({
                particleCount: 7,
                startVelocity: 35,
                angle: 140,
                spread: 30,
                origin: {
                    x: 1,
                    y: 1,
                },
                colors: colors
            });
            
            confetti({
                particleCount: 7,
                startVelocity: 35,
                angle: 40,
                spread: 30,
                origin: {
                    x: 0,
                    y: 1,
                },
                colors: colors
            });
            
            if (Date.now() < end) {
                requestAnimationFrame(frame);
            }
        }());
    }
})