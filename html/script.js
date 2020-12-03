window.addEventListener('message', function (event) {
    $("#StatusHud #stress").hide()
    let data = event.data
    loadStats = function(){
        $('#shieldval').html(Math.round(data.armour))
        $('#hungerlevel').html(Math.round(data.food))
        $('#waterlevel').html(Math.round(data.thirst))
        $('#stresslevel').html(Math.round(data.stress))
    }
    if (data.hud && !data.pauseMenu){
        $("body").show();
        if (data.health != -100){
            $('#healtlevel').html(Math.round(data.health))
            if (data.health < 50 ){
                $('#healtlevel').addClass('red')
            }else{
                $('#healtlevel').removeClass('red')
            }
        }else if(data.health == -100){
            $('#healtlevel').html("0")
            $('#healtlevel').addClass('red')
        }
        if(data.hudPosition == 'right'){
            $("#StatusHud").animate({"left": '28vh', "bottom":'3vh'},200 );
        }else{
            $("#StatusHud").animate({"left": '0.7vh', "bottom":'0.7vh'},350 );
        }
        loadStats();
        if (data.stress) {
            $("#StatusHud #stress").show() 
        }else if(!data.stress){
            $("#StatusHud #stress").hide()
        }
    }
});
