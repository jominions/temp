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
        function clearMTC() {
            var bg = document.geneSignatureFrm.multipleTestingCorrection;
            bg[0].checked=false;
            bg[1].checked=false;
        }

        function validate() {
            var errorMsg = "";
            var formName = "geneSignatureFrm";

            //p-value cutoff required
            var cutoff = document.forms[formName].elements['pValueCutoffConceptCode.id'];
            if(cutoff.value=="null") errorMsg = "\n- 请选择一个P值切断(P-value cutoff)";//<SIAT_zh_CN original="Please select a p-value cutoff">请选择一个P值切断(P-value cutoff)</SIAT_zh_CN>

            //file schema
            var schema = document.forms[formName].elements['fileSchema.id'];
            if(schema.value=="null") errorMsg = errorMsg + "\n- 请选择文件结构";//<SIAT_zh_CN original="Please select a file schema">请选择文件结构</SIAT_zh_CN>

            //fold change metric
            var metricType = document.forms[formName].elements['foldChgMetricConceptCode.id'];
            if(metricType.value=="null") errorMsg = errorMsg + "\n- 请选择一个倍数变化指标(Fold-change metric)";//<SIAT_zh_CN original="Please select a fold-change metric">请选择一个倍数变化指标(Fold-change metric)</SIAT_zh_CN>

            // upload file
            <g:if test="${wizard.wizardType==0}">
            if(document.geneSignatureFrm.uploadFile.value=="") errorMsg = errorMsg + "\n- 请选择和你的基因印记有关的上传文件";
            </g:if>//<SIAT_zh_CN original="Please select a file to upload with your gene signature">请选择和你的基因印记有关的上传文件</SIAT_zh_CN>

            // if no errors, continue submission
            if(errorMsg=="") return true;

            alert("请纠正以下错误:\n" + errorMsg);//<SIAT_zh_CN original="Please correct the following errors:">请纠正以下错误:</SIAT_zh_CN>
            return false;
        }

    </script>
</head>

<body>

<div class="body">
<!-- initialize -->
    <g:set var="gs" value="${wizard.geneSigInst.properties}" />

<!--  show message -->
    <g:if test="${flash.message}">
        <div class="warning">${flash.message}</div>
        <g:hasErrors bean="${wizard.geneSigInst}"><div class="errors"><g:renderErrors bean="${wizard.geneSigInst}" as="list" /></div></g:hasErrors>
        <br>
    </g:if>

    <g:if test="${wizard.wizardType==0}"><h1>创建基因印记<!--<SIAT_zh_CN original="Gene Signature Create">创建基因印记</SIAT_zh_CN>--></h1></g:if>
    <g:if test="${wizard.wizardType==1}"><h1>编辑基因印记<!--<SIAT_zh_CN original="Gene Signature Edit">编辑基因印记</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>
    <g:if test="${wizard.wizardType==2}"><h1>复制基因印记<!--<SIAT_zh_CN original="Gene Signature Clone">克隆基因印记</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>

<!-- instructions -->
    <g:render template="instructions" />
    <br>

    <g:form name="geneSignatureFrm" enctype="multipart/form-data" method="post">
        <g:hiddenField name="page" value="3" />

        <p style="font-weight: bold;">页面 3: 分析元数据:<!--<SIAT_zh_CN original="Page 3: Analysis Meta-Data:">页面 3: 分析元数据:</SIAT_zh_CN>--></p>
        <table class="detail">
            <tr class="prop">
                <td class="name">执行分析者:<!--<SIAT_zh_CN original="Analysis Performed By">执行分析者</SIAT_zh_CN>--></td>
                <td class="value"><g:textField name="analystName" value="${gs.analystName}" size="100%" maxlength="100" /></td>
            </tr>
            <tr class="prop">
                <td class="name">归一化方法:<!--<SIAT_zh_CN original="Normalization Method">归一化方法</SIAT_zh_CN>--></td>
                <td class="value">
                    <g:select name="normMethodConceptCode.id"
                              from="${wizard.normMethods}"
                              value="${existingValues.'normMethodConceptCode.id'}"
                              noSelection="['null':'select normalization method']"
                              optionValue="codeName"
                              optionKey="id"
                              onchange="javascript: toggleOtherDiv(this, 'norm_method_other_div');" />
                <!--  toggle other div accordingly -->
                    <g:if test="${existingValues.'normMethodConceptCode.bioConceptCode'=='OTHER'}">
                        <div id="norm_method_other_div" style="display: block;">
                    </g:if>
                    <g:else>
                        <div id="norm_method_other_div" style="display: none;">
                    </g:else>
                    <label>请提供'其他'细节<!--<SIAT_zh_CN original="please provide 'other' detail">请提供'其他'细节</SIAT_zh_CN>--><g:requiredIndicator/>:</label><br><g:textField name="normMethodOther" value="${gs.normMethodOther}" size="100%" maxlength="255" />
                </div>
                </td>
            </tr>
            <tr class="prop">
                <td class="name">分析信息<!--<SIAT_zh_CN original="Analysis Info">分析信息</SIAT_zh_CN>-->
</td>
                <td class="value">
                    <table>
                        <tr>
                            <td style="width:20%; border: none;">类别<!--<SIAT_zh_CN original="Category">类别</SIAT_zh_CN>-->:</td>
                            <td style="border: none;">
                                <g:select name="analyticCatConceptCode.id"
                                          from="${wizard.analyticTypes}"
                                          value="${existingValues.'analyticCatConceptCode.id'}"
                                          noSelection="['null':'select category']"
                                          optionValue="${{(it?.bioConceptCode=='OTHER')? it?.codeName : it?.codeName + ' (' + it?.codeDescription + ')'}}"
                                          optionKey="id"
                                          onchange="javascript: toggleOtherDiv(this, 'analysis_cat_other_div');" />
                            <!--  toggle other div accordingly -->
                                <g:if test="${existingValues.'analyticCatConceptCode.bioConceptCode'=='OTHER'}">
                                    <div id="analysis_cat_other_div" style="display: block;">
                                </g:if>
                                <g:else>
                                    <div id="analysis_cat_other_div" style="display: none;">
                                </g:else>
                                <label>请提供'其他'细节<!--<SIAT_zh_CN original="please provide 'other' detail">请提供'其他'细节</SIAT_zh_CN>--><g:requiredIndicator/>:</label><br><g:textField name="analyticCatOther" value="${gs.analyticCatOther}" size="100%" maxlength="255" />
                            </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:20%; border: none;">方法:<!--<SIAT_zh_CN original="Method">方法</SIAT_zh_CN>--></td>
                            <td style="border: none;">
                                <g:select name="analysisMethodConceptCode.id"
                                          from="${wizard.analysisMethods}"
                                          value="${existingValues.'analysisMethodConceptCode.id'}"
                                          noSelection="['null':'select analysis method']"
                                          optionValue="codeName"
                                          optionKey="id"
                                          onchange="javascript: toggleOtherDiv(this, 'analysis_method_other_div');" />
                            <!--  toggle other div accordingly -->
                                <g:if test="${existingValues.'analysisMethodConceptCode.bioConceptCode'=='OTHER'}">
                                    <div id="analysis_method_other_div" style="display: block;">
                                </g:if>
                                <g:else>
                                    <div id="analysis_method_other_div" style="display: none;">
                                </g:else>
                                <label>请提供'其他'细节<!--<SIAT_zh_CN original="please provide 'other' detail">请提供'其他'细节</SIAT_zh_CN>--><g:requiredIndicator/>:</label><br><g:textField name="analysisMethodOther" value="${gs.analysisMethodOther}" size="100%" maxlength="255" />
                            </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="prop">
                <td class="name">启用多重检验校正?<!--<SIAT_zh_CN original="Multiple Testing Correction Employed?">启用多重检验校正？</SIAT_zh_CN>--></td>
                <td class="value">
                    <g:radioGroup name="multipleTestingCorrection" values="[1,0]" labels="['Yes','No']" value="${gs.multipleTestingCorrection}" >
                        ${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;
                    </g:radioGroup>
                    &nbsp;<a href="javascript:clearMTC();">clear<!--<SIAT_zh_CN original="clear">清除</SIAT_zh_CN>--></a>
                </td>
            </tr>
            <tr class="prop">
                <td class="name">P值切断(P-value cutoff):<!--<SIAT_zh_CN original="P-value Cutoff">P值切断(P-value cutoff)</SIAT_zh_CN>--><g:requiredIndicator/></td>
                <td class="value">
                    <g:select name="pValueCutoffConceptCode.id"
                              from="${wizard.pValCutoffs}"
                              value="${existingValues.'pValueCutoffConceptCode.id'}"
                              noSelection="['null':'select p-value cutoff']"
                              optionValue="codeName"
                              optionKey="id" />
                </td>
            </tr>
        </table>
        <br>

        <g:if test="${wizard.wizardType==1 || wizard.wizardType==2}">
            <table class="detail" style="width: 100%">
            <g:tableHeaderToggle label="Upload New File Only to Override Existing Items" divPrefix="file_info" />
            <tbody id="file_info_detail" style="display: none;">
            <tr>
                <td colspan="2" style="font-weight: bold; font-size: 12px;">上传文件信息(仅含制表符分隔的文本文件，不包括后缀名为.xls的Excel文件 ):<!--<SIAT_zh_CN original="File Upload Information (tab delimited text only, no .xls Excel files):">上传文件信息(仅含制表符分隔的文本文件，不包括后缀名为.xls的Excel文件 ):</SIAT_zh_CN>-->&nbsp;&nbsp;
                    <a style="font-style:italic;" href="${resource(dir:'images',file:'gene_sig_samples.txt')}" target="_blank"><img alt="examples" src="${resource(dir:'images',file:'text.png')}" />&nbsp;查看范例<!--<SIAT_zh_CN original="See Samples">查看范例</SIAT_zh_CN>--></a>
            </td>
        </tr>
        </g:if>
        <g:else>
            <p style="font-weight: bold;">上传文件信息(仅含制表符分隔的文本文件，不包括后缀名为.xls的Excel文件 ):<!--<SIAT_zh_CN original="File Upload Information (tab delimited text only, no .xls Excel files):">上传文件信息(仅含制表符分隔的文本文件，不包括后缀名为.xls的Excel文件 ):</SIAT_zh_CN>-->&nbsp;&nbsp;
                <a style="font-style:italic;" href="${resource(dir:'images',file:'gene_sig_samples.txt')}" target="_blank"><img alt="examples" src="${resource(dir:'images',file:'text.png')}" />&nbsp;查看范例<!--<SIAT_zh_CN original="See Samples">查看范例</SIAT_zh_CN>--></a></p>
            <table class="detail" style="width: 100%">
                <tbody id="file_info_detail">
        </g:else>
        <tr class="prop">
            <td class="name">文件信息:<!--<SIAT_zh_CN original="File Information">文件信息</SIAT_zh_CN>--><g:requiredIndicator/></td>
            <td class="value">
                <table>
                    <tr>
                        <td style="width:25%; border: none;">文件结构:<!--<SIAT_zh_CN original="File schema:">文件结构</SIAT_zh_CN>--></td>
                        <td style="border: none;">
                            <g:select name="fileSchema.id" from="${wizard.schemas}" value="${existingValues.'fileSchema.id'}" optionValue="name" optionKey="id" /></td>
                    </tr>
                    <tr>
                        <td style="width:25%; border: none;">倍数变化指标(Fold-change metric):<!--<SIAT_zh_CN original="Fold change metric">倍数变化指标(Fold-change metric)</SIAT_zh_CN>--></td>
                        <td style="border: none;">
                            <g:select name="foldChgMetricConceptCode.id"
                                      from="${wizard.foldChgMetrics}"
                                      value="${existingValues.'foldChgMetricConceptCode.id'}"
                                      noSelection="['null':'select metric indicator']"
                                      optionValue="codeName"
                                      optionKey="id" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="prop">
            <td class="name">上传文件<!--<SIAT_zh_CN original="Upload File">上传文件</SIAT_zh_CN>--><g:if test="${wizard.wizardType==0}"><g:requiredIndicator/></g:if><br>(仅含制表符分隔的文本文件)<!--<SIAT_zh_CN original="(tab delimited text files only)">(仅含制表符分隔的文本文件)</SIAT_zh_CN>--></td>
            <td class="value"><input type="file" name="uploadFile" <g:if test="${wizard.wizardType==0}">value="${gs.uploadFile}"</g:if><g:else>value=""</g:else> size="100" /></td>
        </tr>
        </tbody>
    </table>

        <div class="buttons">
            <g:actionSubmit class="previous" action="${(wizard.wizardType==1 || wizard.wizardType==2) ? 'edit2' : 'create2'}" value="元数据" /><!--<SIAT_zh_CN original="Meta-Data">元数据</SIAT_zh_CN>-->
            <g:actionSubmit class="save" action="${(wizard.wizardType==1) ? 'update' : 'save'}" value="保存" onclick="return validate();" /><!--<SIAT_zh_CN original="Save">保存</SIAT_zh_CN>-->
            <g:actionSubmit class="cancel" action="refreshSummary" onclick="return confirm('确认离开？')" action="Cancel" value="取消" /><!--<SIAT_zh_CN original="Are you sure you want to exit?">确认离开？</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>-->
        </div>

    </g:form>

</div>
</body>
</html>
