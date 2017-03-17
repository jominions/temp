<g:overlayPopup title="导出数据暂存区" divContainerId="${params.eleId}"><!--<SIAT_zh_CN original="Export Cart">导出数据暂存区</SIAT_zh_CN>-->

    <g:form action="sendFiles">

        <div class="list">
            <h2 class="rdc-h2">${folder.title}</h2>
            <table class="baseGrid">
                <tbody>
                <g:each in="${layout}" status="i" var="layoutRow">
                    <tr>
                        <td valign="top" align="right" class="name">${layoutRow.displayName}</td>
                        <td valign="top" align="left" class="value">
                            <g:if test="${fieldValue(bean: folder, field: layoutRow.column).length() < 100}">
                                <g:textField size="100" name="${layoutRow.column}"
                                             value="${fieldValue(bean: folder, field: layoutRow.column)}"/>
                            </g:if>
                            <g:else>
                                <g:textArea size="100" cols="74" rows="5" name="${layoutRow.column}"
                                            value="${fieldValue(bean: folder, field: layoutRow.column)}"/>
                            </g:else>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div></div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="export" id="Export"
                                                 value="${message(code: 'default.button.update.label', default: '导出')}"/></span><!--<SIAT_zh_CN original="Export">导出</SIAT_zh_CN>-->
            <span class="button"><g:actionSubmit class="cancel" action="clear" id="Clear"
                                                 value="${message(code: 'default.button.update.label', default: '清空暂存区')}"/></span><!--<SIAT_zh_CN original="Clear Cart">清空暂存区</SIAT_zh_CN>-->
            <span class="button"><g:actionSubmit class="list" action="list" id="cancel" value="Cancel"
                                                 onclick="return confirm('您确认吗?')"/></span><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Are you sure?">您确认吗?</SIAT_zh_CN>-->
        </div>
    </g:form>
</g:overlayPopup>
