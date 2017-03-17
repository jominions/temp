<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>授权用户列表<!--<SIAT_zh_CN original="AuthUser List">授权用户列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>授权用户列表<!--<SIAT_zh_CN original="AuthUser List">授权用户列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>
                <g:sortableColumn property="id" title="全球标识符"/><!--<SIAT_zh_CN original="WWID">全球标识符</SIAT_zh_CN>-->
                <g:sortableColumn property="username" title="登录用户名"/><!--<SIAT_zh_CN original="Login Name">登录用户名</SIAT_zh_CN>-->
                <g:sortableColumn property="userRealName" title="用户全名"/><!--<SIAT_zh_CN original="Full Name">用户全名</SIAT_zh_CN>-->
                <g:sortableColumn property="enabled" title="已启用"/><!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>-->
                <g:sortableColumn property="description" title="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${personList}" status="i" var="person">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${person.id}</td>
                    <td>${person.username?.encodeAsHTML()}</td>
                    <td>${person.userRealName?.encodeAsHTML()}</td>
                    <td>${person.enabled?.encodeAsHTML()}</td>
                    <td>${person.description?.encodeAsHTML()}</td>
                    <td class="actionButtons">
                        <span class="actionButton">
                            <g:link action="show" id="${person.id}">显示<!--<SIAT_zh_CN original="Show">显示</SIAT_zh_CN>--></g:link>
                        </span>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${org.transmart.searchapp.AuthUser.count()}"/>
    </div>

</div>
</body>
</html>
