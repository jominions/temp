<%@ page import="com.recomdata.transmart.plugin.PluginModule" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示插件模块<!--<SIAT_zh_CN original="Show PluginModule">显示插件模块</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
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
                <td valign="top" class="name">Id<!--<SIAT_zh_CN original="Id">Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'id')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'name')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">模块名称<!--<SIAT_zh_CN original="Module Name">模块名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'moduleName')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">有效的<!--<SIAT_zh_CN original="Active">有效的</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><g:checkBox name="active" value="${pluginModuleInstance?.active}"
                                                           disabled="true"></g:checkBox></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">已形成<!--<SIAT_zh_CN original="Has Form">已形成</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><g:checkBox name="active" value="${pluginModuleInstance?.hasForm}"
                                                           disabled="true"></g:checkBox></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">类别<!--<SIAT_zh_CN original="Category">类别</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'category')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">形成链接<!--<SIAT_zh_CN original="Form Link">形成链接</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'formLink')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">形成页面<!--<SIAT_zh_CN original="Form Page">形成页面</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: pluginModuleInstance, field: 'formPage')}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">参数<!--<SIAT_zh_CN original="Params">参数</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><textarea id="paramsStr" name="paramsStr" rows="15" cols="80"
                                                         readonly="readonly">${paramsStr}</textarea></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">插件<!--<SIAT_zh_CN original="Plugin">插件</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value"><g:link controller="plugin" action="show"
                                                       id="${pluginModuleInstance?.plugin?.id}">${pluginModuleInstance?.plugin?.name}</g:link></td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${pluginModuleInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>-->
</span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
            action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>-->
<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>-->
</span>
        </g:form>
    </div>
</div>
</body>
</html>
