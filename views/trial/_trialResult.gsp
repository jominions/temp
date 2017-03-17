<g:setProvider library="prototype"/>

<g:if test="${searchresult?.result?.groupByExp}"><div id='gfilterresult'></g:if>
<g:else><div id='gfilterresult_tea'></g:else>

<g:if test="${searchresult?.result == null || searchresult.result?.analysisCount == 0}">
    <g:render template="/search/noResult"/>
</g:if>
<g:else>
    <p style="font-weight:bold; font-size:11px;padding-left:5px;padding-bottom:5px; padding-top:5px;">
        <g:if test="${searchresult?.result?.groupByExp}">研究结果<!--<SIAT_zh_CN original="Study result">研究结果</SIAT_zh_CN>-->:&nbsp;&nbsp;${searchresult?.result?.expCount} clinical trial(s) with ${searchresult?.result?.analysisCount}&nbsp;
            <g:if test="${searchresult?.result?.analysisCount > 1}">分析结果<!--<SIAT_zh_CN original="analyses">分析结果</SIAT_zh_CN>--></g:if>
            <g:else>分析<!--<SIAT_zh_CN original="analysis">分析</SIAT_zh_CN>--></g:else>
        </g:if>
        <g:else>分析结果<!--<SIAT_zh_CN original="Analysis result">分析结果</SIAT_zh_CN>-->:&nbsp;&nbsp;${searchresult?.result?.analysisCount}&nbsp;
            <g:if test="${searchresult?.result?.analysisCount > 1}">分析结果<!--<SIAT_zh_CN original="analyses">分析结果</SIAT_zh_CN>--></g:if>
            <g:else>分析<!--<SIAT_zh_CN original="analysis">分析</SIAT_zh_CN>--></g:else>
            来自 ${searchresult?.result?.expCount} 临床试验<!--<SIAT_zh_CN original="from ${searchresult?.result?.expCount} clinical trial(s)">来自 ${searchresult?.result?.expCount} 临床试验</SIAT_zh_CN>-->
        </g:else>
    </p>
    <g:if test="${searchresult?.result?.groupByExp}">
        <div id="expListDivtrial">
          <div class="paginateButtons">
        <g:remotePaginate update="gfilterresult"
                          total="${searchresult?.trialCount}" controller="trial"
                          action="datasourceTrial"
                          maxsteps="${grailsApplication.config.com.recomdata.search.paginate.maxsteps}"
                          max="${grailsApplication.config.com.recomdata.search.paginate.max}"/>
        </div>

        <table width="100%" class="trborderbottom">
            <g:each in="${searchresult.result.expAnalysisResults}" status="ti"
                    var="trialresult">
                <tr>
                    <td width="100%" class="bottom">
                        <table width="100%">
                            <tr>
                                <td style="padding: 5px 0px 5px 5px; margin-top: 5px;"><div
                                        id="TrialDet_${trialresult.trial.id}_anchor">
                                    <a onclick="javascript:if (divIsEmpty('${trialresult.trial.trialNumber}_detail')) {
                                        var ldiv = '${trialresult.trial.trialNumber}_detail_loading';
                                        ${remoteFunction(action:'getTrialAnalysis',controller:'trial', id:trialresult.trial.id, before:'toggleVisible(ldiv);', onComplete:'toggleVisible(ldiv);', update:trialresult.trial.trialNumber+'_detail')};
                                    }
                                    ;
                                    toggleDetail('${trialresult.trial.trialNumber}')">
                                        <div id="${trialresult.trial.trialNumber}_fclose"
                                             style="visibility: hidden; display: none; width: 16px;">
                                            <img alt=""
                                                 src="${resource(dir: 'images', file: 'folder-minus.gif')}"
                                                 style="vertical-align: middle;"/>
                                        </div>

                                        <div id="${trialresult.trial.trialNumber}_fopen"
                                             style="display: inline; width: 16px;">
                                            <img alt=""
                                                 src="${resource(dir: 'images', file: 'folder-plus.gif')}"
                                                 style="vertical-align: middle;"/>
                                        </div>
                                    </a>
                                    <a onclick="javascript:showDialog('TrialDet_${trialresult.trial.id}', { title: '${trialresult.trial.trialNumber}', url: '${createLink(action:'expDetail',id:trialresult.trial.id)}' });"
                                       onmouseover="delayedTask.delay(2000, showDialog, this, ['TrialDet_${trialresult.trial.id}', { title: '${trialresult.trial.trialNumber}', url: '${createLink(action:'expDetail',id:trialresult.trial.id)}'}]);"
                                       onmouseout="delayedTask.cancel();">
                                        <img alt=""
                                             src="${resource(dir: 'images', file: 'view_detailed.png')}"
                                             style="vertical-align: top;"/>
                                        <b><span
                                                style="color: #339933;">${trialresult.trial.trialNumber}</span>:&nbsp;&nbsp;${trialresult.trial.title}
                                        </b>
                                    </a>
                                    <br>
                                    &nbsp;&nbsp;&nbsp;- ${trialresult.analysisCount}
                                    <g:if test="${trialresult.analysisCount > 1}">分析结果发现<!--<SIAT_zh_CN original="analyses found">分析结果发现</SIAT_zh_CN>--></g:if>
                                    <g:else>分析结果发现<!--<SIAT_zh_CN original="analysis found">分析结果发现</SIAT_zh_CN>--></g:else>
                                    <br>
                                &nbsp;&nbsp;&nbsp;
                                    <g:set var="pt"
                                           value="${trialresult.getProtocol()}"/>
                                    <g:if test="${pt != null}">
                                        <g:createFileLink
                                                content="${pt.content}"
                                                displayLabel="Protocol"/>
                                    </g:if>
                                    <g:else>
                                        <b>协议<!--<SIAT_zh_CN original="Protocol">协议</SIAT_zh_CN>--></b>: 不可用<!--<SIAT_zh_CN original="not available">不可用</SIAT_zh_CN>-->
                                    </g:else>
                                &nbsp;&nbsp;&nbsp;|
                                    <g:set var="hasFiles" value="${false}"/>
                                    <g:each in="${trialresult.getFiles()}"
                                            status="fileCount" var="file">
                                        <g:if test="${fileCount > 0}">,</g:if><g:else><g:set
                                            var="hasFiles"
                                            value="${true}"/></g:else>
                                        <g:createFileLink
                                                content="${file.content}"
                                                displayLabel="${file.type}"/>
                                    </g:each>
                                    <g:if test="${!hasFiles}">
                                        <b>分析计划<!--<SIAT_zh_CN original="Analysis plan">分析计划</SIAT_zh_CN>--></b>: 不可用<!--<SIAT_zh_CN original="not available">不可用</SIAT_zh_CN>-->
                                    </g:if>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 20px;">
                                    <div id="${trialresult.trial.trialNumber}_detail_loading"
                                         style="display:none">
                                        <img src="${resource(dir: 'images', file: 'loader-small.gif')}"
                                             alt=""/>载入<!--<SIAT_zh_CN original="Loading">载入</SIAT_zh_CN>-->...
                                    </div>

                                    <div id="${trialresult.trial.trialNumber}_detail"
                                         class="gtb1"
                                         style="display: none;"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </g:each>
        </table>
    </g:if>
    <g:else>
        <g:render template="/trial/trialAnalysis"
                  model="[trialresult: searchresult?.result?.expAnalysisResults[0], showTrial: true]"/>
    </g:else>
</g:else>

</div>
