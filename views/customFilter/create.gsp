</head>
<body>
<g:render template="/layouts/commonheader" model="['app': 'customfilters']"/>
<div class="nav">
    <span class="menuButton"><g:link class="list" action="list">保存过滤器<!--<SIAT_zh_CN original="Saved Filters">保存过滤器</SIAT_zh_CN>--></g:link></span>
    <% topicID = "1021" %>
    <a HREF='JavaScript:D2H_ShowHelp(<%=topicID%>,helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP )'>
        <img src="${resource(dir: 'images', file: 'help/helpbutton.jpg')}" alt="Help" border=0 width=18pt
             style="margin-top:1pt;margin-bottom:1pt;margin-right:18pt;float:right"/>
    </a>
</div>

<div style="padding: 20px 10px 10px 10px;">
    <h1 style="font-weight:bold; font-size:10pt; padding-bottom:5px;">创建过滤器<!--<SIAT_zh_CN original="Create Filter">创建过滤器</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${customFilterInstance}">
        <div class="errors">
            <g:renderErrors bean="${customFilterInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save" method="post">
        <input type="hidden" name="searchUserId" value="${customFilterInstance?.searchUserId}"/>

        <div class="dialog">
            <table>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name">名称:<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: customFilterInstance, field: 'name', 'errors')}">
                        <g:textField size="80" name="name"
                                     value="${fieldValue(bean: customFilterInstance, field: 'name')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="description">描述:<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: customFilterInstance, field: 'description', 'errors')}">
                        <g:textArea rows="2" cols="61" name="description"
                                    value="${fieldValue(bean: customFilterInstance, field: 'description')}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="privateFlag">私有标签:<!--<SIAT_zh_CN original="Private Flag">私有标签</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: customFilterInstance, field: 'privateFlag', 'errors')}">
                        <g:checkBox name="privateFlag"
                                    value="${fieldValue(bean: customFilterInstance, field: 'privateFlag') == 'Y'}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="items">总结:<!--<SIAT_zh_CN original="Summary">总结</SIAT_zh_CN>--></label>
                    </td>
                    <td valign="top">
                        ${customFilterInstance.summary}
                    </td>
                </tr>
            </table>
        </div>

        <div class="buttons">
            <g:actionSubmit class="save" value="创建" action="save"/><!--<SIAT_zh_CN original="Create">创建</SIAT_zh_CN>-->
            <g:actionSubmit class="cancel" value="取消" action="list"/><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>-->
        </div>
    </g:form>
</div>
</body>
</html>
