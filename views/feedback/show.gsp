<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示反馈<!--<SIAT_zh_CN original="Show Feedback">显示反馈</SIAT_zh_CN>--></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'feedback.css')}"/>
</head>

<body>
<g:render template="/layouts/commonheader" model="['app': 'feedback']"/>

<div class="nav">
    <span class="menuButton"><g:link class="list" action="list">反馈列表<!--<SIAT_zh_CN original="Feedback List">反馈列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">新建反馈<!--<SIAT_zh_CN original="New Feedback">新建反馈</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示反馈<!--<SIAT_zh_CN original="Show Feedback">显示反馈</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>
            <g:if test="${feedback.searchUserId != null && feedback.searchUserId.toString().length() > 0}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="feedback.searchUserId" default="用户"/><!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>-->:</td>
                    <td valign="top" class="value">${fieldValue(bean: feedback, field: 'searchUserId')}</td>
                </tr>
            </g:if>
            <g:if test="${feedback.createDate != null && feedback.createDate.toString().length() > 0}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="feedback.createDate" default="已创建"/><!--<SIAT_zh_CN original="Created">已创建</SIAT_zh_CN>-->:</td>
                    <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd"
                                                                 date="${feedback.createDate}"/></td>
                </tr>
            </g:if>
            <g:if test="${feedback.appVersion != null && feedback.appVersion.toString().length() > 0}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="feedback.appVersion" default="版本"/><!--<SIAT_zh_CN original="Version">版本</SIAT_zh_CN>-->:</td>
                    <td valign="top" class="value">${fieldValue(bean: feedback, field: 'appVersion')}</td>
                </tr>
            </g:if>
            <g:if test="${feedback.feedbackText != null && feedback.feedbackText.toString().length() > 0}">
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="feedback.feedbackText" default="反馈"/><!--<SIAT_zh_CN original="Feedback">反馈</SIAT_zh_CN>-->:</td>
                    <td valign="top" class="value">${fieldValue(bean: feedback, field: 'feedbackText')}</td>
                </tr>
            </g:if>
            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${feedback?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
