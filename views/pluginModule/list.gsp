<%@ page import="com.recomdata.transmart.plugin.PluginModule" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>插件模块列表<!--<SIAT_zh_CN original="PluginModule List">插件模块列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="create" action="create">创建插件模块<!--<SIAT_zh_CN original="New PluginModule">创建插件模块</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>插件模块列表<!--<SIAT_zh_CN original="PluginModule List">插件模块列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="name" title="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->


                <g:sortableColumn property="active" title="激活的"/><!--<SIAT_zh_CN original="Active">激活的</SIAT_zh_CN>-->

                <g:sortableColumn property="category" title="类别"/><!--<SIAT_zh_CN original="Category">类别</SIAT_zh_CN>-->


                <g:sortableColumn property="hasForm" title="包含表单"/><!--<SIAT_zh_CN original="Has Form">包含表单</SIAT_zh_CN>-->


                <g:sortableColumn property="formLink" title="表单链接"/><!--<SIAT_zh_CN original="Form Link">表单链接</SIAT_zh_CN>-->


                <g:sortableColumn property="formPage" title="表单页"/><!--<SIAT_zh_CN original="Form Page">表单页</SIAT_zh_CN>-->

            </tr>
            </thead>
            <tbody>
            <g:each in="${pluginModuleInstanceList}" status="i" var="pluginModuleInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show" id="${pluginModuleInstance.id}"
                                style="font-size:12px">${fieldValue(bean: pluginModuleInstance, field: 'name')}</g:link></td>

                    <td align="center"><g:checkBox name="" value="${pluginModuleInstance?.active}"
                                                   disabled="true"></g:checkBox></td>

                    <td>${fieldValue(bean: pluginModuleInstance, field: 'category')}</td>

                    <td align="center"><g:checkBox name="" value="${pluginModuleInstance?.hasForm}"
                                                   disabled="true"></g:checkBox></td>

                    <td>${fieldValue(bean: pluginModuleInstance, field: 'formLink')}</td>

                    <td>${fieldValue(bean: pluginModuleInstance, field: 'formPage')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${pluginModuleInstanceTotal}"/>
    </div>
</div>
</body>
</html>
