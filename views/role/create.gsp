<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>创建角色<!--<SIAT_zh_CN original="Create Role">创建角色</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">

    <h1>创建角色<!--<SIAT_zh_CN original="Create Role">创建角色</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${authority}">
        <div class="errors">
            <g:renderErrors bean="${authority}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name"><label for="authority">角色名称<!--<SIAT_zh_CN original="Role Name">Role Name</SIAT_zh_CN>-->:</label></td>
                    <td valign="top" class="value ${hasErrors(bean: authority, field: 'authority', 'errors')}">
                        <input type="text" id="authority" name="authority"
                               value="${authority?.authority?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="description">描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</label></td>
                    <td valign="top" class="value ${hasErrors(bean: authority, field: 'description', 'errors')}">
                        <input type="text" id="description" name="description"
                               value="${authority?.description?.encodeAsHTML()}"/>
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