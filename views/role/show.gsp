<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示角色<!--<SIAT_zh_CN original="Show Role">显示角色</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>显示角色<!--<SIAT_zh_CN original="Show Role">显示角色</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">ID<!--<SIAT_zh_CN original="ID">ID</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${authority.id}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">角色名称<!--<SIAT_zh_CN original="Role Name">Role Name</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${authority.authority}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${authority.description}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">包含用户<!--<SIAT_zh_CN original="People">包含用户</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">&nbsp;</td>

            </tr>
            <tr class="prop">
                <td colspan="2">

                    <table>
                        <thead>
                        <tr>
                            <g:sortableColumn property="id" title="WWID"/>
                            <g:sortableColumn property="username" title="登陆名称"/><!--<SIAT_zh_CN original="Login Name">登陆名称</SIAT_zh_CN>-->
                            <g:sortableColumn property="userRealName" title="全名"/><!--<SIAT_zh_CN original="Full Name">全名</SIAT_zh_CN>-->
                            <g:sortableColumn property="enabled" title="已启用"/><!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>-->
                            <g:sortableColumn property="description" title="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${authority.people}" status="i" var="person">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td>${person.id}</td>
                                <td>${person.username?.encodeAsHTML()}</td>
                                <td>${person.userRealName?.encodeAsHTML()}</td>
                                <td>${person.enabled?.encodeAsHTML()}</td>
                                <td>${person.description?.encodeAsHTML()}</td>
                                <td class="actionButtons">
                                    <span class="actionButton">
                                        <g:link controller="authUser" action="show" id="${person.id}">详细内容<!--<SIAT_zh_CN original="Detail">详细内容</SIAT_zh_CN>--></g:link>
                                    </span>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>

                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${authority?.id}"/>
           <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>

            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
          action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>

</div>

</body>
</html>