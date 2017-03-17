<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑授权用户安全访问<!--<SIAT_zh_CN original="Edit AuthUserSecureAccess">编辑授权用户安全访问</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>编辑授权用户安全访问<!--<SIAT_zh_CN original="Edit AuthUserSecureAccess">编辑授权用户安全访问</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${authUserSecureAccessInstance}">
        <div class="errors">
            <g:renderErrors bean="${authUserSecureAccessInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <input type="hidden" name="id" value="${authUserSecureAccessInstance?.id}"/>
        <input type="hidden" name="version" value="${authUserSecureAccessInstance?.version}"/>

        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="authUser">授权用户:<!--<SIAT_zh_CN original="Auth User">授权用户</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: authUserSecureAccessInstance, field: 'authUser', 'errors')}">
                        <g:select optionKey="id" from="${AuthUser.listOrderByUsername()}" name="authUser.id"
                                  value="${authUserSecureAccessInstance?.authUser?.id}"
                                  noSelection="['null': '']"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accessLevel">访问级别:<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: authUserSecureAccessInstance, field: 'accessLevel', 'errors')}">
                        <g:select optionKey="id" optionValue="accessLevelName" from="${accessLevelList}"
                                  name="accessLevel.id"
                                  value="${authUserSecureAccessInstance?.accessLevel?.id}"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secureObject">安全对象:<!--<SIAT_zh_CN original="Secure Object">安全对象</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: authUserSecureAccessInstance, field: 'secureObject', 'errors')}">
                        <g:select optionKey="id" optionValue="displayName"
                                  from="${org.transmart.searchapp.SecureObject.listOrderByDisplayName()}"
                                  name="secureObject.id"
                                  value="${authUserSecureAccessInstance?.secureObject?.id}"></g:select>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗?');"
                                                action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
