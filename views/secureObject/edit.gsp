<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑安全对象(SecureObject)<!--<SIAT_zh_CN original="Edit SecureObject">编辑安全对象(SecureObject)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>编辑安全对象(SecureObject)<!--<SIAT_zh_CN original="Edit SecureObject">编辑安全对象(SecureObject)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${secureObjectInstance}">
        <div class="errors">
            <g:renderErrors bean="${secureObjectInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <input type="hidden" name="id" value="${secureObjectInstance?.id}"/>
        <input type="hidden" name="version" value="${secureObjectInstance?.version}"/>

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
                        <label for="conceptPaths">概念路径(Concept Paths)<!--<SIAT_zh_CN original="Concept Paths">概念路径(Concept Paths)</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectInstance, field: 'conceptPaths', 'errors')}">

                        <ul>
                            <g:each var="c" in="${secureObjectInstance?.conceptPaths ?}">
                                <li><g:link controller="secureObjectPath" action="show"
                                            id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </ul>
                        <g:link controller="secureObjectPath" params="['secureObject.id': secureObjectInstance?.id]"
                                action="create">添加安全对象路径(SecureObjectPath)<!--<SIAT_zh_CN original="Add SecureObjectPath">添加安全对象路径(SecureObjectPath)</SIAT_zh_CN>--></g:link>

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
            <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
            action="Delete" value="删除"/></span><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>-->
        </div>
    </g:form>
</div>
</body>
</html>
