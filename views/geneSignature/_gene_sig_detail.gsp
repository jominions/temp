<g:if test="${gs.experimentTypeConceptCode?.bioConceptCode == 'IN_VIVO_ANIMAL' || gs.experimentTypeConceptCode?.bioConceptCode == 'IN_VIVO_HUMAN'}">
    <tr>
        <td style="border: none;">'在vivo' 模型:&nbsp;<!--<SIAT_zh_CN original="'in vivo' model">'在vivo' 模型：</SIAT_zh_CN>-->${gs.experimentTypeInVivoDescr}</td>
    </tr>
</g:if>
<tr><td style="border: none;">ATCC 命名:&nbsp;<!--<SIAT_zh_CN original="ATCC designation">ATCC 命名</SIAT_zh_CN>-->${gs.experimentTypeATCCRef}</td></tr>
</table>
</td>
</tr>
</tbody>
</table>

<table class="detail" style="width: 100%">
    <g:tableHeaderToggle label="Analysis Meta-Data" divPrefix="${gs.id}_analysis" colSpan="2"/>

    <tbody id="${gs.id}_analysis_detail" style="display: none;">
    <tr class="prop">
        <td class="name">执行分析者:<!--<SIAT_zh_CN original="Analysis Performed By">执行分析者</SIAT_zh_CN>--></td>
        <td class="value">${gs.analystName}</td>
    </tr>
    <tr class="prop">
        <td class="name">归一化方法:<!--<SIAT_zh_CN original="Normalization Method">归一化方法</SIAT_zh_CN>--></td>
        <td class="value">
            <g:if test="${gs.normMethodConceptCode?.id == 1}">${gs.normMethodOther}</g:if>
            <g:else>${gs.normMethodConceptCode?.codeName}</g:else>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">分析类型:<!--<SIAT_zh_CN original="Analytic Category">分析类型</SIAT_zh_CN>--></td>
        <td class="value">
            <g:if test="${gs.analyticCatConceptCode?.id == 1}">${gs.analyticCatOther}</g:if>
            <g:else>${gs.analyticCatConceptCode?.codeName}</g:else>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">分析方法:<!--<SIAT_zh_CN original="Analysis Method">分析方法</SIAT_zh_CN>--></td>
        <td class="value">
            <g:if test="${gs.analysisMethodConceptCode?.id == 1}">${gs.analysisMethodOther}</g:if>
            <g:else>${gs.analysisMethodConceptCode?.codeName}</g:else>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">多重检验校正:<!--<SIAT_zh_CN original="Multiple Testing Correction">多重检验校正</SIAT_zh_CN>--></td>
        <td class="value"><g:if
                test="${gs.multipleTestingCorrection != null}">${gs.multipleTestingCorrection == 1 ? '是' : '否'}</g:if></td><!--<SIAT_zh_CN original="Yes">是</SIAT_zh_CN>-->
                <!--<SIAT_zh_CN original="No">否</SIAT_zh_CN>-->
    </tr>
    <tr class="prop">
        <td class="name">P值切断:<!--<SIAT_zh_CN original="P-value Cutoff">P值切断</SIAT_zh_CN>--></td>
        <td class="value">${gs.pValueCutoffConceptCode?.codeName}</td>
    </tr>
    <tr class="prop">
        <td class="name">倍数变化指标:<!--<SIAT_zh_CN original="Fold-change metric">倍数变化指标</SIAT_zh_CN>--></td>
        <td class="value">${gs.foldChgMetricConceptCode?.codeName}</td>
    </tr>
    <tr class="prop">
        <td class="name">原始上传文件:<!--<SIAT_zh_CN original="Original upload file">原始上传文件</SIAT_zh_CN>--></td>
        <td class="value">${gs.uploadFile}</td>
    </tr>
    </tbody>
</table>

<table style="width: 100%">
    <g:tableHeaderToggle label="Gene Signature Items" divPrefix="${gs.id}_items"/>

    <tbody id="${gs.id}_items_detail" style="display: none;">
    <tr><td>
        <table class="detail" width="100%" border=1>
            <tr>
                <td style="font-weight: bold;">基因符号<!--<SIAT_zh_CN original="Gene Symbol">基因符号</SIAT_zh_CN>--></td>
                <td style="font-weight: bold;">探测集 ID<!--<SIAT_zh_CN original="Probeset ID">探测集 ID</SIAT_zh_CN>--></td>
                <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode != 'NOT_USED'}"><td
                        style="font-weight: bold; white-space: nowrap;">倍数变化指标<!--<SIAT_zh_CN original="Fold-change metric">倍数变化指标</SIAT_zh_CN>--></td></g:if>
            </tr>
            <g:each in="${gs.geneSigItems}">
                <tr>
                    <td class="name">${it.geneSymbol.join("/")}</td>
                    <td class="name">${it.probeset}</td>
                    <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode != 'NOT_USED'}">
                        <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode == 'TRINARY'}"><td class="name"
                                  style="text-align: right;"><g:formatNumber
                                    number="${it.foldChgMetric}" format="0"/></td></g:if>
                        <g:else><td class="name" style="text-align: right;"><g:formatNumber number="${it.foldChgMetric}"
                                  format="##0.###"/></td></g:else>
                    </g:if>
                </tr>
            </g:each>
        </table>
    </td></tr>
    </tbody>
</table>
