<%@ page import="com.recomdata.transmart.plugin.PluginModule" %>
<%@ page import="com.recomdata.transmart.plugin.PluginModuleCategory" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>编辑插件模块<!--<SIAT_zh_CN original="Edit PluginModule">编辑插件模块</SIAT_zh_CN>--></title>
    <g:javascript library="prototype"/>
    <g:javascript library="scriptaculous"/>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">插件模块列表<!--<SIAT_zh_CN original="PluginModule List">插件模块列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">创建插件模块<!--<SIAT_zh_CN original="New PluginModule">创建插件模块</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>编辑插件模块<!--<SIAT_zh_CN original="Edit PluginModule">编辑插件模块</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${pluginModuleInstance}">
        <div class="errors">
            <g:renderErrors bean="${pluginModuleInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <input type="hidden" name="id" value="${pluginModuleInstance?.id}"/>
        <input type="hidden" name="version" value="${pluginModuleInstance?.version}"/>

        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginModuleInstance, field: 'name', 'errors')}">
                        <input type="text" id="name" name="name"
                               value="${fieldValue(bean: pluginModuleInstance, field: 'name')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="moduleName">模块名称<!--<SIAT_zh_CN original="Module Name">模块名称</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: pluginModuleInstance, field: 'moduleName', 'errors')}">
                        <input type="text" id="moduleName" name="moduleName"
                               value="${fieldValue(bean: pluginModuleInstance, field: 'moduleName')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="active">有效的<!--<SIAT_zh_CN original="Active">有效的</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginModuleInstance, field: 'active', 'errors')}">
                        <g:checkBox name="active" value="${pluginModuleInstance?.active}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="hasForm">已形成<!--<SIAT_zh_CN original="Has Form">已形成</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginModuleInstance, field: 'hasForm', 'errors')}">
                        <g:checkBox name="hasForm" value="${pluginModuleInstance?.hasForm}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="category">类别<!--<SIAT_zh_CN original="Category">类别</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: pluginModuleInstance, field: 'category', 'errors')}">
                        <g:select name="category" from="${PluginModuleCategory.values()}"
                                  value="${fieldValue(bean: pluginModuleInstance, field: 'category')}"
                                  optionKey="key" optionValue="value"></g:select>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="formLink">形成链接<!--<SIAT_zh_CN original="Form Link">形成链接</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: pluginModuleInstance, field: 'formLink', 'errors')}">
                        <input type="text" id="formLink" name="formLink"
                               value="${fieldValue(bean: pluginModuleInstance, field: 'formLink')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="formPage">表单页面<!--<SIAT_zh_CN original="Form Page">表单页面</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: pluginModuleInstance, field: 'formPage', 'errors')}">
                        <input type="text" id="formPage" name="formPage"
                               value="${fieldValue(bean: pluginModuleInstance, field: 'formPage')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="params">参数<!--<SIAT_zh_CN original="Params">参数</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginModuleInstance, field: 'params', 'errors')}">
                        <textarea id="paramsStr" name="paramsStr" rows="15" cols="80">${paramsStr}</textarea>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="plugin">插件<!--<SIAT_zh_CN original="Plugin">插件</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginModuleInstance, field: 'plugin', 'errors')}">
                        <g:select optionKey="id" optionValue="name"
                                  from="${com.recomdata.transmart.plugin.Plugin.list()}" name="plugin.id"
                                  value="${pluginModuleInstance?.plugin?.id}"></g:select>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="Update" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>-->
</span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确认吗?');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>-->
<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>-->
</span>
        </div>
    </g:form>
</div>
</body>
</html>
