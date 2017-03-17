<g:form controller="trial" name="trialfilter-form" id="trialfilter-form" action="filterTrial">
    <input type="hidden" name="checked" value="">
    <g:set var="trialFilter" value="${session.searchFilter.trialFilter}"/>

    <table class="jubfilter" style="width:600px">
        <tr>
            <th colspan=2 style="align: right">
                <span class="button">
                    <g:submitButton class="search" onclick="submitChecked('trialfilter');" value="过滤器结果"
                                    action="filterTrial" name="trialfilterbutton"/><!--<SIAT_zh_CN original="Filter Results">过滤器结果</SIAT_zh_CN>-->&nbsp;
                </span>
            </th>
        </tr>
        <tr>
            <td colspan=2 style="border-right:0px solid #ccc">
                <table class="jubfiltersection">
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">疾病<!--<SIAT_zh_CN original="Disease">疾病</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${diseases}" name="bioDiseaseId" optionKey="id" optionValue="preferredName"
                                      value="${trialFilter.bioDiseaseId}" noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">化合物<!--<SIAT_zh_CN original="Compound">化合物</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${compounds}" name="bioCompoundId" optionKey="id" optionValue="name"
                                      value="${trialFilter.bioCompoundId}" noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">案例阶段<!--<SIAT_zh_CN original="Study Phase">案例阶段</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${phases}" name="phase" value="${trialFilter.phase}"
                                      noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">案例类型<!--<SIAT_zh_CN original="Study Type">案例类型</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${studyTypes}" name="studyType" value="${trialFilter.studyType}"
                                      noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">案例设计<!--<SIAT_zh_CN original="Study Design">案例设计</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${studyDesigns}" name="studyDesign" value="${trialFilter.studyDesign}"
                                      noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan=2 style="border-right:0px solid #ccc">
                <table class="jubfiltersection">
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">数据平台<!--<SIAT_zh_CN original="Data Platform">数据平台</SIAT_zh_CN>-->:</td>
                        <td>
                            <g:select from="${studyPlatform}" name="platform" value="${trialFilter?.platform}"
                                      noSelection="['': '-- Any --']"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">倍数变化切断(Fold Change Cut Off)<!--<SIAT_zh_CN original="Fold Change Cut Off">倍数变化切断(Fold Change Cut Off)</SIAT_zh_CN>-->:</td>
                        <td style="font-weight:normal">
                            <g:textField name="foldChange"
                                         value="${trialFilter?.foldChange}"/> (最小倍数变化比率+/-1.0<!--<SIAT_zh_CN original="Minimum Fold Change Ratio +/-1.0">最小倍数变化比率+/-1.0</SIAT_zh_CN>-->)
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">p值小于<!--<SIAT_zh_CN original="p Value Is Less Than">p值小于</SIAT_zh_CN>-->:</td>
                        <td style="font-weight:normal">
                            <g:textField name="pvalue" value="${trialFilter?.pvalue}"/> (最大P值0.1<!--<SIAT_zh_CN original="Maximum P-Value 0.1">最大P值0.1</SIAT_zh_CN>-->)
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 175px; white-space: nowrap;">绝对R/Rho值小于<!--<SIAT_zh_CN original="Absolute R/Rho Value is Less Than">绝对R/Rho值小于</SIAT_zh_CN>-->:</td>
                        <td style="font-weight:normal">
                            <g:textField name="rvalue" value="${trialFilter?.rvalue}"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan=2 style="border-right: 0px solid #ccc">
                <table class="jubfiltersection">
                    <tr>
                        <td>
                            <b>临床试验<!--<SIAT_zh_CN original="Clinical Trials">临床试验</SIAT_zh_CN>-->:</b>
                            <br>
                            <br>

                            <div id="trialfilter-div"
                                 style="overflow:auto; height:350px; width:700px; border:0px solid #c3daf9;"></div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</g:form>
