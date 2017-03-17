<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>用户<!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>用户<!--<SIAT_zh_CN original="User">用户</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">WWID:<!--<SIAT_zh_CN original="WWID">WWID</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.id}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">登录用户名:<!--<SIAT_zh_CN original="Login Name">登录用户名</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">用户全名:<!--<SIAT_zh_CN original="Full Name">用户全名</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.userRealName?.encodeAsHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">已启用:<!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.enabled}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.description?.encodeAsHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">邮箱:<!--<SIAT_zh_CN original="Email">邮箱</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">显示邮箱:<!--<SIAT_zh_CN original="Show Email">显示邮箱</SIAT_zh_CN>--></td>
                <td valign="top" class="value">${person.emailShow}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">角色:<!--<SIAT_zh_CN original="Roles">角色</SIAT_zh_CN>--></td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${roleNames}" var='name'>
                            <li>${name}</li>
                        </g:each>
                    </ul>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">用户组:<!--<SIAT_zh_CN original="Groups">用户组</SIAT_zh_CN>--></td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${person.groups}" var='group'>
                            <li><g:link controller="userGroup" action="show"
                                        id="${group.id}">${group.name}</g:link></li>
                        </g:each>
                    </ul>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">已分配的案例:<!--<SIAT_zh_CN original="Studies Assigned">已分配的案例</SIAT_zh_CN>--></td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${org.transmart.searchapp.SecureObjectAccess.findAllByPrincipal(person, [sort: accessLevel])}"
                                var='soa'>
                            <li>${soa.getObjectAccessName()}</li>
                        </g:each>
                    </ul>
                </td>
            </tr>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">案例访问(通过组):<!--<SIAT_zh_CN original="Studies with Access(via groups)">案例访问(通过组)</SIAT_zh_CN>--></td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${org.transmart.searchapp.AuthUserSecureAccess.findAllByAuthUser(person, [sort: accessLevel])}"
                                var='soa'>
                            <li><g:link controller="secureObject" action="show"
                                        id="${soa.secureObject.id}">${soa.getObjectAccessName()}</g:link></li>
                        </g:each>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${person.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>

</div>
</body>
</html>
