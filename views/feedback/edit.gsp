<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>编辑反馈<!--<SIAT_zh_CN original="Edit Feedback">编辑反馈</SIAT_zh_CN>--></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'feedback.css')}"/>
</head>

<body>
<g:render template="/layouts/commonheader" model="['app': 'feedback']"/>
<div class="nav">
    <span class="menuButton"><g:link class="list" action="list">反馈列表<!--<SIAT_zh_CN original="Feedback List">反馈列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">新建反馈<!--<SIAT_zh_CN original="New Feedback">新建反馈</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>编辑反馈<!--<SIAT_zh_CN original="Edit Feedback">编辑反馈</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${feedback}">
        <div class="errors">
            <g:renderErrors bean="${feedback}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <input type="hidden" name="id" value="${feedback?.id}"/>

        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="appuser">用户:<!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: feedback, field: 'appUser', 'errors')}">
                        <input type="text" id="appUser" name="appUser"
                               value="${fieldValue(bean: feedback, field: 'appUser')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="createDate">已创建:<!--<SIAT_zh_CN original="Created">已创建</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: feedback, field: 'createDate', 'errors')}">
                        <g:datePicker name="createDate" value="${feedback?.createDate}" precision="day"></g:datePicker>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="appVersion">版本:<!--<SIAT_zh_CN original="Version">版本</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: feedback, field: 'appVersion', 'errors')}">
                        <input type="text" id="appVersion" name="appVersion"
                               value="${fieldValue(bean: feedback, field: 'appVersion')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="feedbackText">反馈:<!--<SIAT_zh_CN original="Feedback">反馈</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: feedback, field: 'feedbackText', 'errors')}">
                        <textarea id="feedbackText" name="feedbackText" rows="10"
                                  cols="100">${fieldValue(bean: feedback, field: 'feedbackText')}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
