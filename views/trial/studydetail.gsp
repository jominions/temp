<html>
<head>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/ext/resources/css', file: 'ext-all.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/ext/resources/css', file: 'xtheme-gray.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'datasetExplorer.css')}">

</head>

<body>
<g:if test="${clinicalTrial == null}">
    <table class="detail">
        <tr>
            <td>无案例结果<!--<SIAT_zh_CN original="Study not found">无案例结果</SIAT_zh_CN>-->.</td>
        </tr>
</g:if>
<g:else>
    <table class="detail" style="width: 515px;">
        <tbody>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.trialnumber" default="Trial number"/>:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'trialNumber')} <g:if
                    test="${clinicalTrial?.files.size() > 0}">
                <g:set var="fcount" value="${0}"/>
                <g:each in="${clinicalTrial.files}" var="file">
                    <g:if test="${file.content.type == 'Experiment Web Link'}">
                        <g:set var="fcount" value="${fcount++}"/>
                        <g:if test="${fcount > 1}">,</g:if>
                        <g:createFileLink content="${file.content}"
                                          displayLabel="${file.content.repository.repositoryType}"/>
                    </g:if>
                    <g:elseif
                            test="${file.content.type == 'Dataset Explorer Node Link' && search == 1}">
                        <g:link controller="datasetExplorer" action="index"
                                params="[path: file.content.location]">数据集管理器<!--<SIAT_zh_CN original="Dataset Explorer">数据集管理器</SIAT_zh_CN>--><img
                                src="${resource(dir: 'images', file: 'internal-link.gif')}"/>
                        </g:link>
                    </g:elseif>
                </g:each>
            </g:if> <g:if test="${searchId != null}">
                | <g:link controller="search" action="newSearch" id="${searchId}">搜索已分析数据<!--<SIAT_zh_CN original="Search analyzed Data">搜索已分析数据</SIAT_zh_CN>--> <img
                        src="${resource(dir: 'images', file: 'internal-link.gif')}"/>
                </g:link>
            </g:if></td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.name"
                                                     default="名称"/><!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'title')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.completiondate" default="日期"/><!--<SIAT_zh_CN original="Date">日期</SIAT_zh_CN>-->:</td>
            <g:if
                    test="${fieldValue(bean: clinicalTrial, field: 'completionDate')?.length() > 10}">
                <td valign="top" class="value">
                    ${fieldValue(bean: clinicalTrial, field: 'completionDate').substring(0, 11)}
                </td>
            </g:if>
            <g:else>
                <td valign="top" class="value">&nbsp;</td>
            </g:else>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.owner"
                                                     default="拥有者"/><!--<SIAT_zh_CN original="Owner">拥有者</SIAT_zh_CN>-->:</td>
            <g:if test="${clinicalTrial.type == 'Clinical Trial'}">
                <td valign="top" class="value">
                    ${fieldValue(bean: clinicalTrial, field: 'studyOwner')}
                </td>
            </g:if>
            <g:else>
                <td valign="top" class="value">
                    ${fieldValue(bean: clinicalTrial, field: 'primaryInvestigator')}
                </td>
            </g:else>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.institution" default="机构"/><!--<SIAT_zh_CN original="Institution">机构</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'institution')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.country"
                                                     default="国家"/><!--<SIAT_zh_CN original="Country">国家</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'country')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.publication" default="相关发表物"/><!--<SIAT_zh_CN original="Related Publication(s)">相关发表物</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                <g:if
                        test="${clinicalTrial?.files.size() > 0}">
                    <g:set var="fcount" value="${0}"/>
                    <g:each in="${clinicalTrial.files}" var="file">
                        <g:if test="${file.content.type == 'Publication Web Link'}">
                            <g:set var="fcount" value="${fcount++}"/>
                            <g:if test="${fcount > 1}">,</g:if>
                            <g:createFileLink content="${file.content}"
                                              displayLabel="${file.content.repository.repositoryType}"/>
                        </g:if>
                    </g:each>
                </g:if>
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.description" default="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'description')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.accessType" default="访问类型"/><!--<SIAT_zh_CN original="Access Type">访问类型</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'accessType')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.clinicalTrialphase" default="阶段"/><!--<SIAT_zh_CN original="Phase">阶段</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'studyPhase')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.design"
                                                     default="客观的"/><!--<SIAT_zh_CN original="Objective">客观的</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'design')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.bioMarkerType" default="生物标志物类型"/><!--<SIAT_zh_CN original="BioMarker Type">生物标志物类型</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'bioMarkerType')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.compound" default="化合物"/><!--<SIAT_zh_CN original="Compound">化合物</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value"><g:each
                    in="${clinicalTrial.compounds}" var="compound">
                <g:createFilterDetailsLink id="${compound?.id}"
                                           label="${compound?.genericName}" type="compound"/>
                <br>
            </g:each></td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.studydesign" default="设计因子"/><!--<SIAT_zh_CN original="Design Factors">设计因子</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'overallDesign')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.numberofpatients"
                    default="以下Subjects的数量"/><!--<SIAT_zh_CN original="Number of Followed Subjects">以下Subjects的数量</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                ${fieldValue(bean: clinicalTrial, field: 'numberOfPatients')}
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.organism" default="生物体"/><!--<SIAT_zh_CN original="Organism(s)">生物体</SIAT_zh_CN>-->:</td>
            <td valign="top" style="text-align: left;" class="value"><g:each
                    var="og" in="${clinicalTrial.organisms}">
                ${og?.label.encodeAsHTML()}<br>
            </g:each></td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message
                    code="clinicalTrial.target" default="目标/途径"/>:</td>
            <td valign="top" class="value"><!--<SIAT_zh_CN original="Target/Pathways">目标/途径</SIAT_zh_CN>-->
                ${fieldValue(bean: clinicalTrial, field: 'target')}
            </td>
        </tr>
        </tbody>
    </table>
</g:else>
</body>
</html>