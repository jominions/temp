<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑 Requestmap<!--<SIAT_zh_CN original="Edit Requestmap">编辑 Requestmap</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>编辑 Requestmap<!--<SIAT_zh_CN original="Edit Requestmap">编辑 Requestmap</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${requestmap}">
        <div class="errors">
            <g:renderErrors bean="${requestmap}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="prop">
        <span class="name">ID<!--<SIAT_zh_CN original="ID">ID</SIAT_zh_CN>-->:</span>
        <span class="value">${requestmap.id}</span>
    </div>

    <g:form>
        <input type="hidden" name="id" value="${requestmap.id}"/>
        <input type="hidden" name="version" value="${requestmap.version}"/>

        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name"><label for="url">URL形式<!--<SIAT_zh_CN original="URL Pattern"></SIAT_zh_CN>-->:</label></td>
                    <td valign="top" class="value ${hasErrors(bean: requestmap, field: 'url', 'errors')}">
                        <input type="text" id="url" name="url" value="${requestmap.url?.encodeAsHTML()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><label for="configAttribute">角色 (以逗点隔开)<!--<SIAT_zh_CN original="Role (comma-delimited)">角色 (以逗点隔开)</SIAT_zh_CN>-->:</label></td>
                    <td valign="top" class="value ${hasErrors(bean: requestmap, field: 'configAttribute', 'errors')}">
                        <input type="text" name='configAttribute' value="${requestmap.configAttribute}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
           <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>

            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
             action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </div>

    </g:form>

</div>
</body>
</html>
