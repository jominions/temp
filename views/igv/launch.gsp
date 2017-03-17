<g:form method="post" controller="igv">
    <input type="hidden" name="sessionFile" value="${sessionFile}"/>

    <table class="subsettable" style="margin: 10px;width:530px; border: 0px none; border-collapse: collapse;">
        <tr>
            <td colspan="2">
                <span class='AnalysisHeader'>结果<!--<SIAT_zh_CN original="Result">结果</SIAT_zh_CN>--></span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr/>
            </td>
        </tr>
        <tr>
            <td align="center">
                <div class="buttons">
                    <span class="button">
                        <g:actionSubmit value="启动IGV" action="launchJNLP"/><!--<SIAT_zh_CN original="Launch IGV">启动IGV</SIAT_zh_CN>-->
                    </span>
                </div>
            </td>
        </tr>
    </table>

</g:form>