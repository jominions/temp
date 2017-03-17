<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>访问日志列表<!--<SIAT_zh_CN original="AccessLog List">访问日志列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <g:form name="form">
        <table style="width: 700px;"><tr><td>
           开始日期<!--<SIAT_zh_CN original="Start Date">开始日期</SIAT_zh_CN>-->&nbsp;&nbsp;<input id="startdate" name="startdate" type="text" value="${startdate}"></td>
            <td>截至日期<!--<SIAT_zh_CN original="End Date">截至日期</SIAT_zh_CN>-->&nbsp;&nbsp;<input id="enddate" name="enddate" type="text" value="${enddate}"></td>
            <td><g:actionSubmit class="filter" value="过滤器"
                                action="list"/><!--<SIAT_zh_CN original="Filter">过滤器</SIAT_zh_CN>-->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<g:actionSubmit class="filter"
                           value="导出至Excel"
                                    action="export"/><!--<SIAT_zh_CN original="Export to Excel">导出至Excel</SIAT_zh_CN>-->
            </td></tr></table>
    </g:form>
    <h1>访问日志列表<!--<SIAT_zh_CN original="AccessLog List">访问日志列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr style="height: 30px;">

                <th style="vertical-align: middle;"><g:message code="accessLogInstance.accesstime"
                                                               default="访问时间"/></th><!--<SIAT_zh_CN original="Access Time">访问时间</SIAT_zh_CN>-->


                <th style="vertical-align: middle;"><g:message code="accessLogInstance.username" default="用户"/></th><!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>-->


                <th style="vertical-align: middle;"><g:message code="accessLogInstance.event" default="事件"/></th><!--<SIAT_zh_CN original="Event">事件</SIAT_zh_CN>-->


                <th style="vertical-align: middle;"><g:message code="accessLogInstance.eventmessage"
                                                               default="事件消息"/></th><!--<SIAT_zh_CN original="Event Message">事件消息</SIAT_zh_CN>-->

            </tr>
            </thead>
            <tbody>
            <g:each in="${accessLogInstanceList}" status="i" var="accessLogInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="height: 30px;">

                    <td style="width: 180px; vertical-align: top;">${fieldValue(bean: accessLogInstance, field: 'accesstime')}</td>
                    <td style="width: 100px; vertical-align: top;">${fieldValue(bean: accessLogInstance, field: 'username')}</td>
                    <td style="width: 200px; vertical-align: top;">${fieldValue(bean: accessLogInstance, field: 'event')}</td>
                    <td style="vertical-align: top;">${fieldValue(bean: accessLogInstance, field: 'eventmessage')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate
                total="${totalcount}"
                maxsteps="${grailsApplication.config.com.recomdata.search.paginate.maxsteps}"
                max="${grailsApplication.config.com.recomdata.search.paginate.max}"/>
    </div>
</div>
<r:script>
    jQuery(function () {
        jQuery("#startdate").datepicker({ dateFormat: 'dd/mm/yy' });
    });
    jQuery(function () {
        jQuery("#enddate").datepicker({ dateFormat: 'dd/mm/yy' });
    });
</r:script>
</body>
</html>
