<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>安全对象(SecureObject) 列表<!--<SIAT_zh_CN original="SecureObject List">安全对象(SecureObject) 列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>安全对象(SecureObject) 列表<!--<SIAT_zh_CN original="SecureObject List">安全对象(SecureObject) 列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="Id"/>

                <g:sortableColumn property="bioDataId" title="生物数据Id"/><!--<SIAT_zh_CN original="Bio Data Id">生物数据Id</SIAT_zh_CN>-->

                <g:sortableColumn property="dataType" title="数据类型"/><!--<SIAT_zh_CN original="Data Type">数据类型</SIAT_zh_CN>-->

                <g:sortableColumn property="bioDataUniqueId" title="生物数据唯一Id"/><!--<SIAT_zh_CN original="Bio Data Unique Id">生物数据唯一Id</SIAT_zh_CN>-->

                <g:sortableColumn property="displayName" title="显示名称"/><!--<SIAT_zh_CN original="Display Name ">显示名称</SIAT_zh_CN>-->

            </tr>
            </thead>
            <tbody>
            <g:each in="${secureObjectInstanceList}" status="i" var="secureObjectInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${secureObjectInstance.id}">${fieldValue(bean: secureObjectInstance, field: 'id')}</g:link></td>

                    <td>${fieldValue(bean: secureObjectInstance, field: 'bioDataId')}</td>

                    <td>${fieldValue(bean: secureObjectInstance, field: 'dataType')}</td>

                    <td>${fieldValue(bean: secureObjectInstance, field: 'bioDataUniqueId')}</td>

                    <td>${fieldValue(bean: secureObjectInstance, field: 'displayName')}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${secureObjectInstanceTotal}"/>
    </div>
</div>
</body>
</html>
