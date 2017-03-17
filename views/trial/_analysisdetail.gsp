<table class="detail" style="width: 515px;">
    <tbody>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">标题<!--<SIAT_zh_CN original="Title">标题</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'shortDescription')}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">分析描述<!--<SIAT_zh_CN original="Analysis Description">分析描述</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'longDescription')}</td>
    </tr>
    <g:if test='${"comparison".equals(analysis.analysisMethodCode)}'>
        <tr class="prop">
            <td valign="top" class="name" style="text-align: right">p值切断(p-Value Cut Off)<!--<SIAT_zh_CN original="p-Value    Cut Off">p值切断(p-Value Cut Off)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: analysis, field: 'pvalueCutoff')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name" style="text-align: right">倍数变化切断(Fold Change Cut Off)<!--<SIAT_zh_CN original="Fold Change Cut Off">倍数变化切断(Fold Change Cut Off)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: analysis, field: 'foldChangeCutoff')}</td>
        </tr>
    </g:if>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">QA条件(QA Criteria)<!--<SIAT_zh_CN original="QA Criteria">QA条件(QA Criteria)</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'qaCriteria')}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">分析平台<!--<SIAT_zh_CN original="Analysis Platform">分析平台</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'analysisPlatform.platformName')}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">方法<!--<SIAT_zh_CN original="Method">方法</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'analysisMethodCode')}</td>
    </tr>
    <tr class="prop">
        <td valign="top" class="name" style="text-align: right">数据类型<!--<SIAT_zh_CN original="Data type">数据类型</SIAT_zh_CN>-->:</td>
        <td valign="top" class="value">${fieldValue(bean: analysis, field: 'assayDataType')}</td>
    </tr>
    </tbody>
</table>
