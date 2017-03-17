<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>角色列表<!--<SIAT_zh_CN original="Role List">角色列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>角色列表<!--<SIAT_zh_CN original="Role List">角色列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>
                <g:sortableColumn property="id" title="ID"/>
                <g:sortableColumn property="authority" title="角色名称"/><!--<SIAT_zh_CN original="Role Name">角色名称</SIAT_zh_CN>-->
                <g:sortableColumn property="description" title="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${authorityList}" status="i" var="authority">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${authority.id}</td>
                    <td>${authority.authority?.encodeAsHTML()}</td>
                    <td>${authority.description?.encodeAsHTML()}</td>
                    <td class="actionButtons">
                        <span class="actionButton">
                            <g:link action="show" id="${authority.id}"><!--<SIAT_zh_CN original="Show">显示</SIAT_zh_CN>--></g:link>
                        </span>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${org.transmart.searchapp.Role.count()}"/>
    </div>
</div>
</body>
</html>
