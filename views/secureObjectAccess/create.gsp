<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>创建安全对象访问权限(SecureObjectAccess)<!--<SIAT_zh_CN original="Create SecureObjectAccess">创建安全对象访问权限(SecureObjectAccess)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">安全对象访问权限(SecureObjectAccess)列表<!--<SIAT_zh_CN original="SecureObjectAccess List">安全对象访问权限(SecureObjectAccess)列表</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>创建安全对象访问权限(SecureObjectAccess)<!--<SIAT_zh_CN original="Create SecureObjectAccess">创建安全对象访问权限(SecureObjectAccess)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${secureObjectAccessInstance}">
        <div class="errors">
            <g:renderErrors bean="${secureObjectAccessInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="principal">负责人<!--<SIAT_zh_CN original="Principal">负责人</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: secureObjectAccess, field: 'principal', 'errors')}">
                        <g:select optionKey="id" from="${org.transmart.searchapp.Principal.list()}" name="principal.id"
                                  value="${secureObjectAccess?.principal?.id}" noSelection="['null': '']"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accessLevel">访问级别<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectAccess, field: 'accessLevel', 'errors')}">
                        <g:select optionKey="id" from="${org.transmart.searchapp.SecureAccessLevel.list()}"
                                  name="accessLevel.id" value="${secureObjectAccess?.accessLevel?.id}"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secureObject">安全对象(Secure Object)<!--<SIAT_zh_CN original="Secure Object">安全对象(Secure Object)</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectAccess, field: 'secureObject', 'errors')}">
                        <g:select optionKey="id" from="${org.transmart.searchapp.SecureObject.list()}"
                                  name="secureObject.id" value="${secureObjectAccess?.secureObject?.id}"></g:select>
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
