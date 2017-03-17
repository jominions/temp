<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>安全对象路径(SecureObjectPath)列表<!--<SIAT_zh_CN original="SecureObjectPath List">安全对象路径(SecureObjectPath)列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>安全对象路径(SecureObjectPath)列表<!--<SIAT_zh_CN original="SecureObjectPath List">安全对象路径(SecureObjectPath)列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="Id"/>

                <g:sortableColumn property="conceptPath" title="概念路径"/><!--<SIAT_zh_CN original="Concept Path">概念路径</SIAT_zh_CN>-->

                <th>安全对象<!--<SIAT_zh_CN original="Secure Object">安全对象(Secure Object)</SIAT_zh_CN>--></th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${secureObjectPathInstanceList}" status="i" var="secureObjectPathInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${secureObjectPathInstance.id}">${fieldValue(bean: secureObjectPathInstance, field: 'id')}</g:link></td>

                    <td>${fieldValue(bean: secureObjectPathInstance, field: 'conceptPath')}</td>

                    <td>${fieldValue(bean: secureObjectPathInstance, field: 'secureObject')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${secureObjectPathInstanceTotal}"/>
    </div>
</div>
</body>
</html>
