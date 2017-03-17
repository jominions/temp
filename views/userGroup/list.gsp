<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>用户组列表<!--<SIAT_zh_CN original="User Group List">用户组列表</SIAT_zh_CN>--></title>
</head>

<body>

<div class="body">
    <h1>用户组列表<!--<SIAT_zh_CN original="User Group List">用户组列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="id"/><!--<SIAT_zh_CN original="Id">id</SIAT_zh_CN>-->

                <g:sortableColumn property="name" title="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->

                <g:sortableColumn property="description" title="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->

                <g:sortableColumn property="enabled" title="已启用"/><!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>-->


                <g:sortableColumn property="groupCategory" title="组类别"/><!--<SIAT_zh_CN original="Group Category">组类别</SIAT_zh_CN>-->

            </tr>
            </thead>
            <tbody>
            <g:each in="${userGroupInstanceList}" status="i" var="userGroupInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${userGroupInstance.id}">${fieldValue(bean: userGroupInstance, field: 'id')}</g:link></td>

                    <td>${fieldValue(bean: userGroupInstance, field: 'name')}</td>

                    <td>${fieldValue(bean: userGroupInstance, field: 'description')}</td>

                    <td>${fieldValue(bean: userGroupInstance, field: 'enabled')}</td>


                    <td>${fieldValue(bean: userGroupInstance, field: 'groupCategory')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">

    </div>
</div>
</body>
</html>
