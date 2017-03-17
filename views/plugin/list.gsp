<%@ page import="com.recomdata.transmart.plugin.Plugin" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>插件列表<!--<SIAT_zh_CN original="Plugin List">插件列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="create" action="create">创建插件<!--<SIAT_zh_CN original="New Plugin">创建插件</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>插件列表<!--<SIAT_zh_CN original="Plugin List">插件列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="Id"/>

                <g:sortableColumn property="name" title="Name"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->

                <g:sortableColumn property="pluginName" title="Plugin Name"/><!--<SIAT_zh_CN original="Plugin Name">插件名称</SIAT_zh_CN>-->


                <g:sortableColumn property="hasModules" title="Has Modules"/><!--<SIAT_zh_CN original="Has Modules">包含模块</SIAT_zh_CN>-->

                <g:sortableColumn property="hasForm" title="Has Form"/><!--<SIAT_zh_CN original="Has Form">包含表单</SIAT_zh_CN>-->

                <g:sortableColumn property="active" title="Active"/><!--<SIAT_zh_CN original="Active">激活的</SIAT_zh_CN>-->

                <g:sortableColumn property="defaultLink" title="Default Link"/><!--<SIAT_zh_CN original="Default Link">默认链接</SIAT_zh_CN>-->

            </tr>
            </thead>
            <tbody>
            <g:each in="${pluginInstanceList}" status="i" var="pluginInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${pluginInstance.id}">${fieldValue(bean: pluginInstance, field: 'id')}</g:link></td>

                    <td>${fieldValue(bean: pluginInstance, field: 'name')}</td>

                    <td>${fieldValue(bean: pluginInstance, field: 'pluginName')}</td>

                    <td><g:checkBox name="hasModules" value="${pluginInstance?.hasModules}"
                                    disabled="true"></g:checkBox></td>

                    <td><g:checkBox name="hasForm" value="${pluginInstance?.hasForm}" disabled="true"></g:checkBox></td>

                    <td><g:checkBox name="active" value="${pluginInstance?.active}" disabled="true"></g:checkBox></td>

                    <td>${fieldValue(bean: pluginInstance, field: 'defaultLink')}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${pluginInstanceTotal}"/>
    </div>
</div>
</body>
</html>
