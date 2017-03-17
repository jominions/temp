</head>
<body>
<g:render template="/layouts/commonheader" model="['app': 'customfilters']"/>
<div style="padding: 20px 10px 10px 10px;">
    <% topicID = "1017" %>
    <a HREF='JavaScript:D2H_ShowHelp(<%=topicID%>,helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP )'>
        <img src="${resource(dir: 'images', file: 'help/helpbutton.jpg')}" alt="Help" border=0 width=18pt
             style="margin-top:1pt;margin-bottom:1pt;margin-right:18pt;float:right"/>
    </a>

    <h1 style="font-weight:bold; font-size:10pt; padding-bottom:5px; color: #006DBA;">
        <g:if test="${params.lastFilterID != null}">
            <g:link controller="search" action="searchCustomFilter" id="${params.lastFilterID}"
                    style="color: #006DBA;">搜索<!--<SIAT_zh_CN original="Search">搜索</SIAT_zh_CN>--></g:link>&nbsp;> 已保存的过滤器<!--<SIAT_zh_CN original="Saved Filters">已保存的过滤器</SIAT_zh_CN>-->
        </g:if>
        <g:else>
            <g:link controller="search" style="color: #006DBA;">搜索<!--<SIAT_zh_CN original="Search">搜索</SIAT_zh_CN>--></g:link>&nbsp;> 已保存的过滤器<!--<SIAT_zh_CN original="Saved Filters">已保存的过滤器</SIAT_zh_CN>-->
        </g:else>
    </h1>
    <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
    <div>
    <table>
        <tr>
            <th>&nbsp;</th>
        </tr>
        <g:each in="${customFilterInstanceList}" status="i" var="customFilterInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td>
                    <table class="rnoborder">
            <tr>
                <td width="100%">
                    <g:link style="color:#000000;" controller="search" action="searchCustomFilter"
                            id="${customFilterInstance.id}">
                        ${fieldValue(bean: customFilterInstance, field: 'name')}
                    </g:link>
                </td>
                <td>
                    <nobr>
                        <g:link controller="search" action="searchCustomFilter" id="${customFilterInstance.id}"
                                class="tiny"
                                style="text-decoration:underline;color:blue;font-size:11px;">选择<!--<SIAT_zh_CN original="select">选择</SIAT_zh_CN>--></g:link>
                        <g:link action="edit" id="${customFilterInstance.id}"
                                class="tiny" style="text-decoration:underline;color:blue;font-size:11px;">编辑<!--<SIAT_zh_CN original="edit">编辑</SIAT_zh_CN>--></g:link>
                        <g:link action="delete" onclick="return confirm('Are you sure?');"
                                id="${customFilterInstance.id}"
                                class="tiny"
                                style="text-decoration:underline;color:blue;font-size:11px;">删除<!--<SIAT_zh_CN original="delete">删除</SIAT_zh_CN>--></g:link>
                    </nobr>
                </td>
            </tr>
            <tr>
                <td colspan="2">${fieldValue(bean: customFilterInstance, field: 'description')}</td>
            </tr>
            <tr>
                <td colspan="2">${customFilterInstance.summary}</td>
            </tr>
            <tr>
                <td colspan="2"><b>快捷方式<!--<SIAT_zh_CN original="Shortcut">快捷方式</SIAT_zh_CN>-->:</b>
                    <g:if test="${customFilterInstance.privateFlag != 'Y'}">
                        ${createLink(controller: 'search', action: 'searchCustomFilter', absolute: true, id: customFilterInstance.id)}
                        ${createCustomFilterEmailLink(customFilter: customFilterInstance)}
                    </g:if>
                    <g:else>
                        私有<!--<SIAT_zh_CN original="Private">私有</SIAT_zh_CN>-->
                    </g:else>
                </td>
            </tr>
            </table>
        </td>
    </tr>
        </g:each>
    </table>
    </div>
    <br/>
    <a href="${createLink(controller: 'search', action: 'index')}"
       style="text-decoration:underline;color:blue;font-size:12px;">返回搜索页面<!--<SIAT_zh_CN original="Return to Search">返回搜索页面</SIAT_zh_CN>--></a>
</div>
</body>
</html>
