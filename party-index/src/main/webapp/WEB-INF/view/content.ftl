<#import "/master/blank.ftl" as master />

<@master.masterBlank>

    <@master.header></@master.header>

<div id="cont_tongzhigonggao">
    <div class="t_conts">
        <div class="t_left">
            <div class="t_tit">通知公告</div>
            <ul class="t_list">
                <li><a href="#this">网络课程</a></li>
                <li><a href="#this">党课视频</a></li>
                <li><a href="#this">学习讨论</a></li>
                <li><a href="#this">网络课程</a></li>
                <li><a href="#this">党课视频</a></li>
                <li><a href="#this">网络课程</a></li>
                <li><a href="#this">学习讨论</a></li>
            </ul>
        </div>
        <div class="t_right">
            <div class="t_cont_r">
                <div class="title">
                    <div class="t">${article.title}</div>
                </div>
                <div class="captial">关于党校改版的致歉信</div>
                <div class="time">${article.publishTime?string('yyyy-MM-dd')}</div>
                <div class="summary">
                    <p>摘要：</p>
                    <p>${(article.summary)!}</p>
                </div>
                <div class="text">
                    ${(article.content)!}
                </div>
            </div>
        </div>
    </div>
</div>

    <@master.footer></@master.footer>

</@master.masterBlank>
