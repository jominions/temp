<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>授权新的访问控制<!--<SIAT_zh_CN original="Grant New Access Control">授权新的访问控制</SIAT_zh_CN>--></title>
    <g:setProvider library="prototype"/>
</head>

<body>
<div class="body">
    <h1>授权新的访问控制<!--<SIAT_zh_CN original="Grant New Access Control">授权新的访问控制</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${authUserSecureAccessInstance}">
        <div class="errors">
            <g:renderErrors bean="${authUserSecureAccessInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
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
                                  value="${authUserSecureAccessInstance?.authUser?.id}" noSelection="['null': '']"
                                  onchange="${remoteFunction(action: 'listAccessLevel',
                                          update: 'accessLevelList',
                                          params: '\'id=\'+this.value')}"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accessLevel">访问级别:<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: authUserSecureAccessInstance, field: 'accessLevel', 'errors')}">
                        <g:select id="accessLevelList" optionKey="id" optionValue="accessLevelName"
                                  from="${SecureAccessLevel.listOrderByAccessLevelValue()}" name="accessLevel.id"
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
            <span class="button"><input class="save" type="submit" value="创建"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
