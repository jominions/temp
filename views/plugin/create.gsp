<%@ page import="com.recomdata.transmart.plugin.Plugin" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>创建插件<!--<SIAT_zh_CN original="Create Plugin">创建插件</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">返回主页<!--<SIAT_zh_CN original="Home">返回主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">插件列表<!--<SIAT_zh_CN original="Plugin List">插件列表</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>创建插件<!--<SIAT_zh_CN original="Create Plugin">创建插件</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${pluginInstance}">
        <div class="errors">
            <g:renderErrors bean="${pluginInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'name', 'errors')}">
                        <input type="text" id="name" name="name"
                               value="${fieldValue(bean: pluginInstance, field: 'name')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="pluginName">插件名称<!--<SIAT_zh_CN original="Plugin Name">插件名称</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'pluginName', 'errors')}">
                        <input type="text" id="pluginName" name="pluginName"
                               value="${fieldValue(bean: pluginInstance, field: 'pluginName')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="hasModules">内含模块<!--<SIAT_zh_CN original="Has Modules">内含模块</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'hasModules', 'errors')}">
                        <g:checkBox name="hasModules" value="${pluginInstance?.hasModules}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="hasForm">已形成<!--<SIAT_zh_CN original="Has Form">已形成</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'hasForm', 'errors')}">
                        <g:checkBox name="hasForm" value="${pluginInstance?.hasForm}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="active">有效的<!--<SIAT_zh_CN original="Active">有效的</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'active', 'errors')}">
                        <g:checkBox name="active" value="${pluginInstance?.active}"></g:checkBox>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="defaultLink">默认链接<!--<SIAT_zh_CN original="Default Link">默认链接</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'defaultLink', 'errors')}">
                        <input type="text" id="defaultLink" name="defaultLink"
                               value="${fieldValue(bean: pluginInstance, field: 'defaultLink')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="formLink">形成链接<!--<SIAT_zh_CN original="Form Link">形成链接</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'formLink', 'errors')}">
                        <input type="text" id="formLink" name="formLink"
                               value="${fieldValue(bean: pluginInstance, field: 'formLink')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="formPage">形成页面<!--<SIAT_zh_CN original="Form Page">形成页面</SIAT_zh_CN>-->:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: pluginInstance, field: 'formPage', 'errors')}">
                        <input type="text" id="formPage" name="formPage"
                               value="${fieldValue(bean: pluginInstance, field: 'formPage')}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><input class="save" type="submit" value="创建"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>--></span>
        </div>
    </g:form>
</div>
</body>
</html>
