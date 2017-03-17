<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>创建 Requestmap<!--<SIAT_zh_CN original="Create Requestmap">创建 Requestmap</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>创建 Requestmap<!--<SIAT_zh_CN original="Create Requestmap">创建 Requestmap</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${requestmap}">
        <div class="errors">
            <g:renderErrors bean="${requestmap}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
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
                        <input type="text" id="configAttribute" name="configAttribute"
                               value="${requestmap.configAttribute?.encodeAsHTML()}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><input class="save" type="submit" value="Create"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
