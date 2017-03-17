<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示 Requestmap<!--<SIAT_zh_CN original="Show Requestmap">显示 Requestmap</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>显示 Requestmap<!--<SIAT_zh_CN original="Show Requestmap">显示 Requestmap</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">ID<!--<SIAT_zh_CN original="ID">ID</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${requestmap.id}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">URL<!--<SIAT_zh_CN original="URL">URL</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${requestmap.url}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">角色<!--<SIAT_zh_CN original="Roles">角色</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${requestmap.configAttribute}</td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${requestmap.id}"/>
             <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>

            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
             action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>

</div>
</body>
</html>
