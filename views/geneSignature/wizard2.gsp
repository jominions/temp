<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="genesigmain" />
    <g:if test="${wizard.wizardType==1}">
        <title>编辑基因印记<!--<SIAT_zh_CN original="Gene Signature Edit">编辑基因印记</SIAT_zh_CN>--></title>
    </g:if>
    <g:else>
        <title>创建基因印记<!--<SIAT_zh_CN original="Gene Signature Create">创建基因印记</SIAT_zh_CN>--></title>
    </g:else>

    <script type="text/javascript">
        // id prefix for ajax window
        var lkupWinId = null;

        function speciesToggle(selectItem) {
            var mouseSrc = document.getElementById('mouse_source_div')
            var moutseOther = document.getElementById('mouse_other_id')
            var selectVal = selectItem.value
            var selectText = selectItem.options[selectItem.selectedIndex].text

            // toggle mouse source
            //if(selectVal=='MOUSE_1' || selectVal=='MOUSE_2' || selectVal=='MOUSE_3' || selectVal=='MOUSE_4')
            if(selectText.indexOf('Mouse')!=-1)
                mouseSrc.style.display='inline';
            else
                mouseSrc.style.display='none';

            // toggle mouse other
            //if(selectVal=='MOUSE_3' || selectVal=='MOUSE_4')
            if(selectText=='Mouse (knockout or transgenic)' || selectText=='Mouse (other)')
                moutseOther.style.display='block';
            else
                moutseOther.style.display='none';
        }

        function toggleExpType(selectItem) {
            var toggleDiv = document.getElementById('in_vivo_id')
            var cellLineDiv = document.getElementById('exp_cell_line_div')
            var selectVal = selectItem.value
            var selectText = selectItem.options[selectItem.selectedIndex].text

            // toggle mouse source
            if(selectText.indexOf('in vivo')!=-1)
                toggleDiv.style.display='inline';
            else
                toggleDiv.style.display='none';

            // toggle established cell line
            if(selectText=='Established cell line')
                cellLineDiv.style.display='inline';
            else
                cellLineDiv.style.display='none';
        }

        function validate() {
            var errorMsg = "";
            var formName = "geneSignatureFrm";

            //species required
            var species = document.forms[formName].elements['speciesConceptCode.id'];
            if(species.value=="null") errorMsg = "\n- 请选择相关物种";//<SIAT_zh_CN original="Please select a relevant species">请选择相关物种</SIAT_zh_CN>

            //tech platform required
            var techPlat = document.forms[formName].elements['techPlatform.id'];
            if(techPlat.value=="null") errorMsg = errorMsg + "\n- 请选择相关技术平台";//<SIAT_zh_CN original="Please select a technology platform">请选择相关技术平台</SIAT_zh_CN>


            if(errorMsg=="") return true;

            alert("请纠正以下错误:\n" + errorMsg);//<SIAT_zh_CN original="Please correct the following errors">请纠正以下错误</SIAT_zh_CN>
            return false;
        }

        // show cell line lookup dialog
        function showCellLineLookup() {
            // must select a species first
            var species = document.forms['geneSignatureFrm'].elements['speciesConceptCode.id'];
            if(species.value=="null") {
                alert("请在选择细胞系之前先选择一个物种！");//<SIAT_zh_CN original="Please select a species before picking a cell line!">请在选择细胞系之前先选择一个物种！</SIAT_zh_CN>
                return false;
            }

            // pass species filter
            var lkupUrl = "${createLink([controller:'geneSignature',action:'cellLineLookup'])}/" + species.value;
            //alert("url: "+lkupUrl);
            lkupWinId = "lkup"+(new Date()).getTime();
            showDialog(lkupWinId, { title: '查找细胞', url: lkupUrl })//<SIAT_zh_CN original="Cell Line Lookup">查找细胞</SIAT_zh_CN>
        }

        // populate cell line controls from ajax selection
        function selectCellLine(clId, clText) {
            var clIdBox = document.forms['geneSignatureFrm'].elements['experimentTypeCellLine.id'];
            clIdBox.value = clId;

            var clTextBox = document.forms['geneSignatureFrm'].elements['experimentTypeCellLineText'];
            clTextBox.value = clText;

            // destroy ajax window
            var ajaxWin = Ext.getCmp(lkupWinId + '-win');
            ajaxWin.destroy();
        }

    </script>
</head>

<body>

<div class="body">
<!-- initialize -->
<g:set var="gs" value="${wizard.geneSigInst.properties}" />

<g:if test="${wizard.wizardType==0}"><h1>创建基因签名<!--<SIAT_zh_CN original="Gene Signature Create">创建基因签名</SIAT_zh_CN>--></h1></g:if>
<g:if test="${wizard.wizardType==1}"><h1>编辑基因签名<!--<SIAT_zh_CN original="Gene Signature Edit">编辑基因签名</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>
<g:if test="${wizard.wizardType==2}"><h1>复制基因签名<!--<SIAT_zh_CN original="Gene Signature Clone">克隆基因签名</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>

<!-- instructions -->
<g:render template="instructions" />
<br>

<g:form name="geneSignatureFrm" method="post">
<g:hiddenField name="page" value="2" />

<p style="font-weight: bold;">页面 2: 元数据:<!--<SIAT_zh_CN original="Page 2: Meta-Data:">页面 2: 元数据:</SIAT_zh_CN>--></p>
<table class="detail">
    <tr class="prop">
        <td class="name">源列表<!--<SIAT_zh_CN original="Source of list">源列表</SIAT_zh_CN>--></td>
        <td class="value">
            <g:select name="sourceConceptCode.id"
                      from="${wizard.sources}"
                      value="${existingValues.'sourceConceptCode.id'}"
                      noSelection="['null':'选择源']"
                      optionValue="codeName"
                      optionKey="id"
                      onChange="javascript: toggleOtherDiv(this, 'source_other_div');" /><!--<SIAT_zh_CN original="select source">选择源</SIAT_zh_CN>-->
        <!--  toggle source other div accordingly -->
            <g:if test="${existingValues.'sourceConceptCode.bioConceptCode'=='OTHER'}">
                <div id="source_other_div" style="display: block;">
            </g:if>
            <g:else>
                <div id="source_other_div" style="display: none;">
            </g:else>
            <label>请提供'其他'细节<!--<SIAT_zh_CN original="please provide 'other' detail">请提供'其他'细节</SIAT_zh_CN>--><g:requiredIndicator/>:</label>
            <br><g:textField name="sourceOther" value="${gs.sourceOther}" size="100%" maxlength="255" />
        </div>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">数据拥有者<!--<SIAT_zh_CN original="Owner of data">数据拥有者</SIAT_zh_CN>--></td>
        <td class="value">
            <g:select name="ownerConceptCode.id"
                      from="${wizard.owners}"
                      value="${existingValues.'ownerConceptCode.id'}"
                      noSelection="['null':'选择数据拥有者']"
                      optionValue="codeName"
                      optionKey="id" /><!--<SIAT_zh_CN original="select owner of the data">选择数据拥有者</SIAT_zh_CN>-->
        </td>
    </tr>
    <tr class="prop">
        <td class="name">刺激<!--<SIAT_zh_CN original="Stimulus">刺激</SIAT_zh_CN>--></td>
        <td class="value">
            <table>
                <tr>
                    <td style="border: none; width; 33%;">如 LPS，polyIC等:<!--<SIAT_zh_CN original="i.e. LPS, polyIC, etc:">如 LPS，polyIC等</SIAT_zh_CN>--></td><td style="border: none;"><g:textArea name="stimulusDescription" value="${gs.stimulusDescription}" rows="3" cols="85" /></td>
                </tr>
                <tr>
                    <td style="border: none; width; 33%;">剂量，单位，和时间:<!--<SIAT_zh_CN original="Dose, units, and time:">剂量，单位，和时间:</SIAT_zh_CN>--></td><td style="border: none;"><g:textField name="stimulusDosing" value="${gs.stimulusDosing}" size="67%" maxlength="255" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">治疗<!--<SIAT_zh_CN original="Treatment">治疗</SIAT_zh_CN>--></td>
        <td class="value">
            <table>
                <tr>
                    <td style="border: none; width; 33%;">该药物治疗使用测定法:<!--<SIAT_zh_CN original="Drug treatment used in assay:">该药物治疗使用测定法:</SIAT_zh_CN>--></td><td style="border: none;"><g:textArea name="treatmentDescription" value="${gs.treatmentDescription}" rows="6" cols="85" /></td>
                </td>
                </tr>
                <tr>
                    <td style="border: none; width; 33%;">剂量，单位，和时间:<!--<SIAT_zh_CN original="Dose, units, and time:">剂量，单位，和时间:</SIAT_zh_CN>--></td><td style="border: none;"><g:textField name="treatmentDosing" value="${gs.treatmentDosing}" size="67%" maxlength="255" /></td>
                </tr>
                <tr><td style="border: none; font-weight: bold; font-style: italic;" colspan=2>或进入:<!--<SIAT_zh_CN original="OR Enter:">或进入:</SIAT_zh_CN>--></td></tr>
                <tr>
                    <td style="border: none; width; 33%;">化合物:<!--<SIAT_zh_CN original="Compound:">化合物:</SIAT_zh_CN>--></td>
                    <td style="border: none;"><g:select name="treatmentCompound.id"
                                                        from="${wizard.compounds}"
                                                        value="${existingValues.'treatmentCompound.id'}"
                                                        noSelection="['null':'选择化合物']"
                                                        optionValue="${{it?.getName()}}"
                                                        optionKey="id" /><!--<SIAT_zh_CN original="select compound">选择化合物</SIAT_zh_CN>-->
                    </td>
                </tr>
                <tr>
                    <td style="border: none; width; 33%;">协议编号:<!--<SIAT_zh_CN original="Protocol Number:">协议编号:</SIAT_zh_CN>--></td><td style="border: none;"><g:textField name="treatmentProtocolNumber" value="${gs.treatmentProtocolNumber}" size="67%" maxlength="255" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">PMIDs (用逗号隔开)<!--<SIAT_zh_CN original="PMIDs (comma separated)">PMIDs (用逗号隔开)</SIAT_zh_CN>--></td>
        <td class="value"><g:textField name="pmIds" value="${gs.pmIds}" size="67%" maxlength="255" /></td>
    </tr>
    <tr class="prop">
        <td class="name">物种<!--<SIAT_zh_CN original="Species">物种</SIAT_zh_CN>--><g:requiredIndicator/></td>
        <td class="value">
            <table>
            <tr>
                <td style="border: none; width: 50%">
                    <g:select name="speciesConceptCode.id"
                              from="${wizard.species}"
                              value="${existingValues.'speciesConceptCode.id'}"
                              noSelection="['null':'选择相关物种']"
                              optionValue="codeName"
                              optionKey="id"
                              onChange="javascript:speciesToggle(this);" />&nbsp;<!--<SIAT_zh_CN original="select relevant species">选择相关物种</SIAT_zh_CN>-->
                <!--  toggle mouse div accordingly -->
                    <g:if test="${existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_1' || existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_2' ||
                            existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_3' || existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_4'}">
                        <div id="mouse_source_div" style="display: inline;">对于实验用鼠，请键入源<!--<SIAT_zh_CN original="For Mouse, enter source">对于实验用鼠，请键入源</SIAT_zh_CN>--><g:requiredIndicator/>:
                    </g:if>
                    <g:else>
                        <div id="mouse_source_div" style="display: none;">对于实验用鼠，请键入源<!--<SIAT_zh_CN original="For Mouse, enter source">对于实验用鼠，请键入源</SIAT_zh_CN>--><g:requiredIndicator/>:
                    </g:else>
                    <g:select name="speciesMouseSrcConceptCode.id"
                              from="${wizard.mouseSources}"
                              value="${existingValues.'speciesMouseSrcConceptCode.id'}"
                              noSelection="['null':'选择源']"
                              optionValue="codeName"
                              optionKey="id" /><!--<SIAT_zh_CN original="select source">选择源</SIAT_zh_CN>-->
                </div>
                </td>
            <!--  toggle mouse other accordingly -->
                <g:if test="${existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_3' || existingValues.'speciesConceptCode.bioConceptCode'=='MOUSE_4'}">
                    <tr id="mouse_other_id" style="display: block;"><td>
                </g:if>
                <g:else>
                    <tr id="mouse_other_id" style="display: none;">
                </g:else>
                <td style="border: none;">
                    <label>关于'淘汰/转基因‘小鼠与'其他'小鼠血缘关系的细节:<!--<SIAT_zh_CN original="Detail for 'knockout/transgenic' or 'other' mouse strain">关于'淘汰/转基因‘小鼠与'其他'小鼠血缘关系的细节:</SIAT_zh_CN>--><g:requiredIndicator/>:</label>
                    <br><g:textField name="speciesMouseDetail" value="${gs.speciesMouseDetail}" size="100%" maxlength="255" />
                </td>
            </tr>
            </table>
        </td>
    </tr>
    <tr class="prop">
        <td class="name">技术平台<!--<SIAT_zh_CN original="Technology Platform">技术平台</SIAT_zh_CN>--><g:requiredIndicator/></td>
        <td class="value">
            <g:select name="techPlatform.id"
                      from="${wizard.platforms}"
                      value="${existingValues.'techPlatform.id'}"
                      noSelection="['null':'选择技术平台']"
                      optionValue="${{it?.vendor + ' - ' + it?.array + ' [' + it?.accession + ']'}}"
                      optionKey="id"
                      onChange="javascript: toggleOtherDiv(this, 'platform_other_div');" /><!--<SIAT_zh_CN original="select tech platform">选择技术平台</SIAT_zh_CN>-->
            <div id="platform_other_div" style="display: none;">
                <label>请提供'其他'添加物<!--<SIAT_zh_CN original="please provide 'other' accession">请提供'其他'添加物</SIAT_zh_CN>--> #<g:requiredIndicator/>:</label>
                <br><input type="text" name="techPlatformOther" size="100%" />
            </div>
    </tr>
    <tr class="prop">
        <td class="name">组织类型<!--<SIAT_zh_CN original="Tissue Type">组织类型</SIAT_zh_CN>--></td>
        <td class="value">
            <g:select name="tissueTypeConceptCode.id"
                      from="${wizard.tissueTypes}"
                      value="${existingValues.'tissueTypeConceptCode.id'}"
                      noSelection="['null':'选择相关组织']"
                      optionValue="codeName"
                      optionKey="id" /><!--<SIAT_zh_CN original="select relevant tissue">选择相关组织</SIAT_zh_CN>-->
        </td>
    </tr>
    <tr class="prop">
        <td class="name">实验类型<!--<SIAT_zh_CN original="Experiment Type">实验类型</SIAT_zh_CN>--></td>
        <td class="value">
            <table>
                <tr>
                    <td style="border: none; width: 50%">
                        <g:select name="experimentTypeConceptCode.id"
                                  from="${wizard.expTypes}"
                                  value="${existingValues.'experimentTypeConceptCode.id'}"
                                  noSelection="['null':'选择实验类型']"
                                  optionValue="codeName"
                                  optionKey="id"
                                  onChange="javascript:toggleExpType(this);" /><!--<SIAT_zh_CN original="select experiment type">选择实验类型</SIAT_zh_CN>-->

                    <!--  toggle established cell line accordingly -->
                        <g:if test="${existingValues.'experimentTypeConceptCode.bioConceptCode'=='ESTABLISHED'}">
                            <div id="exp_cell_line_div" style="display: inline;">进入细胞系<!--<SIAT_zh_CN original="Enter cell line">进入细胞系</SIAT_zh_CN>--><g:requiredIndicator/>:
                        </g:if>
                        <g:else>
                            <div id="exp_cell_line_div" style="display: none;">进入细胞系<!--<SIAT_zh_CN original="Enter cell line">进入细胞系</SIAT_zh_CN>--><g:requiredIndicator/>:
                        </g:else>
                    <!-- cell line lookup support -->
                        <g:hiddenField name="experimentTypeCellLine.id" value="${gs.experimentTypeCellLine? gs.experimentTypeCellLine.id : 'null'}" />
                        <g:if test="${gs.experimentTypeCellLine!=null}"><g:textField name="experimentTypeCellLineText" value="${existingValues.'experimentTypeCellLine.cellLineName' + ' ('+existingValues.'experimentTypeCellLine.attcNumber'+')'}" readonly="readonly" size="80%" /> </g:if>
                        <g:else><g:textField name="experimentTypeCellLineText" readonly="readonly" size="80%" /> </g:else>
                    &nbsp;<a onclick="javascript:showCellLineLookup();"><img alt="Cell Line Lookup" src="${resource(dir:'images',file:'filter.png')}" /></a>
                    </div>
                    </td>
            <tr>
            <!--  toggle in vivo model accordingly -->
                <g:if test="${existingValues.'experimentTypeConceptCode.bioConceptCode'=='IN_VIVO_ANIMAL' || existingValues.'experimentTypeConceptCode.bioConceptCode'=='IN_VIVO_HUMAN'}">
                    <tr id="in_vivo_id" style="display: inline;">
                </g:if>
                <g:else>
                    <tr id="in_vivo_id" style="display: none;">
                </g:else>
                <td style="border: none;">
                    <label>对于'in vivo' 描述模型:<!--<SIAT_zh_CN original="For 'in vivo', describe model">对于'in vivo' 描述模型：</SIAT_zh_CN>--><g:requiredIndicator/>:</label><br><g:textField name="experimentTypeInVivoDescr" value="${gs.experimentTypeInVivoDescr}" size="100%" maxlength="255" />
                </td>
            </tr>
                <tr><td style="border: none;"><label>如果可行，给出ATCC的描述:<!--<SIAT_zh_CN original="If applicable, ATCC designation">如果可行，给出ATCC的描述</SIAT_zh_CN>--></label><br><g:textField name="experimentTypeATCCRef" value="${gs.experimentTypeATCCRef}" size="100%" maxlength="255" /></td></tr>
            </table>
        </td>
    </tr>
</table>

<div class="buttons">
    <g:actionSubmit class="previous" action="${(wizard.wizardType==1 || wizard.wizardType==2) ? 'edit1' : 'create1'}" value="定义" /><!--<SIAT_zh_CN original="Definition">定义</SIAT_zh_CN>-->
    <g:actionSubmit class="next" action="${(wizard.wizardType==1 || wizard.wizardType==2) ? 'edit3' : 'create3'}" value="下一步" onclick="return validate();" /><!--<SIAT_zh_CN original="Next">下一步</SIAT_zh_CN>-->
    <g:actionSubmit class="cancel" action="refreshSummary" onclick="return confirm('确认离开？')" action="Cancel" value="取消" /><!--<SIAT_zh_CN original="Are you sure you want to exit?">确认离开？</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>-->
</div>

</g:form>
</div>
</body>
</html>
