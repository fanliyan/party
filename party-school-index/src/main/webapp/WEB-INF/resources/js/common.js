function Year_Month(){
    var now = new Date();
    var yy = now.getFullYear();
    var mm = now.getMonth()+1;
    return(yy + '年' + mm + '月');
}

function Date_of_Today(){
    var now = new Date();
    return(now.getDate() + '日');
}

function Day_of_Today(){
    var day = new Array();
    day[0] = "星期日";
    day[1] = "星期一";
    day[2] = "星期二";
    day[3] = "星期三";
    day[4] = "星期四";
    day[5] = "星期五";
    day[6] = "星期六";
    var now = new Date();
    return(day[now.getDay()]);
}

function CurentTime(){
    var now = new Date();
    var hh = now.getHours();
    var mm = now.getMinutes();
    var ss = now.getTime() % 60000;
    ss = (ss - (ss % 1000)) / 1000;
    var clock = hh+':';
    if (mm < 10) clock += '0';
    clock += mm+':';
    if (ss < 10) clock += '0';
    clock += ss;
    return(clock);
}

function refreshCalendarClock(){
    document.all.year.innerHTML = Year_Month();
    document.all.today.innerHTML = Date_of_Today();
    document.all.week.innerHTML = Day_of_Today();
    document.all.time.innerHTML = CurentTime();
}


!function(){
    var timeDiv = $(".left1");
    timeDiv.html(
        '<span class="ymd">'+
        '<b id="year"></b><b id="today"></b>'+
        ' <b id="week"></b>'+
        '</span>'+
        '  <span id="time"></span>');
    setInterval('refreshCalendarClock()',1000);
}();
