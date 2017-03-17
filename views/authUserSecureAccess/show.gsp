<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示授权用户安全访问<!--<SIAT_zh_CN original="Show AuthUserSecureAccess">显示授权用户安全访问</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>显示访问控制<!--<SIAT_zh_CN original="Show Access Control">显示访问控制</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">Id:<!--<SIAT_zh_CN original="Id">Id</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: authUserSecureAccessInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">授权用户:<!--<SIAT_zh_CN original="Auth User">授权用户</SIAT_zh_CN>--></td>

                <td valign="top" class="value"><g:link controller="authUser" action="show"
                                                       id="${authUserSecureAccessInstance?.authUser?.id}">${authUserSecureAccessInstance?.authUser?.username?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">Access Level:<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>--></td>

                <td valign="top" class="value"><g:link controller="secureAccessLevel" action="show"
                                                       id="${authUserSecureAccessInstance?.accessLevel?.id}">${authUserSecureAccessInstance?.accessLevel?.accessLevelName?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">安全对象:<!--<SIAT_zh_CN original="Secure Object">安全对象</SIAT_zh_CN>--></td>

                <td valign="top" class="value"><g:link controller="secureObject" action="show"
                                                       id="${authUserSecureAccessInstance?.secureObject?.id}">${authUserSecureAccessInstance?.secureObject?.displayName?.encodeAsHTML()}</g:link></td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${authUserSecureAccessInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
