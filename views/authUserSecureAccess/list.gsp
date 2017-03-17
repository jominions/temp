<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>访问控制列表<!--<SIAT_zh_CN original="Access Control List">访问控制列表</SIAT_zh_CN>--></title>
</head>

<body>
<g:render template="/layouts/commonheader" model="['app': 'authUserSecureAccess']"/>
<div class="body">
    <h1>授权用户安全访问列表<!--<SIAT_zh_CN original="AuthUserSecureAccess List">授权用户安全访问列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>
                <g:sortableColumn property="id" title="Id"/><!--<SIAT_zh_CN original="Id">Id</SIAT_zh_CN>-->
                <g:sortableColumn property="username" title="用户名"/><!--<SIAT_zh_CN original="User Name">用户名</SIAT_zh_CN>-->
                <g:sortableColumn property="accessLevelName" title="访问级别"/><!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>-->
                <g:sortableColumn property="displayName" title="安全对象"/><!--<SIAT_zh_CN original="Secure Object">安全对象</SIAT_zh_CN>-->
            </tr>
            </thead>
            <tbody>
            <g:each in="${authUserSecureAccessInstanceList}" status="i" var="authUserSecureAccessInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td><g:link action="show"
                                id="${authUserSecureAccessInstance.id}">${fieldValue(bean: authUserSecureAccessInstance, field: 'id')}</g:link></td>
                    <td>${fieldValue(bean: authUserSecureAccessInstance, field: 'authUser')}</td>
                    <td>${fieldValue(bean: authUserSecureAccessInstance, field: 'accessLevel.accessLevelName')}</td>
                    <td>${fieldValue(bean: authUserSecureAccessInstance, field: 'secureObject.displayName')}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${authUserSecureAccessInstanceTotal}"/>
    </div>
</div>
</body>
</html>
