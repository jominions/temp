<%@ page import="com.recomdata.transmart.plugin.Plugin" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示插件<!--<SIAT_zh_CN original="Show Plugin">显示插件</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">插件列表<!--<SIAT_zh_CN original="Plugin List">插件列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">创建插件<!--<SIAT_zh_CN original="New Plugin">创建插件</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示插件<!--<SIAT_zh_CN original="Show Plugin">显示插件</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.name" default="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'name')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.pluginName" default="插件名称"/><!--<SIAT_zh_CN original="Plugin Name">插件名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'pluginName')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.hasModules" default="包含模块"/><!--<SIAT_zh_CN original="Has Modules">包含模块</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'hasModules')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.hasForm" default="包含表单"/><!--<SIAT_zh_CN original="Has Form">包含表单</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'hasForm')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.defaultLink"
                                                         default="Default Link"/>:</td><!--<SIAT_zh_CN original="Default Link">默认链接</SIAT_zh_CN>-->

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'defaultLink')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.formLink" default="Form Link"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'formLink')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.formPage" default="表单页"/><!--<SIAT_zh_CN original="Form Page">表单页</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginInstance, field: 'formPage')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginInstance.modules" default="模块"/><!--<SIAT_zh_CN original="Modules">模块</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="m" in="${pluginInstance.modules}">
                            <li><g:link controller="pluginModule" action="show"
                                        id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${pluginInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
