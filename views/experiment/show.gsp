<%@ page import="org.transmart.biomart.Experiment" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>显示实验<!--<SIAT_zh_CN original="Show Experiment">显示实验</SIAT_zh_CN>--></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${resource(dir: '')}">主页<!--<SIAT_zh_CN original="Home">主页</SIAT_zh_CN>--></a></span>
    <span class="menuButton"><g:link class="list" action="list">实验列表<!--<SIAT_zh_CN original="Experiment List">实验列表</SIAT_zh_CN>--></g:link></span>
    <span class="menuButton"><g:link class="create" action="create">新建实验<!--<SIAT_zh_CN original="New Experiment">新建实验</SIAT_zh_CN>--></g:link></span>
</div>

<div class="body">
    <h1>显示实验<!--<SIAT_zh_CN original="Show Experiment">显示实验</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.id" default="Id"/>:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'id')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.type" default="类型"/><!--<SIAT_zh_CN original="Type">类型</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'type')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.title" default="标题"/><!--<SIAT_zh_CN original="Title">标题</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'title')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.description"
                                                         default="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'description')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.design" default="设计"/><!--<SIAT_zh_CN original="Design">设计</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'design')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.startDate"
                                                         default="开始日期"/><!--<SIAT_zh_CN original="Start Date">开始日期</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'startDate')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.completionDate"
                                                         default="完成日期"/><!--<SIAT_zh_CN original="Completion Date">完成日期</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'completionDate')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.primaryInvestigator"
                                                         default="首席研究员"/><!--<SIAT_zh_CN original="Primary Investigator">首席研究员</SIAT_zh_CN>-->:</td>

                <td valign="top"
                    class="value">${fieldValue(bean: experimentInstance, field: 'primaryInvestigator')}</td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.compounds" default="Compounds"/><!--<SIAT_zh_CN original="Compounds">化合物</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="c" in="${experimentInstance.compounds}">
                            <li><g:link controller="compound" action="show"
                                        id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.diseases" default="疾病"/><!--<SIAT_zh_CN original="Diseases">疾病</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="d" in="${experimentInstance.diseases}">
                            <li><g:link controller="disease" action="show"
                                        id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.files" default="文档"/><!--<SIAT_zh_CN original="Docs">文档</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="d" in="${experimentInstance.files}">
                            <li><g:link controller="contentReference" action="show"
                                        id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.uniqueIds"
                                                         default="唯一Ids"/><!--<SIAT_zh_CN original="Unique Ids">唯一Ids</SIAT_zh_CN>-->:</td>

                <td valign="top" style="text-align:left;" class="value">
                    <ul>
                        <g:each var="u" in="${experimentInstance.uniqueIds}">
                            <li><g:link controller="bioData" action="show"
                                        id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>


            <tr class="prop">
                <td valign="top" class="name"><g:message code="experimentInstance.uniqueId" default="唯一Id"/><!--<SIAT_zh_CN original="Unique Id">唯一Id</SIAT_zh_CN>-->:</td>

                <td valign="top" class="value">${fieldValue(bean: experimentInstance, field: 'uniqueId')}</td>

            </tr>

            </tbody>
        </table>
    </div>

    <div class="buttons">
        <g:form>
            <input type="hidden" name="id" value="${experimentInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="Edit" value="编辑"/><!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></span>
            <span class="button"><g:actionSubmit class="delete" onclick="return confirm('您确定吗？');"
                                                 action="Delete" value="删除"/><!--<SIAT_zh_CN original="Are you sure?">你确定吗</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></span>
        </g:form>
    </div>
</div>
</body>
</html>
