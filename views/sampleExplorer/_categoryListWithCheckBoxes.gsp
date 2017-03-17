<table class="categoryListCheckbox">
    <TBODY>

    <tr>
        <td style="font-weight:bold;">
            By ${termDisplayName}
        </td>
    </tr>
    </TBODY>

<TBODY>
    <g:each var="term" in="${termList}" status="iterator">
        <g:if test="${(iterator == grailsApplication.config.com.recomdata.solr.maxLinksDisplayed)}">
            </TBODY>
            <TBODY id="tbodyMoreLink${termName}">
            <tr>
                <td>
                    <a href="#"
                       onClick="toggleMoreResults(document.getElementById('tbodyMoreLink${termName}'), document.getElementById('tbodyLessLink${termName}'), document.getElementById('tbodyHiddenResults${termName}'))">更多<!--<SIAT_zh_CN original="More">更多</SIAT_zh_CN>--> [+]</a>
                </td>
            </tr>
            </TBODY>
            <TBODY id="tbodyHiddenResults${termName}" style="display:none;">
        </g:if>
        <tr>
            <td>
                <input type="checkBox" name="${termName}_${term.key}"
                       <g:if test="${JSONData[termName]?.contains(term.key)}">检查<!--<SIAT_zh_CN original="checked">检查</SIAT_zh_CN>--></g:if>
                       onClick="updateFilterList('${term.key.replace("'","\\'")}', this.checked, '${termName}');"/>
                <a href="#" class="categoryLinks"
                   onClick="toggleMainCategorySelection('${term.key.replace("'","\\'")}', '${termName}')">${term.key} (${term.value})</a>
            </td>
        </tr>
    </g:each>
</TBODY>

    <TBODY id="tbodyLessLink${termName}" style="display:none;">
    <tr>
        <td>
            <a href="#"
               onClick="toggleMoreResults(document.getElementById('tbodyMoreLink${termName}'), document.getElementById('tbodyLessLink${termName}'), document.getElementById('tbodyHiddenResults${termName}'))">收起<!--<SIAT_zh_CN original="Less">收起</SIAT_zh_CN>--> [-]</a>
        </td>
    </tr>
    </TBODY>
</table>