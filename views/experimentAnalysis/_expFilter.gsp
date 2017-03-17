<g:form controller="experimentAnalysis" action="filterResult">
    <g:set var="expAnalysisFilter" value="${session.searchFilter.expAnalysisFilter}"/>

    <table class="jubfilter" style="width: 650px">
        <tr>
            <th colspan=2 style="align: right">
                <span class="button"><g:actionSubmit class="search" action="filterResult"
                                                     value="过滤结果"/><!--<SIAT_zh_CN original="Filter Results">过滤结果</SIAT_zh_CN>-->&nbsp;</span>
            </th>
        </tr>
        <tr>
            <td colspan=2 style="border-right: 0px solid #ccc">
                <table class="jubfiltersection">
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">平台物种(Platform Species):<!--<SIAT_zh_CN original="Platform Species">平台物种(Platform Species)</SIAT_zh_CN>--></td>
                        <td><g:select from="${platformOrganisms}" name="species" value="${expAnalysisFilter.species}"
                                      noSelection="['': '-- Any --']"/></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">疾病:<!--<SIAT_zh_CN original="Disease">疾病</SIAT_zh_CN>--></td>
                        <td><g:select from="${diseases}" name="bioDiseaseId" optionKey="id"
                                      optionValue="preferredName" value="${expAnalysisFilter.bioDiseaseId}"
                                      noSelection="['': '-- Any --']"/></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">化合物:<!--<SIAT_zh_CN original="Compound">化合物</SIAT_zh_CN>--></td>
                        <td><g:select from="${compounds}" name="bioCompoundId" optionKey="bioDataId"
                                      optionValue="keyword"
                                      value="${expAnalysisFilter.bioCompoundId}" noSelection="['': '-- Any --']"/></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">实验设计:<!--<SIAT_zh_CN original="Experiment Design">实验设计</SIAT_zh_CN>--></td>
                        <td><g:select from="${expDesigns}" name="expDesign" value="${expAnalysisFilter.expDesign}"
                                      noSelection="['': '-- Any --']"/></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">数据倍数变化截除:<!--<SIAT_zh_CN original="Data Fold Change Cut Off">数据倍数变化截除</SIAT_zh_CN>--></td>
                        <td style="font-weight:normal"><g:textField name="foldChange"
                                                                    value="${expAnalysisFilter.foldChange}"/> (最低均值变化率+ / - -1.0)<!--<SIAT_zh_CN original="Minimum Fold Change Ratio +/-1.0">最低均值变化率+ / - -1.0</SIAT_zh_CN>--></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; white-space: nowrap;">数据p值小于:<!--<SIAT_zh_CN original="Data p Value Less Than">数据p值小于</SIAT_zh_CN>--></td>
                        <td style="font-weight:normal"><g:textField name="pvalue"
                                                                    value="${expAnalysisFilter.pvalue}"/> (最大的P值0.1)<!--<SIAT_zh_CN original="Maximum P-Value 0.1">最大的P值0.1</SIAT_zh_CN>--></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</g:form>
