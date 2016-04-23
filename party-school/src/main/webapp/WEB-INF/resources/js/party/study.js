/**
 * Created by kuangye on 2016/4/20.
 */
!function () {

    var ws;
    var obj = {
        data: {
            videoConfig: videoConfig,
            missed_heartbeats: 0,
            timerHeartBeat: "",
            message: 0,
            isStart:false
        },
        event:{
            data:"",
        },
        model: {
            userId: 0,
            courseId: 0,
            wareId: 0,
            message: "",
            code: "",
            hashcode: "",
            timestamp: ""
        },
        video: {
            element: "",
            video:"",
            init: function () {
                obj.video.element = videojs('video');

                player = obj.video.element;
                // 检测播放时间
                player.on('timeupdate', function () {
                    // console.log("当前播放时间：" + player.currentTime());
                });
                // 开始或恢复播放
                player.on('play', function () {
                    //学习开始/恢复播放
                    var jsonData = {
                        userId: obj.model.userId,
                        courseId: obj.model.courseId,
                        wareId: obj.model.wareId,
                        message: obj.data.message,
                        code: 301,
                        hashcode: obj.model.hashcode,
                        timestamp: new Date().getTime(),
                        duration: player.duration,
                        playedTime: player.currentTime()
                    };
                    obj.sedMsgToApi(jsonData);
                    // console.log('开始/恢复播放');
                    obj.data.isStart = true;
                });
                // 暂停播放
                player.on('pause', function () {
                    obj.data.message = new Date().getTime();
                    var jsonData = {
                        userId: obj.model.userId,
                        courseId: obj.model.courseId,
                        wareId: obj.model.wareId,
                        message: obj.data.message,
                        code: 302,
                        hashcode: obj.model.hashcode,
                        timestamp: new Date().getTime(),
                        duration: player.duration,
                        playedTime: player.currentTime()
                    };
                    obj.sedMsgToApi(jsonData);
                    // console.log('暂停播放');
                });
                player.on('ended', function () {
                    var jsonData = {
                        userId: obj.model.userId,
                        courseId: obj.model.courseId,
                        wareId: obj.model.wareId,
                        message: "停止播放",
                        code: 304,
                        hashcode: obj.model.hashcode,
                        timestamp: new Date().getTime(),
                        duration: player.duration,
                        playedTime: player.currentTime()
                    };
                    obj.sedMsgToApi(jsonData);

                    // console.log('停止播放');
                });
            }
        },
        plugin: {
            webSocket: "",
        },
        //onmessage
        getMsgFromApi: function () {
            obj.data.missed_heartbeats = 0;
            var data = event.data;
            if (data) {
                data = JSON.parse(data);
                if (data.code > 0) {
                    // console.log("status normal");
                } else if (data.code == 0) {
                    alert(data.message);
                }
            }
        },
        sedMsgToApi: function (jsonData, callback) {
            var data = JSON.stringify({
                userId: jsonData.userId,
                courseId: jsonData.courseId,
                wareId: jsonData.wareId,
                message: jsonData.message,
                code: jsonData.code,
                hashcode: jsonData.hashcode,
                timestamp: jsonData.timestamp,
                duration: jsonData.duration,
                playedTime: jsonData.playedTime
            });
            try{
                obj.plugin.webSocket.send(data);
                callback && callback();
            }catch (e){
                alert("系统异常，将自动刷新");
                location.reload();
                //是否要记录日志
            }
        },
        webSocketPingPong: function () {
            obj.data.timerHeartBeat = setInterval(function () {
                try {
                    var jsonData = {
                        userId: obj.model.userId,
                        courseId: obj.model.courseId,
                        wareId: obj.model.wareId,
                        message: "PINGPONG",
                        code: 500,
                        hashcode: obj.model.hashcode,
                        timestamp: new Date().getTime(),
                        duration: obj.video.element.duration,
                        playedTime: obj.video.element.currentTime()
                    };
                    obj.sedMsgToApi(jsonData);
                    if (obj.data.missed_heartbeats >= 3) {
                        obj.plugin.webSocket.close();
                        obj.plugin.webSocketFN();
                        alert("网络重新连接中……");
                        // throw new Error("Too many missed heartbeats.");
                    }
                    obj.data.missed_heartbeats++;
                } catch (e) {
                    clearInterval(obj.data.timerHeartBeat);
                }
            }, 5000);
        },
        webSocketFN: function () {
            obj.plugin.webSocket = new ReconnectingWebSocket(obj.data.videoConfig.wsurl);
            obj.plugin.webSocket.onmessage = obj.getMsgFromApi;
            obj.plugin.webSocket.onopen = obj.open;
        },
        open:function(){
            obj.firstConn();
        },
        lCallBack: {
            closeWindow: function () {
                obj.video.element.pause();
                obj.plugin.webSocket.close();
            },
            // ended: function () {
            //     obj.video.videoEnd();
            // }

        },
        listen: function () {

            // obj.video.element.addEventListener("ended", obj.lCallBack.ended); //播放结束

            window.onbeforeunload = obj.lCallBack.closeWindow;
            window.onunload = obj.lCallBack.closeWindow;
        },
        firstConn:function(){
            var jsonData = {
                userId: obj.model.userId,
                courseId: obj.model.courseId,
                wareId: obj.model.wareId,
                message: "",
                code: 0,
                hashcode: obj.model.hashcode,
                timestamp: new Date().getTime(),
                duration: 0,
                playedTime: 0
            };
            obj.sedMsgToApi(jsonData);

            $(obj.video.video).prop("controls",true);
        },
        fullValue:function(){
            obj.video.element = obj.data.videoConfig.video[0];

            obj.model.userId=obj.data.videoConfig.userId;
            obj.model.courseId=obj.data.videoConfig.courseId;
            obj.model.wareId=obj.data.videoConfig.wareId;
            obj.model.hashcode=obj.data.videoConfig.hashcode;
            obj.video.video = obj.data.videoConfig.video;
        },
        init: function () {

            obj.fullValue();

            obj.webSocketFN();

            obj.webSocketPingPong();

            obj.listen();

            obj.video.init();


        }
    };
    obj.init();
}();
