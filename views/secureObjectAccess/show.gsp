<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示安全对象访问权限(SecureObjectAccess)<!--<SIAT_zh_CN original="Show SecureObjectAccess">显示安全对象访问权限(SecureObjectAccess)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">安全对象访问权限列表<!--<SIAT_zh_CN original="SecureObjectAccess List">安全对象访问权限列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">创建安全对象访问权限<!--<SIAT_zh_CN original="New SecureObjectAccess">创建安全对象访问权限</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示安全对象访问权限(SecureObjectAccess)<!--<SIAT_zh_CN original="Show SecureObjectAccess">显示安全对象访问权限(SecureObjectAccess)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="secureObjectAccessInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectAccessInstance, field: 'id')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="secureObjectAccessInstance.principal"
                                                         default="负责人"/><!--<SIAT_zh_CN original="Principal">负责人</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><g:link controller="principal" action="show"
                                                       id="${secureObjectAccessInstance?.principal?.id}">${secureObjectAccessInstance?.principal?.encodeAsHTML()}</g:link></td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="secureObjectAccessInstance.accessLevel"
                                                         default="访问级别"/>:</td><!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>-->

                <td valign="top" class="value"><g:link controller="secureAccessLevel" action="show"
                                                       id="${secureObjectAccessInstance?.accessLevel?.id}">${secureObjectAccessInstance?.accessLevel?.encodeAsHTML()}</g:link></td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="secureObjectAccessInstance.secureObject"
                                                         default="安全对象"/>:</td><!--<SIAT_zh_CN original="Secure Object">安全对象</SIAT_zh_CN>-->

                <td valign="top" class="value"><g:link controller="secureObject" action="show"
                                                       id="${secureObjectAccessInstance?.secureObject?.id}">${secureObjectAccessInstance?.secureObject?.encodeAsHTML()}</g:link></td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${secureObjectAccessInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
            action="Delete" value="删除"/><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
