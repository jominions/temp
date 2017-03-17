<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示登录日志<!--<SIAT_zh_CN original=“Show AccessLog">显示登录日志</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>显示登录日志<!--<SIAT_zh_CN original=“Show AccessLog">显示登录日志</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="accessLogInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: accessLogInstance, field: 'id')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="accessLogInstance.username" default="用户"/>:</td><!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>-->

                <td valign="top" class="value">${fieldValue(bean: accessLogInstance, field: 'username')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="accessLogInstance.event" default="事件"/>:</td><!--<SIAT_zh_CN original="Event">事件</SIAT_zh_CN>-->

                <td valign="top" class="value">${fieldValue(bean: accessLogInstance, field: 'event')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="accessLogInstance.eventmessage"
                                                         default="事件消息"/>:</td><!--<SIAT_zh_CN original="Event Message">事件消息</SIAT_zh_CN>-->

                <td valign="top" class="value">${fieldValue(bean: accessLogInstance, field: 'eventmessage')}</td>

            </tr>



            <tr class="prop">
                <td valign="top" class="name"><g:message code="accessLogInstance.accesstime"
                                                         default="访问时间"/>:</td><!--<SIAT_zh_CN original="Access Time">访问时间</SIAT_zh_CN>-->

                <td valign="top" class="value">${fieldValue(bean: accessLogInstance, field: 'accesstime')}</td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${accessLogInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original=Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm("你确定吗?");"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original=“Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
