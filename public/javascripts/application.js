TrainChallange = (function(){
    var setText = function(){
      $("#fittext").fitText(1.2);  
    };
    return{
        init:function(){
            setEvents();
            setText();
        }
    }
})();
$(document).ready(function(){
   TrainChallange.init();
});