<%@ page import="org.transmart.searchapp.CustomFilter" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示定制过滤器<!--<SIAT_zh_CN original="Show CustomFilter">显示定制过滤器</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">主页<!--<SIAT_zh_CN original="Home">主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">定制过滤器列表<!--<SIAT_zh_CN original="CustomFilter List">定制过滤器列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">新建定制过滤器<!--<SIAT_zh_CN original="New CustomFilter">新建定制过滤器</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示定制过滤器<!--<SIAT_zh_CN original="Show CustomFilter">显示定制过滤器</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: customFilterInstance, field: 'id')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.name" default="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: customFilterInstance, field: 'name')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.description"
                                                         default="Description"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: customFilterInstance, field: 'description')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.privateFlag"
                                                         default="私有标志"/><!--<SIAT_zh_CN original="Private Flag">私有标志</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: customFilterInstance, field: 'privateFlag')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.items" default="项"/><!--<SIAT_zh_CN original="Items">项</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="i" in="${customFilterInstance.items}">
                            <li><g:link controller="customFilterItem" action="show"
                                        id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="customFilterInstance.searchUserId"
                                                         default="搜索用户Id"/><!--<SIAT_zh_CN original="Search User Id">搜索用户Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: customFilterInstance, field: 'searchUserId')}</td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${customFilterInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
