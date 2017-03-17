//**************Start of functions to set global subset ids**************
/**
 * 1. If the global subset ids are null call runAllQueries to populate them.
 * 2. Calls heatmapvalidate to get all relevant data for the high dimensional selection.
 * @param divId
 */
function gatherHighDimensionalData(divId){
	if(!variableDivEmpty(divId)
			&& ((GLOBAL.CurrentSubsetIDs[1]	== null) ||	(multipleSubsets() && GLOBAL.CurrentSubsetIDs[2]== null))){
		runAllQueriesForSubsetId(function(){gatherHighDimensionalData(divId);}, divId);
		return;
	}
	if(variableDivEmpty(divId)){
		Ext.Msg.alert("尚未选择队列！", "请先选择一个队列。");//<SIAT_zh_CN original="No cohort selected!">尚未选择队列！</SIAT_zh_CN>//<SIAT_zh_CN original="Please select a cohort first.">请先选择一个队列。</SIAT_zh_CN>
		return;
	}
	//genePatternReplacement();
	//Send a request to generate the heatmapdata that we use to populate the dropdowns in the popup.
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/analysis/heatmapvalidate",
				method : 'POST',
				timeout: '1800000',
				params :  Ext.urlEncode(
						{
							result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
							result_instance_id2 : GLOBAL.CurrentSubsetIDs[2],
							analysis            : GLOBAL.HeatmapType
						}
				),
				success : function(result, request)
				{
					determineHighDimVariableType(result);
					readCohortData(result,divId);
				},
				failure : function(result, request)
				{
                   Ext.Msg.alert("错误", "Ajax异步请求失败。");//<SIAT_zh_CN original="Error">错误</SIAT_zh_CN>//<SIAT_zh_CN original="Ajax call is failed.">Ajax异步请求失败。</SIAT_zh_CN>
				}
			}
	);
}

function gatherHighDimensionalDataSingleSubset(divId, currentSubsetId){
	if((!variableDivEmpty(divId) && currentSubsetId== null)){
		runQueryForSubsetidSingleSubset(function(sId){gatherHighDimensionalDataSingleSubset(divId, sId);}, divId);
		return;
	}
	if(variableDivEmpty(divId)){
		Ext.Msg.alert("尚未选择队列！", "请先选择一个队列。");//<SIAT_zh_CN original="No cohort selected!">尚未选择队列！</SIAT_zh_CN>//<SIAT_zh_CN original="Please select a cohort first.">请先选择一个队列。</SIAT_zh_CN>
		return;
	}
	//genePatternReplacement();
	//Send a request to generate the heatmapdata that we use to populate the dropdowns in the popup.
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/analysis/heatmapvalidate",
				method : 'POST',
				timeout: '1800000',
				params :  Ext.urlEncode(
						{
							result_instance_id1 : currentSubsetId,
							result_instance_id2 : '',
							analysis            : GLOBAL.HeatmapType
						}
				),
				success : function(result, request)
				{
					determineHighDimVariableType(result);
					readCohortData(result,divId);
				},
				failure : function(result, request)
				{
                   Ext.Msg.alert("错误", "异步请求失败。");//<SIAT_zh_CN original="Error">错误</SIAT_zh_CN>//<SIAT_zh_CN original="Ajax call is failed.">异步请求失败。</SIAT_zh_CN>
				}
			}
	);
}

/**
 * Determine if we are dealing with genotype or copy number
 */
function determineHighDimVariableType(result){
	var mobj=result.responseText.evalJSON();
	GLOBAL.HighDimDataType=mobj.markerType;
}

/**
 * read the result from heatmapvalidate call.
 * @param result
 * @param completedFunction
 */
function readCohortData(result, divId)
{
	//Get the JSON string we got from the server into a real JSON object.
	var mobj=result.responseText.evalJSON();

	//If we failed to retrieve any test from the heatmap server call, we alert the user here. Otherwise, show the popup.
	if(mobj.NoData && mobj.NoData == "true")
	{
		Ext.Msg.alert("没有数据！","您所选的样本中未发现任何数据！");//<SIAT_zh_CN original="No Data!">没有数据！</SIAT_zh_CN>//<SIAT_zh_CN original="No data found for the samples you selected!">您所选的样本中未发现任何数据！</SIAT_zh_CN>
		return;
	}
	
	//If we got data, store the JSON data globally.
	GLOBAL.DefaultCohortInfo=mobj;
	
	GLOBAL.CurrentAnalysisDivId=divId;
	
	//Reset the pathway information.
	GLOBAL.CurrentPathway = '';
	GLOBAL.CurrentPathwayName = '';	
	
	if(GLOBAL.DefaultCohortInfo.defaultPlatforms[0]=='' || GLOBAL.DefaultCohortInfo.defaultPlatforms[0]==null){
		Ext.Msg.alert("没有高维数据！","请选择一个高维数据节点。");//<SIAT_zh_CN original="No High Dimensional Data!">没有高维数据！</SIAT_zh_CN>//<SIAT_zh_CN original="Please select a high dimensional data node.">请选择一个高维数据节点。</SIAT_zh_CN>
		return;
	}

	//render the pathway selection popup
	showCompareStepPathwaySelection();
}

/**
 * Check to see if a a selection has been made for the variable
 * @param divId
 * @returns {Boolean}
 */
function variableDivEmpty(divId){
	var queryDiv=Ext.get(divId);
	if(queryDiv.dom.childNodes.length>0){
		return false;
	}	
	return true;
}

function runAllQueriesForSubsetId(callback, divId)
{
	// analysisPanel.body.update("<table border='1' width='100%' height='100%'><tr><td width='50%'><div id='analysisPanelSubset1'></div></td><td><div id='analysisPanelSubset2'></div></td></tr>");
	var subset = 1;
	if(isSubsetEmpty(1) && isSubsetEmpty(2))
	{
		Ext.Msg.alert('子集为空', '所有子集为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集为空。请选择子集。</SIAT_zh_CN>
		return;
	}

	// setup the number of subsets that need running
	var subsetstorun = 0;
	for (var i = 1; i <= GLOBAL.NumOfSubsets; i++)
	{
		if( ! isSubsetEmpty(i) && GLOBAL.CurrentSubsetIDs[i] == null)
		{
			subsetstorun ++ ;
		}
	}
	STATE.QueryRequestCounter = subsetstorun;
	/* set the number of requests before callback is fired for runquery complete */

	// iterate through all subsets calling the ones that need to be run
	for (var i = 1; i <= GLOBAL.NumOfSubsets; i++)
	{
		if( ! isSubsetEmpty(i) && GLOBAL.CurrentSubsetIDs[i] == null)
		{
			runQueryForSubsetId(i, callback, divId);
		} else if (!isSubsetEmpty(i) && GLOBAL.CurrentSubsetIDs[i] != null) {
            // execute the callback if subset is not empty and has subset id
            callback();
		}
	}
}

function runQueryForSubsetId(subset, callback, divId)
{
	if(Ext.get('analysisPanelSubset1') == null)
	{
		// analysisPanel.body.update("<table border='1' width='100%' height='100%'><tr><td width='50%'><div id='analysisPanelSubset1'></div></td><td><div id='analysisPanelSubset2'></div></td></tr>");
	}
	/* if(isSubsetEmpty(subset))
   {
   callback();
   return;
   } */
	var query = getCRCRequest(subset, "", divId);
	// first subset
	queryPanel.el.mask('正在获取子集 ' + subset + '...', 'x-mask-loading');//<SIAT_zh_CN original="Getting Subsets">正在获取子集</SIAT_zh_CN>
	Ext.Ajax.request(
			{
				url : pageInfo.basePath + "/queryTool/runQueryFromDefinition",
				method : 'POST',
				xmlData : query,
				// callback : callback,
				success : function(result, request)
				{
				runQueryComplete(result, subset, callback);
				}
			,
			failure : function(result, request)
			{
				runQueryComplete(result, subset, callback);
			}
			,
			timeout : '600000'
			}
	);

	if(GLOBAL.Debug)
	{
		resultsPanel.setBody("<div style='height:400px;width500px;overflow:auto;'>" + Ext.util.Format.htmlEncode(query) + "</div>");
	}
}

function runQueryForSubsetidSingleSubset(callback, divId){
    var query = getCRCRequestSingleSubset(divId);
    Ext.Ajax.request(
        {
            url : pageInfo.basePath + "/queryTool/runQueryFromDefinition",
            method : 'POST',
            xmlData : query,
            // callback : callback,
            success : function(result, request)
            {
                runQueryComplete(result, null, callback);
            }
            ,
            failure : function(result, request)
            {
               Ext.Msg.alert("错误", "Ajax异步请求失败。")//<SIAT_zh_CN original="Error">错误</SIAT_zh_CN>//<SIAT_zh_CN original="Ajax call is failed.">Ajax异步请求失败。</SIAT_zh_CN>
            }
            ,
            timeout : '600000'
        }
    );

    if(GLOBAL.Debug)
    {
        resultsPanel.setBody("<div style='height:400px;width500px;overflow:auto;'>" + Ext.util.Format.htmlEncode(query) + "</div>");
    }
}

function getCRCRequest(subset, queryname, divId){
	if(queryname=="" || queryname==undefined){
		var d=new Date();
		queryname=GLOBAL.Username+"'s Query at "+ d.toUTCString();
		}
	var query= '<ns4:query_definition xmlns:ns4="http://www.i2b2.org/xsd/cell/crc/psm/1.1/">\
	                <query_name>'+queryname+'</query_name>\
	                <specificity_scale>0</specificity_scale>';
	
	var qcd=Ext.get(divId);
	
	if(qcd.dom.childNodes.length>0)
	{
		query=query+getCRCRequestPanel(qcd.dom, 1);
	}
	
	for(var i=1;i<=GLOBAL.NumOfQueryCriteriaGroups;i++)
	{
		var qcd=Ext.get("queryCriteriaDiv"+subset+'_'+i.toString());
		if(qcd.dom.childNodes.length>0)
		{
		query=query+getCRCRequestPanel(qcd.dom, i);
		}
	}
	
	query=query+"</ns4:query_definition>";
	return query;
}

function getCRCRequestSingleSubset(divId, queryname){
	if(queryname=="" || queryname==undefined){
		var d=new Date();
		queryname=GLOBAL.Username+"'s Query at "+ d.toUTCString();
		}
	var query= '<ns4:query_definition xmlns:ns4="http://www.i2b2.org/xsd/cell/crc/psm/1.1/">\
	                <query_name>'+queryname+'</query_name>\
	                <specificity_scale>0</specificity_scale>';
	
	var qcd=Ext.get(divId);
	
	if(qcd.dom.childNodes.length>0)
	{
		query=query+getCRCRequestPanel(qcd.dom, 1);
	}
	
	query=query+"</ns4:query_definition>";
	return query;
}

//**************End of functions to set global subset ids**************

function applyToForm(){
	var divId = GLOBAL.CurrentAnalysisDivId;
	var probesAgg = document.getElementById("probesAggregation");
	var snpType = document.getElementById("SNPType");
	
	var subsetCount = multipleSubsets()?2:1;
	for(var idx = 1; idx<=subsetCount; idx++){
		applySubsetToForm(divId, idx);
	}
	
	//Pull other values from javascript object.
	window[divId+'pathway']				= GLOBAL.CurrentPathway;
	window[divId+'pathwayName'] 		= GLOBAL.CurrentPathwayName;
	window[divId+'probesAggregation']	= probesAgg.checked;
	window[divId+'SNPType']				= snpType.value;
	window[divId+'markerType']			= GLOBAL.HighDimDataType;
	
	//Pull the actual values for these items so we can filter on them in a SQL query later. When we click on the items in the dropdowns these "Value" fields get a list of all items in both subsets.
	window[divId+'samplesValues']		= GLOBAL.CurrentSamples;
	window[divId+'tissuesValues']		= GLOBAL.CurrentTissues;
	window[divId+'timepointsValues']	= GLOBAL.CurrentTimepoints;
	window[divId+'gplValues']			= GLOBAL.CurrentGpls.toArray();	
	
	displayHighDimSelectionSummary(subsetCount, divId, probesAgg, snpType);

	compareStepPathwaySelection.hide();
}

function applySubsetToForm(divId, idx){
	//Pull the text value for the selections from the popup form.
	window[divId+'samples'+idx]				= Ext.get('sample'+idx).dom.value;
	window[divId+'platforms'+idx]			= Ext.get('platforms'+idx).dom.value;
	window[divId+'gpls'+idx]				= Ext.get('gpl'+idx).dom.value;
	window[divId+'tissues'+idx]				= Ext.get('tissue'+idx).dom.value;
	window[divId+'timepoints'+idx]			= Ext.get('timepoint'+idx).dom.value;

	//Pull the actual GPL values.
	window[divId+'gplsValue'+idx]			= GLOBAL.CurrentGpls[idx-1];	
	
	//Pull other values from javascript object.
	window[divId+'rbmPanels'+idx]			= GLOBAL.CurrentRbmpanels[idx-1]; 
}

function displayHighDimSelectionSummary(subsetCount, divId, probesAgg, snpType){

	var summaryString="";
	for(var idx = 1; idx<=subsetCount; idx++){
		summaryString=createSelectionSummaryString(divId, idx, summaryString);
	}
	
	
	var selectedSearchPathway =Ext.get('searchPathway').dom.value;
	
	var innerHtml = summaryString+ 
	'<br> <b>途径:</b> '+selectedSearchPathway+//<SIAT_zh_CN original="Pathway">途径</SIAT_zh_CN>
	'<br> <b>标志物类型:</b> '+GLOBAL.HighDimDataType;//<SIAT_zh_CN original="Marker Type:">标志物类型</SIAT_zh_CN>

	if(GLOBAL.HighDimDataType==HIGH_DIMENSIONAL_DATA["mrna"].type)
	{
		if(isProbesAggregationSupported()){
			innerHtml += '<br><b> 骨料探针（Aggregate Probes）:</b> '+ probesAgg.checked;//<SIAT_zh_CN original="Aggregate Probes">骨料探针（Aggregate Probes）</SIAT_zh_CN>
		}
	} else if(GLOBAL.HighDimDataType==HIGH_DIMENSIONAL_DATA["snp"].type){
		if(isProbesAggregationSupported()){
			innerHtml += '<br><b> 骨料探针（Aggregate Probes）:</b> '+ probesAgg.checked;//<SIAT_zh_CN original="Aggregate Probes">骨料探针（Aggregate Probes）</SIAT_zh_CN>
		}
		innerHtml += '<br><b> SNP 类型:</b> '+ snpType.value;//<SIAT_zh_CN original="SNP Type">SNP 类型</SIAT_zh_CN>
		}
	
	var domObj = document.getElementById("display"+divId);
	domObj.innerHTML=innerHtml;
}

function createSelectionSummaryString(divId, idx, summaryString){
	var selectedPlatform =Ext.get('platforms'+idx).dom.value;
	var selectedGpl =Ext.get('gpl'+idx).dom.value;
	var selectedSample =Ext.get('sample'+idx).dom.value;
	var selectedTissue =Ext.get('tissue'+idx).dom.value;
	var selectedTimepoint =Ext.get('timepoint'+idx).dom.value;
	
	summaryString += '<br> <b>子集'+idx+'</b>'+//<SIAT_zh_CN original="Subset">子集</SIAT_zh_CN>
	'<br> <b>平台:</b> '+ selectedPlatform +//<SIAT_zh_CN original="Platform">平台</SIAT_zh_CN>
	'<br> <b>GPL平台:</b> '+selectedGpl+//<SIAT_zh_CN original="GPL Platform">GPL平台</SIAT_zh_CN>
	'<br> <b>样本:</b> '+selectedSample+//<SIAT_zh_CN original="Sample">样本</SIAT_zh_CN>
	'<br> <b>组织:</b> '+selectedTissue+//<SIAT_zh_CN original="Tissue">组织</SIAT_zh_CN>
	'<br> <b>时间点:</b> '+selectedTimepoint+//<SIAT_zh_CN original="Timepoint">时间点</SIAT_zh_CN>
	'<br>';
	
	return summaryString
}

function clearHighDimDataSelections(divId){
	var subsetCount = multipleSubsets()?2:1;
	for(var idx = 1; idx<=subsetCount; idx++){
		window[divId+'timepoints'+idx]		="";
		window[divId+'samples'+idx]			="";
		window[divId+'rbmPanels'+idx]		=""; 
		window[divId+'platforms'+idx]		="";
		window[divId+'gpls'+idx]			="";
		window[divId+'tissues'+idx]			="";
		window[divId+'samplesValues'+idx]	="";
		window[divId+'tissuesValues'+idx]	="";
		window[divId+'timepointsValues'+idx]="";
	}
	
	window[divId+'pathway']				="";
	window[divId+'pathwayName'] 		="";
	window[divId+'probesAggregation']	="";
	window[divId+'SNPType']				="";
	window[divId+'markerType']			="";
	
	//invalidate the two global subsets
//	GLOBAL.CurrentSubsetIDs[1]			=null;
//	GLOBAL.CurrentSubsetIDs[2]			=null;
	
	GLOBAL.CurrentPathway				=null;
	GLOBAL.CurrentPathwayName			=null;
	GLOBAL.HighDimDataType				=null;
	
}

function clearSummaryDisplay(divId){
	var domObj = document.getElementById("display"+divId);
	if(domObj){
		domObj.innerHTML="";
	}
}

function multipleSubsets(){
	var multipleSubsets=false; 
	if(Ext.get('multipleSubsets') && (getQuerySummary(2)!="")){
		multipleSubsets = (Ext.get('multipleSubsets').dom.value=='true');
	}
	return multipleSubsets;
}

function toggleDataAssociationFields(extEle){

	
	if((GLOBAL.Analysis=='Advanced')||multipleSubsets()){
		//rbm panel, gpl, sample and tissue have display rules based on the selected platform
		//Those rules have been applied by now in i2b2common.js->resetCohortInfoValues().
		//The display property for those fields is not modified.
		document.getElementById("labelsubset1").style.display="";
		document.getElementById("labelsubset2").style.display="";
		document.getElementById("divplatform2").style.display="";
		document.getElementById("divtimepoint2").style.display="";
	}else{
		document.getElementById("labelsubset1").style.display="none";
		document.getElementById("labelsubset2").style.display="none";
		document.getElementById("divplatform2").style.display="none";
		document.getElementById("divrbmpanel2").style.display="none";
		document.getElementById("divgpl2").style.display="none";
		document.getElementById("divsample2").style.display="none";
		document.getElementById("divtissue2").style.display="none";
		document.getElementById("divtimepoint2").style.display="none";
	}
	
	// toggle display of Probes aggregation checkbox
	if (document.getElementById("divProbesAggregation") != null) {
		
		document.getElementById("divProbesAggregation").style.display="none";

		if(isProbesAggregationSupported()){
			document.getElementById("divProbesAggregation").style.display="";
			document.getElementById("divProbesAggregation").checked=false
		}
	}
	
	//toggle display of SNP type dropdown
    if (document.getElementById("divSNPType") != null) {
        if (GLOBAL.Analysis == 'Advanced') {
            document.getElementById("divSNPType").style.display = "none";
        } else if (GLOBAL.Analysis == "dataAssociation") {

            if (GLOBAL.HighDimDataType == HIGH_DIMENSIONAL_DATA["snp"].type)
                document.getElementById("divSNPType").style.display = "";
            else
                document.getElementById("divSNPType").style.display = "none";

        }
    }

    //display the appropriate submit button
	if(GLOBAL.Analysis=="dataAssociation"){
		document.getElementById("compareStepPathwaySelectionOKButton").style.display="none";
		document.getElementById("dataAssociationApplyButton").style.display="";
	}else if(GLOBAL.Analysis=='Advanced'){
		document.getElementById("compareStepPathwaySelectionOKButton").style.display="";
		document.getElementById("dataAssociationApplyButton").style.display="none";
	}
}

function isProbesAggregationSupported(){
	var probesAggregationSupported = false;
	//The checkbox is displayd only for the dataAssociation tab.
	if(GLOBAL.Analysis=="dataAssociation"){
		var highDimDataTypeSupported=false;

		if(["Gene Expression", "SNP"].indexOf(GLOBAL.HighDimDataType)>-1){
			highDimDataTypeSupported=true;
		}
		
		var analysisSupported=true;
		var currentAnalysis=(Ext.get("analysis")).dom.value;
		if(["markerSelection", "pca"].indexOf(currentAnalysis)>-1){
			analysisSupported=false;
		}
			
		if(highDimDataTypeSupported && analysisSupported){
			probesAggregationSupported=true; 
		}
	}
	return probesAggregationSupported;
}


function loadHighDimensionalParameters(formParams)
{
	//These will tell tranSMART what data types we need to retrieve.
	var mrnaData = false
	var snpData = false

	//Gene expression filters.
	var fullGEXSampleType 	= "";
	var fullGEXTissueType 	= "";
	var fullGEXTime 		= "";
	var fullGEXGeneList 	= "";
	var fullGEXGPL 			= "";
	
	//SNP Filters.
	var fullSNPSampleType 	= "";
	var fullSNPTissueType 	= "";
	var fullSNPTime 		= "";	
	var fullSNPGeneList 	= "";
	var fullSNPGPL 			= "";
	
	//Pull the individual filters from the window object.
	var independentGeneList = window['divIndependentVariablepathway'];
	var dependentGeneList 	= window['divDependentVariablepathway'];
	
	var dependentPlatform 	= window['divDependentVariableplatforms1'];
	var independentPlatform = window['divIndependentVariableplatforms1'];
	
	var dependentType 		= window['divDependentVariablemarkerType'];
	var independentType		= window['divIndependentVariablemarkerType'];
	
	var dependentTime		= window['divDependentVariabletimepointsValues'];
	var independentTime		= window['divIndependentVariabletimepointsValues'];
	
	var dependentSample		= window['divDependentVariablesamplesValues'];
	var independentSample	= window['divIndependentVariablesamplesValues'];
	
	var dependentTissue		= window['divDependentVariabletissuesValues'];
	var independentTissue	= window['divIndependentVariabletissuesValues'];
	
	var dependentGPL		= window['divDependentVariablegplValues'];
	var independentGPL		= window['divIndependentVariablegplValues'];
	
	if(dependentGPL) dependentGPL = dependentGPL[0];
	if(independentGPL) independentGPL = independentGPL[0];		
	
	//If we are using High Dimensional data we need to create variables that represent genes from both independent and dependent selections (In the event they are both of a single high dimensional type).
	//Check to see if the user selected GEX in the independent input.
	if(independentType == "Gene Expression")
	{
		//Put the independent filters in the GEX variables.
		fullGEXGeneList 	= String(independentGeneList);
		fullGEXSampleType 	= String(independentSample);
		fullGEXTissueType 	= String(independentTissue);
		fullGEXTime			= String(independentTime);
		fullGEXGPL 			= String(independentGPL);
		
		//This flag will tell us to write the GEX text file.
		mrnaData = true;
		
		//Fix the platform to be something the R script expects.
		independentType = "MRNA";		
	}

	if(dependentType == "Gene Expression")
	{
		//If the gene list already has items, add a comma.
		if(fullGEXGeneList != "") 	fullGEXGeneList 	+= ","
		if(fullGEXSampleType != "") fullGEXSampleType 	+= ","
		if(fullGEXTissueType != "") fullGEXTissueType 	+= ","
		if(fullGEXTime != "") 		fullGEXTime 		+= ","
		if(fullGEXGPL != "") 		fullGEXGPL 			+= ","
				
		//Add the genes in the list to the full list of GEX genes.
		fullGEXGeneList 	+= String(dependentGeneList);
		fullGEXSampleType 	+= String(dependentSample);
		fullGEXTissueType 	+= String(dependentTissue);
		fullGEXTime			+= String(dependentTime);
		fullGEXGPL 			+= String(dependentGPL);
		
		//This flag will tell us to write the GEX text file.		
		mrnaData = true;
		
		//Fix the platform to be something the R script expects.
		dependentType = "MRNA";	
	}
	
	//Check to see if the user selected SNP in the independent input.
	if(independentType == "SNP")
	{
		//The genes entered into the search box were SNP genes.
		fullSNPGeneList 	= String(independentGeneList);
		fullSNPSampleType 	= String(independentSample);
		fullSNPTissueType 	= String(independentTissue);
		fullSNPTime 		= String(independentTime);
		fullSNPGPL 			= String(independentGPL);
		
		//This flag will tell us to write the SNP text file.
		snpData = true;
	}
	
	if(dependentType == "SNP")
	{
		//If the gene list already has items, add a comma.
		if(fullSNPGeneList != "") 	fullSNPGeneList 	+= ","
		if(fullSNPSampleType != "") fullSNPSampleType 	+= ","
		if(fullSNPTissueType != "") fullSNPTissueType 	+= ","
		if(fullSNPTime != "") 		fullSNPTime 		+= ","
		if(fullSNPGPL != "") 		fullSNPGPL 			+= ","
				
		//Add the genes in the list to the full list of SNP genes.
		fullSNPGeneList 	+= String(dependentGeneList)
		fullSNPSampleType 	+= String(dependentSample);
		fullSNPTissueType 	+= String(dependentTissue);
		fullSNPTime 		+= String(dependentTime);	
		fullSNPGPL 			+= dependentGPL;
		
		//This flag will tell us to write the SNP text file.		
		snpData = true;
	}	
	
	if((fullGEXGeneList == "") && (independentType == "MRNA" || dependentType == "MRNA"))
	{
		Ext.Msg.alert("未选中任何基因", "请在基因/途径搜索框中指定基因")//<SIAT_zh_CN original="No Genes Selected">未选中任何基因</SIAT_zh_CN>//<SIAT_zh_CN original="Please specify Genes in the Gene/Pathway Search box.">请在基因/途径搜索框中指定基因</SIAT_zh_CN>
		return false;
	}
	
	if((fullSNPGeneList == "") && (independentType == "SNP" || dependentType == "SNP"))
	{
		Ext.Msg.alert("未选中任何基因", "请在基因/途径搜索框中指定基因")//<SIAT_zh_CN original="No Genes Selected">未选中任何基因</SIAT_zh_CN>//<SIAT_zh_CN original="Please specify Genes in the Gene/Pathway Search box.">请在基因/途径搜索框中指定基因</SIAT_zh_CN>
		return false;
	}
		
	//If we don't have a platform, fill in Clinical.
	if(dependentPlatform == null || dependentPlatform == "") dependentType = "CLINICAL"
	if(independentPlatform == null || independentPlatform == "") independentType = "CLINICAL"
	
	formParams["divDependentVariabletimepoints"] 			= window['divDependentVariabletimepoints1'];
	formParams["divDependentVariablesamples"] 				= window['divDependentVariablesamples1'];
	formParams["divDependentVariablerbmPanels"]				= window['divDependentVariablerbmPanels1'];
	formParams["divDependentVariableplatforms"]				= dependentPlatform
	formParams["divDependentVariablegpls"]					= window['divDependentVariablegplsValue1'];
	formParams["divDependentVariabletissues"]				= window['divDependentVariabletissues1'];
	formParams["divDependentVariableprobesAggregation"]	 	= window['divDependentVariableprobesAggregation'];
	formParams["divDependentVariableSNPType"]				= window['divDependentVariableSNPType'];
	formParams["divDependentVariableType"]					= dependentType;
	formParams["divDependentVariablePathway"]				= dependentGeneList;
	formParams["divIndependentVariabletimepoints"]			= window['divIndependentVariabletimepoints1'];
	formParams["divIndependentVariablesamples"]				= window['divIndependentVariablesamples1'];
	formParams["divIndependentVariablerbmPanels"]			= window['divIndependentVariablerbmPanels1'];
	formParams["divIndependentVariableplatforms"]			= independentPlatform;
	formParams["divIndependentVariablegpls"]				= window['divIndependentVariablegplsValue1'];
	formParams["divIndependentVariabletissues"]				= window['divIndependentVariabletissues1'];
	formParams["divIndependentVariableprobesAggregation"]	= window['divIndependentVariableprobesAggregation'];
	formParams["divIndependentVariableSNPType"]				= window['divIndependentVariableSNPType'];
	formParams["divIndependentVariableType"]				= independentType;
	formParams["divIndependentVariablePathway"]				= independentGeneList;
	formParams["gexpathway"]								= fullGEXGeneList;
	//formParams["gextime"]									= fullGEXTime;
	//formParams["gextissue"]									= fullGEXTissueType;
	//formParams["gexsample"]									= fullGEXSampleType;
	formParams["snppathway"]								= fullSNPGeneList;
	//formParams["snptime"]									= fullSNPTime;
	//formParams["snptissue"]									= fullSNPTissueType;
	//formParams["snpsample"]									= fullSNPSampleType;
	formParams["divIndependentPathwayName"]					= window['divIndependentVariablepathwayName'];
	formParams["divDependentPathwayName"]					= window['divDependentVariablepathwayName'];
	formParams["mrnaData"]									= mrnaData;
	formParams["snpData"]									= snpData;
	formParams["gexgpl"]									= fullGEXGPL;
	formParams["snpgpl"]									= fullSNPGPL;
	
	return true;
}
