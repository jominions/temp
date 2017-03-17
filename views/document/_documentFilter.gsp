<g:form controller="document" action="filterDocument" name="documentfilters">
    <table class="jubfilter" style="width:500px">
        <tr>
            <th colspan=2 style="align:right">
                <span class="button">
                    <g:actionSubmit class="search" action="filterDocument" value="过滤器结果"
                                    onclick="return validateDocumentFilters();"/><!--<SIAT_zh_CN original="Filter Results">过滤器结果</SIAT_zh_CN>-->&nbsp;
                </span>
            </th>
        </tr>
        <tr>
            <td colspan=2 style="border-right:0px solid #ccc">
                <table class="jubfiltersection">
                    <tr>
                        <td style="vertical-align:top; border-left:0; font-weight:bold; padding-top:7px;" width="110"
                            nowrap="nowrap">
                            存储库<!--<SIAT_zh_CN original="Repository">存储库</SIAT_zh_CN>-->
                        </td>
                        <td style="vertical-align:top; line-height:normal;">
                            <g:each in="${repositories.keySet()}" status="i" var="repository">
                                <g:checkBox name="repository_${repository.toLowerCase().replace(' ', '_')}"
                                            value="${filter.repositories.get(repository)}"/>
                                ${repository}<br/>
                            </g:each>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top; border-left:0; font-weight:bold; padding-top:7px;" width="110"
                            nowrap="nowrap">
                            路径<!--<SIAT_zh_CN original="Path">路径</SIAT_zh_CN>-->
                        </td>
                        <td style="line-height:normal;">
                            <g:textField name="path" value="${filter.path}" style="width:250px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top; border-left:0; font-weight:bold; padding-top:7px;" width="110"
                            nowrap="nowrap">
                            文档类型<!--<SIAT_zh_CN original="Document Type">文档类型</SIAT_zh_CN>-->
                        </td>
                        <td style="vertical-align:top; line-height:normal;">
                            <g:checkBox name="type_excel" value="${filter.type_excel}"/>Excel<br/>
                            <g:checkBox name="type_html" value="${filter.type_html}"/>HTML<br/>
                            <g:checkBox name="type_pdf" value="${filter.type_pdf}"/>PDF<br/>
                            <g:checkBox name="type_powerpoint" value="${filter.type_powerpoint}"/>PowerPoint<br/>
                            <g:checkBox name="type_text" value="${filter.type_text}"/>Text<br/>
                            <g:checkBox name="type_word" value="${filter.type_word}"/>Word<br/>
                            <g:checkBox name="type_other" value="${filter.type_other}"/>其他<!--<SIAT_zh_CN original="Other">其他</SIAT_zh_CN>-->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</g:form>