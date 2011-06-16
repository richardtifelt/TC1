TrainChallange = (function(){
    var setText = function(){
      $("#fittext").fitText(1.2);  
    };
    return{
        init:function(){
            setText();
        }
    }
})();
$(document).ready(function(){
    console.log("test");
   TrainChallange.init();
});