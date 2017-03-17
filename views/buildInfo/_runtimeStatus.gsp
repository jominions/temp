<%@ page import="grails.util.Environment" %>
<h1>运行时属性<!--<SIAT_zh_CN original="Runtime Attributes">运行时属性</SIAT_zh_CN>--></h1>

<table>
    <thead>
    <tr style="height: 30px;">
        <th style="vertical-align: middle; width: 250px;"><g:message code="buildInfo.prop" default="属性"/><!--<SIAT_zh_CN original="Property">属性</SIAT_zh_CN>--></th>
        <th style="vertical-align: middle; width: 400px;"><g:message code="buildInfo.value" default="值"/><!--<SIAT_zh_CN original="Value">值</SIAT_zh_CN>--></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd" style="height: 30px;">
        <td><g:message code="grails.env"/></td><td>${Environment.current}</td>
    </tr>
    <tr class="even" style="height: 30px;">
        <td><g:message code="app.version"/></td><td><g:meta name="app.version"/></td>
    </tr>
    <tr class="odd" style="height: 30px;">
        <td><g:message code="app.grails.version"/></td><td><g:meta name="app.grails.version"/></td>
    </tr>
    <tr class="even" style="height: 30px;">
        <td><g:message code="java.version"/></td><td>${System.getProperty('java.version')}</td>
    </tr>
    </tbody>
</table>
