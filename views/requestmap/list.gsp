<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>Requestmap 列表<!--<SIAT_zh_CN original="Requestmap List">Requestmap 列表</SIAT_zh_CN>--></title>
</head>

<body>
<div class="body">
    <h1>Requestmap 列表<!--<SIAT_zh_CN original="Requestmap List">Requestmap 列表</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>
                <g:sortableColumn property="id" title="ID"/>
                <g:sortableColumn property="url" title="URL 模式"/><!--<SIAT_zh_CN original="URL Pattern">URL 模式</SIAT_zh_CN>-->
                <g:sortableColumn property="configAttribute" title="角色"/><!--<SIAT_zh_CN original="Roles">角色</SIAT_zh_CN>-->
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${requestmapList}" status="i" var="requestmap">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${requestmap.id}</td>
                    <td>${requestmap.url?.encodeAsHTML()}</td>
                    <td>${requestmap.configAttribute}</td>
                    <td class="actionButtons">
                        <span class="actionButton">
                            <g:link action="show" id="${requestmap.id}">显示<!--<SIAT_zh_CN original="Show">显示</SIAT_zh_CN>--></g:link>
                        </span>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${org.transmart.searchapp.Requestmap.count()}"/>
    </div>

</div>
</body>
</html>
