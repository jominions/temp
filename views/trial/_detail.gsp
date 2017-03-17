<div class="gtb1">
    <table class="detail">
        <tbody>
        <tr class="prop">
            <td valign="top" class="name">分析<!--<SIAT_zh_CN original="Analysis">分析</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'contentID')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">基因<!--<SIAT_zh_CN original="Gene">基因</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'geneSymbol')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">GenBank添加物(GenBank Accession)<!--<SIAT_zh_CN original="GenBank Accession">GenBank添加物(GenBank Accession)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'genBankAccession')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'description')}</td>
        </tr>

        <g:if test="${geneExprAnalysis.probeSet != null}">
            <tr class="prop">
                <td valign="top" class="name">探测集(Probe Set)<!--<SIAT_zh_CN original="Probe Set">探测集(Probe Set)</SIAT_zh_CN>-->:</td>
                <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'probeSet')}</td>
            </tr>
        </g:if>
        <tr class="prop">
            <td valign="top" class="name">倍数变化(Fold Change)<!--<SIAT_zh_CN original="Fold Change">倍数变化(Fold Change)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'ratio')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">Rho值(Rho Value)<!--<SIAT_zh_CN original="Rho Value">Rho值(Rho Value)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: geneExprAnalysis, field: 'rhovalue')}</td>

        </tr>
        </tbody>
    </table>
</div>