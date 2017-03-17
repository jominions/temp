<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>创建 安全对象(SecureObject)<!--<SIAT_zh_CN original="Create SecureObject">创建 安全对象(SecureObject)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>创建 安全对象(SecureObject)<!--<SIAT_zh_CN original="Create SecureObject">创建 安全对象(SecureObject)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${secureObjectInstance}">
        <div class="errors">
            <g:renderErrors bean="${secureObjectInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="bioDataId">生物数据Id<!--<SIAT_zh_CN original="Bio Data Id">生物数据Id</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectInstance, field: 'bioDataId', 'errors')}">
                        <input type="text" id="bioDataId" name="bioDataId"
                               value="${fieldValue(bean: secureObjectInstance, field: 'bioDataId')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="dataType">数据类型<!--<SIAT_zh_CN original="Data Type">数据类型</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectInstance, field: 'dataType', 'errors')}">
                        <textarea rows="5" cols="40"
                                  name="dataType">${fieldValue(bean: secureObjectInstance, field: 'dataType')}</textarea>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="bioDataUniqueId">生物数据唯一Id<!--<SIAT_zh_CN original="Bio Data Unique Id">生物数据唯一Id</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectInstance, field: 'bioDataUniqueId', 'errors')}">
                        <input type="text" id="bioDataUniqueId" name="bioDataUniqueId"
                               value="${fieldValue(bean: secureObjectInstance, field: 'bioDataUniqueId')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="displayName">显示名称<!--<SIAT_zh_CN original="Display Name">显示名称</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectInstance, field: 'displayName', 'errors')}">
                        <input type="text" id="displayName" name="displayName"
                               value="${fieldValue(bean: secureObjectInstance, field: 'displayName')}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><input class="save" type="submit" value="创建"/></span><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>-->
        </div>
    </g:form>
</div>
</body>
</html>
