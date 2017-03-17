<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>编辑安全对象路径(SecureObjectPath)<!--<SIAT_zh_CN original="Edit SecureObjectPath">编辑安全对象路径(SecureObjectPath)</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>编辑安全对象路径(SecureObjectPath)<!--<SIAT_zh_CN original="Edit SecureObjectPath">编辑安全对象路径(SecureObjectPath)</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${secureObjectPathInstance}">
        <div class="errors">
            <g:renderErrors bean="${secureObjectPathInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <input type="hidden" name="id" value="${secureObjectPathInstance?.id}"/>
        <input type="hidden" name="version" value="${secureObjectPathInstance?.version}"/>

        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="conceptPath">概念路径(Concept Path)<!--<SIAT_zh_CN original="Concept Path">概念路径(Concept Path)</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectPathInstance, field: 'conceptPath', 'errors')}">
                        <input type="text" id="conceptPath" name="conceptPath"
                               value="${fieldValue(bean: secureObjectPathInstance, field: 'conceptPath')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secureObject">安全对象(Secure Object)<!--<SIAT_zh_CN original="Secure Object">安全对象(Secure Object)</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: secureObjectPathInstance, field: 'secureObject', 'errors')}">
                        <g:select optionKey="id" from="${org.transmart.searchapp.SecureObject.list()}"
                                  name="secureObject.id"
                                  value="${secureObjectPathInstance?.secureObject?.id}"></g:select>
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
