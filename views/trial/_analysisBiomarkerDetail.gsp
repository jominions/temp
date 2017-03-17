<table class="detail">
    <tbody>
    <g:each in="${analysisresult.getAnalysisValueSubList()}" status="adi" var="analysisvalue">
        <g:set var="data" value="${analysisvalue.analysisData}" />
        <g:set var="marker" value="${analysisvalue.bioMarker}" />
        <tr class="prop">
            <td valign="top" class="name" style="text-align: right; font-weight: bold;">${fieldValue(bean:analysisvalue,field:'bioMarker.name')}&nbsp;
            <!-- signature regulation status -->
                [&nbsp;
                <g:if test="${analysisvalue.valueMetric!= null && analysisvalue.valueMetric!=0}">
                    <g:if test="${analysisvalue.valueMetric>0}"><img alt="signature up" src="${resource(dir:'images',file:'up_arrow.PNG')}" /></g:if>
                    <g:else><img alt="signature down" src="${resource(dir:'images',file:'down_arrow.PNG')}" /></g:else>
                </g:if>

            <!--  removed NA diplay since is not application for non gene sig/list searches -->

            <!--  gene expression/regulation status -->
                <g:if test="${data.foldChangeRatio!= null}">
                    <g:if test="${data.foldChangeRatio>=0}"><img alt="fc up" src="${resource(dir:'images',file:'up_arrow.PNG')}" /></g:if>
                    <g:else><img alt="fc down" src="${resource(dir:'images',file:'down_arrow.PNG')}" /></g:else>
                </g:if>
                <g:else>NA<!--<SIAT_zh_CN original="NA">NA</SIAT_zh_CN>--></g:else>
            &nbsp;]&nbsp;</td>
            <g:if test="${data.featureGroupName!=null}"><td style="white-space: nowrap;"><B>探测集(ProbeSet)<!--<SIAT_zh_CN original="ProbeSet">探测集(ProbeSet)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'featureGroupName')}</td></g:if>
            <td style="white-space: nowrap;"><b>基因<!--<SIAT_zh_CN original="Gene">基因</SIAT_zh_CN>-->:</b>&nbsp;<g:createFilterDetailsLink id="${marker?.id}" label="${marker?.name}" type="gene" /></td>
            <g:if test="${data.foldChangeRatio!=null}"><td style="white-space: nowrap;"><B>倍数变化(Fold Change)<!--<SIAT_zh_CN original="Fold Change">倍数变化(Fold Change)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'foldChangeRatio')}</td></g:if>
            <g:if test="${data.rvalue!=null}"><td style="white-space: nowrap;"><B>R值(RValue)<!--<SIAT_zh_CN original="RValue">R值(RValue)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'rvalue')}</td></g:if>
            <g:if test="${data.rawPvalue!=null}"><td style="white-space: nowrap;"><B>p值(p-Value)<!--<SIAT_zh_CN original="p-Value">p值(p-Value)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'rawPvalue')}</td></g:if>
            <g:if test="${data.teaNormalizedPValue!=null}"><td style="white-space: nowrap;"><B>TEA p值(TEA p-Value<!--<SIAT_zh_CN original="TEA p-Value">TEA p值(TEA p-Value</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'teaNormalizedPValue')}</td></g:if>
            <g:if test="${dataadjustedPvalue!=null}"><td style="white-space: nowrap;"><B>FDR p值(FDR p-Value)<!--<SIAT_zh_CN original="FDR p-Value">FDR p值(FDR p-Value)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'adjustedPvalue')}</td></g:if>
            <g:if test="${data.rhoValue!=null}"><td style="white-space: nowrap;"><B>Rho值(Rho-Value)<!--<SIAT_zh_CN original="Rho-Value">Rho值(Rho-Value)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'rhoValue')}</td></g:if>
            <g:if test="${data.cutValue!=null}"><td style="white-space: nowrap;"><B>Cut 值(Cut Value)<!--<SIAT_zh_CN original="Cut Value">Cut 值(Cut Value)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'cutValue')}</td></g:if>
            <g:if test="${data.resultsValue!=null}"><td style="white-space: nowrap;"><B>结果值(Result Value)<!--<SIAT_zh_CN original="Results Value">结果值(Result Value)</SIAT_zh_CN>-->:</B>&nbsp;${fieldValue(bean:data,field:'resultsValue')}</td></g:if>
            <g:if test="${data.numericValue!=null}"><td style="white-space: nowrap;"><B>${fieldValue(bean:data,field:'numericValueCode')}:</B>&nbsp;${fieldValue(bean:data,field:'numericValue')}</td></g:if>
        </tr>
    </g:each>
    </tbody>
</table>
