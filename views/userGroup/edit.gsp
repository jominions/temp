<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑用户组<!--<SIAT_zh_CN original="Edit UserGroup">编辑用户组</SIAT_zh_CN>--></title>
    <g:setProvider library="jquery"/>
</head>

<body>

<div class="body">
<h1>编辑用户组<!--<SIAT_zh_CN original="Edit UserGroup">编辑用户组</SIAT_zh_CN>--></h1>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${userGroupInstance}">
    <div class="errors">
        <g:renderErrors bean="${userGroupInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form method="post">
    <input type="hidden" name="id" value="${userGroupInstance?.id}"/>
    <input type="hidden" name="version" value="${userGroupInstance?.version}"/>

    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="enabled">启用:<!--<SIAT_zh_CN original="Enabled">启用</SIAT_zh_CN>--></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'enabled', 'errors')}">
                    <g:checkBox name="enabled" value="${userGroupInstance?.enabled}"></g:checkBox>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="description">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'description', 'errors')}">
                    <textarea rows="5" cols="40"
                              name="description">${fieldValue(bean: userGroupInstance, field: 'description')}</textarea>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="name">姓名:<!--<SIAT_zh_CN original="Name">姓名</SIAT_zh_CN>--></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'name', 'errors')}">
                    <input type="text" id="name" name="name"
                           value="${fieldValue(bean: userGroupInstance, field: 'name')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="reports">成员:<!--<SIAT_zh_CN original="Members">成员</SIAT_zh_CN>--></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'members', 'errors')}">
                    <table>
                        <tr><td></td><td></td><td><input
                                name="searchtext"
                                id="searchtext"><button
                                class=""
                                onclick="${remoteFunction(action:'searchUsersNotInGroup',update:[success:'groupmembers', failure:''], id:userGroupInstance?.id, params:'jQuery(\'#searchtext\').serialize()' )};
                                return false;">搜索用户<!--<SIAT_zh_CN original="Search Users">搜索用户</SIAT_zh_CN>--></button>
                        </td>
                        <tr><td>组成员:<!--<SIAT_zh_CN original="Members of group">组成员</SIAT_zh_CN>--></td><td></td><td>可用的用户:<!--<SIAT_zh_CN original="Available users">可用的用户</SIAT_zh_CN>--></td>
                        </tr>
                        <tr id="groupmembers">
                            <g:render template="addremove"
                                      bean="${userGroupInstance}"/>
                        </tr>
                    </table>
    </div>
    </td>
</tr>

</tbody>
</table>
</div>
    <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>--></span>
        <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗?');"
                                             action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
    </div>
</g:form>
</div>
</body>
</html>
