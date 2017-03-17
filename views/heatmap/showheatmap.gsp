<div class="gtbl" style="overflow: auto;">
    <table class="detail">
        <g:tableHeaderToggle label="Legend" divPrefix="legend" colSpan="3"/>

        <tbody id="legend_detail" style="display: none;">
        <g:each in="${contentlist}" status="i" var="content">
            <tr class="prop">
                <td width="300px" class="name" align=left
                    style="text-align: left; white-space: normal">
                    <a style="text-decoration: underline"
                       onclick="showDialog('AnalysisDet_${content.id}', { title: '${content.shortDescription}', element: 'detaildiv_${content.id}' });">${content.shortDescription}</a>
                </td>
                <td class="value" align=left style="text-align: left">${content.longDescription}</td>
                <td>
                    <div style="display: none">
                        <div id="detaildiv_${content.id}" style="background-color: #ffffff;"><g:render
                                template="/trial/analysisdetail" model="[analysis: content]"/></div>
                    </div>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div id="heatmapViewContainer">
    <p style="padding-bottom: 5px; padding-top: 5px;"><a href="javascript:backToTop();">返回到顶端<!--<SIAT_zh_CN original="Back to Top">返回到顶端</SIAT_zh_CN>--></a></p>
    <table class="" border="0">
        <tr>
            <g:if test="${comtable != null}">
                <td width='${(comtable == null || comtable == "") ? 1 : (hmapwidth)}%'
                    align="center"
                    style="text-align: center; padding: 0 0 0 0; white-space: nowrap;">
                    基因表达的比较<!--<SIAT_zh_CN original="Gene Expression Comparison">基因表达的比较</SIAT_zh_CN>--><br>

                    <div id="comHeatmapContainer"><img src="${resource(dir: 'images', file: 'loader-mid.gif')}"
                                                       alt="loading"/>
                    </div>
                </td>
            </g:if>
            <g:if test="${cortable != null}">
                <td width='${(cortable == null || cortable == "") ? 1 : (hmapwidth)}%'
                    align="center"
                    style="text-align: center; padding: 0 0 0 0; white-space: nowrap;">基因表达的相关性<!--<SIAT_zh_CN original="Gene Expression Correlation">基因表达的相关性</SIAT_zh_CN>--><br>

                    <div id="corHeatmapContainer"><img src="${resource(dir: 'images', file: 'loader-mid.gif')}"
                                                       alt="loading"/></div>
                </td>
            </g:if>
            <g:if test="${rbmtable != null}">
                <td width='${(rbmtable == null || rbmtable == "") ? 1 : (hmapwidth)}%'
                    style="text-align: center; padding: 0 0 0 0; white-space: nowrap;">
                   RMB比较<!--<SIAT_zh_CN original="RBM Comparison">RMB比较</SIAT_zh_CN>--><br>

                    <div id="rbmHeatmapContainer"></div>
                </td>
            </g:if>
            <g:if test="${rhotable != null}">
                <td width='${(rhotable == null || rhotable == "") ? 1 : (hmapwidth)}%'
                    style="text-align: center; padding: 0 0 0 0; white-space: nowrap;">
                    RBM Spearman相关性<!--<SIAT_zh_CN original="RBM Spearman Correlation">RBM Spearman相关性</SIAT_zh_CN>--><br>

                    <div id="rhoHeatmapContainer"></div>
                </td>
            </g:if>
        </tr>
    </table>
</div>

<div id="tableContainer" style="display: none">
    <p style="padding-bottom: 5px; padding-top: 5px;"><a href="javascript:backToTop();">返回到顶端<!--<SIAT_zh_CN original="Back to Top">返回到顶端</SIAT_zh_CN>--></a></p>
    <table>
        <g:if test="${comtable != null}">
            <tr>
                <td>基因表达的比较<!--<SIAT_zh_CN original="Gene Expression Comparison">基因表达的比较</SIAT_zh_CN>--><br>

                    <div id="comTableView"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <hr>
                    <br>
                </td>
            </tr>
        </g:if>

        <g:if test="${cortable != null}">
            <tr>
                <td>基因表达相互性<!--<SIAT_zh_CN original="Gene Expression Correlation">基因表达相互性</SIAT_zh_CN>--><br>

                    <div id="corTableView"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <hr>
                    <br>
                </td>
            </tr>
        </g:if>

        <g:if test="${rbmtable != null}">
            <tr>
                <td>RBM 比较<!--<SIAT_zh_CN original="RBM Comparison">RBM 比较</SIAT_zh_CN>--><br>

                    <div id="rbmTableView"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <hr>
                    <br>
                </td>
            </tr>
        </g:if>

        <g:if test="${rhotable != null}">
            <tr>
                <td>RBM Spearman相关性<!--<SIAT_zh_CN original="RBM Spearman Correlation">RBM Spearman相关性</SIAT_zh_CN>--><br>

                    <div id="rhoTableView"></div>
                </td>
            </tr>
        </g:if>
    </table>
</div>

</div>
</body>
</html>
