TrainChallange = (function(){
    var setTitle = function(){
        $("article").bind("end.pjax", function(){
            $("title").text($("h2#fittext").text().substr(0, 100));
        });
    };
    var setText = function(){
      $("#fittext").fitText(1.2);  
    };
    var initPjax = function(){
        $('a[data-pjax]').pjax('article');
    };
    var getJoke = function(){
        if($('#joke-url').length > 0){
            $.pjax({
                url: $('#joke-url').data('url'),
                container: 'article'
            });
        }
    };
    return{
        init:function(){
            setText();
            initPjax();
            getJoke();
            setTitle();
        }
    };
})();

$(document).ready(function(){
   TrainChallange.init();
});
