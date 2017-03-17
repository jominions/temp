<%@ page import="com.recomdata.transmart.plugin.PluginModule" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示插件模块<!--<SIAT_zh_CN original="Show PluginModule">显示插件模块</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">插件模块列表<!--<SIAT_zh_CN original="PluginModule List">插件模块列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">创建插件模块<!--<SIAT_zh_CN original="New PluginModule">创建插件模块</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示插件模块<!--<SIAT_zh_CN original="Show PluginModule">显示插件模块</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.name" default="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'name')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.active" default="激活的"/><!--<SIAT_zh_CN original="Active">激活的</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'active')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.hasForm" default="包含表单"/><!--<SIAT_zh_CN original="Has Form">包含表单</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'hasForm')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.formLink"
                                                         default="表单链接"/><!--<SIAT_zh_CN original="Form Link">表单链接</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'formLink')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.formPage"
                                                         default="表单页"/><!--<SIAT_zh_CN original="Form Page">表单页</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'formPage')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.params" default="参数"/><!--<SIAT_zh_CN original="Params">参数</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'params')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="pluginModuleInstance.plugin" default="插件"/><!--<SIAT_zh_CN original="Plugin">插件</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><g:link controller="plugin" action="show"
                                                       id="${pluginModuleInstance?.plugin?.id}">${pluginModuleInstance?.plugin?.encodeAsHTML()}</g:link></td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${pluginModuleInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" value="Edit"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
                                                 value="Delete"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
