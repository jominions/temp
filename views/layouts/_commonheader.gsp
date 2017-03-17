<g:if test="${debug}">
    <div id="search-explain" class="overlay">
        <b>搜索解析器<!--<SIAT_zh_CN original="Search Explainer">搜索解析器</SIAT_zh_CN>--></b>
        <span style="font-family:'Lucida Console', monospace" id="searchlog">&nbsp;</span>
    </div>
</g:if>

<table class="menuDetail" width="100%" style="height: 28px; border-collapse: collapse">
    <tr>
        <th class="menuBar" style="width: 20px">&nbsp;</th>
        <th class="menuBar" style="width: 150px"><g:if test="${'rwg' == app || 'datasetExplorer' == app}"><select
                id="search-categories"></select></g:if></th>
        <th class="menuBar" style="width: 190px"><g:if test="${'rwg' == app || 'datasetExplorer' == app}"><input
                id="search-ac"/></g:if></th>
        <th class="menuBar" style="width: 110px">
            <g:if test="${'rwg' == app}">
                <div id="cartbutton" class="greybutton">
                    <%-- <g:remoteLink controller="export" action="selection" update="${overlayExportDiv}"
                                 params="[eleId:overlayExportDiv]"
                                 before="initLoadingDialog('${overlayExportDiv}')" onComplete="centerDialog('${overlayExportDiv}')">--%>
                    <img src="${resource(dir: 'images', file: 'cart.png')}"/> 导出数据暂存区<!--<SIAT_zh_CN original="Export Cart">导出数据暂存区</SIAT_zh_CN>-->
                <%-- </g:remoteLink>--%>
                    <div id="cartcount">${exportCount ?: 0}</div>
                </div>
            </g:if>
        </th>
        <th class="menuBar" style="text-align: left;">
            <!-- menu links -->
            <table class="menuDetail" id="menuLinks" style="width: 1px;"
                   align="right"><!-- Use minimum possible width -->
                <tr>
                    <th width="150">&nbsp;</th>
                    <%--See Config.groovy--%>
                    <g:if test="${grailsApplication.config.ui.tabs.search.show}">
                        <g:if test="${'search'==app}"><th class="menuVisited">搜索<!--<SIAT_zh_CN original="Search">搜索</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="search">搜索<!--<SIAT_zh_CN original="Search">搜索</SIAT_zh_CN>--></g:link></th></g:else>
                    </g:if>

                    <g:if test="${!grailsApplication.config.ui.tabs.browse.hide}">
                        <g:if test="${'rwg' == app}"><th class="menuVisited">浏览<!--<SIAT_zh_CN original="Browse">浏览</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="RWG">浏览<!--<SIAT_zh_CN original="Browse">浏览</SIAT_zh_CN>--></g:link></th></g:else>
                    </g:if>
                    <%--Analyze tab is always visible--%>
                    <g:if test="${'datasetExplorer' == app}"><th class="menuVisited">分析<!--<SIAT_zh_CN original="Analyze">分析</SIAT_zh_CN>--></th></g:if>
                    <g:else><th class="menuLink"><g:link controller="datasetExplorer">分析<!--<SIAT_zh_CN original="Analyze">分析</SIAT_zh_CN>--></g:link></th></g:else>

                    <g:if test="${!grailsApplication.config.ui.tabs.sampleExplorer.hide}">
                        <g:if test="${'sampleexplorer' == app}"><th class="menuVisited">样本管理器<!--<SIAT_zh_CN original="Sample Explorer">样本管理器</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="sampleExplorer">样本管理器<!--<SIAT_zh_CN original="Sample Explorer">样本管理器</SIAT_zh_CN>--></g:link></th></g:else>
                    </g:if>

                    <g:if test="${!grailsApplication.config.ui.tabs.geneSignature.hide}">
                        <g:if test="${'genesignature' == app}"><th class="menuVisited">基因印记列表<!--<SIAT_zh_CN original="Gene&nbsp;Signature/Lists">基因印记列表</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="geneSignature">基因印记列表<!--<SIAT_zh_CN original="Gene&nbsp;Signature/Lists">基因印记列表</SIAT_zh_CN>--></g:link></th></g:else>
                    </g:if>

                    <g:if test="${!grailsApplication.config.ui.tabs.gwas.hide}">
                        <g:if test="${'gwas' == app}"><th class="menuVisited">GWAS</th></g:if>
                        <g:else><th class="menuLink"><g:link controller="GWAS">GWAS</g:link></th></g:else>
                    </g:if>

                    <g:if test="${!grailsApplication.config.ui.tabs.uploadData.hide}">
                        <g:if test="${'uploaddata' == app}"><th class="menuVisited">上传数据<!--<SIAT_zh_CN original="Upload Data">上传数据</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="uploadData">上传数据<!--<SIAT_zh_CN original="Upload Data">上传数据</SIAT_zh_CN>--></g:link></th></g:else>
                    </g:if>

                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <g:if test="${'accesslog' == app}"><th class="menuVisited">管&nbsp;理&nbsp;员<!--<SIAT_zh_CN original="Admin">管理员</SIAT_zh_CN>--></th></g:if>
                        <g:else><th class="menuLink"><g:link controller="accessLog">管&nbsp;理&nbsp;员<!--<SIAT_zh_CN original="Admin">管理员</SIAT_zh_CN>--></g:link></th></g:else>
                    </sec:ifAnyGranted>

                    <tmpl:/layouts/utilitiesMenu/>
                </tr>
            </table>
        </th>

    </tr>
</table>

<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'sanofi.css')}">

<script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.idletimeout.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.idletimer.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'sessiontimeout.js')}"></script>

<!-- Session timeout dialog -->
<div id="timeout-div" title="Your session is about to expire!">
    <p>你将在<span id="timeout-countdown"></span> 秒内登出系统。</p><!--<SIAT_zh_CN original="You will be logged off in <span id="timeout-countdown"></span> seconds.">你将在<span id="timeout-countdown"></span> 秒内登出系统。</SIAT_zh_CN>-->

    <p>希望继续你的会话吗？<!--<SIAT_zh_CN original="Do you want to continue your session?">希望继续你的会话吗？</SIAT_zh_CN>--></p>
</div>
<r:require module="session_timeout_nodep"/>
<r:script>
    jQuery(document).ready(function() {
        addTimeoutDialog({
            sessionTimeout : ${grails.util.Holders.config.com.recomdata.sessionTimeout},
            heartbeatURL : "${createLink([controller: 'userLanding', action: 'checkHeartBeat'])}",
            heartbeatLaps : ${grails.util.Holders.config.com.recomdata.heartbeatLaps},
            logoutURL : "${createLink([controller: 'login', action: 'forceAuth'])}"
        });
   });
</r:script>
