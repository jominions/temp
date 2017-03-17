<g:if test="${tags.isEmpty()}">
    <table class="detail">
        <tr><td>没有标签<!--<SIAT_zh_CN original="No tags found">没有标签</SIAT_zh_CN>-->.</td></tr>
    </table>
</g:if>
<g:else>
    <table class="detail" style="width: 515px;">
        <g:each in="${tags}" var="tag">
            <tr class="prop">
                <td valign="top" class="name"><g:message code="${'tag' + tag.tagtype}" default="${tag.tagtype}"/>:</td>
                <td valign="top" class="value">${fieldValue(bean: tag, field: 'tag')}</td>
            </tr>
        </g:each>
    </table>
</g:else>
