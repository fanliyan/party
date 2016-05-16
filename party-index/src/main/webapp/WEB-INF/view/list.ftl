<#import "/master/blank.ftl" as master />
<#import "/master/splitPage.ftl" as splitPage />

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
                    <div class="t">通知公告</div>
                    <dl class="check">
                        <dt>站内搜索：</dt>
                        <dd><input type="text" class="inp" /></dd>
                    </dl>
                </div>
                <ul class="list">
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                    <li><a href="#this">关于党校改版的致歉信</a><span class="date">2016-04-04</span></li>
                </ul>

                <@splitPage.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />

            </div>
        </div>
    </div>
</div>

    <@master.footer></@master.footer>

</@master.masterBlank>
