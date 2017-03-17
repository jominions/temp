<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>创建用户组<!--<SIAT_zh_CN original="Create User Group">创建用户组</SIAT_zh_CN>--></title>
</head>

<body>

<div class="body">
    <h1>创建用户组<!--<SIAT_zh_CN original="Create User Group">创建用户组</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${userGroupInstance}">
        <div class="errors">
            <g:renderErrors bean="${userGroupInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">名称:<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'name', 'errors')}">
                        <input type="text" id="name" name="name"
                               value="${fieldValue(bean: userGroupInstance, field: 'name')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: userGroupInstance, field: 'description', 'errors')}">
                        <textarea rows="5" cols="40"
                                  name="description">${fieldValue(bean: userGroupInstance, field: 'description')}</textarea>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="enabled">已启用:<!--<SIAT_zh_CN original="Enabled">已启用</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'enabled', 'errors')}">
                        <g:checkBox name="enabled" value="${userGroupInstance?.enabled}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="uniqueId">唯一的Id:<!--<SIAT_zh_CN original="Unique Id">唯一的Id</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userGroupInstance, field: 'uniqueId', 'errors')}">
                        <input type="text" id="uniqueId" name="uniqueId"
                               value="${fieldValue(bean: userGroupInstance, field: 'uniqueId')}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><input class="save" type="submit" value="创建"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
