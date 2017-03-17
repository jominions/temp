/**
 * This file contains functions for handling the UI elements related to the concept code reporting system.
 */

/**
 * When the user clicks to save the report, prompt for a name/description/public flag and submit to the controller.
 */
function saveCodeReport() 
{
	jQuery( "#saveReportDialog" ).dialog({title: '保存报告', modal:true});//<SIAT_zh_CN original="Save Report">保存报告</SIAT_zh_CN>
	jQuery( "#saveReportDialog" ).dialog("open");
}

/**
 * When the user clicks to save a report, send off the ajax call to save the record.
 * @param newReport
 * @param reportName
 * @param reportDescription
 * @param reportPublic
 * @param parConceptList
 */
function saveReport(newReport,reportName,reportDescription,reportPublic,parConceptList,studiesList)
{
	//Validate the user input.
	if(reportName == "")
	{
		Ext.Msg.alert('遗漏的输入','请输入一个报告名称')//<SIAT_zh_CN original="Missing Input">遗漏的输入</SIAT_zh_CN>//<SIAT_zh_CN original="Please enter a report name.">请输入一个报告名称</SIAT_zh_CN>
		return;
	}
	
	//Verify the user isn't mixing studies.
	var uniqueStudies = studiesList.unique()
	
	if(uniqueStudies.size() > 1)
	{
		Ext.Msg.alert('混合的案例','请仅从相同的案例中选择概念')//<SIAT_zh_CN original="Mixed Studies">混合的案例</SIAT_zh_CN>//<SIAT_zh_CN original="Please only select concepts from the same study.">请仅从相同的案例中选择概念</SIAT_zh_CN>
		return;
	}	
	
	//Verify the user selected at least one study.
	if(uniqueStudies.size() < 1)
	{
		Ext.Msg.alert('遗漏的参数','请在保存报告之前先从结果/分析屏幕拖拽一个参数列表')//<SIAT_zh_CN original="Missing Parameters">遗漏的参数</SIAT_zh_CN>//<SIAT_zh_CN original="Please drag in a list of parameters to the results/analysis screen before saving a report.">请在保存报告之前先从结果/分析屏幕拖拽一个参数列表</SIAT_zh_CN>
		return;
	}		
	
	//Pull the unique study.
	var uniqueStudy = uniqueStudies.unique()[0].split(":")[1]
	
	jQuery.ajax({
		  url: pageInfo.basePath + '/report/saveReport',
		  success:function(data){
			  jQuery( "#saveReportDialog" ).dialog("close");
			  resultsTabPanel.setActiveTab('workspacePanel');
			  },
		  failure:function(data){alert("报告保存失败");},//<SIAT_zh_CN original="Report failed to save.">报告保存失败</SIAT_zh_CN>
		  data: {	name:reportName,
			  		description:reportDescription,
			  		publicflag:reportPublic,
			  		conceptList:parConceptList,
			  		study:uniqueStudy}
		});
}
/**
 * Determine if the Report is a SummaryStatistics or Adv. Workflow
 * @param moduleName
 */ 
function runReportOrAnalysis(reportId, reportStudy, moduleName){
	//Verify a subset was selected.
	if(isSubsetEmpty(1) && isSubsetEmpty(2))
    {
        Ext.Msg.alert('子集为空', '所有子集均为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集均为空。请选择子集。</SIAT_zh_CN>
        return;
    }	
	// If its a Summary Statistics report
	if(moduleName  && moduleName == "Summary Statistics"){
		generateReportFromId(reportId, reportStudy)
	}else {  //otherwise its a RModule
		loadAdvWorkflowAnalysis(reportId,reportStudy,moduleName)
	}
}

/**
 * If a subset is loaded, pull the codes for that report from the database and generate the statistics for each.
 * @param reportId
 */
function generateReportFromId(reportId, reportStudy)
{
	//Verify a subset was selected.
	if(isSubsetEmpty(1) && isSubsetEmpty(2))
    {
       Ext.Msg.alert('子集为空', '所有子集均为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集均为空。请选择子集。</SIAT_zh_CN>
         return;
    }	
	
	//Before running the report clear out global report codes and study arrays
	GLOBAL.currentReportCodes=[];
	GLOBAL.currentReportStudy=[];
	
	//Move the user to the analysis tab.
	resultsTabPanel.setActiveTab('analysisPanel');
	
	resultsTabPanel.body.mask("正在生成统计总结", 'x-mask-loading');//<SIAT_zh_CN original="Generating Summary Statistics">正在生成统计总结</SIAT_zh_CN>
	
	//If the code hasn't been run to build the cohorts, do so here.
    if((GLOBAL.CurrentSubsetIDs[1] == null && ! isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && ! isSubsetEmpty(2)))
    {
        runAllQueries(function(){generateReportFromId(reportId, reportStudy);});
        return;
    }	

    //Get the basic summary statistics. When that is done processing run "pullReportCodes" which will run an analysis per code.
	getSummaryStatistics(pullReportCodes, [reportId, reportStudy]);
	
}

function pullReportCodes(reportParams)
{
	resultsTabPanel.body.mask("正在从已保存的节点中生成报告", 'x-mask-loading');//<SIAT_zh_CN original="Generating Report From Saved Codes">正在从已保存的节点中生成报告</SIAT_zh_CN>
	
	//Get the JSON list of codes for this report.
	jQuery.ajax({
		  url: pageInfo.basePath + '/report/retrieveReportCodes',
		  success:function(returnedData){drawReports(returnedData, reportParams[1]);},
		  failure:function(returnedData){resultsTabPanel.body.unmask();alert("检索您的报告时产生错误")},//<SIAT_zh_CN original="There was an error retrieving your report.">检索您的报告时产生错误</SIAT_zh_CN>
		  data: {reportid:reportParams[0]}
		});
}

/**
 * Function used to iterate through codes and build the analysis for each.
 * @param returnedData
 */
function drawReports(returnedData, reportsStudy)
{
	for(var i=0;i<returnedData.length;i++)
	{
		buildAnalysisFromCode(returnedData[i],i==returnedData.length-1, reportsStudy);
	}
}


function buildAnalysisFromCode(nodeCode, lastCode, reportsStudy)
{
    Ext.Ajax.request(
            {
                url : pageInfo.basePath+"/chart/analysis",
                method : 'POST',
                timeout: '600000',
                params :  Ext.urlEncode(
                        {
                            charttype : "analysis",
                            concept_key : nodeCode,
                            result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
                            result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
                        }
                ), // or a URL encoded string
                success : function(result, request)
                {
                	GLOBAL.currentReportCodes.push(nodeCode);
                	GLOBAL.currentReportStudy.push(reportsStudy);
                	buildAnalysisComplete(result);
                	if(lastCode) resultsTabPanel.body.unmask();
                }
	            ,
	            failure : function(result, request)
	            {
	                buildAnalysisComplete(result);
	                resultsTabPanel.body.unmask()
	            }
            }
    );

}


/**
 * If a subset is loaded, pull the codes for that report from the database and generate the statistics for each.
 * @param reportId
 */
function deleteReportFromId(reportId)
{
	if(confirm("报告将被删除。继续吗？")){//<SIAT_zh_CN original="Report will be deleted. Proceed?">报告将被删除。继续吗？</SIAT_zh_CN>
		jQuery.ajax({
			  url: pageInfo.basePath + '/report/deleteReport',
			  success:function(data){
					var rowEle = document.getElementById("reportRow"+reportId);
					var rowIndex = reportsTable.fnGetPosition(rowEle); 
					reportsTable.fnDeleteRow(rowIndex);
			  },
			  failure:function(data){alert("报告删除失败");},//<SIAT_zh_CN original="Report failed to delete.">报告删除失败</SIAT_zh_CN>
			  error:function(data){alert("报告删除失败");},//<SIAT_zh_CN original="Report failed to delete.">报告删除失败</SIAT_zh_CN>
			  data: {reportId:reportId}
			});
	}
}

function clearSavedReports()
{
	//Clear the items used to save reports.
	if(document.getElementById('txtReportName')){
		document.getElementById('txtReportName').value = "";
	}
	if(document.getElementById('txtReportDescription')){
		document.getElementById('txtReportDescription').value = "";
	}
	if(document.getElementById('chkReportPublic')){
		document.getElementById('chkReportPublic').checked = false;
	}

	GLOBAL.currentReportCodes = [];
	GLOBAL.currentReportStudy = [];
}

function editReportName(reportId){
	jQuery("#reportNameDisplay"+reportId).hide();
	jQuery("#editReportNameBox"+reportId).show();
	jQuery("#editReportNameBox"+reportId).focus();
}

function updateReportName(reportId){
	var name = jQuery("#editReportNameBox"+reportId).val();
	jQuery.get(pageInfo.basePath + '/report/updateName', {reportId:reportId, name:name}, function(data){
		renderWorkspace();
	})
}

function toggleReportPublicFlag(reportId){
	jQuery.get(pageInfo.basePath + '/report/togglePublicFlag', {reportId:reportId}, function(data){
		if(data=='true'){
			jQuery("#reportPublicFlag"+reportId).removeClass("ui-icon-locked");
			jQuery("#reportPublicFlag"+reportId).addClass("ui-icon-unlocked");
		}else if(data=='false'){
			jQuery("#reportPublicFlag"+reportId).removeClass("ui-icon-unlocked");
			jQuery("#reportPublicFlag"+reportId).addClass("ui-icon-locked");
		}
	}).fail(function() { alert("切换公有标志时服务器产生错误"); })//<SIAT_zh_CN original="Server Error in toggling public flag">切换公有标志时服务器产生错误。</SIAT_zh_CN>
}

function displayReportCodes(event, reportId){
	var posX=event.clientX;
	var posY=event.clientY;
	displayReportCodesFunction = setTimeout(function(){
		//Get the JSON list of codes for this report.
		jQuery.ajax({
			  url: pageInfo.basePath + '/report/retrieveReportCodes',
			  success:function(returnedData){
				  var reportCodes="<b>变量</b><br>";//<SIAT_zh_CN original="Variables">变量</SIAT_zh_CN>
				  for(var i=0;i<returnedData.length;i++){
					  	reportCodes=reportCodes+"(";
						reportCodes=reportCodes+returnedData[i];
						reportCodes=reportCodes+")";
						reportCodes=reportCodes+"<br>"
				  }
				jQuery(workspaceReportCodesDisplayDialog).dialog("option", {position:[posX+20, posY+60]});
				jQuery(workspaceReportCodesDisplayDialog).data("displayData",reportCodes).dialog("open");
			  },
			  failure:function(returnedData){alert("检索您的报告时产生错误")},//<SIAT_zh_CN original="There was an error retrieving your report.">检索您的报告时产生错误</SIAT_zh_CN>
			  data: {reportid:reportId}
			});
	}, 500);
}

function hideReportCodes(){
	clearTimeout(displayReportCodesFunction);
	jQuery(workspaceReportCodesDisplayDialog).dialog("close");
}

/**
 * If a subset is loaded, pull the codes for that report from the database and load the analysis
 * @param reportId
 * @param reportStudy
 */
function loadAdvWorkflowAnalysis(reportId, reportStudy,moduleName)
{
	//Verify a subset was selected.
	if(isSubsetEmpty(1) && isSubsetEmpty(2))
    {
         Ext.Msg.alert('子集为空', '所有子集均为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集均为空。请选择子集。</SIAT_zh_CN>
       return;
    }	
	
	//Before running the report clear out global report codes and study arrays
	GLOBAL.currentAnalysisParams=[];
	GLOBAL.currentReportStudy=[];
	GLOBAL.returnedAnalysisData = [];
	//resultsTabPanel.body.mask("loading Analysis Parameters From Database", 'x-mask-loading');
	
	//Move the user to theAdv. Workfows tab.
	resultsTabPanel.setActiveTab('dataAssociationPanel');
	
	//Get the JSON list of codes for this report.
	jQuery.ajax({
		  url: pageInfo.basePath + '/report/retrieveReportCodes',
		  success:function(returnedData){openAnalysis(moduleName, returnedData, reportStudy);},
		  failure:function(returnedData){resultsTabPanel.body.unmask();alert("检索您的分析参数时产生错误hz")},
		  data: {reportid:reportId}//<SIAT_zh_CN original="There was an error retrieving your analysisParameters.">检索您的分析参数时产生错误</SIAT_zh_CN>
		});
	
//	jQuery(document).ready(function() {
//		//alert("It's loaded!");
//		//populateAnalysis(GLOBAL.returnedAnalysisData[1]);
//	})
	
	 jQuery(document).ready(function () { 
		 setTimeout(function () { 
				var selectedAnalysis = document.getElementById("analysis").value;
				selectedAnalysis = selectedAnalysis.charAt(0).toUpperCase()+selectedAnalysis.substring(1);
				
				var funcName = "populate"+selectedAnalysis;
				
				if (typeof funcName == 'string' && eval('typeof ' + funcName) == 'function') 
				{
					eval(funcName +'()');
				}
			 //populateAnalysis(GLOBAL.returnedAnalysisData[1]);
			 
			 }, 3000); });
	
}


function openAnalysis(moduleName, returnedData, reportStudy){
	
	var menuItem = Ext.getCmp(moduleName);
	onItemClick(menuItem);
    clearDataAssociation();
	GLOBAL.returnedAnalysisData[1] = returnedData;

}
