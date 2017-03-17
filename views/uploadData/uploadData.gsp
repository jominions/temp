<!DOCTYPE html>
<g:logMsg>In uploadData.gsp</g:logMsg>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link rel="shortcut icon" href="${resource(dir:'images',file:'searchtool.ico')}">
		<link rel="icon" href="${resource(dir:'images',file:'searchtool.ico')}">
		<link rel="stylesheet" href="${resource(dir:'js', file:'ext/resources/css/ext-all.css')}"></link>
		<link rel="stylesheet" href="${resource(dir:'js', file:'ext/resources/css/xtheme-gray.css')}"></link>
		<link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}"></link>
		<link rel="stylesheet" href="${resource(dir:'css',file:'/jquery/cupertino/jquery-ui-1.8.18.custom.css')}"></link>   
        <link rel="stylesheet" href="${resource(dir:'css/jquery/skin', file:'ui.dynatree.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'rwg.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'uploadData.css')}"></link>

	<!--[if IE 7]>
		<style type="text/css">
			 div#gfilterresult,div#ptfilterresult, div#jubfilterresult, div#dqfilterresult {
				width: 99%;
			}
		</style>
	<![endif]-->
		
		<g:javascript library="prototype" />
<script type="text/javascript" src="${resource(dir:'js/jQuery', file:'jquery-1.8.3.min.js')}"></script>
<script type="text/javascript" src="${resource(dir:'js/jQuery', file:'jquery-ui.min.js')}"></script>
<script type="text/javascript">$j = jQuery.noConflict();</script>
<script type="text/javascript" src="${resource(dir:'js', file:'uploadData.js')}"></script>
<script type="text/javascript" charset="utf-8">
var studyBrowseWindowUrl = '${createLink([controller: 'experiment', action: 'browseExperimentsSingleSelect'])}';
var studyDetailUrl = '${createLink([controller:'experimentAnalysis', action:'expDetail'])}';
var studyHasFolderUrl = '${createLink([controller:'uploadData', action:'studyHasFolder'])}';
var platformTypesUrl = '${createLink([action:'platformsForVendor',controller:'bioAssayPlatform'])}';
var templateDownloadUrl = '${createLink([action:'template',controller:'uploadData'])}';

var IS_EDIT = ${uploadDataInstance?.id ? true : false};
var ANALYSIS_TYPE = null;
jQuery(document).ready(function() {
jQuery("#sensitiveDesc").hide();
jQuery("#sensitiveFlag").val('1');
});

var helpURL = '${grailsApplication.config.com.recomdata.searchtool.adminHelpURL}';
var contact = '${grailsApplication.config.com.recomdata.searchtool.contactUs}';
var appTitle = '${grailsApplication.config.com.recomdata.searchtool.appTitle}';
var buildVer = 'Build Version: <g:meta name="environment.BUILD_NUMBER"/> - <g:meta name="environment.BUILD_ID"/>';

<g:if test="${study}">
    updateStudyTable('${study.accession}');
</g:if>
</script>
<title>${grailsApplication.config.com.recomdata.dataUpload.appTitle}</title>
<!-- ************************************** -->
<!-- This implements the Help functionality -->
<script type="text/javascript" src="${resource(dir:'js', file:'help/D2H_ctxt.js')}"></script>
<script language="javascript">
    helpURL = '${grailsApplication.config.com.recomdata.searchtool.adminHelpURL}';
</script>
<!-- ************************************** -->
<r:layoutResources/>
</head>
<body>
<div id="header-div">
    <g:render template="/layouts/commonheader" model="['app':'uploaddata', 'utilitiesMenu':'true']" />
</div>

<div id="mainUploadPane">
    <g:uploadForm name="dataUpload" action="upload" method="post">
        <div id="formPage1" class="formPage">

            <div class="dataFormTitle" id="dataFormTitle1">
                <g:if test="${uploadDataInstance?.id ? true : false}">
                    编辑元数据<!--<SIAT_zh_CN original="Edit Metadata">编辑元数据</SIAT_zh_CN>-->
                </g:if>
                <g:else>
                    上传分析数据<!--<SIAT_zh_CN original="Upload Analysis Data">上传分析数据</SIAT_zh_CN>-->
                </g:else>
            </div>
            <div style="position: relative; text-align:right;">
                <a class="button" href="mailto:${grailsApplication.config.com.recomdata.dataUpload.adminEmail}">Email管理员<!--<SIAT_zh_CN original="Email administrator">Email管理员</SIAT_zh_CN>--></a>
                 <tmpl:/help/helpIcon id="1331"/>&nbsp;
                <div class="uploadMessage">如果您无法使用相关案例(Study)，请点击上方"Email管理员"传送邮件<!--<SIAT_zh_CN original="If you are unable to locate the relevant study, email the administrator by clicking the button above">如果您无法使用相关案例(Study)，请点击上方"Email管理员"传送邮件</SIAT_zh_CN>-->.</div>
            </div>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <table class="uploadTable">
                <tr>
                    <td width="10%">&nbsp;</td>
                    <td width="90%">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        案例(Study)<!--<SIAT_zh_CN original="Study">案例(Study)</SIAT_zh_CN>-->:
                    </td>
                    <td>
                        <div id="studyErrors">
                            <g:eachError bean="${uploadDataInstance}" field="study">
                                <div class="fieldError"><g:message error="${it}"/></div>
                            </g:eachError>
                        </div>
                        <tmpl:extSearchField width="600" fieldName="study" searchAction="extSearch" searchController="experiment" value="${study?.accession}" label="${study?.title}" paramString="'studyType':UPLOAD_STUDY_TYPE"/>
                        <a id="studyChangeButton" class="upload" onclick="$j('#studyDiv').empty().slideUp('slow'); changeField('study-combobox', 'study')">更新<!--<SIAT_zh_CN original="Change">更新</SIAT_zh_CN>--></a>
                        <a style="margin-left: 32px;" id="studyBrowseButton" class="upload" onclick="generateBrowseWindow();">浏览<!--<SIAT_zh_CN original="Browse">浏览</SIAT_zh_CN>--></a>
                        <br/><br/>
                        <div id="studyNoFolderMessage" class="fieldError" style="display: none;"></div>
                        <div id="studyDiv" style="height: 200px; width: 540px; overflow: auto; display: none;">&nbsp;</div>
                    </td>
                </tr>
            </table>
            <div id="uploadAnalysisPane">
                <table class="uploadTable">
                    <tr>
                        <td width="10%">
                            上传分析类型<!--<SIAT_zh_CN original="Analysis Type to Upload">上传分析类型</SIAT_zh_CN>-->:<br/>
                        </td>
                        <td width="90%">
                            <div id="dataTypeErrors">
                                <g:eachError bean="${uploadDataInstance}" field="dataType">
                                    <div class="fieldError"><g:message error="${it}"/></div>
                                </g:eachError>
                            </div>
                            <g:select name="dataType" name="dataType" noSelection="${['null':'Select...']}" from="${['GWAS':'GWAS','Metabolic GWAS':'GWAS Metabolomics','EQTL':'eQTL']}" optionKey="${{it.key}}" optionValue="${{it.value}}" value="${uploadDataInstance?.dataType}"/>
                            <a class="upload" href="#" onclick="downloadTemplate();">下载模板<!--<SIAT_zh_CN original="Download Template">下载模板</SIAT_zh_CN>--></a>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            分析名称<!--<SIAT_zh_CN original="Analysis Name">分析名称</SIAT_zh_CN>-->:
                        </td>
                        <td>
                            <div id="analysisNameErrors">
                                <g:eachError bean="${uploadDataInstance}" field="analysisName">
                                    <div class="fieldError"><g:message error="${it}"/></div>
                                </g:eachError>
                            </div>
                            <g:textField name="analysisName" style="width: 90%" value="${uploadDataInstance.analysisName}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>分析描述<!--<SIAT_zh_CN original="Analysis Description">分析描述</SIAT_zh_CN>-->:</td>
                        <td colspan="3">
                            <g:textArea name="description" style="width: 90%; height: 100px">${uploadDataInstance.description}</g:textArea>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="uploadFilePane">
                <table class="uploadTable">
                    <tr>
                        <td width="10%">
                            上传文件<!--<SIAT_zh_CN original="File to Upload">上传文件</SIAT_zh_CN>-->:
                        </td>
                        <td width="90%">
                            <div id="uploadFileErrors">
                                &nbsp;
                            </div>
                            <input type="file" id="uploadFile" name="uploadFile" style="border: 1px dotted #CCC" />
                        </td>

                    </tr>

                    <tr>
                        <td>
                            文件名称<!--<SIAT_zh_CN original="File Name">文件名称</SIAT_zh_CN>-->:
                        </td>
                        <td>
                            <div id="uploadFileNameErrors">
                                <g:eachError bean="${uploadFileInstance}" field="displayName">
                                    <div class="fieldError"><g:message error="${it}"/></div>
                                </g:eachError>
                            </div>
                            <g:textField name="displayName" style="width: 90%" value="${uploadFileInstance?.displayName}"/>
                            <br/>
                            <div class="uploadMessage">若此处未填，将使用原始文件名称<!--<SIAT_zh_CN original="If this is left blank, the original file name will be used">若此处未填，将使用原始文件名称</SIAT_zh_CN>-->.</div>
                        </td>
                    </tr>
                    %{--<tr>--}%
                        %{--<td>文件描述:<!--<SIAT_zh_CN original="File Description:">文件描述</SIAT_zh_CN>--></td>--}%
                        %{--<td colspan="3">--}%
                            %{--<g:textArea name="fileDescription" style="width: 90%; height: 100px">${uploadFileInstance?.fileDescription}</g:textArea>--}%
                        %{--</td>--}%
                    %{--</tr>--}%
                </table>
            </div>

            <div class="buttonbar">
                <a class="button" id="enterMetadataButton" onclick="showDataUploadForm()">元数据(metadata)<!--<SIAT_zh_CN original="Enter metadata">元数据(metadata)</SIAT_zh_CN>--></a>
                <g:actionSubmit class="upload" value="上传文件" action="uploadFile" id="uploadFileButton" onclick="validateFile(event)"/><!--<SIAT_zh_CN original="Upload File">上传文件</SIAT_zh_CN>-->
                <a class="button" href="${createLink([action:'index',controller:'search'])}">取消<!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>--></a>
            </div>
        </div>

        <div id="formPage2" class="formPage" style="display: none;">

            <div class="dataFormTitle" id="dataFormTitle2">上传日期<!--<SIAT_zh_CN original="Upload Data">上传日期</SIAT_zh_CN>--></div>
                <div style="position: relative; text-align:right;">
                    <a class="button" href="mailto:${grailsApplication.config.com.recomdata.dataUpload.adminEmail}">Email管理员<!--<SIAT_zh_CN original="Email administrator">Email管理员</SIAT_zh_CN>--></a>
                    <tmpl:/help/helpIcon id="1332"/>&nbsp;
                    <div class="uploadMessage">如果您无法完成相关栏位，请点击上方"Email管理员"发送邮件<!--<SIAT_zh_CN original="If you are unable to locate the relevant autocomplete fields, email the administrator by clicking the button above">如果您无法完成相关栏位，请点击上方"Email管理员"发送邮件</SIAT_zh_CN>-->.</div>
                </div>

                <%-- Appalling hack from previous version - leaving this in until I can sort it properly --%>
                        <g:if test="${flash.message2}">
                            <div class="fieldError">${flash.message2}</div>
                        </g:if>
                        <table class="uploadTable">
                            <tr>
                                <td width="10%">
                                    文件<!--<SIAT_zh_CN original="File">文件</SIAT_zh_CN>-->:
                                </td>
                                <td colspan="3">
                                    <g:if test="${uploadDataInstance.status == 'ERROR' || uploadDataInstance.status == 'NEW'}">
                                        <input type="file" id="file" name="file" style="border: 1px dotted #CCC" />
                                        <a class="upload" href="#" onclick="downloadTemplate();">下载模板<!--<SIAT_zh_CN original="Download Template">下载模板</SIAT_zh_CN>--></a>
                                    </g:if>
                                    <g:else>
                                        <i>这个数据集<!--<SIAT_zh_CN original="This data set is">这个数据集</SIAT_zh_CN>--> ${uploadDataInstance.status} - 此文件无法变更<!--<SIAT_zh_CN original="the file cannot be changed">此文件无法变更</SIAT_zh_CN>-->.</i>
                                    </g:else>
                                    <br/>
                                    <i>上传文件必须是文字文件(text file)<!--<SIAT_zh_CN original="Upload should be a tab-delimited plain text file">上传文件必须是文字文件(text file)</SIAT_zh_CN>--></i>
                                </td>
                            </tr>

                            <tr class="borderbottom bordertop">
                                <td id="tagsLabel">
                                    表型(Phenotype)<!--<SIAT_zh_CN original="Phenotype">表型(Phenotype)</SIAT_zh_CN>-->:
                                </td>
                                <td colspan="3">
                                    <tmpl:extDiseaseSearchField fieldName="tags" searchAction="extSearch" searchController="disease" values="${tags}"/>
                                    <%--<a id="tagsLink" class="upload" href="#">Add more Phenotypes/Tags</a>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>Population<!--<SIAT_zh_CN original="Population">Population</SIAT_zh_CN>-->:</td>
                                <td>
                                    <g:textField name="population" value="${uploadDataInstance.population}"/>
                                </td>
                                <td>样本大小<!--<SIAT_zh_CN original="Sample Size">样本大小</SIAT_zh_CN>-->:</td>
                                <td>
                                    <g:textField name="sampleSize" value="${uploadDataInstance.sampleSize}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>组织<!--<SIAT_zh_CN original="Tissue">组织</SIAT_zh_CN>-->:</td>
                                <td>
                                    <g:textField name="tissue" value="${uploadDataInstance.tissue}"/>
                                </td>
                                <td>细胞类型<!--<SIAT_zh_CN original="Cell Type">细胞类型</SIAT_zh_CN>-->:</td>
                                <td>
                                    <g:textField name="cellType" value="${uploadDataInstance.cellType}"/>
                                </td>
                            </tr>
                            <tr class="bordertop borderbottom">
                                <td id="platformLabel">
                                    平台<!--<SIAT_zh_CN original="Platform">平台</SIAT_zh_CN>-->:
                                </td>
                                <td colspan="3">

                                    <div style="width: 100%" id="genotypePlatform-tags" class="tagBox" name="genotypePlatform">

                                        <g:each in="${genotypePlatforms}" var="value">
                                            <span class="tag" id="genotypePlatform-tag-${value.key}" name="${value.key}">${value.value}</span>
                                        </g:each>

                                    </div>
                                    <div class="breaker">&nbsp;</div>
                                    <div style="background-color: #E4E4E4; float:left; padding: 8px; border-radius: 8px;">
                                        <div style="float: left; font-style: italic; line-height: 32px; margin-right: 8px">添加<!--<SIAT_zh_CN original="Add new">添加</SIAT_zh_CN>-->: </div>
                                        <div style="float: left; margin-right: 8px">
                                            <div class="textsmaller">提供者(Vender)<!--<SIAT_zh_CN original="Vendor">提供者(Vender)</SIAT_zh_CN>--></div>
                                            <g:select style="width: 400px" name="genotypePlatformVendor" noSelection="${['null':'Select...']}" from="${snpVendors}" onChange="loadPlatformTypes('genotypePlatform', 'SNP')"/>
                                        </div>
                                        <div style="float: left">
                                            <div class="textsmaller">平台<!--<SIAT_zh_CN original="Platform">平台</SIAT_zh_CN>--></div>
                                            <g:select style="width: 200px" name="genotypePlatformName" from="${snpVendors}" onchange="addPlatform('genotypePlatform')"/>
                                            <select id="genotypePlatform" name="genotypePlatform" multiple="multiple" style="display: none;">
                                                <g:each in="${genotypePlatforms}" var="value">
                                                    <option selected="selected" value="${value.key}">${value.value}</option>
                                                </g:each>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="breaker">&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    基因组版本(Genome Version)<!--<SIAT_zh_CN original="Genome Version">基因组版本(Genome Version)</SIAT_zh_CN>-->:
                                </td>
                                <td colspan="3">
                                    <g:select name="genomeVersion" noSelection="${['null':'Select...']}" from="${['HG18':'HG18','HG19':'HG19']}" optionKey="${{it.key}}" optionValue="${{it.value}}" value="${uploadDataInstance.genomeVersion}"/>
                                </td>
                            </tr>
                            <tr id="expressionPlatformRow" class="bordertop borderbottom">
                                <td>
                                    表达平台(Expression Platform)<!--<SIAT_zh_CN original="Expression Platform">表达平台(Expression Platform)</SIAT_zh_CN>-->:
                                </td>
                                <td colspan="3">
                                    <div style="width: 100%" id="expressionPlatform-tags" class="tagBox" name="expressionPlatform">
                                        <g:each in="${expressionPlatforms}" var="value">
                                            <span class="tag" id="expressionPlatform-tag-${value.key}" name="${value.key}">${value.value}</span>
                                        </g:each>
                                    </div>
                                    <div class="breaker">&nbsp;</div>
                                    <div style="background-color: #E4E4E4; float:left; padding: 8px; border-radius: 8px;">
                                        <div style="float: left; font-style: italic; line-height: 32px; margin-right: 8px">添加<!--<SIAT_zh_CN original="Add new">添加</SIAT_zh_CN>-->: </div>
                                        <div style="float: left; margin-right: 8px">
                                            <div class="textsmaller">提供者(Vender)<!--<SIAT_zh_CN original="Vendor">提供者(Vender)</SIAT_zh_CN>--></div>
                                            <g:select style="width: 400px" name="expressionPlatformVendor" noSelection="${['null':'Select...']}" from="${expVendors}" onChange="loadPlatformTypes('expressionPlatform', 'Gene Expression')"/>
                                        </div>
                                        <div style="float: left">
                                            <div class="textsmaller">平台<!--<SIAT_zh_CN original="Platform">平台</SIAT_zh_CN>--></div>
                                            <g:select style="width: 200px" name="expressionPlatformName" onchange="addPlatform('expressionPlatform')" from="${expVendors}"/>
                                            <select id="expressionPlatform" name="expressionPlatform" multiple="multiple" style="display: none;">
                                                <g:each in="${expressionPlatforms}" var="value">
                                                    <option selected="selected" value="${value.key}">${value.value}</option>
                                                </g:each>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="breaker">&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    模型名称(Model Name)<!--<SIAT_zh_CN original="Model Name">模型名称(Model Name)</SIAT_zh_CN>-->:
                                </td>
                                <td>
                                    <g:textField name="modelName" value="${uploadDataInstance.modelName}"/>
                                </td>
                                <td>
                                    模型描述<!--<SIAT_zh_CN original="Model Description">模型描述</SIAT_zh_CN>-->:
                                </td>
                                <td>
                                    <g:textField name="modelDescription" value="${uploadDataInstance.modelDescription}"/>
                                </td>
                            </tr>
                            <tr class="borderbottom">

                                <td>
                                    统计试验<!--<SIAT_zh_CN original="Statistical Test">统计试验</SIAT_zh_CN>-->:
                                </td>
                                <td>
                                    <g:textField name="statisticalTest" value="${uploadDataInstance.statisticalTest}"/>
                                </td>
                                <td>
                                    P值切断(P-value cutoff)<!--<SIAT_zh_CN original="P-value cutoff">P值切断(P-value cutoff)</SIAT_zh_CN>--> &lt;=
                                </td>
                                <td>
                                    <g:textField name="pValueCutoff" value="${uploadDataInstance.pValueCutoff}"/>
                                </td>
                            </tr>
                            <tr class="borderbottom">
                                <td>
                                    研究单元<!--<SIAT_zh_CN original="Research Unit">研究单元</SIAT_zh_CN>-->:
                                </td>
                                <td>
                                    <div style="width: 100%" id="researchUnit-tags" class="tagBox" name="researchUnit">
                                    <g:each in="${researchUnit}" var="value">
                                            <span class="tag" id="researchUnit-tag-${value.key}" name="${value.key}">${value.value}</span>
                                        </g:each>
                                    </div>
                                    <g:select style="width: 300px" name="researchUnitName" noSelection="${['null':'Select...']}" from="${ResearchUnits}" onchange="addResearchUnit('researchUnit')"/>
                                    <select id="researchUnit" name="researchUnit" multiple="multiple" style="display: none;">
                                                <g:each in="${researchUnit}" var="value">
                                                    <option selected="selected" value="${value.key}">${value.value}</option>
                                                </g:each>
                                            </select>


                                </td>
                                <td style="width:190px;">
                                    <input type="checkbox" style="width:20px;" name="sensitiveFlag" value="${uploadDataInstance.sensitiveFlag}" id="sensitiveFlag"  onclick="isDataSensitive();">是否为敏感数据<!--<SIAT_zh_CN original="Is Data Sensitive">是否为敏感数据</SIAT_zh_CN>-->?
                                    </input>
                                </td>
                                <td>
                                    <g:textField name="sensitiveDesc" value="${uploadDataInstance.sensitiveDesc}"/>
                                </td>
                            </tr>
                        </table>
                        <div class="buttonbar">
                            <a class="button" onclick="showAnalysisForm()">返回<!--<SIAT_zh_CN original="Back">返回</SIAT_zh_CN>--></a>
                            <g:actionSubmit class="upload" value="Upload" action="upload"/>
                            <a class="button" href="${createLink([action:'index',controller:'GWAS'])}">取消<!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>--></a>
                        </div>
                    </div>


                    <g:hiddenField name="id" value="${uploadDataInstance?.id}"/>

                </div>
            </g:uploadForm>
        </div>

        <div id="uploadSidebarWrapper">
            <div id="uploadSidebar">
                <div id="title-upload-target" class="ui-widget-header">
                    <h2 style="float:left" class="title">上传目标<!--<SIAT_zh_CN original="Upload target"></SIAT_zh_CN>--></h2>
                </div>
                <ul class="dynatree-container">
                    <li class="sidebarRadio" id="uploadAnalysisRadio">
                        <span class="dynatree-node dynatree-folder dynatree-exp-c dynatree-ico-cf">
                            <span class="dynatree-no-connector">

                            </span>
                            <a class="dynatree-title">上传分析数据<!--<SIAT_zh_CN original="Upload analysis data">上传分析数据</SIAT_zh_CN>--></a>
                        </span>
                    </li>
                    %{--<li class="sidebarRadio" id="uploadFileRadio">--}%
                        %{--<span class="dynatree-node dynatree-folder dynatree-exp-c dynatree-ico-cf">--}%
                            %{--<span class="dynatree-no-connector"></span>--}%
                            %{--<a class="dynatree-title">上传文件到Faceted搜索<!--<SIAT_zh_CN original="Upload file to Faceted Search">上传文件到Faceted搜索</SIAT_zh_CN>--></a>--}%
                        %{--</span>--}%
                    %{--</li>--}%
                    <li class="sidebarRadio" id="uploadFileDatasetExplorerRadio">
                        <span class="dynatree-node dynatree-folder dynatree-exp-c dynatree-ico-cf">
                            <span class="dynatree-no-connector"></span>
                            <a class="dynatree-title">上传文件到数据集管理器<!--<SIAT_zh_CN original="Upload file to Dataset Explorer">上传文件到数据集管理器</SIAT_zh_CN>--></a>
                        </span>
                    </li>
                </ul>
            </div>
            <div id="uploadSidebarDisabled" style="display: none;">
                <!--<SIAT_zh_CN original="Editing metadata for an existing upload">编辑已上传元数据</SIAT_zh_CN>-->.
            </div>
        </div>

		<!-- Browse dialog -->
		<div id="divBrowseStudies" title="Studies" style="display: none;">
		   	<img src="${resource(file:'ajax-loader.gif', dir:'images')}"/>
		</div>
<r:layoutResources/>
	</body>
</html>
