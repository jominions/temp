<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>显示 安全对象(SecureObject)安全对象(SecureObject)安全对象(SecureObject)安全对象(SecureObject)<!--<SIAT_zh_CN original="Show SecureObject">显示 安全对象(SecureObject)安全对象(SecureObject)安全对象(SecureObject)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>显示 安全对象(SecureObject)安全对象(SecureObject)<!--<SIAT_zh_CN original="Show SecureObject">显示 安全对象(SecureObject)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">Id<!--<SIAT_zh_CN original="Id">Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">生物数据Id<!--<SIAT_zh_CN original="Bio Data Id">生物数据Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectInstance, field: 'bioDataId')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">数据类型<!--<SIAT_zh_CN original="Data Type">数据类型</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectInstance, field: 'dataType')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">生物数据唯一Id<!--<SIAT_zh_CN original="Bio Data Unique Id">生物数据唯一Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectInstance, field: 'bioDataUniqueId')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">概念路径(Concept Paths)<!--<SIAT_zh_CN original="Concept Paths">概念路径(Concept Paths)</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="c" in="${secureObjectInstance.conceptPaths}">
                            <li><g:link controller="secureObjectPath" action="show"
                                        id="${c.id}">${c?.conceptPath?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">显示名称<!--<SIAT_zh_CN original="Display Name">显示名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: secureObjectInstance, field: 'displayName')}</td>

            </tr>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">允许访问的用户/用户组<!--<SIAT_zh_CN original="User/Group With Access">允许访问的用户/用户组</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">
                    <ul>
                        <g:each in="${org.transmart.searchapp.SecureObjectAccess.findAllBySecureObject(secureObjectInstance, [sort: accessLevel])}"
                                var='soa'>
                            <g:if test="${soa.principal.type == 'GROUP'}">
                                <li><g:link controller="userGroup" action="show"
                                            id="${soa.principal.id}">${soa.getPrincipalAccessName()}</g:link></li>
                            </g:if>
                            <g:else>
                                <li><g:link controller="authUser" action="show"
                                            id="${soa.principal.id}">${soa.getPrincipalAccessName()}</g:link></li>

                            </g:else>
                        </g:each>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${secureObjectInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/></span><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>-->
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('确认吗?');"
                                                action="Delete" value="删除"/></span>
        </g:form><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Are you sure?">确认吗?</SIAT_zh_CN>-->
    </div>
</div>
</body>
</html>
