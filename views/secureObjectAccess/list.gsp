<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>安全对象访问权限列表<!--<SIAT_zh_CN original="SecureObjectAccess List">安全对象访问权限列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="create" action="create">创建安全对象访问权限<!--<SIAT_zh_CN original="New SecureObjectAccess">创建安全对象访问权限</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>安全对象访问权限列表<!--<SIAT_zh_CN original="SecureObjectAccess List">安全对象访问权限列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <th><g:message code="secureObjectAccessInstance.id" default="Id"/></th>


                <th><g:message code="secureObjectAccessInstance.principal" default="Principal"/></th>


                <th><g:message code="secureObjectAccessInstance.accessLevel" default="Access Level"/></th>


                <th><g:message code="secureObjectAccessInstance.secureObject" default="Secure Object"/></th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${secureObjectAccessInstanceList}" status="i" var="secureObjectAccessInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${secureObjectAccessInstance.id}">${fieldValue(bean: secureObjectAccessInstance, field: 'id')}</g:link></td>

                    <td>${fieldValue(bean: secureObjectAccessInstance, field: 'id')}</td>

                    <td>${fieldValue(bean: secureObjectAccessInstance, field: 'principal')}</td>

                    <td>${fieldValue(bean: secureObjectAccessInstance, field: 'accessLevel')}</td>

                    <td>${fieldValue(bean: secureObjectAccessInstance, field: 'secureObject')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${org.transmart.searchapp.SecureObjectAccess.count()}"/>
    </div>
</div>
</body>
</html>
