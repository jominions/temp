<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示用户组<!--<SIAT_zh_CN original="Show User Group">显示用户组</SIAT_zh_CN>--></title>
</head>

<body>

<div class="body">
    <h1>用户组<!--<SIAT_zh_CN original="User Group">用户组</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">Id:<!--<SIAT_zh_CN original="Id">Id</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">已启用:<!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'enabled')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'description')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">组类别:<!--<SIAT_zh_CN original="Group Category">组类别</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'groupCategory')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name">名称:<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'name')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">类型:<!--<SIAT_zh_CN original="Type">类型</SIAT_zh_CN>--></td>

                <td valign="top" class="value">${fieldValue(bean: userGroupInstance, field: 'type')}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">成员:<!--<SIAT_zh_CN original="Members">成员</SIAT_zh_CN>--></td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="m" in="${userGroupInstance.members}">
                            <li><g:link controller="authUser" action="show"
                                        id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">访问案例:<!--<SIAT_zh_CN original="Access to Studies">访问案例</SIAT_zh_CN>--></td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${org.transmart.searchapp.SecureObjectAccess.findAllByPrincipal(userGroupInstance, [sort: accessLevel])}"
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
            <input type="hidden" name="id" value="${userGroupInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                               action="Delete"  value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
