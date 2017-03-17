<g:if test="${clinicalTrial == null}">
    <table class="detail">
    <tr><td>无此试验<!--<SIAT_zh_CN original="Trial not found">无此试验</SIAT_zh_CN>-->.</td></tr>
</g:if>
<g:else>
    <table class="detail" style="width: 515px;">
        <tbody>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.trialnumber" default="实验编号"/><!--<SIAT_zh_CN original="Trial number">实验编号</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'trialNumber')}
                <g:if test="${clinicalTrial?.files.size() > 0}">
                    <g:set var="fcount" value="${0}"/>
                    <g:each in="${clinicalTrial.files}" var="file">
                        <g:if test="${file.content.type == 'Experiment Web Link'}">
                            <g:set var="fcount" value="${fcount++}"/>
                            <g:if test="${fcount > 1}">,</g:if>
                            <g:createFileLink content="${file.content}"
                                              displayLabel="${file.content.repository.repositoryType}"/>
                        </g:if>
                        <g:elseif test="${file.content.type == 'Dataset Explorer Node Link' && search == 1}">
                            <g:link controller="datasetExplorer" action="index"
                                    params="[path: file.content.location]">数据集管理器<!--<SIAT_zh_CN original="Dataset Explorer">数据集管理器</SIAT_zh_CN>--><img
                                    src="${resource(dir: 'images', file: 'internal-link.gif')}"/></g:link>
                        </g:elseif>
                    </g:each>
                </g:if>
                <g:if test="${searchId != null}">
                    | <g:link controller="search" action="newSearch" id="${searchId}">搜索已分析数据<!--<SIAT_zh_CN original="Search analyzed Data">搜索已分析数据</SIAT_zh_CN>--> <img
                        src="${resource(dir: 'images', file: 'internal-link.gif')}"/></g:link>
                </g:if>

            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.title" default="标题"/><!--<SIAT_zh_CN original="Title">标题</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'title')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.owner" default="拥有者"/><!--<SIAT_zh_CN original="Owner">拥有者</SIAT_zh_CN>-->:</td>
            <g:if test="${clinicalTrial.type == 'Clinical Trial'}">
                <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'studyOwner')}</td>
            </g:if>
            <g:else>
                <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'primaryInvestigator')}</td>
            </g:else>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.description" default="描述"/><!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'description')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.studyphase" default="案例阶段"/><!--<SIAT_zh_CN original="Study phase">案例阶段</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'studyPhase')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.studytype" default="案例类型"/><!--<SIAT_zh_CN original="Study type">案例类型</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'studyType')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.studydesign" default="案例设计"/><!--<SIAT_zh_CN original="Study design">案例设计</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'design')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.blindingprocedure"
                                                     default="Blinding procedure"/><!--<SIAT_zh_CN original="Blinding procedure">Blinding procedure</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'blindingProcedure')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.durationofstudyweeks"
                                                     default="案例时长(周)"/><!--<SIAT_zh_CN original="Duration of study (weeks)">案例时长(周)</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'durationOfStudyWeeks')}</td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.completiondate"
                                                     default="完成日期"/><!--<SIAT_zh_CN original="Completion date">完成日期</SIAT_zh_CN>-->:</td>
            <g:if test="${fieldValue(bean: clinicalTrial, field: 'completionDate')?.length() > 10}">
                <td valign="top"
                    class="value">${fieldValue(bean: clinicalTrial, field: 'completionDate').substring(0, 11)}</td>
            </g:if>
            <g:else>
                <td valign="top" class="value">&nbsp;</td>
            </g:else>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.compound" default="化合物"/><!--<SIAT_zh_CN original="Compound">化合物</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">
                <g:each in="${clinicalTrial.compounds}" var="compound">
                    <g:createFilterDetailsLink id="${compound?.id}" label="${compound?.genericName}" type="compound"/>
                    <br>
                </g:each>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.inclusioncriteria"
                                                     default="选择标准"/><!--<SIAT_zh_CN original="Inclusion criteria">选择标准</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'inclusionCriteria')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.exclusioncriteria"
                                                     default="淘汰标准"/>:</td><!--<SIAT_zh_CN original="Exclusion criteria">淘汰标准</SIAT_zh_CN>-->
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'exclusionCriteria')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.dosingregimen" default="给药方案"/><!--<SIAT_zh_CN original="Dosing regimen">给药方案</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'dosingRegimen')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.typeofcontrol"
                                                     default="控制类型"/><!--<SIAT_zh_CN original="Type of control">控制类型</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'typeOfControl')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.genderrestrictionmfb"
                                                     default="性别限制 mfb"/><!--<SIAT_zh_CN original="Gender restriction mfb">性别限制 mfb</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'genderRestrictionMfb')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.groupassignment"
                                                     default="组分配"/>:</td><!--<SIAT_zh_CN original="Group assignment">组分配</SIAT_zh_CN>-->
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'groupAssignment')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.primaryendpoints"
                                                     default="主要试验评估指标"/><!--<SIAT_zh_CN original="Primary endpoints">主要试验评估指标</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'primaryEndPoints')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.secondaryendpoints"
                                                     default="次要试验评估指标"/>:</td><!--<SIAT_zh_CN original="Secondary endpoints">次要试验评估指标</SIAT_zh_CN>-->
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'secondaryEndPoints')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.routeofadministration"
                                                     default="给药途径"/>:</td><!--<SIAT_zh_CN original="Route of administration">给药途径</SIAT_zh_CN>-->
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'routeOfAdministration')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.secondaryids" default="次要ids"/><!--<SIAT_zh_CN original="Secondary ids">次要ids</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'secondaryIds')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.subjects" default="Subjects"/><!--<SIAT_zh_CN original="Subjects">Subjects</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'subjects')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.maxage" default="最大年龄"/><!--<SIAT_zh_CN original="Max age">最大年龄</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'maxAge')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.minage" default="最小年龄"/><!--<SIAT_zh_CN original="Min age">最小年龄</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'minAge')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.numberofpatients"
                                                     default="病患数量"/><!--<SIAT_zh_CN original="Number of patients">病患数量</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'numberOfPatients')}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name"><g:message code="clinicalTrial.numberofsites"
                                                     default="试点数量"/><!--<SIAT_zh_CN original="Number of sites">试点数量</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${fieldValue(bean: clinicalTrial, field: 'numberOfSites')}</td>
        </tr>
        </tbody>
    </table>
</g:else>