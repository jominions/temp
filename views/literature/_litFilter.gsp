<div style="border:0px;overflow:auto;width:100%;height:100%">
    <g:form controller="literature">
        <table border="0" cellspacing="0" cellpadding="0" class="jubfilter">
            <tr>
                <th colspan="4">
                    <g:actionSubmit class="search" action="filterJubilant" value="过滤的结果"/><!--<SIAT_zh_CN original="Filter Results">过滤的结果</SIAT_zh_CN>-->&nbsp;
                </th>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">疾病:<!--<SIAT_zh_CN original="Disease">疾病</SIAT_zh_CN>--></td>
                <td colspan="3" class="selection">
                    <g:select from="${disease}" name="bioDiseaseId" optionKey="id" optionValue="preferredName"
                              value="${session.searchFilter.litFilter.bioDiseaseId}" noSelection="['': '-- Any --']"/>
                </td>
            </tr>
            <tr style="vertical-align:top">
                <td class="title" style="vertical-align:top;">疾病网站:<!--<SIAT_zh_CN original="Disease Site">疾病网站</SIAT_zh_CN>--></td>
                <td class="selection" colspan="3">
                    <g:select from="${diseaseSite}" name="diseaseSite"
                              value="${session.searchFilter.litFilter.diseaseSite}" noSelection="['': 'All']"
                              multiple="multiple" size="5"/>
                </td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">基因:<!--<SIAT_zh_CN original="Gene">基因</SIAT_zh_CN>--></td>
                <td colspan="3" class="selection">
                    <g:select from="${component}" name="componentList"
                              value="${session.searchFilter.litFilter.componentList}" noSelection="['': 'All']"
                              multiple="multiple" size="5"/>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="titlebar">Jubilant 变更过滤器<!--<SIAT_zh_CN original="Jubilant Alteration Filters">Jubilant 变更过滤器</SIAT_zh_CN>--></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">突变类型:<!--<SIAT_zh_CN original="Mutation Type">突变类型</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${mutationType}" name="mutationType"
                                                value="${session.searchFilter.litFilter.mutationType}"
                                                noSelection="['': '-- Any --']"/></td>
                <td class="title">地区:<!--<SIAT_zh_CN original="Region">地区</SIAT_zh_CN>--></td>
                <td class="selection" width="100%"><g:select from="${mutationSite}" name="mutationSite"
                                                             value="${session.searchFilter.litFilter.mutationSite}"
                                                             noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">表观遗传<!--<SIAT_zh_CN original="Epigenetic">表观遗传</SIAT_zh_CN>-->&nbsp;类型:<!--<SIAT_zh_CN original="Type">类型</SIAT_zh_CN>-->&nbsp;</td>
                <td class="selection"><g:select from="${epigeneticType}" name="epigeneticType"
                                                value="${session.searchFilter.litFilter.epigeneticType}"
                                                noSelection="['': '-- Any --']"/></td>
                <td class="title">地区:<!--<SIAT_zh_CN original="Region">地区</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${epigeneticRegion}" name="epigeneticRegion"
                                                value="${session.searchFilter.litFilter.epigeneticRegion}"
                                                noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:top">
                <td class="title" style="vertical-align:top;">变更<!--<SIAT_zh_CN original="Alteration">变更</SIAT_zh_CN>-->&nbsp;类型:<!--<SIAT_zh_CN original="Type">类型</SIAT_zh_CN>-->&nbsp;</td>
                <td colspan="3" class="selction">
                    <g:each in="${session.searchFilter.litFilter.alterationTypes.keySet()}" status="i"
                            var="alterationType">
                        <g:checkBox name="alterationtype_${alterationType.toLowerCase().replace(' ', '_')}"
                                    value="${session.searchFilter.litFilter.alterationTypes.get(alterationType)}"/>
                        ${alterationType}<br/>
                    </g:each>
                </td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">分子类型:<!--<SIAT_zh_CN original="Molecule Type">分子类型</SIAT_zh_CN>--></td>
                <td colspan="3" class="selection"><g:select from="${moleculeType}" name="moleculeType"
                                                            value="${session.searchFilter.litFilter.moleculeType}"
                                                            noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">规则:<!--<SIAT_zh_CN original="Regulation">规则</SIAT_zh_CN>--></td>
                <td colspan="3" class="selection">
                    <select class="jubselect" name="regulation" id="regulation">
                        <option value="">-- 任何<!--<SIAT_zh_CN original="Any">任何</SIAT_zh_CN>--> --</option>
                        <option value="Expression" ${session.searchFilter.litFilter.regulation == 'Expression' ? "selected" : ""}>表达式<!--<SIAT_zh_CN original="Expression">表达式</SIAT_zh_CN>--></option>
                        <option value="OverExpression" ${session.searchFilter.litFilter.regulation == 'OverExpression' ? "selected" : ""}>超表达式<!--<SIAT_zh_CN original="OverExpression">超表达式</SIAT_zh_CN>--></option>
                    </select>
                </td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">PTM类型:<!--<SIAT_zh_CN original="PTM Type">PTM类型</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${ptmType}" name="ptmType"
                                                value="${session.searchFilter.litFilter.ptmType}"
                                                noSelection="['': '-- Any --']"/></td>
                <td class="title">地区:<!--<SIAT_zh_CN original="Region">地区</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${ptmRegion}" name="ptmRegion"
                                                value="${session.searchFilter.litFilter.ptmRegion}"
                                                noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr>
                <td colspan="4" class="titlebar" colspan="4">Jubilant 互动过滤器<!--<SIAT_zh_CN original="Jubilant Interaction Filters">Jubilant 互动过滤器</SIAT_zh_CN>--></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">来源:<!--<SIAT_zh_CN original="Source">来源</SIAT_zh_CN>--></td>
                <td class="selection" colspan="3"><g:select from="${source}" name="source"
                                                            value="${session.searchFilter.litFilter.source}"
                                                            noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">目标:<!--<SIAT_zh_CN original="Target">目标</SIAT_zh_CN>--></td>
                <td class="selection" colspan="3"><g:select from="${target}" name="target"
                                                            value="${session.searchFilter.litFilter.target}"
                                                            noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">模型:<!--<SIAT_zh_CN original="Model">模型</SIAT_zh_CN>--></td>
                <td><g:select from="${experimentalModel}" name="experimentalModel"
                              value="${session.searchFilter.litFilter.experimentalModel}"
                              noSelection="['': '-- Any --']"/></td>
                <td class="title">机制:<!--<SIAT_zh_CN original="Mechanism">机制</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${mechanism}" name="mechanism"
                                                value="${session.searchFilter.litFilter.mechanism}"
                                                noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr>
                <td colspan="4" class="titlebar">Jubilant 抑制剂过滤器<!--<SIAT_zh_CN original="Jubilant Inhibitor Filters">Jubilant 抑制剂过滤器</SIAT_zh_CN>--></td>
            </tr>
            <tr>
                <td class="title">案例类型:<!--<SIAT_zh_CN original="Study Type">案例类型</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${trialType}" name="trialType"
                                                value="${session.searchFilter.litFilter.trialType}"
                                                noSelection="['': '-- Any --']"/></td>
                <td class="title">试验<!--<SIAT_zh_CN original="Trial">试验</SIAT_zh_CN>-->&nbsp;阶段:<!--<SIAT_zh_CN original="Phase">阶段</SIAT_zh_CN>--></td>
                <td class="selection"><g:select from="${trialPhase}" name="trialPhase"
                                                value="${session.searchFilter.litFilter.trialPhase}"
                                                noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">抑制剂名称:<!--<SIAT_zh_CN original="Inhibitor Name">抑制剂名称</SIAT_zh_CN>--></td>
                <td class="selection" colspan="3"><g:select from="${inhibitorName}" name="inhibitorName"
                                                            value="${session.searchFilter.litFilter.inhibitorName}"
                                                            noSelection="['': '-- Any --']"/></td>
            </tr>
            <tr style="vertical-align:middle">
                <td class="title">模型:<!--<SIAT_zh_CN original="Model">模型</SIAT_zh_CN>--></td>
                <td class="selection" colspan="3"><g:select from="${trialExperimentalModel}"
                                                            name="trialExperimentalModel"
                                                            value="${session.searchFilter.litFilter.trialExperimentalModel}"
                                                            noSelection="['': '-- Any --']"/></td>
            </tr>
        </table>
    </g:form>
</div>