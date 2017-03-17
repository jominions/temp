<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>创建反馈<!--<SIAT_zh_CN original="Create Feedback">创建反馈</SIAT_zh_CN>--></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'feedback.css')}"/>
</head>

<body>
<g:render template="/layouts/commonheader" model="['app': 'feedback']"/>
<div class="nav">
    <span class="menuButton"><g:link class="list" action="list">反馈列表<!--<SIAT_zh_CN original="Feedback List">反馈列表</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>创建反馈<!--<SIAT_zh_CN original="Create Feedback">创建反馈</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${feedback}">
        <div class="errors">
            <g:renderErrors bean="${feedback}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="appuser">用户:<!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: feedback, field: 'searchUserId', 'errors')}">
                        <input type="text" id="searchUserId" name="searchUserId"
                               value="${fieldValue(bean: feedback, field: 'searchUserId')}"/>
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
            <span class="button"><input class="save" type="submit" value="创建"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
