<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑授权用户<!--<SIAT_zh_CN original="Edit AuthUser">编辑授权用户</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>编辑授权用户<!--<SIAT_zh_CN original="Edit AuthUser">编辑授权用户</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${person}">
        <div class="errors">
            <g:renderErrors bean="${person}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="prop">
        <span class="name">WWID:<!--<SIAT_zh_CN original="WWID">WWID</SIAT_zh_CN>--></span>
        <span class="value">${person.id}</span>
    </div>

    <g:form>
        <input type="hidden" name="id" value="${person.id}"/>
        <input type="hidden" name="version" value="${person.version}"/>

        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name"><label for="username">登录用户名:<!--<SIAT_zh_CN original="Login Name">登录用户名</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'username', 'errors')}">
                        <input type="text" id="username" name="username" value="${person.username?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="userRealName">用户全名:<!--<SIAT_zh_CN original="Full Name">用户全名</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'userRealName', 'errors')}">
                        <input type="text" id="userRealName" name="userRealName"
                               value="${person.userRealName?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="passwd">密码:<!--<SIAT_zh_CN original="Password">密码</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'passwd', 'errors')}">
                        <input type="password" id="passwd" name="passwd" value=""/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="enabled">已启用:<!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'enabled', 'errors')}">
                        <g:checkBox name="enabled" value="${person.enabled}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="description">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'description', 'errors')}">
                        <input type="text" id="description" name="description"
                               value="${person.description?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="email">邮箱:<!--<SIAT_zh_CN original="Email">邮箱</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
                        <input type="text" id="email" name="email" value="${person?.email?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="emailShow">显示邮箱:<!--<SIAT_zh_CN original="Show Email">显示邮箱</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'emailShow', 'errors')}">
                        <g:checkBox name="emailShow" value="${person.emailShow}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="authorities">角色:<!--<SIAT_zh_CN original="Roles">角色</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value ${hasErrors(bean: person, field: 'authorities', 'errors')}">
                        <ul>
                            <g:each var="entry" in="${roleMap}">
                                <li>${entry.key.authority.encodeAsHTML()}
                                <g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
                                </li>
                            </g:each>
                        </ul>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </div>

    </g:form>

</div>
</body>
</html>
