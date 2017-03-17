
String.prototype.trim = function() {
	return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

Ext.layout.BorderLayout.Region.prototype.getCollapsedEl = Ext.layout.BorderLayout.Region.prototype.getCollapsedEl.createSequence(function () {
        if ((this.position == 'north' || this.position == 'south') && !this.collapsedEl.titleEl) {
		this.collapsedEl.titleEl = this.collapsedEl.createChild(
				{
					style : 'color:#15428b;font:11px/15px tahoma,arial,verdana,sans-serif;padding:2px 5px;', cn : this.panel.title
				}
		);
	}
		}
);

var runner = new Ext.util.TaskRunner();

var wfsWindow = null;


function dataSelectionCheckboxChanged(ctl) {
    if (getSelected(ctl)[0] != undefined) {
		Ext.getCmp("exportStepDataSelectionNextButton").enable();
	}
}

function setDataAssociationAvailableFlag(el, success, response, options) {
	
	if (!success) {
		var dataAssociationPanel = Ext.getCmp('dataAssociationPanel');
		var resultsTabPanel = Ext.getCmp('resultsTabPanel');
		resultsTabPanel.remove(dataAssociationPanel);
		resultsTabPanel.doLayout();
	} else {
		Ext.Ajax.request(
		{
			url : pageInfo.basePath+"/dataAssociation/loadScripts",
				method : 'GET',
				timeout: '600000',
				params :  Ext.urlEncode({}),
                success: function (result, request) {
					var exp = result.responseText.evalJSON();
					if (exp.success && exp.files.length > 0)	{
						loadScripts(exp.files);
					}
				},
                failure: function (result, request) {
					alert("无法处理该导出：" + result.responseText);//<SIAT_zh_CN original="Unable to process the export:">无法处理该导出：</SIAT_zh_CN>
				}
		});
	}
}

/**
 * Load js and css dynamically
 * @param scripts
 */
function loadScripts(scripts) {
    // loop through script array
    for (var i = 0; i < scripts.length; i++) {

        var file = scripts[i];

        if (file.type == 'script') { // if javascript
            $j.getScript(file.path);
        } else if (file.type == 'css') { // if css
            $j('head').append($j('<link rel="stylesheet" type="text/css" />').attr('href', file.path));
        } else {
            console.error("未知的文件类型。");//<SIAT_zh_CN original="Unknown file type.">未知的文件类型。</SIAT_zh_CN>
        }
    }
}

Ext.Panel.prototype.setBody = function (html) {
	var el = this.getEl();
	var domel = el.dom.lastChild.firstChild;
	domel.innerHTML = html;
}

Ext.Panel.prototype.getBody = function (html) {
	var el = this.getEl();
	var domel = el.dom.lastChild.firstChild;
	return domel.innerHTML;
}

Ext.onReady(function () {

	Ext.QuickTips.init();

	//set ajax to 600*1000 milliseconds
	Ext.Ajax.timeout = 1800000;

	// this overrides the above
	Ext.Updater.defaults.timeout = 1800000;


	// create the main regions of the screen
	westPanel = new Ext.Panel(
			{
				id : 'westPanel',
				region : 'west',
                width: 320,
				minwidth : 280,
				split : true,
				border : true,
				layout : 'border'
			}
	);
	qphtml = "<div style='margin: 10px'>查询条件<br /><select size='8' id='queryCriteriaSelect1' style='width:400px; height:250px;'></select><br />\
		< button onclick = 'resetQuery()' > 重置 < / button > < br / > < div id = 'queryCriteriaDiv1' style = 'font:11pt;width:200px; height:250px; white-space:nowrap;overflow:auto;border:1px solid black' > < / div > < / div > "
//<SIAT_zh_CN original="Query Criteria">查询条件</SIAT_zh_CN>//<SIAT_zh_CN original="Reset">重置</SIAT_zh_CN>
		var tb = new Ext.Toolbar(
				{
					id : 'maintoolbar',
					title : '主工具栏',//<SIAT_zh_CN original="maintoolbar">主工具栏</SIAT_zh_CN>
					items : [new Ext.Toolbar.Button(
							{
								id : 'changetool',
								text : '切换到子集试图',//<SIAT_zh_CN original="Switch to subset view">切换到子集试图</SIAT_zh_CN>
								iconCls : 'nextbutton',
								disabled : false,
                        handler: function () {
								window.location.href = "i2b2client.jsp"
								}
							}
					)]
				}
		);

		expmenu = new Ext.menu.Menu(
			{
				id : 'exportMenu',
				minWidth: 250,
                items: [
                    {
					text : '统计总结',//<SIAT_zh_CN original="Summary Statistics">统计总结</SIAT_zh_CN>
					handler : function()	{
						if((typeof(grid)!='undefined') && (grid!=null))	{
							exportGrid();
						} else {
							alert("没有数据/文件用于导出");//<SIAT_zh_CN original="Nothing to export">没有数据/文件用于导出</SIAT_zh_CN>
						}
					}
				}
				,
				'-'
				,
				{
					text : '基因表达/RBM数据集',//<SIAT_zh_CN original="Gene Expression/RBM Datasets">基因表达/RBM数据集</SIAT_zh_CN>
					handler : function()	{
						exportDataSets();
					}
				}
				]
			}
		);

		advmenu = new Ext.menu.Menu(
				{
					id : 'advancedMenu',
					minWidth: 250,
					items : [
					         {
					        	 text : '热图(Heatmap)',//<SIAT_zh_CN original="Heatmap">热图(Heatmap)</SIAT_zh_CN>
					        	 disabled : true,
					        	 // when checked has a boolean value, it is assumed to be a CheckItem
                        handler: function () {
					        	 	GLOBAL.HeatmapType = 'Compare';
					        	 	validateHeatmap();
					        	 	advancedWorkflowContextHelpId="1085";
					        	 },
					        	 disabled : GLOBAL.GPURL == "" 
					         }
					         ,
					         {
					        	 text : '层次聚类',//<SIAT_zh_CN original="Hierarchical Clustering">层次聚类</SIAT_zh_CN>
					        	 disabled : true,
					        	 // when checked has a boolean value, it is assumed to be a CheckItem
                        handler: function () {
					        	 	GLOBAL.HeatmapType = 'Cluster';
					        	 	validateHeatmap();
					        	 	advancedWorkflowContextHelpId="1085";
					        	 },
					        	 disabled : GLOBAL.GPURL == ""
					         }
					         ,
					         {
					        	 text : 'K-均值聚类',//<SIAT_zh_CN original="K-Means Clustering">K-均值聚类</SIAT_zh_CN>
					        	 disabled : true,
					        	 // when checked has a boolean value, it is assumed to be a CheckItem
                        handler: function () {
					        	 	GLOBAL.HeatmapType = 'KMeans';
					        	 	validateHeatmap();
					        	 	advancedWorkflowContextHelpId="1085";
					        	 },
					        	 disabled : GLOBAL.GPURL == ""
					         }
					         ,
					         {
					        	 text : '比较标志物选择 (Heatmap)',//<SIAT_zh_CN original="Comparative Marker Selection">比较标志物选择</SIAT_zh_CN>
					        	 disabled : true,
					        	 // when checked has a boolean value, it is assumed to be a CheckItem
                        handler: function () {
					        	 	GLOBAL.HeatmapType = 'Select';
					        	 	validateHeatmap();
					        	 	advancedWorkflowContextHelpId="1085";
					        	 },
					        	 disabled : GLOBAL.GPURL == ""
					         }
					         ,
				        	 '-' 
					         ,					         
					         {
					        	 text : '主成分分析',//<SIAT_zh_CN original="Principal Component Analysis">主成分分析</SIAT_zh_CN>
					        	 disabled : true,
					        	 // when checked has a boolean value, it is assumed to be a CheckItem
                        handler: function () {
					        	 	GLOBAL.HeatmapType = 'PCA';
					        	 	validateHeatmap();
					        	 	advancedWorkflowContextHelpId="1172";
					        	 },
					        	 disabled : GLOBAL.GPURL == ""
					         }
					         ,
				        	 '-'
				        	 ,
					         {
					        	 text : '生存分析',//<SIAT_zh_CN original="Survival Analysis">生存分析</SIAT_zh_CN>
                        handler: function () {
                            if (isSubsetEmpty(1) || isSubsetEmpty(2)) {
					        			alert('生存分析需要所有子集的时间点数据.');//<SIAT_zh_CN original="Survival Analysis needs time point data from both subsets.">生存分析需要所有子集的时间点数据.</SIAT_zh_CN>
					        		 	return;
					        	 	}
					        	 	else {
					        	 		showSurvivalAnalysis();
					        	 	}
					        	 },
					        	 disabled : GLOBAL.GPURL == ""
					         }
					         ,
				        	 '-'
				        	 ,
					         {
					        	 text : 'Haploview',//<SIAT_zh_CN original="Haploview">Haploview</SIAT_zh_CN>
					        	 handler : function()	{
                            if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
					        			alert('检测到空子集，分析需要一个有效的子集！');//<SIAT_zh_CN original="Empty subsets found, need a valid subset to analyze!">检测到空子集，分析需要一个有效的子集！</SIAT_zh_CN>
					        		 	return;
					        	 	}
                            if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
					        			runAllQueries(function()	{
					        				showHaploviewGeneSelection();
					        			});
					        	 	} else	{
					        	 		showHaploviewGeneSelection()
					        	 	}
					        	 	return;
					        	}
					        }
					        ,
					        {
					        	 text : 'SNPViewer',//<SIAT_zh_CN original="SNPViewer">SNPViewer</SIAT_zh_CN>
					        	 disabled : true,
					        	 handler : function()	{
                            if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
					        			alert('子集均为空，请选择一个有效的数据集。');//<SIAT_zh_CN original="Both dataset is empty. Please choose a valid dataset.">子集均为空，请选择一个有效的数据集。</SIAT_zh_CN>
					        		 	return;
					        	 	}
                            if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
					        			runAllQueries(function()	{
					        				showSNPViewerSelection();
					        			});
					        	 	} else	{
					        	 		showSNPViewerSelection();
					        	 	}
					        	 	return;
					        	},
					        	disabled : GLOBAL.GPURL == ""
					        }
					        ,
					        {
					        	 text : 'Integrative Genome Viewer',//<SIAT_zh_CN original="Integrative Genome Viewer">Integrative Genome Viewer</SIAT_zh_CN>
					        	 disabled : true,
					        	 handler : function()	{
                            if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
					        			alert('子集均为空，请选择一个有效的数据集。');//<SIAT_zh_CN original="Both dataset is empty. Please choose a valid dataset.">子集均为空，请选择一个有效的数据集。</SIAT_zh_CN>
					        		 	return;
					        	 	}
                            if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
					        			runAllQueries(function()	{
					        				showIgvSelection();
					        			});
					        	 	} else	{
					        	 		showIgvSelection();
					        	 	}
					        	 	return;
					        	},
					        	disabled : GLOBAL.GPURL == ""
					        }
					        ,
					        {
					        	 text : 'PLINK',//<SIAT_zh_CN original="PLINK">PLINK</SIAT_zh_CN>
					        	 disabled : true,
					        	 handler : function()	{
                            if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
					        			alert('子集均为空，请选择一个有效的数据集。');//<SIAT_zh_CN original="Both dataset is empty. Please choose a valid dataset.">子集均为空，请选择一个有效的数据集。</SIAT_zh_CN>
					        		 	return;
					        	 	}
                            if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
					        			runAllQueries(function()	{
					        				showPlinkSelection();
					        			});
					        	 	} else	{
					        	 		showPlinkSelection();
					        	 	}
					        	 	return;
					        	}
					        },
					        {
					        	 text : '全基因组关联分析(GWAS)',//<SIAT_zh_CN original="Genome-Wide Association Study">全基因组关联分析</SIAT_zh_CN>
					        	 handler : function()	{
                            if (isSubsetEmpty(1) || isSubsetEmpty(2)) {
					        			alert('GWAS需要在子集1中放置控制对照（正常患者）数据集，在子集2中放置案例（疾病患者）数据集。');//<SIAT_zh_CN original="Genome-Wide Association Study needs control datasets (normal patients) in subset 1, and case datasets (disease patients) in subset 2.">GWAS需要在子集1中放置控制对照（正常患者）数据集，在子集2中放置案例（疾病患者）数据集。</SIAT_zh_CN>
					        		 	return;
					        	 	}
                            if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
					        			runAllQueries(function()	{
					        				showGwasSelection();
					        			});
					        	 	} else	{
					        	 		showGwasSelection();
					        	 	}
					        	 	return;
					        	}
                    }
                ]
				}
		);


		var tb2 = new Ext.Toolbar(
				{
					id : 'maintoolbar',
					title : 'maintoolbar',//<SIAT_zh_CN original="maintoolbar">主工具栏</SIAT_zh_CN>
                items: [
					new Ext.Toolbar.Button(
							{
								id : 'dataExplorerHelpButton',
								iconCls : 'contextHelpBtn',
								qtip: '点击获取数据管理器的相关帮助',//<SIAT_zh_CN original="Click for Dataset Explorer Help">点击获取数据管理器的相关帮助</SIAT_zh_CN>
								disabled : false,
                            handler: function () {
								    D2H_ShowHelp("1258",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
								}
							}
					)
					]
				}
		);


		centerMainPanel = new Ext.Panel(
				{
					id : 'centerMainPanel',
					region : 'center',
					// tbar : tb,
					layout : 'border'
				}
		);

		centerPanel = new Ext.Panel(
				{
					id : 'centerPanel',
					region : 'center',
					width : 500,
					minwidth : 150,
					split : true,
					border : true,
                layout: 'fit'
				}
		);

        // **************
        // Comparison tab
        // **************

		queryPanel = new Ext.Panel(
				{
					id : 'queryPanel',
					title : '对比',//<SIAT_zh_CN original="Comparison">对比</SIAT_zh_CN>
					region : 'north',
					height : 340,
					autoScroll : true,
					split : true,					
            autoLoad: {
						url : pageInfo.basePath+'/panels/subsetPanel.html',
						scripts : true,
						nocache : true,
						discardUrl : true,
						method : 'POST'
					},
					collapsible : true,
					titleCollapse : false,
					animCollapse : false,
            listeners: {
						activate : function() {
							GLOBAL.Analysis="Advanced";
						}
					},
					bbar: new Ext.StatusBar({
						// Status bar to show the progress of generating heatmap and other advanced workflows
				        id: 'asyncjob-statusbar',
				        defaultText: '就绪',//<SIAT_zh_CN original="Ready">就绪</SIAT_zh_CN>
				        defaultIconCls: 'default-icon',
				        text: '就绪',//<SIAT_zh_CN original="Ready">就绪</SIAT_zh_CN>
				        statusAlign: 'right',
				        iconCls: 'ready-icon',
                items: [
                    {
				        	xtype: 'button',
				        	id: 'cancjob-button',
				        	text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
				        	hidden: true
                    }
                ]
				    })
        });

		resultsPanel = new Ext.Panel(
				{
					id : 'resultsPanel',
					title : '结果',//<SIAT_zh_CN original="Results">结果</SIAT_zh_CN>
					region : 'center',
					split : true,
					height : 90
				}
		);

		resultsTabPanel = new Ext.TabPanel(
				{
					id : 'resultsTabPanel',
					title : '分析/结果',//<SIAT_zh_CN original="Analysis/Results">分析/结果</SIAT_zh_CN>
					region : 'center',

                defaults: {
					hideMode : 'display'
                },
				collapsible : false,
				//height : 300,
				deferredRender : false,
				activeTab : 0,
                tools: [
                    {
                        id: 'help',
					qtip:'点击获取生成统计总结的相关帮助',//<SIAT_zh_CN original="Click for Generate Summary Statistics help">点击获取生成统计总结的相关帮助</SIAT_zh_CN>
				    handler: function(event, toolEl, panel){
				    	D2H_ShowHelp("1074",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
				    },
				hidden:true
				}
                ]
            }
		);

        GalaxyPanel = new Ext.Panel(
            {
                id : 'GalaxyPanel',
                title : 'Galaxy导出',//<SIAT_zh_CN original="Galaxy Export">Galaxy导出</SIAT_zh_CN>
                region : 'center',
                split : true,
                height : 90,
                layout : 'fit',
                listeners :
                {
                    activate : function(p) {
                        getJobsDataForGalaxy(p)
                    }
                },
                collapsible : true
            }
        );

        // **************
        // Grid view tab
        // **************

		analysisGridPanel = new Ext.Panel(
				{
					id : 'analysisGridPanel',
					title : '网格视图',//<SIAT_zh_CN original="Grid View">网格视图</SIAT_zh_CN>
					region : 'center',
					split : true,
					height : 90,
                layout: 'fit',
                listeners: {
                    activate: function (p) {
                        if (isSubsetQueriesChanged(p.subsetQueries) || !Ext.get('analysisGridPanel')) {
                            runAllQueries(getSummaryGridData, p);
                            activateTab();
                            onWindowResize();
                        } else {
                            getSummaryGridData();
                        }
                    },
                    deactivate: function(){
                        resultsTabPanel.tools.help.dom.style.display = "none";
                    },
                    'afterLayout': {
                        fn: function (el) {
                            onWindowResize();
                        }
                    }
                }
            }
		);

        // ******************
        // Summary Statistics
        // ******************

        analysisPanel = new Ext.Panel ({
					id : 'analysisPanel',
                    title: '统计总结',//<SIAT_zh_CN original="Summary Statistics">统计总结</SIAT_zh_CN>
					region : 'center',
					fitToFrame : true,
                    listeners: {
                        activate: function (p) {
                            if (isSubsetQueriesChanged(p.subsetQueries) || !Ext.get('analysis_title')) {
                                p.body.mask("正在加载...", 'x-mask-loading');//<SIAT_zh_CN original="Loading...">正在加载...</SIAT_zh_CN>
                                runAllQueries(getSummaryStatistics, p);
                                activateTab();
                                onWindowResize();
                            }
                        },
                        deactivate: function(){
                        resultsTabPanel.tools.help.dom.style.display = "none";
                            },
                        'afterLayout': {
                            fn: function (el) {
                                onWindowResize();
                            }
                        }
                    },
				autoScroll : true,
                html: '<div style="text-align:center;font:12pt arial;width:100%;height:100%;">' +
                '<table style="width:100%;height:100%;"><tr><td align="center" valign="center">拖拽概念 ' +
                '到此面板以查看由该概念所分解出的子集</td></tr></table></div>',//<SIAT_zh_CN original="Drag concepts to this panel to view a breakdown of the subset by that concept">拖拽概念到此面板以查看由该概念所分解出的子集</SIAT_zh_CN>
				split : true,
				closable : false,
				height : 90,
                tbar    : [
                '->', // Fill
                {
                    id : 'printanalysisbutton',
                    text : '打印',//<SIAT_zh_CN original="Print">打印</SIAT_zh_CN>
                    iconCls : 'printbutton',
                    handler : function() {
                        var text = getAnalysisPanelContent();
                        printPreview(text);
                    }
                }
            ]
        });

        // ************
        // Data Exports
        // ************

		analysisDataExportPanel = new Ext.Panel(
				{
					id : 'analysisDataExportPanel',
					title : '数据导出',//<SIAT_zh_CN original="Data Export">数据导出</SIAT_zh_CN>
					region : 'center',
					split : true,
					height : 90,
					layout : 'fit',
                listeners: {
						activate : function(p) {
                        if (isSubsetQueriesChanged(p.subsetQueries) || !Ext.get('dataTypesGridPanel')) {
							p.body.mask("正在加载...", 'x-mask-loading');//<SIAT_zh_CN original="Loading">正在加载</SIAT_zh_CN>
							runAllQueries(getDatadata, p);
			        	 	return;
                        }
						},
                    'afterLayout': {
                        fn: function (el) {
                            onWindowResize();
                        }
						}
					},
					collapsible : true						
				}
		);
		
        // ******************
        // Advanced Workflow
        // ******************

		dataAssociationPanel = new Ext.Panel(
				{
					id : 'dataAssociationPanel',
					title : '高级工作流',//<SIAT_zh_CN original="Advanced Workflow">高级工作流</SIAT_zh_CN>
					region : 'center',
					split : true,
					height : 90,
					layout : 'fit',
					tbar : new Ext.Toolbar({
						id : 'advancedWorkflowToolbar',
						title : '高级工作流的actions',//<SIAT_zh_CN original="Advanced Workflow actions">高级工作流的actions</SIAT_zh_CN>
						items : []
						}),
					autoScroll : true,
                autoLoad: {
			        	url : pageInfo.basePath+'/dataAssociation/defaultPage',
			           	method:'POST',
			           	callback: setDataAssociationAvailableFlag,
			           	evalScripts:true
			        },
                listeners: {
                    activate: function (p) {
                        /**
                         * routines when activating advanced workflow tab
                         * @private
                         */
                        var _activateAdvancedWorkflow = function () {
                            activateTab();
							GLOBAL.Analysis="dataAssociation";
							renderCohortSummary();
                            onWindowResize();
						}

                        if (isSubsetQueriesChanged(p.subsetQueries)) {
                            runAllQueries(_activateAdvancedWorkflow, p);
				}
		
                        _activateAdvancedWorkflow();
						},
                    'afterLayout': {
                        fn: function (el) {
                            onWindowResize();
						}
				}
				},
				collapsible : true
			}
		);

        // ******************
        // Export Jobs
        // ******************

        analysisExportJobsPanel = new Ext.Panel(
				{
                id: 'analysisExportJobsPanel',
                title: '导出工作',//<SIAT_zh_CN original="Export Jobs">导出工作</SIAT_zh_CN>
					region : 'center',
					split : true,
					height : 90,
					layout : 'fit',
                listeners: {
						activate : function(p) {
                        p.body.mask("正在加载...", 'x-mask-loading');//<SIAT_zh_CN original="Loading">正在加载</SIAT_zh_CN>
                        getExportJobs(p)
						},
						deactivate: function(){
						}
					},
					collapsible : true						
				}
		);

        /**
         * panel to display list of jobs belong to a user
         * @type {Ext.Panel}
         */
        analysisJobsPanel = new Ext.Panel(
            {
                id : 'analysisJobsPanel',
                title : '分析工作',//<SIAT_zh_CN original="Analysis Jobs">分析工作</SIAT_zh_CN>
                region : 'center',
                split : true,
                height : 90,
                layout : 'fit',
                listeners :
                {
                    activate : function(p) {
                        getJobsData(p)
                    }
                },
                collapsible : true
            }
        );

        workspacePanel = new Ext.Panel(
            {
                id : 'workspacePanel',
                title : '工作空间',//<SIAT_zh_CN original="Workspace">工作空间</SIAT_zh_CN>
                region : 'center',
                split : true,
                height : 90,
                layout : 'fit',
                autoScroll : false,
                listeners :
                {
                    activate : function(p) {
                        renderWorkspace(p)
                    },
                    deactivate: function(){

                    }
                },
                collapsible : true
            }
        );

        sampleExplorerPanel = new Ext.Panel(
            {
                id: "sampleExplorer",
                title:"样本细节",//<SIAT_zh_CN original="Sample Details">样本细节</SIAT_zh_CN>
                layout: "fit",
                listeners: {
                    activate: function(p) {
                        p.body.mask("正在加载...", 'x-mask-loading');//<SIAT_zh_CN original="Loading">正在加载</SIAT_zh_CN>
                        generatePatientSampleCohort(launchSampleBrowseWithCohort)
                    }
                }
            }
        )

        resultsTabPanel.add(queryPanel);
		resultsTabPanel.add(analysisPanel);
		resultsTabPanel.add(analysisGridPanel);
        resultsTabPanel.add(dataAssociationPanel);
        resultsTabPanel.add(analysisDataExportPanel);
        resultsTabPanel.add(analysisExportJobsPanel);
        resultsTabPanel.add(analysisJobsPanel);
        resultsTabPanel.add(workspacePanel);

        if (GLOBAL.sampleExplorerEnabled)
            resultsTabPanel.add(sampleExplorerPanel);

        function loadResources(resources, bootstrap) {
            var scripts = [];
            for (var i = 0; i < resources.length; i++) {
                var aFile = resources[i];
                if (aFile.type == 'script') {
                    scripts.push(aFile.path);
                } else if (aFile.type == 'stylesheet') {
                    dynamicLoad.loadCSS(aFile.path);
                }
            }
            if (scripts.length > 0) {
                dynamicLoad.loadScriptsSequential(scripts, bootstrap);
            } else {
                bootstrap();
            }
        }

        function loadResourcesByUrl(url, bootstrap) {
            return jQuery.post(url, function(data) {
                if (data.success) {
                    loadResources(data.files, bootstrap)
                }
            }, "json").fail(function() {
                console.error("无法从此URL加载资源：" + url);//<SIAT_zh_CN original="Cannot load resources for">无法从此URL加载资源：</SIAT_zh_CN>
            });
        }

        function loadPlugin(pluginName, scriptsUrl, bootstrap) {
            var def = jQuery.Deferred();
            jQuery.post(pageInfo.basePath + "/pluginDetector/checkPlugin", {pluginName: pluginName}, function(data) {
                if (data === 'true') {
                    loadResourcesByUrl(pageInfo.basePath + scriptsUrl, function() {
                        bootstrap();
                        def.resolve();
                    }).fail(def.reject);
                } else {
                    def.reject();
                }
            }).fail(def.reject);
            return def;
        }

        // DALLIANCE
        // =======
        loadPlugin('dalliance-plugin', "/Dalliance/loadScripts", function () {
            loadDalliance(resultsTabPanel);
        }).always(function () {
            // Keep loading order to prevent tabs shuffling
            if (GLOBAL.metacoreAnalyticsEnabled) {
                loadPlugin('transmart-metacore-plugin', "/MetacoreEnrichment/loadScripts", function () {
                    loadMetaCoreEnrichment(resultsTabPanel);
                });
            }
        });

        if (GLOBAL.galaxyEnabled == 'true') {
           resultsTabPanel.add(GalaxyPanel);
        }

		southCenterPanel = new Ext.Panel(
				{
					id : 'southCenterPanel',
					region : 'center',
					layout : 'border',
					split : true,
					tbar : tb2
				}
		);

		exportPanel = new Ext.Panel(
				{
					id : 'exportPanel',
					title : '比较/导出',//<SIAT_zh_CN original="Compare/Export">比较/导出</SIAT_zh_CN>
					region : 'east',
					html : '<div style="text-align:center;font:12pt arial;width:100%;height:100%;"><table style="width:100%;height:100%;"><tr><td align="center" valign="center">拖拽子集至此面板以比较并导出</td></tr></table></div>',//<SIAT_zh_CN original="Drag subsets to this panel to compare and export them">拖拽子集至此面板以比较并导出</SIAT_zh_CN>
					split : true,
					width : 300,
					height : 90,
					buttons : [
					           {
					        	   text : '比较',//<SIAT_zh_CN original="Compare">比较</SIAT_zh_CN>
                        handler: function () {
					        	   var subsets = exportPanel.body.dom.childNodes;
                            if (subsets.length != 2) {
					        		   alert("必须有两个子集！");//<SIAT_zh_CN original="Must have two subsets!">必须有两个子集！</SIAT_zh_CN>
					        	   }
					        	   else showCompareStepPathwaySelection();
					        	   }
					           }
					           ,
					           {
					        	   text : '导出',//<SIAT_zh_CN original="Export">导出</SIAT_zh_CN>
					        	   iconCls : 'exportbutton',
                        handler: function () {
					        	   showExportStepSplitTimeSeries();
					        	   }
					           }
					           ,
					           {
					        	   text : '清除',//<SIAT_zh_CN original="Clear">清除</SIAT_zh_CN>
					        	   iconCls : 'clearbutton',
                        handler: function () {
					        	   clearExportPanel();
					        	   }
					           }

					           ]
				}
		);

		var treetitle = "查询历史";//<SIAT_zh_CN original="Previous Queries">查询历史</SIAT_zh_CN>
		if(GLOBAL.Config == 'jj')
			treetitle = "Subsets";//<SIAT_zh_CN original="Subsets">子集</SIAT_zh_CN>

		var Tree = Ext.tree;
		prevTree = new Tree.TreePanel(
				{
					id : 'previousQueriesTree',
					title : treetitle,
					animate : false,
					autoScroll : true,
					enableDrag : true,
					ddGroup : 'makeQuery',
					containerScroll : true,
					enableDrop : false,
					region : 'south',
					rootVisible : false,
					expanded : true,
					split : true,
					height : 300
				}
		);

		prevTreeRoot = new Tree.TreeNode(
				{
					text : 'root',//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
					draggable : false,
					id : 'prevroot',
					qtip : 'root'
				}
		);


		prevTree.setRootNode(prevTreeRoot);


		/**********new prototype*********/

		centerPanel.add(resultsTabPanel);
		/********************************/

		westPanel.add(createOntPanel());
		centerMainPanel.add(westPanel);
		centerMainPanel.add(centerPanel);


		viewport = new Ext.Viewport(
				{
					layout : 'border',
                items: [centerMainPanel],
                listeners: {
                    'afterLayout': {
                        fn: function (el) {
                            onWindowResize();
                        }
                    }
				}
            }
		);

		Ext.get(document.body).addListener('contextmenu', contextMenuPressed);

		// preload the setvalue dialog
		setvaluePanel = new Ext.Panel(
				{
					id : 'setvaluePanel',
					region : 'north',
					height : 140,
					width : 490,
					split : false,
                autoLoad: {
					url : pageInfo.basePath+'/panels/setValueDialog.html',
					scripts : true,
					nocache : true,
					discardUrl : true,
					method : 'POST'
					}
				}
		);

		setvaluechartsPanel1 = new Ext.Panel(
				{
					id : 'setvaluechartsPanel1',
					region : 'center',
					width : 245,
					height : 180,
					split : false
				}
		);

		setvaluechartsPanel2 = new Ext.Panel(
				{
					id : 'setvaluechartsPanel2',
					region : 'east',
					width : 245,
					height : 180,
					split : false
				}
		);

		// preload the setvalue dialog
        if (!this.setvaluewin) {
			setvaluewin = new Ext.Window(
					{
						id : 'setValueWindow',
						title : '设置值',//<SIAT_zh_CN original="Set Value">设置值</SIAT_zh_CN>
						layout : 'border',
						width : 500,
						height : 240,
						closable : false,
						plain : true,
						modal : true,
						border : false,
						items : [setvaluePanel , setvaluechartsPanel1, setvaluechartsPanel2],
						buttons : [
						           {
						        	   text : '展示直方图',//<SIAT_zh_CN original="Show Histogram">展示直方图</SIAT_zh_CN>
                            handler: function () {
						        	   showConceptDistributionHistogram();
						        	   }
						           }
						           ,
						           {
						        	   text : '展示关于子集的直方图',//<SIAT_zh_CN original="Show Histogram for subset">展示关于子集的直方图</SIAT_zh_CN>
                            handler: function () {
						        	   var subset;
                                if (selectedConcept.parentNode.id == "hiddenDragDiv") {
						        		   subset = getSubsetFromPanel(STATE.Target);
						        	   }
                                else {
						        		   subset = getSubsetFromPanel(selectedConcept.parentNode)
						        	   }

                                if (!isSubsetEmpty(subset)) {
						        		   runQuery(subset, showConceptDistributionHistogramForSubset);
						        	   }
						        	   else alert('子集为空！');//<SIAT_zh_CN original="Subset is empty!">子集为空！</SIAT_zh_CN>
						        	   }
						           }
						           ,
						           {
						        	   text : '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
                            handler: function () {
						        	   var mode = getSelected(document.getElementsByName("setValueMethod"))[0].value;
						        	   var highvalue = document.getElementById("setValueHighValue").value;
						        	   var lowvalue = document.getElementById("setValueLowValue").value;
						        	   var units = document.getElementById("setValueUnits").value;
						        	   var operator = document.getElementById("setValueOperator").value;
						        	   var highlowselect = document.getElementById("setValueHighLowSelect").value;

						        	   // make sure that there is a value set
						        	   if (mode=="numeric" && operator == "BETWEEN" && (highvalue == "" || lowvalue== "")){
						        		   alert('你必须指定下边界以及上边界');//<SIAT_zh_CN original="You must specify a low and a high value.">你必须指定下边界以及上边界.</SIAT_zh_CN>
						        	   } else if (mode=="numeric" && lowvalue == "") {
						        		   alert('你必须指定一个值');//<SIAT_zh_CN original="You must specify a value.">你必须指定一个值</SIAT_zh_CN>
						        	   } else {
						        		   setvaluewin.hide();
						        		   setValueDialogComplete(mode, operator, highlowselect, highvalue, lowvalue, units);
						        	   }
						        	   }
						           }
						           ,
						           {
						        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
                            handler: function () {
						        	   setvaluewin.hide();
						        	   }
						           }
						           ],
						           resizable : false,
                    tools: [
                        {
										id:'help',
										qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
									    handler: function(event, toolEl, panel){
									    	D2H_ShowHelp("1239", helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
									    }
                        }
                    ]

					}
			);
			setvaluewin.show();
			setvaluewin.hide();
		}


		showLoginDialog();
		var h=queryPanel.header;

		}



);

function onWindowResize() {
    //Assorted hackery for accounting for the presence of the toolbar
    var windowHeight = jQuery(window).height();

    jQuery('#centerMainPanel').css('top', jQuery('#header-div').height());

    var boxHeight = jQuery('#box-search').height();
    jQuery('#navigateTermsPanel .x-panel-body').height(windowHeight - boxHeight - 90);

    jQuery('#analysisPanel .x-panel-body').height(jQuery(window).height() - 65);

    if (jQuery('#dataTypesGridPanel .x-panel-body').size() > 0) {
        var exportPanelTop = jQuery('#dataTypesGridPanel .x-panel-body').offset()['top'];
        jQuery('#dataTypesGridPanel .x-panel-body').height(jQuery(window).height() - exportPanelTop - 40);
    }
    if (jQuery('#resultsTabPanel .x-tab-panel-body').size() > 0) {
        var panelTop = jQuery('#resultsTabPanel .x-tab-panel-body').offset()['top'];
        jQuery('#resultsTabPanel .x-tab-panel-body').height(jQuery(window).height() - panelTop);
    }
//	if (jQuery('#dataAssociationBody').size() > 0) {
//		var panelTop = jQuery('#dataAssociationBody').offset()['top'];
//		jQuery('#dataAssociationBody').height(jQuery(window).height() - 50);
//	}
    jQuery('#subsets_wrapper').find('div.dataTables_scrollBody').css("height", calcWorkspaceDataTableHeight() + "px");
    jQuery('#reports_wrapper').find('div.dataTables_scrollBody').css("height", calcWorkspaceDataTableHeight() + "px");

}




/*
This function will make a quick call to the server to check
a session variable that if set indicates that it is OK
to export the datasets since the user ran the one of the
heatmap options and loaded the gene expression data
*/
function exportDataSets() {
	Ext.get("exportdsform").dom.submit();
				}

function hasMultipleTimeSeries() {
	return true;
}

function createOntPanel() {
	// make tab panel, search panel, ontTree and combine them
    ontTabPanel = new Ext.Panel(
			{
				id : 'ontPanel',
				region : 'center',
            defaults: {
				hideMode : 'offsets'
            },
			collapsible : false,
			height : 300,
            width: 250,
			deferredRender : false,
            split: true
	        		}
	);

	ontSearchByCodePanel = new Ext.Panel(
			{
				id : 'searchByCodePanel',
				title : '根据编码搜索',//<SIAT_zh_CN original="Search by Codes">根据编码搜索</SIAT_zh_CN>
				region : 'center'
			}
	);


	searchByNamePanel = new Ext.Panel(
			{
				title : '根据名称搜索',//<SIAT_zh_CN original="Search by Names">根据名称搜索</SIAT_zh_CN>
				id : 'searchByNamePanel',
				region : 'center',
				height : 500,
            width: 250,
				border : true,
				bodyStyle : 'background:lightgrey;',
				layout : 'border',
				split : true
			}
	);




    // make the ontSearchByNamePanel
	shtml='<table style="font:10pt arial;"><tr><td><select id="searchByNameSelect"><option value="left">始于</option><option value="right">终于</option>\
		<option value="contains" selected>选择本体:</option><option value="exact">Exact</option></select>&nbsp;&nbsp;</td><td><input id="searchByNameInput" onkeypress="if(enterWasPressed(event)){searchByName();}" type="text" size="15">&nbsp;</td>\
		<td><button onclick="searchByName()">搜索</button></td></tr><tr><td colspan="2">选择本体:<select id="searchByNameSelectOntology"></select></td></tr></table>';
		//<SIAT_zh_CN original="Starting with">始于</SIAT_zh_CN>//<SIAT_zh_CN original="Ending with">终于</SIAT_zh_CN>//<SIAT_zh_CN original="Containing">包含</SIAT_zh_CN>//<SIAT_zh_CN original="Exact">Exact</SIAT_zh_CN>//<SIAT_zh_CN original="Find">搜索</SIAT_zh_CN>//<SIAT_zh_CN original="Select Ontology:">选择本体:</SIAT_zh_CN>
		searchByNameForm = new Ext.Panel(
				{
					id : 'searchByNameForm',
					region : 'north',
					bodyStyle : 'background:#eee;padding: 10px;',
					html : shtml,
					height : 70,
					border : true,
					split : false
				}
		);

		// shorthand
		var Tree = Ext.tree;

		searchByNameTree = new Tree.TreePanel(
				{
					id : 'searchByNameTree',
					animate : false,
					autoScroll : true,
					loader : new Ext.ux.OntologyTreeLoader(
							{
								dataUrl : 'none'
							}
					),
					enableDrag : true,
					ddGroup : 'makeQuery',
					containerScroll : true,
					enableDrop : false,
					region : 'center',
					rootVisible : false,
					expanded : true,
					split : true,
					border : true,
					height : 400
				}
		);

		searchByNameTreeRoot = new Tree.TreeNode(
				{
					text : 'root',//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
					draggable : false,
					id : 'root',
					qtip : 'root'
				}
		);
		// add a tree sorter in folder mode
		new Tree.TreeSorter(searchByNameTree,
				{
			folderSort : true
				}
		);

		searchByNameTree.setRootNode(searchByNameTreeRoot);
		searchByNamePanel.add(searchByNameForm);
		searchByNamePanel.add(searchByNameTree);
//		******************************************************************************
//		FILTER PANEL
//		******************************************************************************
		var showFn = function(node, e){
			Ext.tree.TreePanel.superclass.onShow.call(this);
				}

		// shorthand
		var Tree = Ext.tree;

		ontFilterTree = new Tree.TreePanel(
				{
					id : 'ontFilterTree',
					animate : false,
					autoScroll : true,
					loader : new Ext.ux.OntologyTreeLoader(
							{
								dataUrl : 'none'
							}
					),
					enableDrag : true,
					ddGroup : 'makeQuery',
					containerScroll : true,
					enableDrop : false,
					region : 'center',
					rootVisible : false,
					expanded : true,
					border : true,
					height : 400
				}
		);

		ontFilterTreeRoot = new Tree.TreeNode(
				{
					text : 'root',//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
					draggable : false,
					id : 'root',
					qtip : 'root'//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
				}
		);
		// add a tree sorter in folder mode
		new Tree.TreeSorter(ontFilterTree,
				{
			folderSort : true
				}
		);

		ontFilterTree.setRootNode(ontFilterTreeRoot);

    setupOntTree('navigateTermsPanel', '术语导航');//<SIAT_zh_CN original="Navigate Terms">术语导航</SIAT_zh_CN>

		return ontTabPanel;
}

function closeBrowser() {
	window.open('http://www.i2b2.org', '_self', '');
	window.close();
}
function showLoginDialog() {

	loginwin = new Ext.Window(
			{
				id : 'loginWindow',
				title : '登录',//<SIAT_zh_CN original="Login">登录</SIAT_zh_CN>
				layout : 'fit',
				width : 350,
				height : 140,
				closable : false,
				plain : true,
				modal : true,
				border : false,
				resizable : false
			}
	);

	var txtboxdomain = new Ext.form.TextField(
			{
				fieldLabel : 'Domain',
				id : 'txtFieldDomain',
				name : 'domain'
			}
	);

	var txtboxusername = new Ext.form.TextField(
			{
				fieldLabel : 'Username',
				name : 'username'
			}
	);

	txtboxpassword = new Ext.form.TextField(
			{
				fieldLabel : 'Password',
				name : 'password',
				inputType : 'password'
			}
	);

	loginform = new Ext.FormPanel(
			{
				id : 'loginForm',
				labelWidth : 75,
				frame : true,
				region : 'center',
				width : 350,
				height : 130,
            defaults: {
				width : 230
            },
			defaultType : 'textfield',
			items : [txtboxusername, txtboxpassword],
			buttons : [
			           {
			        	   text : '登录',//<SIAT_zh_CN original="Login">登录</SIAT_zh_CN>
                    handler: function () {
			        	   loginform.el.mask('正在登录...', 'x-mask-loading');//<SIAT_zh_CN original="Logging in...">正在登录...</SIAT_zh_CN>
			        	   login(txtboxdomain.getValue(), txtboxusername.getValue(), txtboxpassword.getValue());
			        	   }
			           }
			           ,
			           {
			        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
			        	   handler : closeBrowser
			           }
			           ]
			}
	);


    if (GLOBAL.AutoLogin) {
		login(GLOBAL.Domain, GLOBAL.Username, GLOBAL.Password);
	}
    else {
		loginwin.add(loginform);
		loginwin.show(viewport);

        txtboxpassword.getEl().addListener('keypress', function (e) {
                if (enterWasPressed(e)) {
				loginform.el.mask('正在登录...', 'x-mask-loading');//<SIAT_zh_CN original="Logging in...">正在登录...</SIAT_zh_CN>
				login(txtboxdomain.getValue(), txtboxusername.getValue(), txtboxpassword.getValue());
			}
				}
		);
	}
}


function login(domain, username, password) {
	GLOBAL.Domain = domain;
	GLOBAL.Username = username;
	GLOBAL.Password = password;
	getServices();
}

function loginComplete() {
    if (loginform.isVisible()) {
        loginform.el.unmask();
        loginwin.hide();
    }

    projectDialogComplete();
	
	// Login GenePattern server. The login process should be completed by the time a user starts GenePattern tasks.
	genePatternLogin();
}

function showProjectDialog(projects) {

	// create the array
	Ext.projects = [];

	// populate the array
    for (c = 0; c < projects.length; c++) {
		var p = projects[c].getAttribute("id");
		var a = [];
		a[0] = p;
		a[1] = p;
		Ext.projects[c] = a;
	}


	projectwin = new Ext.Window(
			{
				id : 'projectWindow',
				title : '项目',//<SIAT_zh_CN original="Projects">项目</SIAT_zh_CN>
				layout : 'fit',
				width : 350,
				height : 140,
				closable : false,
				plain : true,
				modal : true,
				border : false,
				resizable : false
			}
	);

	// simple array store
	var store = new Ext.data.SimpleStore(
			{
				fields : ['id', 'projects'],
				data : Ext.projects
			}
	);


	var drdprojects = new Ext.form.ComboBox(
			{
				id : 'drdproject',
				name : 'drdproject',
				title : '项目',//<SIAT_zh_CN original="Projects">项目</SIAT_zh_CN>
				store : store,
				fieldLabel : 'Projects',
				displayField : 'projects',
				typeAhead : true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : '选择一个项目...',//<SIAT_zh_CN original="Select a project">选择一个项目</SIAT_zh_CN>
				selectOnFocus : true
			}
	);

	projectform = new Ext.FormPanel(
			{
				id : 'projectForm',
				labelWidth : 75,
				frame : true,
				region : 'center',
				width : 350,
				height : 130,
            defaults: {
				width : 230
            },
			defaultType : 'textfield',
			items : [drdprojects],
			buttons : [
			           {
			        	   text : '选择',//<SIAT_zh_CN original="Select">选择</SIAT_zh_CN>
                    handler: function () {
			        	   projectwin.hide();
			        	   projectDialogComplete(drdprojects.getValue());
			        	   }
			           }
			           ,
			           {
			        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
			        	   handler : closeBrowser
			           }
			           ]
			}
	);

	projectwin.add(projectform);
	projectwin.show(viewport);
}


function projectDialogComplete() {
    jQuery('#box-search').prependTo(jQuery('#westPanel')).show();
    jQuery('#noAnalyzeResults').prependTo(jQuery('#navigateTermsPanel .x-panel-body'));

    //Now that the ont tree has been set up, call the initial search
    showSearchResults();

    if (GLOBAL.RestoreComparison) {
		getPreviousQueryFromID(1, GLOBAL.RestoreQID1);
		getPreviousQueryFromID(2, GLOBAL.RestoreQID2);
	}
    if ((!GLOBAL.Tokens.indexOf("EXPORT") > -1) && (!GLOBAL.IsAdmin)) {
        //Ext.getCmp("exportbutton").disable();
    }
}

function getPreviousQueriesComplete(response) {
    // shorthand
    var Tree = Ext.tree;

    if (GLOBAL.Debug) {
        alert(response.responseText);
    }
    // clear the tree
    for (c = prevTreeRoot.childNodes.length - 1; c >= 0;
         c--) {
        prevTreeRoot.childNodes[c].remove();
    }
    // prevTree.render();

    var querymasters = response.responseXML.selectNodes('//query_master');
    for (var c = 0; c < querymasters.length; c++) {
        var querymasterid = querymasters[c].selectSingleNode('query_master_id').firstChild.nodeValue;
        var name = querymasters[c].selectSingleNode('name').firstChild.nodeValue;
        var userid = querymasters[c].selectSingleNode('user_id').firstChild.nodeValue;
        var groupid = querymasters[c].selectSingleNode('group_id').firstChild.nodeValue;
        var createdate = querymasters[c].selectSingleNode('create_date').firstChild.nodeValue;
        // set the root node
        var prevNode = new Tree.TreeNode(
	{
                text: name,
                draggable: true,
                id: querymasterid,
                qtip: name,
                userid: userid,
                groupid: groupid,
                createdate: createdate,
                leaf: true
            }
        );
        prevNode.addListener('contextmenu', previousQueriesRightClick);
        prevTreeRoot.appendChild(prevNode);
	}
}

function getCategoriesComplete(ontresponse){
    getSubCategories(ontresponse);
    }

function setActiveTab(){
	//var activeTab='ontFilterPanel';
	var activeTab='navigateTermsPanel';
	if (GLOBAL.PathToExpand!==''){
		if ((GLOBAL.PathToExpand.indexOf('Across Trials')>-1)&&(GLOBAL.hideAcrossTrialsPanel!='true')){
			activeTab='crossTrialsPanel';
		}else{
			activeTab='navigateTermsPanel';
		}
	}
}

function setupOntTree(id_in, title_in) {

	var Tree = Ext.tree;

    var showFn = function (node, e) {
        Ext.tree.TreePanel.superclass.onShow.call(this);
    }

    var ontTree = new Tree.TreePanel(
        {
            id: id_in,
            title: title_in,
            animate: false,
            autoScroll: true,
            loader: new Ext.ux.OntologyTreeLoader(
                {
                    dataUrl: 'none'
                }
            ),
            enableDrag: true,
            ddGroup: 'makeQuery',
            containerScroll: true,
            enableDrop: false,
            region: 'center',
            rootVisible: false,
            expanded: true,
            onShow: showFn
        }
    );

    ontTree.on('startdrag', function (panel, node, event) {
            Ext.ux.ManagedIFrame.Manager.showShims()

        }
    );

    ontTree.on('enddrag', function (panel, node, event) {
            Ext.ux.ManagedIFrame.Manager.hideShims()

        }
    );

    ontTree.on('beforecollapsenode', function (node, deep, anim) {
            Ext.Ajax.request(
                {
                    url: removeNodeDseURL + "?node=" + node.id,
                    method: 'POST',
                    success: function (result, request) {
                    },
                    failure: function (result, request) {
                        console.error(result);
                    },
                    timeout: '600000'
                }
            );
        }
    );
    var firstExpandProgram = new Array();
    ontTree.on('beforeexpandnode', function (node, deep, anim) {
            var expand = true;
            if (GLOBAL.PathToExpand != undefined && GLOBAL.PathToExpand.indexOf(node.id) > -1 && node.parentNode.id == "treeRoot" && !contains(dseClosedNodes, node.id)) {
                if (firstExpandProgram.indexOf(node.id) == -1) {
                    firstExpandProgram.push(node.id);
                    expand = false;
                }
            }

            if (expand) {
                Ext.Ajax.request(
                    {
                        url: addNodeDseURL + "?node=" + node.id,
                        method: 'POST',
                        success: function (result, request) {
                        },
                        failure: function (result, request) {
                            console.log(result);
                        },
                        timeout: '600000'
                    }
                );
            }

        }
    );

    var treeRoot = new Tree.TreeNode(
        {
            text      : 'root',
            draggable : false,
            id: 'treeRoot',
            qtip      : 'root'
        }
    );

    // add a tree sorter in folder mode
    new Tree.TreeSorter(ontTree,
	{
            folderSort: true
        }
    );

    ontTree.setRootNode(treeRoot);
    ontTabPanel.add(ontTree);
    ontTabPanel.doLayout();
    onWindowResize();
}

function createTree(ontresponse) {
    // shorthand
    var Tree = Ext.tree;
    var ontRoots = [];

    if (GLOBAL.DefaultPathToExpand != "") {
        GLOBAL.PathToExpand += GLOBAL.DefaultPathToExpand + ",";
    }

    var treeRoot = new Tree.TreeNode(
        {
            text: 'root',//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
            draggable: false,
            id: 'treeRoot',
            qtip: 'root'//<SIAT_zh_CN original="root">root</SIAT_zh_CN>
        }
    );
    for (var c = 0; c < ontresponse.length; c++) {
        var level = ontresponse[c].level;
		var key = ontresponse[c].key;
		var name = ontresponse[c].name;
		var tooltip = ontresponse[c].tooltip;
		var dimcode = ontresponse[c].dimcode;
        var visualAttributes = ontresponse[c].visualAttributes;
		
        var fullname = key.substr(key.indexOf("\\", 2), key.length);
        var access = GLOBAL.InitialSecurity[fullname];

		// set the root node
		var autoExpand=false;

        var lockedNode = true;
        if ((access != undefined && access != 'Locked') || GLOBAL.IsAdmin) {
            lockedNode = false;
        }
        if (lockedNode && key.indexOf('\\\\xtrials\\') === 0) {
            // across trial nodes should never be locked
            lockedNode = false;
        }

        if (GLOBAL.PathToExpand.indexOf(key) > -1 && GLOBAL.UniqueLeaves.indexOf(key + ",") == -1 && !lockedNode) {
            autoExpand = true;
        }

        //For search results - if the node level is 1 (study) or below and it doesn't appear in the search results, filter it out.
        if (level <= '1' && GLOBAL.PathToExpand != '' && GLOBAL.PathToExpand.indexOf(key) == -1) {
            continue;
        }

        var iconCls = "";

        if (visualAttributes.indexOf('PROGRAM') != '-1') {
        	iconCls="programicon";
        }

        var tcls = "";

        if (lockedNode) {
            tcls += ' locked';
        }

        var isSearchResult = (GLOBAL.PathToExpand.indexOf(key + ",") > -1);
        if (isSearchResult) {
            tcls += ' searchResultNode';
        }

        var expand = ((contains(dseOpenedNodes, key)) || autoExpand) && (!contains(dseClosedNodes, key));

		var ontRoot = new Tree.AsyncTreeNode(
				{
					text : name,
					draggable : false,
					id : key,
					qtip : tooltip,
                expanded: expand,
                iconCls: iconCls,
                cls: tcls
				}
		);
		
        if (lockedNode) {
            ontRoot.attributes.access = 'locked';
            ontRoot.on('beforeload', function (node) {
                return false
            });
        }

        ontRoots.push(ontRoot);

		/*****************************************/

		}

    return ontRoots;
		}

/*
 * the id_in drives which off these tabs is created
 * 
 */
function getSubCategories(ontresponse) {
	// shorthand
	var Tree = Ext.tree;

	var showFn;
	
    var ontRoots = createTree(ontresponse);
	
    var toolbar = new Ext.Toolbar([
		{
			id:'contextHelp-button',
			handler: function(event, toolEl, panel){
			   	D2H_ShowHelp((id_in=="navigateTermsPanel")?"1066":"1091",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
			},
		    iconCls: "contextHelpBtn"  
		}
    ]);
	
    var treeRoot = Ext.getCmp('navigateTermsPanel').getRootNode();
    for (c = treeRoot.childNodes.length - 1; c >= 0; c--) {
        treeRoot.childNodes[c].remove();
			}

    jQuery('#noAnalyzeResults').hide();

    for (var c = 0; c < ontRoots.length; c++) {
        var newnode = ontRoots[c];
        treeRoot.appendChild(newnode);
			}

    if (ontRoots.length == 0) { //This shouldn't happen!
        jQuery('#noAnalyzeResults').show();
			}

    if (GLOBAL.Debug) {
		alert(ontresponse.responseText);
	}

    onWindowResize();
	
}

function setupDragAndDrop() {
	/* Set up the drag and drop for the query panel */
	// var dts = new Array();


    for (var s = 1; s <= GLOBAL.NumOfSubsets; s++) {
		for(var i = 1; i <= GLOBAL.NumOfQueryCriteriaGroups;
             i++) {
			var qcd = Ext.get("queryCriteriaDiv" + s.toString() + '_' + i.toString());
			dts = new Ext.dd.DropTarget(qcd,
					{
				ddGroup : 'makeQuery'
					}
			);

            dts.notifyDrop = function (source, e, data) {
                if (source.tree.id == "previousQueriesTree") {
					getPreviousQueryFromID(data.node.attributes.id);
					return true;
				}
                else {
					var x=e.xy[0];
					var y=e.xy[1];
					var concept = null;
                    if (data.node.attributes.oktousevalues != "Y") {
						concept = createPanelItemNew(this.el, convertNodeToConcept(data.node));
					}
                    else {
						concept = createPanelItemNew(Ext.get("hiddenDragDiv"), convertNodeToConcept(data.node));
					}
					// new hack to show setvalue box
					selectConcept(concept);
                    if (data.node.attributes.oktousevalues == "Y") {
						STATE.Dragging = true;
						STATE.Target = this.el;
						showSetValueDialog();
					}
					/*new code to show next row*/
					var panelnumber = Number(this.id.substr(18));
					showCriteriaGroup(panelnumber+1);
					return true;
				}
			}
		}
	}

	/* Set up Drag and Drop for the analysis Panel */
	var qcd = Ext.get(analysisPanel.body);

	dts = new Ext.dd.DropTarget(qcd,
			{
            ddGroup: 'makeQuery'
			}
	);

    dts.notifyDrop = function (source, e, data) {
		buildAnalysis(data.node);
		return true;
	}

	/* set up drag and drop for grid */
	var mcd = Ext.get(analysisGridPanel.body);
	dtg = new Ext.dd.DropTarget(mcd,
			{
            ddGroup: 'makeQuery'
			}
	);

    dtg.notifyDrop = function (source, e, data) {
		buildAnalysis(data.node);
		return true;
	}
}

function getValue(node, defaultvalue)
{
    var result = defaultvalue;
    if (node.size() > 0)
        result = node.first().html()
    return result;
}

function getPreviousQueryFromIDComplete(subset, result) {
    if (result.status != 200) {
        queryPanel.el.unmask();
        return;
    }

    GLOBAL['florian'] = result.responseText;
    //resetQuery();  //if i do this now it wipes out the other subset i just loaded need to make it subset specific

    jQuery(GLOBAL['florian']).find("panel").each(function (pi, pe) {

        showCriteriaGroup(++pi);

        if (jQuery(pe).find("invert").first().html() == '1')
            excludeGroup(null, subset, pi);

        jQuery(pe).find("item").each(function (ii, ie) {

            var key = jQuery(ie).find("item_key").first().html()

            if (key == "\\\\Public Studies\\Public Studies\\SECURITY\\")
                return false;

            if (jQuery(ie).find("constrain_by_value").size() <= 0)
                oktousevalues = "Y";

            var mode
            switch (getValue(jQuery(ie, "constrain_by_value value_type"), "")) {
                case "FLAG":
                    mode = "highlow";
                    break;
                case "NUMBER":
                    mode = "highlow";
                    break;
                default:
                    mode = "novalue";
            }

            var operator = getValue(jQuery(ie, "constrain_by_value value_operator"), "");
            var numvalue = getValue(jQuery(ie, "constrain_by_value value_constraint"), "");
            var lowvalue = numvalue;
            var highvalue;

            if (operator == "BETWEEN") {
                lowvalue = numvalue.substring(0, numvalue.indexOf("and"));
                highvalue = numvalue.substring(numvalue.indexOf("and") + 3);
            }

            var highlowselect = mode == "highlow" ? numvalue : ""
            var value = new Value(mode, operator, highlowselect, lowvalue, highvalue, '');

            /* the panel (probably) only needs the concept key and the
             * constraint, hence we not need to fill the rest of the parameters,
             * which is good because we don't have that information...
             */

            var panel = document.getElementById("queryCriteriaDiv" + subset + "_" + pi)
            var concept = new Concept('', key, -1, '', '', key, '', '', oktousevalues, value);
            createPanelItemNew(panel, concept);
        })
    });

    queryPanel.el.unmask();
}

function createExportItem(name, setid) {
	if(GLOBAL.exportFirst == undefined) // clear out the body
	{
		exportPanel.body.update("");
		GLOBAL.exportFirst = false;
	}
	var panel = exportPanel.body.dom;
	var li = document.createElement('div');

	li.setAttribute('setid', setid);
	li.setAttribute('setname', name);
	li.className = "conceptUnselected";
	li.style.font = "10pt arial";
	var text = document.createTextNode(name);
	// tooltip
	li.appendChild(text);
	panel.appendChild(li);
	Ext.get(li).addListener('click', conceptClick);
	Ext.get(li).addListener('contextmenu', conceptRightClick);
}


function ontologyRightClick(eventNode, event) {
    if (!this.contextMenuOntology) {
		this.contextMenuOntology = new Ext.menu.Menu(
				{
					id : 'contextMenuOntology',
					items : [
					         {
                        text: '显示定义', handler: function () {//<SIAT_zh_CN original="Show Definition">显示定义</SIAT_zh_CN>
					        	 showConceptInfoDialog(eventNode.attributes.id, eventNode.attributes.text, eventNode.attributes.comment);
					        	 }
					         }
					         ]
				}
		);
	}
	var xy = event.getXY();
	this.contextMenuOntology.showAt(xy);
	return false;
}

function previousQueriesRightClick(eventNode, event) {
    if (!this.contextMenuPreviousQueries) {
		this.contextMenuPreviousQueries = new Ext.menu.Menu(
				{
					id : 'contextMenuPreviousQueries',
					items : [
					         {
                        text: '重命名', handler: function () {//<SIAT_zh_CN original="Rename">重命名</SIAT_zh_CN>
					        	 alert('rename!');
					        	 }
					         }
					         ,
					         {
                        text: '删除', handler: function () {//<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>
					        	 alert('delete!');
					        	 }
					         }
					         ,
					         {
                        text: '查询总结', handler: function () {//<SIAT_zh_CN original="Query Summary">查询总结</SIAT_zh_CN>
					        	 showQuerySummaryWindow(eventNode);
					        	 }
					         }
					         ]
				}
		);
	}
	var xy = event.getXY();
	this.contextMenuPreviousQueries.showAt(xy);
	return false;
}

function showNode(key){
	GLOBAL.PathToExpand=key;
	setActiveTab();
	var rootNode = ontTabPanel.getActiveTab().getRootNode();
	drillDown(rootNode);
}

function drillDown(rootNode){
	for (var i=0; i<rootNode.childNodes.length; i++){
		if(GLOBAL.PathToExpand.indexOf(rootNode.childNodes[i].id)>-1){
			rootNode.childNodes[i].expand();
			rootNode.childNodes[i].ensureVisible();
			drillDown(rootNode.childNodes[i]);
		}
	}
}

function showConceptInfoDialog(conceptKey, conceptid, conceptcomment) {

    if (!this.conceptinfowin) {
		var link = '<a href="javascript:;"  onclick="return popitup(\'http://www.google.com/search?q='+conceptid+'\')">搜索以获取更多信息...</a>'//<SIAT_zh_CN original="Search for more information">搜索以获取更多信息</SIAT_zh_CN>
		conceptinfowin = new Ext.Window(
				{
					id : 'showConceptInfoWindow',
					title : '显示概念定义-' + conceptid,//<SIAT_zh_CN original="Show Concept Definition">显示概念定义</SIAT_zh_CN>
					layout : 'fit',
					width : 600,
					height : 500,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					autoScroll: true,
					buttons : [
            {
					        	   text : '关闭',//<SIAT_zh_CN original="Close">关闭</SIAT_zh_CN>
                        handler: function () {
					        	   conceptinfowin.hide();
					        	   }
					           }
					           ],
					           resizable : false
				}
		);
	}

	conceptinfowin.show(viewport);
	conceptinfowin.header.update("显示概念定义-" + conceptid);//<SIAT_zh_CN original="Show Concept Definition">显示概念定义</SIAT_zh_CN>
	Ext.get(conceptinfowin.body.id).update(conceptcomment);

		conceptinfowin.load({
			url: pageInfo.basePath+"/ontology/showConceptDefinition",
			params: {conceptKey:conceptKey}, // or a URL encoded string		
			discardUrl: true,
			nocache: true,
			text: "正在加载...",//<SIAT_zh_CN original="Loading">正在加载</SIAT_zh_CN>
			timeout: 30000,
			scripts: false
		});


}

function showQuerySummaryWindow(source) {
    if (!this.querysummarywin) {

		querysummarywin = new Ext.Window(
				{
					id : 'showQuerySummaryWindow',
					title : '查询总结',//<SIAT_zh_CN original="Query Summary">查询总结</SIAT_zh_CN>
					layout : 'fit',
                width: 500,
					height : 500,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					buttons : [
					           {
					        	   text : '完成',//<SIAT_zh_CN original="Done">完成</SIAT_zh_CN>
                        handler: function () {
					        	   querysummarywin.hide();
					        	   }
					           }
					           ],
                resizable: false
				}
		);

		querySummaryPanel = new Ext.Panel(
				{
					id : 'querySummaryPanel',
					region : 'center'
				}
		);
		querysummarywin.add(querySummaryPanel);
	}
	querysummarywin.show(viewport);
	var fakehtml = "<div style='padding:10px;font:12pt arial;width:100%;height:100%;'>\
		< b > 条件 1 < / b > < br > \
		试验\\CT0145T03 < br > \
		< b > 且 < br > \
		条件 2 < / b > < br > \
		性别\\女性 < br > \
		< b > 或 < / b > < br > \
		试验\\CT0145T03\\RBM\\调整值\\IL - 13 - & gt;\
		.75 < br > "//<SIAT_zh_CN original="Criteria">条件</SIAT_zh_CN>
		//<SIAT_zh_CN original="Trials">试验</SIAT_zh_CN>//<SIAT_zh_CN original="AND">且</SIAT_zh_CN>
		//<SIAT_zh_CN original="Criteria">条件</SIAT_zh_CN>//<SIAT_zh_CN original="Sex">性别</SIAT_zh_CN>
		//<SIAT_zh_CN original="Female">女性</SIAT_zh_CN>//<SIAT_zh_CN original="OR">或</SIAT_zh_CN>
		//<SIAT_zh_CN original="Trials">试验</SIAT_zh_CN>//<SIAT_zh_CN original="Adjusted Values">调整值</SIAT_zh_CN>

		var q1 = getQuerySummary(1);
		var q2 = getQuerySummary(2);
    querySummaryPanel.body.update('<table border="1" height="100%" width="100%"><tr><td width="50%" valign="top" style="padding:10px;"><h2>Subset 1 Criteria</h2>' + q1 + '</td><td valign="top" style="padding:10px;"><h2>Subset 2 Criteria</h2>' + q2 + '</td></tr></table>');
}


function showConceptSearchPopUp(conceptid) {
	popitup('http://www.google.com/search?q=' + conceptid)
}
function popitup(url) {
	newwindow = window.open(url, 'name', 'height=500,width=500,toolbar=yes,scrollbars=yes, resizable=yes,');
    if (window.focus) {
		newwindow.focus()
	}
	return false;
}

function showExportStepSplitTimeSeries() {

    if (!this.exportStepSplitTimeSeries) {
		exportStepSplitTimeSeries = new Ext.Window(
				{
					id : 'exportStepSplitTimeSeriesWindow',
					title : '导出-分段时间序列',//<SIAT_zh_CN original="Export-Split Time Series">导出-分段时间序列</SIAT_zh_CN>
					layout : 'fit',
					width : 400,
					height : 200,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					buttons : [
					           {
					        	   id : 'exportStepSplitTimeSeriesNextButton',
					        	   text : '下一步>',//<SIAT_zh_CN original="Next">下一步</SIAT_zh_CN>
					        	   disabled : true,
                        handler: function () {
					        	   exportStepSplitTimeSeries.hide();
					        	   showExportStepDataSelection();
					        	   }
					           }
					           ,
					           {
					        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
                        handler: function () {
					        	   exportStepSplitTimeSeries.hide();
					        	   }
					           }
					           ],
					           resizable : false ,
                autoLoad: {
					url : pageInfo.basePath+'/panels/exportStepSplitTimeSeries.html',
					scripts : true,
					nocache : true,
					discardUrl : true,
					method : 'POST'
					           }
				}
		);
	}

	exportStepSplitTimeSeries.show(viewport);
}

function showExportStepDataSelection() {
    if (!this.exportStepDataSelection) {
		exportStepDataSelection = new Ext.Window(
				{
					id : 'exportStepDataSelectionWindow',
					title : '导出-数据选择',//<SIAT_zh_CN original="Export-Data Selection">导出-数据选择</SIAT_zh_CN>
					layout : 'fit',
					width : 400,
					height : 400,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					buttons : [
					           {
					        	   id : 'exportStepDataSelectionAdvancedButton',
					        	   text : '高级',//<SIAT_zh_CN original="Advanced">高级</SIAT_zh_CN>
                        handler: function () {
					        	   showExportDataSelectionAdvanced();
					        	   }
					           }
					           ,
					           {
					        	   id : 'exportStepDataSelectionNextButton',
					        	   text : '获取数据',//<SIAT_zh_CN original="Get Data">获取数据</SIAT_zh_CN>
					        	   disabled : true,
                        handler: function () {
					        	   getExportData();
					        	   }
					           }
					           ,
					           {
					        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
                        handler: function () {
					        	   exportStepDataSelection.hide();
					        	   }
					           }
					           ],
					           resizable : false,
                autoLoad: {
					url : pageInfo.basePath+'/panels/exportStepDataSelection.html',
					scripts : true,
					nocache : true,
					discardUrl : true,
					method : 'POST'
					           }
				}
		);
	}
	exportStepDataSelection.show(viewport);

}
function getExportData() {

	exportStepDataSelection.getEl().mask("获取数据...");//<SIAT_zh_CN original="Getting Data">获取数据</SIAT_zh_CN>
	setTimeout('exportDataFinished()', 2000)

}
function showExportStepProgress() {
    if (!this.exportStepProgress) {
		exportStepProgress = new Ext.Window(
				{
					id : 'exportStepProgress',
					title : '导出-下载文件',//<SIAT_zh_CN original="Export-Download File">导出-下载文件</SIAT_zh_CN>
					layout : 'fit',
					html : '<br><div style="font:12pt arial;width:100%;height:100%;text-align:center;vertical-align:middle"><a href="export/export.xls">下载文件</a></div>',//<SIAT_zh_CN original="Download File">下载文件</SIAT_zh_CN>
					width : 400,
					height : 200,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					buttons : [
					           {
					        	   text : '完成',//<SIAT_zh_CN original="Done">完成</SIAT_zh_CN>
                        handler: function () {
					        	   exportStepProgress.hide();
					        	   }
					           }
					           ],
					           resizable : false
				}
		);
	}
	exportStepProgress.show(viewport);

}
function exportDataFinished() {
	exportStepDataSelection.getEl().unmask();
	exportStepDataSelection.hide();
	showExportStepProgress();
}

function runAllQueries(callback, panel) {

    if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
        if (panel) {
            panel.body.unmask();
		}

		Ext.Msg.alert('Hello');

		Ext.Msg.alert('子集为空', '所有子集均为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集均为空。请选择子集。</SIAT_zh_CN>
	}

	// setup the number of subsets that need running
	var subsetstorun = 0;
    for (var i = 1; i <= GLOBAL.NumOfSubsets; i++) {
        if (!isSubsetEmpty(i)) {
			subsetstorun ++ ;
		}
	}

    /* set the number of requests before callback is fired for runquery complete */
	STATE.QueryRequestCounter = subsetstorun;

    // init panel's subset query array if it's not existing yet
    if (panel) {
        panel.subsetQueries = panel.subsetQueries ? panel.subsetQueries : ["", "", ""];
    }

	// iterate through all subsets calling the ones that need to be run
    for (var i = 1; i <= GLOBAL.NumOfSubsets; i++) {
        if (!isSubsetEmpty(i)) {
            if (panel) {
                panel.subsetQueries[i] = getSubsetQuery(i); // set subset queries to the selected tab
            }
			runQuery(i, callback);
		}
	}
}


/**
 * Get subset query that represent user's cohort selections
 * @param subsetId
 * @returns {string}
 */
function getSubsetQuery (subsetId) {
    var _query = "";
    for (var i = 1; i <= GLOBAL.NumOfQueryCriteriaGroups; i++) {
        var qcd = Ext.get("queryCriteriaDiv" + subsetId + '_' + i.toString());
        if(qcd.dom.childNodes.length>0) {
            _query += getCRCRequestPanel(qcd.dom, i);
        }
    }

    return _query;
}

/**
 * Check if there're any changes in both subsets
 * @returns {boolean}
 */
function isSubsetQueriesChanged (referenceQueries) {
    var retVal = false;

    for (var i = 1; i <= GLOBAL.NumOfSubsets; i++) {

        // get fresh subset query
        var _newQuery = getSubsetQuery(i);

        if (referenceQueries) {
            // check if reference query is the same as the new query
            // return true if it's changed.
            retVal = referenceQueries[i] != _newQuery ? true : false;
        }

        if (retVal) break;
    }
    return retVal;
}

function runQuery(subset, callback) {
    if (Ext.get('analysisPanelSubset1') == null) {
        // analysisPanel.body.update("<table border='1' width='100%' height='100%'><tr><td width='50%'><div id='analysisPanelSubset1'></div></td><td><div id='analysisPanelSubset2'></div></td></tr>");
    }

    var query = getCRCQueryRequest(subset);

    // first subset
    queryPanel.el.mask('正在获取子集 ' + subset + '...', 'x-mask-loading');//<SIAT_zh_CN original="Getting subset">正在获取子集</SIAT_zh_CN>
    Ext.Ajax.request(
        {
            url: pageInfo.basePath + "/queryTool/runQueryFromDefinition",
            method: 'POST',
            xmlData: query,
            success: function (result, request) {
                runQueryComplete(result, subset, callback);
            },
            failure: function (result, request) {
                runQueryComplete(result, subset, callback);
            },
            timeout: '600000'
        }
    );

    if (GLOBAL.Debug) {
        resultsPanel.setBody("<div style='height:400px;width500px;overflow:auto;'>" + Ext.util.Format.htmlEncode(query) + "</div>");
    }
}

function runQueryComplete(result, subset, callback) {
    var jsonRes = JSON.parse(result.responseText);
    var error;

    if (result.status != 200) {
        error = jsonRes.message;
    } else if (jsonRes.errorMessage !== null) {
        error = jsonRes.errorMessage;
    }

    queryPanel.el.unmask();

    if (error) {
        Ext.Msg.show(
            {
                title: '生成患者集错误',//<SIAT_zh_CN original="Error generating patient set">生成患者集错误</SIAT_zh_CN>
                msg: error,
                buttons: Ext.Msg.OK,
                fn: function () {
                    Ext.Msg.hide();
                },
                icon: Ext.MessageBox.ERROR
            }
        );
    }

    // Current code requires us to set CurrentSubsetIDs regardless of error status...
    GLOBAL.CurrentSubsetIDs[subset] = jsonRes.id ? jsonRes.id : -1;

    // Save query to global variable
    GLOBAL.CurrentSubsetQueries[subset] = getSubsetQuery(subset);

    if (subset === null) { // if single subset

        callback(GLOBAL.CurrentSubsetIDs[subset]);

    } else {

        // getPDO_fromInputList is not implemented in core-db
        //if (GLOBAL.Debug) {
        //    alert(getCRCpdoRequest(patientsetid, 1, jsonRes.setSize));
        //}

        /* removed the pdo request call 12 / 17 / 2008 added the callback logic here instead */
        // runQueryPDO(patientsetid, 1, jsonRes.setSize, subset, callback );

        if (STATE.QueryRequestCounter > 0) { // I'm in a chain of requests so decrement
            STATE.QueryRequestCounter = --STATE.QueryRequestCounter;
        }
        if (STATE.QueryRequestCounter == 0) {
            callback();
        }
        /* I'm the last request outstanding in this chain*/
    }
}


function runQueryPDO(patientsetid, minpatient, maxpatient, subset, callback) {
    var query = getCRCpdoRequest(patientsetid, minpatient, maxpatient, subset)
    queryPanel.el.mask('正在获取患者集 ' + subset + '...', 'x-mask-loading');//<SIAT_zh_CN original="Getting patient set">正在获取患者集</SIAT_zh_CN>
    Ext.Ajax.request(
        {
            url: pageInfo.basePath + "/proxy?url=" + GLOBAL.CRCUrl + "pdorequest",
            method: 'POST',
            xmlData: query,
            success: function (result, request) {
                runQueryPDOComplete(result, subset, callback);
            },
            failure: function (result, request) {
                runQueryPDOComplete(result, subset, callback);
            },
            timeout: '600000'
        }
    );

}

function runQueryPDOComplete(result, subset, callback) {
    if (GLOBAL.Debug) {
        alert(result.responseText)
    }
    ;
    queryPanel.el.unmask();
    var doc = result.responseXML;
    doc.setProperty("SelectionLanguage", "XPath");
    doc.setProperty("SelectionNamespaces", "xmlns:ns2='http://www.i2b2.org/xsd/hive/pdo/1.1/'");
    var patientset = result.responseXML.selectSingleNode("//ns2:patient_set");
    if (patientset == undefined) {
        patientset = result.responseXML.selectSingleNode("//patient_set");
    }
    if (patientset == null) {
        return
    }
    ;
    createStatistics(patientset, subset);
    if (STATE.QueryRequestCounter > 0) // I'm in a chain of requests so decrement
    {
        STATE.QueryRequestCounter = --STATE.QueryRequestCounter;
    }
    if (STATE.QueryRequestCounter == 0) {
        callback();
    }
    /* I'm the last request outstanding in this chain*/
    if (GLOBAL.Debug) {
        resultsPanel.setBody(resultsPanel.getBody() + "<div style='height:200px;width500px;overflow:auto;'>" + Ext.util.Format.htmlEncode(result.responseText) + "</div>");
    }
}

// takes a patientset node
function createStatistics(patientset, subset) {
	var totalpatients = 0;
	var totalmale = 0;
	var totalfemale = 0;
	var total0to9 = 0;
	var total10to17 = 0;
	var total18to34 = 0;
	var total35to44 = 0;
	var total45to54 = 0;
	var total55to64 = 0;
	var total65to74 = 0;
	var total75to84 = 0;
	var totalgreaterthan84 = 0;
	var totalunrecorded = 0;
	var patients = patientset.selectNodes('patient');
	for(var p = 0; p < patients.length; p ++ ) // iterate every patient
	{
		var patient = patients[p];
		var params = patient.selectNodes('param');
        for (var n = 0; n < params.length; n++) {
			var param = params[n];
			var paramname = param.getAttribute("name");
			var paramvalue;
            if (param.firstChild) {
				paramvalue = param.firstChild.nodeValue;
			}
            else {
				paramvalue = null;
			}

			// do something with this param
			// if its a sex add it to the sex variables
            if (paramname == "sex_cd") {
				if(paramvalue == "M")
					totalmale ++ ;
				if(paramvalue == "F")
					totalfemale ++ ;
			}
			// do something with it if its an age
            if (paramname == "age_in_years_num") {
                if (paramvalue >= 0 && paramvalue <= 9) {
					total0to9 ++ ;
				}
                if (paramvalue >= 10 && paramvalue <= 17) {
					total10to17 ++ ;
				}
                if (paramvalue >= 18 && paramvalue <= 34) {
					total18to34 ++ ;
				}
                if (paramvalue >= 35 && paramvalue <= 44) {
					total35to44 ++ ;
				}
                if (paramvalue >= 45 && paramvalue <= 54) {
					total45to54 ++ ;
				}
                if (paramvalue >= 55 && paramvalue <= 64) {
					total55to64 ++ ;
				}
                if (paramvalue >= 65 && paramvalue <= 74) {
					total65to74 ++ ;
				}
                if (paramvalue >= 75 && paramvalue <= 84) {
					total75to84 ++ ;
				}
                if (paramvalue > 84) {
					totalgreaterthan84 ++ ;
				}
			}
		}
		// close param loop
	}
	// close patient loop

	// make sex table
	var statisticshtml = "<table><tr><td><table border='1' class='demoTable' style='border:1px solid black;margin:5px;'>\
		< tr align = 'center' > < td colspan = '2' > < b > 性别分布 < / b > < / td > < / tr > \
		< tr align = 'center' > < th > 男性 < / th > < th > 女性 < / th > < / tr > \
		< tr align = 'center' > < td > "+totalmale+" < / td > < td > "+totalfemale+" < / td > < / tr > < / table > < / td > ";
		// make age table//<SIAT_zh_CN original="Sex distribution">性别分布</SIAT_zh_CN>//<SIAT_zh_CN original="Males">男性</SIAT_zh_CN>//<SIAT_zh_CN original="Females">女性</SIAT_zh_CN>
		statisticshtml = statisticshtml + "<td><table border='1' class='demoTable' style='border:1px solid black;margin:5px'><tr align='center'><td colspan='9'><b>年龄分布</b></td></tr>\
		< tr align = 'center' > < th > 0 - 9 < / th > < th > 10 - 17 < / th > < th > 18 - 34 < / th > < th > 35 - 44 < / th > < th > 45 - 54 < / th > < th > 55 - 64 < / th > < th > 65 - 74 < / th > < th > 75 - 84 < / th > < th > & gt;\
		84 < / th > < / tr > \
		< tr align = 'center' > < td > "+total0to9+" < / td > < td > "+total10to17+" < / td > < td > "+total18to34+" < / td > < td > "+total35to44+" < / td > < td > "+total45to54+" < / td > < td > "+total55to64+" < / td > < td > "+total65to74+" < / td > < td > "+total75to84+" < / td > < td > "+totalgreaterthan84+" < / td > < / tr > \
		< / table > < / td > < / tr > < / table > < br / > ";//<SIAT_zh_CN original="Age distribution">年龄分布</SIAT_zh_CN>
		// analysisPanel.body.insertHtml("beforeEnd", statisticshtml);
		Ext.get("analysisPanelSubset" + subset).insertHtml("beforeEnd", statisticshtml);
		// analysisPanel.body.update(statisticshtml);
}
function getNodeForAnalysis(node) {
	// if im a value leaf return me
    if (node.attributes.oktousevalues == "Y" && node.attributes.leaf == true) {
		return node;
	}
	// if im a concept leaf then recurse with my parent node
    else if (node.attributes.oktousevalues != "Y" && node.attributes.leaf == true) {
		return getNodeForAnalysis(node.parentNode);
	}
    else {
		return node
	}
	// must be a concept folder so return me
}


function buildAnalysis(nodein) {
	var node = nodein // getNodeForAnalysis(nodein);
    if (isSubsetEmpty(1) && isSubsetEmpty(2)) {
		alert('检测到空子集，分析需要一个有效的子集！');//<SIAT_zh_CN original="Empty subsets found, need a valid subset to analyze!">检测到空子集，分析需要一个有效的子集！</SIAT_zh_CN>
		return;
	}


    if ((GLOBAL.CurrentSubsetIDs[1] == null && !isSubsetEmpty(1)) || (GLOBAL.CurrentSubsetIDs[2] == null && !isSubsetEmpty(2))) {
        runAllQueries(function () {
			buildAnalysis(node);
				}
		);
		return;
	}

    resultsTabPanel.body.mask("运行分析...", 'x-mask-loading');//<SIAT_zh_CN original="Running analysis">运行分析</SIAT_zh_CN>

	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/chart/analysis",
				method : 'POST',
				timeout: '600000',
				params :  Ext.urlEncode(
						{
							charttype : "analysis",
							concept_key : node.attributes.id,
							result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
							result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
						}
				), // or a URL encoded string
            success: function (result, request) {
				buildAnalysisComplete(result);
                resultsTabPanel.body.unmask();
            },
            failure: function (result, request) {
				buildAnalysisComplete(result);
			}
			}
	);
	getAnalysisGridData(node.attributes.id);
}

function buildAnalysisComplete(result) {
	// analysisPanel.body.unmask();
	var txt = result.responseText;
	updateAnalysisPanel(txt, true);
}

function updateAnalysisPanel(html, insert) {
    if (insert) {
		var body = analysisPanel.body;
		body.insertHtml('afterBegin', html, false);
		body.scrollTo('top', 0, false);
	}
    else {
		analysisPanel.body.update(html, false, null);
	}
}

function searchByNameComplete(response) {
	// shorthand
	var length;
	var Tree = Ext.tree;
	searchByNameTree.el.unmask();
	var allkeys="";
	var concepts = response.responseXML.selectNodes('//concept');
    if (concepts != undefined) {
        if (concepts.length < GLOBAL.MaxSearchResults) {
			length = concepts.length;
		}
        else {
			length = GLOBAL.MaxSearchResults;
		}
        for (var c = 0; c < length; c++) {
			searchByNameTreeRoot.appendChild(getTreeNodeFromXMLNode(concepts[c]));
			var key=concepts[c].selectSingleNode('key').firstChild.nodeValue;
            if (allkeys != "") {
				allkeys=allkeys+",";
			}
			allkeys=allkeys+key;
		}
	}
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/ontology/sectest",
				method : 'POST',
            success: function (result, request) {
            },
            failure: function (result, request) {
            },
			timeout : '300000',
			params : Ext.urlEncode(
					{
						keys: allkeys
					}
			) // or a URL encoded string
			}
	);
}


function enterWasPressed(e) {
	var pK;
    if (e.which) {
		pK = e.which;
	}
    if (pK == undefined && window.event) {
		pK = window.event.keyCode;
	}
    if (pK == undefined && e.getCharCode) {
		pK = e.getCharCode();
	}
    if (pK == 13) {
		return true;
	}
	else return false;
}

function contextMenuPressed(e) {
	var x = e;
	e.stopEvent();
	return false;
}

function getSelected(opt) {
	var selected = new Array();
	var index = 0;
	for (var intLoop = 0; intLoop < opt.length;
         intLoop++) {
		if ((opt[intLoop].selected) ||
            (opt[intLoop].checked)) {
			index = selected.length;
			selected[index] = new Object;
			selected[index].value = opt[intLoop].value;
			selected[index].index = intLoop;
		}
	}
	return selected;
}

function outputSelected(opt) {
	var sel = getSelected(opt);
	var strSel = "";
	for (var intLoop = 0; intLoop < sel.length;
         intLoop++) {
		strSel += sel[intLoop].value + "\n";
	}
	alert("已选择的项:\n" + strSel);//<SIAT_zh_CN original="Selected Items">已选择的项</SIAT_zh_CN>
}

/** 
 * Function to run the survival analysis asynchronously
 */
function showSurvivalAnalysis() {	
    if ((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) || (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showSurvivalAnalysis);
		return;
	}
	
	Ext.Ajax.request({						
		url: pageInfo.basePath+"/asyncJob/createnewjob",
		method: 'POST',
		success: function(result, request){
			RunSurvivalAnalysis(result, GLOBAL.CurrentSubsetIDs[1], GLOBAL.CurrentSubsetIDs[2],
					getQuerySummary(1), getQuerySummary(2));
		},
		failure: function(result, request){
			Ext.Msg.alert('状态', '无法创建heatmap工作.');//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>//<SIAT_zh_CN original="Unable to create the heatmap job.">无法创建heatmap工作</SIAT_zh_CN>
		},
		timeout: '1800000',
		params: {jobType:  "Survival"}
	});
}

function genePatternReplacement() {
	Ext.Msg.alert('正在执行的工作', '基因模式替换')//<SIAT_zh_CN original="Work In Progress">正在执行的工作</SIAT_zh_CN>//<SIAT_zh_CN original="Gene Pattern replacement">基因模式替换</SIAT_zh_CN>
}

//Once, we get a job created by GPController, we run the survival analysis
function RunSurvivalAnalysis(result, result_instance_id1, result_instance_id2, querySummary1, querySummary2) {
	var jobNameInfo = Ext.util.JSON.decode(result.responseText);					 
	var jobName = jobNameInfo.jobName;

	genePatternReplacement();
	showJobStatusWindow(result);	
	document.getElementById("gplogin").src = pageInfo.basePath + '/analysis/gplogin';   // log into GenePattern
	Ext.Ajax.request(
		{						
			url: pageInfo.basePath+"/genePattern/runsurvivalanalysis",
			method: 'POST',
			timeout: '1800000',
			params: {result_instance_id1: result_instance_id1,
				result_instance_id2:  result_instance_id2,
				querySummary1: querySummary1,
				querySummary2: querySummary2,
				jobName: jobName
			}
	});
	checkJobStatus(jobName);
}

function showSNPViewerSelection() {
	
	if((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) ||
        (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showSNPViewerSelection);
		return;
	}

	//genePatternReplacement();
	var win = new Ext.Window({
		id: 'showSNPViewerSelection',
		title: 'SNPViewer',//<SIAT_zh_CN original="SNPViewer">SNPViewer</SIAT_zh_CN>
		layout:'fit',
		width:600,
		height:400,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		          {
		        	  id: 'showSNPViewerSelectionOKButton',
		        	  text: '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
		        	  handler: function(){
                    if (Ext.get('snpViewChroms') == null) {
		        		  win.close();
		        		  return;
		        	  }
		        	  var ob=Ext.get('snpViewChroms').dom;
		        	  var selected = new Array();
		        	  for (var i = 0; i < ob.options.length; i++)
		        		  if (ob.options[i].selected)
		        			  selected.push(ob.options[i].value);
		        	  GLOBAL.CurrentChroms=selected.join(',');
		        	  getSNPViewer();
                    win.close();
		          }
            }
            ,
            {
		        	  text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
		        	  handler: function(){
                    win.close();
                }
            }
        ],
		resizable: false,
		autoLoad: {
			url: pageInfo.basePath+'/analysis/showSNPViewerSelection',
			scripts: true,
			nocache:true,
			discardUrl:true,
			method:'POST',
			params: {result_instance_id1: GLOBAL.CurrentSubsetIDs[1],
				result_instance_id2: GLOBAL.CurrentSubsetIDs[2]}
		},
        tools: [
            {
			id:'help',
			qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
		    handler: function(event, toolEl, panel){
		   	D2H_ShowHelp("1360",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
            }
        ]
	});
	//  }
	win.show(viewport);
}

function getSNPViewer() {

	// before Ajax call, log into genepattern:
	genePatternLogin();
	var selectedGenesElt = Ext.get("selectedGenesSNPViewer");
	var selectedGenesEltValue = selectedGenesElt.dom.value;
	var selectedGeneStr = "";
	if (selectedGenesEltValue && selectedGenesEltValue.length != 0) {
		selectedGeneStr = selectedGenesEltValue;
	}
	
	var geneAndIdListElt = Ext.get("selectedGenesAndIdSNPViewer");
	var geneAndIdListEltValue = geneAndIdListElt.dom.value;
	var geneAndIdListStr = "";
	if (geneAndIdListElt && geneAndIdListEltValue.length != 0) {
		geneAndIdListStr = geneAndIdListEltValue;
	}
	
	var selectedSNPsElt = Ext.get("selectedSNPs");
	var selectedSNPsEltValue = selectedSNPsElt.dom.value;
	var selectedSNPsStr = "";
	if (selectedSNPsElt && selectedSNPsEltValue.length != 0) {
		selectedSNPsStr = selectedSNPsEltValue;
	}
	//genePatternReplacement();
	Ext.Ajax.request(
	{
		url: pageInfo.basePath+"/analysis/showSNPViewer",
		method: 'POST',
		success: function(result, request){
			//getSNPViewerComplete(result);
		},
		failure: function(result, request){
			//getSNPViewerComplete(result);
		},
		timeout: '1800000',
		params: { result_instance_id1:  GLOBAL.CurrentSubsetIDs[1],
			result_instance_id2:  GLOBAL.CurrentSubsetIDs[2],
			chroms: GLOBAL.CurrentChroms,
			genes: selectedGeneStr,
			geneAndIdList: geneAndIdListStr,
			snps: selectedSNPsStr}
	});
	
	showWorkflowStatusWindow();
}

function showIgvSelection() {
	
	if((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) ||
        (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showIgvSelection);
		return;
	}

	//genePatternReplacement();
	var win = new Ext.Window({
	id: 'showIgvSelection',
		title: 'IGV',//<SIAT_zh_CN original="IGV">IGV</SIAT_zh_CN>
		layout:'fit',
		width:600,
		height:400,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		          {
		        	  id: 'showIgvSelectionOKButton',
		        	  text: '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
		        	  handler: function(){
                    if (Ext.get('igvChroms') == null) {
		        		  win.close();
		        		  return;
		        	  }
		        	  var ob=Ext.get('igvChroms').dom;
		        	  var selected = new Array();
		        	  for (var i = 0; i < ob.options.length; i++)
		        		  if (ob.options[i].selected)
		        			  selected.push(ob.options[i].value);
		        	  GLOBAL.CurrentChroms=selected.join(',');
		        	  getIgv();
                    win.close();
		          }
            }
            ,
            {
		        	  text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
		        	  handler: function(){
                    win.close();
                }
            }
        ],
		resizable: false,
		autoLoad: {
			url: pageInfo.basePath+'/analysis/showIgvSelection',
			scripts: true,
			nocache:true,
			discardUrl:true,
			method:'POST',
			params: {result_instance_id1: GLOBAL.CurrentSubsetIDs[1],
				result_instance_id2: GLOBAL.CurrentSubsetIDs[2]}
		},
        tools: [
            {
			id:'help',
			qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
		    handler: function(event, toolEl, panel){
		   	D2H_ShowHelp("1427",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
            }
        ]
	});
	//  }
	win.show(viewport);
}

function getIgv() {

	// before Ajax call, log into genepattern:
	genePatternLogin();
	var selectedGenesElt = Ext.get("selectedGenesIgv");
	var selectedGenesEltValue = selectedGenesElt.dom.value;
	var selectedGeneStr = "";
	if (selectedGenesEltValue && selectedGenesEltValue.length != 0) {
		selectedGeneStr = selectedGenesEltValue;
	}
	
	var geneAndIdListElt = Ext.get("selectedGenesAndIdIgv");
	var geneAndIdListEltValue = geneAndIdListElt.dom.value;
	var geneAndIdListStr = "";
	if (geneAndIdListElt && geneAndIdListEltValue.length != 0) {
		geneAndIdListStr = geneAndIdListEltValue;
	}
	
	var selectedSNPsElt = Ext.get("selectedSNPsIgv");
	var selectedSNPsEltValue = selectedSNPsElt.dom.value;
	var selectedSNPsStr = "";
	if (selectedSNPsElt && selectedSNPsEltValue.length != 0) {
		selectedSNPsStr = selectedSNPsEltValue;
	}
	
	Ext.Ajax.request(
	{
		url: pageInfo.basePath+"/analysis/showIgv",
		method: 'POST',
		success: function(result, request){
			//getSNPViewerComplete(result);
		},
		failure: function(result, request){
			//getSNPViewerComplete(result);
		},
		timeout: '1800000',
		params: { result_instance_id1:  GLOBAL.CurrentSubsetIDs[1],
			result_instance_id2:  GLOBAL.CurrentSubsetIDs[2],
			chroms: GLOBAL.CurrentChroms,
			genes: selectedGeneStr,
			geneAndIdList: geneAndIdListStr,
			snps: selectedSNPsStr}
	});
	
	showWorkflowStatusWindow();
}


function showPlinkSelection() {
	
	if((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) ||
        (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showIgvSelection);
		return;
	}

	//genePatternReplacement();
	var win = new Ext.Window({
		id: 'showPlinkSelection',
		title: 'PLINK',//<SIAT_zh_CN original="PLINK">PLINK</SIAT_zh_CN>
		layout:'fit',
		width:450,
		height:400,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		          {
		        	  id: 'showPlinkSelectionOKButton',
		        	  text: '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
		        	  handler: function(){
                    if (Ext.get('plinkChroms') == null) {
		        		  win.close();
		        		  return;
		        	  }
		        	  var ob=Ext.get('plinkChroms').dom;
		        	  var selected = new Array();
		        	  for (var i = 0; i < ob.options.length; i++)
		        		  if (ob.options[i].selected)
		        			  selected.push(ob.options[i].value);
		        	  GLOBAL.CurrentChroms=selected.join(',');
		        	  getPlink();
                    win.close();
		          }
            }
            ,
            {
		        	  text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
		        	  handler: function(){
                    win.close();
                }
            }
        ],
		resizable: false,
		autoLoad: {
			url: pageInfo.basePath+'/analysis/showPlinkSelection',
			scripts: true,
			nocache:true,
			discardUrl:true,
			method:'POST',
			params: {result_instance_id1: GLOBAL.CurrentSubsetIDs[1],
				result_instance_id2: GLOBAL.CurrentSubsetIDs[2]}
		},
        tools: [
            {
			id:'help',
			qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
		    handler: function(event, toolEl, panel){
		    // 1360 needs to be changed for PLINK
		   	D2H_ShowHelp("1360",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
            }
        ]
	});
	//  }
	win.show(viewport);
}


function getPlink() {
}

function showGwasSelection() {
	
	if((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) ||
        (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showGwasSelection);
		return;
	}

	//genePatternReplacement();
	var win = new Ext.Window({
		id: 'showGwasSelection',
		title: '全基因组关联分析',//<SIAT_zh_CN original="Genome-Wide Association Study">全基因组关联分析</SIAT_zh_CN>
		layout:'fit',
		width:600,
		height:400,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		          {
		        	  id: 'showGwasSelectionOKButton',
		        	  text: '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
		        	  handler: function(){
                    if (Ext.get('gwasChroms') == null) {
		        		  win.close();
		        		  return;
		        	  }
		        	  var ob=Ext.get('gwasChroms').dom;
		        	  var selected = new Array();
		        	  for (var i = 0; i < ob.options.length; i++)
		        		  if (ob.options[i].selected)
		        			  selected.push(ob.options[i].value);
		        	  GLOBAL.CurrentChroms=selected.join(',');
		        	  showGwas();
                    win.close();
		          }
            }
            ,
            {
		        	  text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
		        	  handler: function(){
                    win.close();
                }
            }
        ],
		resizable: false,
		autoLoad: {
			url: pageInfo.basePath+'/genePattern/showGwasSelection',
			scripts: true,
			nocache:true,
			discardUrl:true,
			method:'POST',
			params: {result_instance_id1: GLOBAL.CurrentSubsetIDs[1],
				result_instance_id2: GLOBAL.CurrentSubsetIDs[2]}
		},
        tools: [
            {
			id:'help',
			qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
		    handler: function(event, toolEl, panel){
		    // 1360 needs to be changed for PLINK
		   	D2H_ShowHelp("1360",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
            }
        ]
	});
	//  }
	win.show(viewport);
}

/** 
 * Function to run the GWAS asynchronously
 */
function showGwas() {	
    if ((!isSubsetEmpty(1) && GLOBAL.CurrentSubsetIDs[1] == null) || (!isSubsetEmpty(2) && GLOBAL.CurrentSubsetIDs[2] == null)) {
		runAllQueries(showGwas);
		return;
	}
	
	genePatternReplacement();
}

// After we get a job created by GPController, we run GWAS
function runGwas(result, result_instance_id1, result_instance_id2, querySummary1, querySummary2) {
	var jobNameInfo = Ext.util.JSON.decode(result.responseText);					 
	var jobName = jobNameInfo.jobName;

	genePatternReplacement();
}

function validateheatmapComplete(result) {
	var mobj=result.responseText.evalJSON();
	GLOBAL.DefaultCohortInfo=mobj;

	showCompareStepPathwaySelection();

}

function compareSubsetsComplete(result, setname1, setname2) {
	viewport.el.unmask();
    if (!this.heatmapDisplay) {
		heatmapDisplay = new Ext.Window(
				{
					id : 'heatmapDisplayWindow',
					title : '热图(Heatmap)比较',//<SIAT_zh_CN original="Heatmap Comparison">热图(Heatmap)比较</SIAT_zh_CN>
					layout : 'fit',
					width : 800,
					height : 600,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					autoScroll : true,
					buttons : [
					           {
					        	   id : 'Done',
					        	   text : '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
                        handler: function () {
					        	   heatmapDisplay.hide();
					        	   }
					           }
					           ],
					           resizable : true,
					           html : '<div style="width:100%;height:100%;overflow:auto;"><div id="heatmapContainer"></div><br><div id="heatmapLegend"></div><div>'
				}
		);
	}
	heatmapDisplay.show(viewport);

	var data = jsonToDataTable(result.responseText);

	var container = heatmapDisplay.body.dom;
	heatmap = new org.systemsbiology.visualization.BioHeatMap(document.getElementById('heatmapContainer'));
	heatmap.draw(data,
			{
		cellHeight : 5, cellWidth : 5, fontHeight : 3
			}
	);
	var html = "s1=" + setname1 + "<br>s2=" + setname2;
	Ext.get("heatmapLegend").update(html);
}
function showNameQueryDialog() {
    if (!this.namequerywin) {
		namequerywin = new Ext.Window(
				{
					id : 'namequeryWindow',
					title : '查询命名',//<SIAT_zh_CN original="Name the Query">查询命名</SIAT_zh_CN>
					layout : 'fit',
					width : 500,
					height : 150,
					closable : false,
					plain : true,
					modal : true,
					border : false,
					buttons : [
					           {
					        	   text : '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
                        handler: function () {
					        	   var newvalue = Ext.get("nameQueryDialogInput").getValue();
					        	   // Ext.get("txtBoxQueryName").dom.value = newvalue;
					        	   GLOBAL.CurrentQueryName = newvalue;
					        	   runQuery2();
					        	   namequerywin.hide();
					        	   }
					           }
					           ,
					           {
					        	   text : '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
                        handler: function () {
					        	   namequerywin.hide();
					        	   }
					           }
					           ],
					           resizable : false,
					           html : '<br>Query Name:&nbsp<input id="nameQueryDialogInput" type="text" size="50">'
				}
		);
	}
	namequerywin.show(viewport);
	Ext.get("nameQueryDialogInput").dom.value = "";
	// clear out for next run
}

function jsonToDataTable(jsontext) {

	var table = eval("(" + jsontext + ")").table;
	var data = new google.visualization.DataTable();

	// convert to Google.DataTable
	// column
	for (var col = 0; col < table.cols.length;
         col++) {
		data.addColumn('string', table.cols[col].label);
	}
	// row
	for (var row = 0; row < table.rows.length;
         row++) {
		data.addRow();
		for (var col = 0; col < table.cols.length;
             col++) {
			data.setCell(row, col, table.rows[row][col].v);
		}
	}

	return data;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
// START: Advanced Heatmap Workflow methods
// Called from Run Workflow button in the Heatmap Validation window 
//////////////////////////////////////////////////////////////////////////////////////////////////////
// Once, we get a job created by GPController, we run the heatmap
function RunHeatMap(result, setid1, setid2, pathway, datatype, analysis, resulttype, nclusters, timepoints1, timepoints2, sample1, sample2, rbmPanels1, rbmPanels2) {
	var jobNameInfo = Ext.util.JSON.decode(result.responseText);					 
	var jobName = jobNameInfo.jobName;

	//genePatternReplacement();
	showJobStatusWindow(result);	
	genePatternLogin();
	Ext.Ajax.request(
		{						
			url: pageInfo.basePath+"/genePattern/runheatmap",
			method: 'POST',
			timeout: '1800000',
			params: {result_instance_id1:  setid1,
				result_instance_id2:  setid2,
				pathway_name:  pathway,
				datatype:  datatype,
				analysis:  analysis,
				resulttype: resulttype,
				nclusters: nclusters,
				timepoints1: timepoints1,
				timepoints2: timepoints2,
				sample1: sample1,
				sample2: sample2,
				rbmPanels1: rbmPanels1,
				rbmPanels2: rbmPanels2,
				jobName: jobName
			}
	});
	checkJobStatus(jobName);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//END: Advanced Heatmap Workflow methods
//////////////////////////////////////////////////////////////////////////////////////////////////////

// This is the new popup window for Survival Analysis. 
function showSurvivalAnalysisWindow(results)	{
	var resultWin = window.open('', 'Survival_Analysis_View_' + (new Date()).getTime(), 
		'width=600,height=800,scrollbars=yes,resizable=yes,location=no,toolbar=no,status=no,menubar=no,directories=no');
	resultWin.document.write(results);
}

//This is the new popup window for GWAS. 
function showGwasWindow(results)	{
	var resultWin = window.open('', 'Gwas_View_' + (new Date()).getTime());
	resultWin.document.write(results);
}

// This is the new popup window for the Haploview
function showHaploViewWindow(results)	{
	var win = new Ext.Window({
		id: 'showHaploView',
		title: 'Haploview',//<SIAT_zh_CN original="Haploview">Haploview</SIAT_zh_CN>
		layout:'fit',
		width:800,
		height:550,
		closable: true,
		plain: false,
		modal: false,
		border:true,
		maximizable:true,								
		resizable: true,
		html: results
	});
	win.show(viewport);						
}

function clearExportPanel() {
	// clear the div
	exportPanel.body.update("");
}

/**
 * @return {String} return the value of the radio button that is checked
 * return an empty string if none are checked, or
 * there are no radio buttons
 * @param {} radioObj
 */
function getCheckedValue(radioObj) {
	if( ! radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
    for (var i = 0; i < radioLength; i++) {
        if (radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

// set the radio button with the given value as being checked
//do nothing if there are no radio buttons
//if the given value does not exist, all the radio buttons
//are reset to unchecked
function setCheckedValue(radioObj, newValue) {
	if( ! radioObj)
		return;
	var radioLength = radioObj.length;
    if (radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
    for (var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
        if (radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}
function searchByName() {
	var matchstrategy = document.getElementById('searchByNameSelect').value;
	var matchterm = document.getElementById('searchByNameInput').value;
	var a=matchterm.trim();
    if (a.length < 3) {
		alert("请输入一个更长一些的搜索关键词");//<SIAT_zh_CN original="Please enter a longer search term">请输入一个更长一些的搜索关键词</SIAT_zh_CN>
		return;
	}
	var matchontology = document.getElementById('searchByNameSelectOntology').value;
	var query = getONTgetNameInfoRequest(matchstrategy, matchterm, matchontology);
	searchByNameTree.el.mask('正在搜索...', 'x-mask-loading');//<SIAT_zh_CN original="Searching">正在搜索</SIAT_zh_CN>
	for(c = searchByNameTreeRoot.childNodes.length - 1;
	c >= 0;
         c--) {
		searchByNameTreeRoot.childNodes[c].remove();
	}
	searchByNameTree.render();
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/proxy?url=" + GLOBAL.ONTUrl + "getNameInfo",
				method : 'POST',
				xmlData : query,
            success: function (result, request) {
				searchByNameComplete(result);
            },
            failure: function (result, request) {
				searchByNameComplete(result);
            },
			timeout : '300000'
			}
	);
}

function getSummaryStatistics() {
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/chart/basicStatistics",
				method : 'POST',
            success: function (result, request) {
				getSummaryStatisticsComplete(result);
                analysisPanel.body.unmask();
            },
            failure: function (result, request) {
                //getSummaryStatisticsComplete(result);
                console.error("无法获取统计总结");//<SIAT_zh_CN original="Cannot get Summary Statistics">无法获取统计总结</SIAT_zh_CN>
                analysisPanel.body.unmask();
            },
			timeout : '300000',
			params : Ext.urlEncode(
					{
						charttype : "basicstatistics",
						concept_key : "",
						result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
						result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
					}
			) // or a URL encoded string
			}
	);
}


function getSummaryStatisticsComplete(result, request) {
	resultsTabPanel.setActiveTab('analysisPanel');
	updateAnalysisPanel(result.responseText, false);
}


function getExportButtonSecurity() {
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/export/exportSecurityCheck",
				method : 'POST',
            success: function (result, request) {
				getExportButtonSecurityComplete(result);
            },
            failure: function (result, request) {
				getExportButtonSecurityComplete(result);
            },
			timeout : '300000',
			params : Ext.urlEncode(
					{
						result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
						result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
					}
			) // or a URL encoded string
			}
	);
}

function getExportButtonSecurityComplete(result) {
	var mobj=result.responseText.evalJSON();
	var canExport=mobj.canExport;
    if (canExport || GLOBAL.IsAdmin) {
		Ext.getCmp("exportbutton").enable();
	}
    else {
		Ext.getCmp("exportbutton").disable();
	}
}

function activateTab(tab) {
    resultsTabPanel.tools.help.dom.style.display = "none";
}

function getSummaryGridData() {

    resultsTabPanel.body.mask("正在加载 ..", 'x-mask-loading');//<SIAT_zh_CN original="Loading">正在加载</SIAT_zh_CN>

    if (!(GLOBAL.CurrentSubsetIDs[0]) && !(GLOBAL.CurrentSubsetIDs[1])) {
		Ext.Msg.alert('子集是不可用的.',
				'请选择一到两个比较子集，然后运行统计总结');//<SIAT_zh_CN original="Subsets are unavailable.">子集是不可用的</SIAT_zh_CN>
		//<SIAT_zh_CN original="Please select one or two Comparison subsets and run Summary Statistics.">请选择一到两个比较子集，然后运行统计总结</SIAT_zh_CN>
		resultsTabPanel.body.unmask();
		return;
	}

    gridstore = new Ext.data.JsonStore(
        {
            url : pageInfo.basePath+'/chart/analysisGrid',
            root : 'rows',
            fields : ['name', 'url']
        }
    );

    gridstore.on('load', storeLoaded);

    var myparams = Ext.urlEncode(
        {
            concept_key : "",
            result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
            result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
        }
    );

    gridstore.load({
        params: myparams,
        callback: function () {
            resultsTabPanel.body.unmask();
        }
    });

}

function storeLoaded() {

    var exportButton = new Ext.Button ({
        text:'导出至Excel',//<SIAT_zh_CN original="Export to Excel">导出至Excel</SIAT_zh_CN>
        listeners: {
            click: function () {
                window.location = 'data:application/vnd.ms-excel;base64,' +
                    Base64.encode(grid.getExcelXml());
            }
        }
    });

	var cm = buildColumnModel(gridstore.reader.meta.fields);

    grid = analysisGridPanel.getComponent('gridView');
    if (grid) {
		analysisGridPanel.remove(grid);
	}

    grid = new GridViewPanel({
        id: 'gridView',
        title: '网格视图',//<SIAT_zh_CN original="Grid View">网格视图</SIAT_zh_CN>
        viewConfig: {
            forceFit : true
        },
        bbar: new Ext.Toolbar({
            buttons: [exportButton]
        }),
        frame:true,
        layout: 'fit',
				cm : cm,
        store: gridstore
    });

	analysisGridPanel.add(grid);
	analysisGridPanel.doLayout();
}

function getAnalysisGridData(concept_key) {
	gridstore = new Ext.data.JsonStore(
			{
				url : pageInfo.basePath+'/chart/analysisGrid',
				root : 'rows',
				fields : ['name', 'url']
			}
	);
	gridstore.on('load', storeLoaded);
	var myparams = Ext.urlEncode(
			{
				charttype : "analysisgrid",
				concept_key : concept_key,
				result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
				result_instance_id2 : GLOBAL.CurrentSubsetIDs[2]
			}
	);
	// or a URL encoded string */

    gridstore.load({
				params : myparams
    });
			}

function getAnalysisPanelContent() {
	var a = analysisPanel.body;
	return analysisPanel.body.dom.innerHTML;
}

function printPreview(content) {
	var stylesheet = "<html><head><link rel='stylesheet' type='text/css' href='../css/chartservlet.css'></head><body>";
	var generator = window.open('', 'name', 'height=400,width=500, resizable=yes, scrollbars=yes');
	var printbutton = "<input type='button' value=' 打印此页 'onclick='window.print();return false;' />";//<SIAT_zh_CN original=" Print this page ">打印此页</SIAT_zh_CN>
    //var savebutton = "<input type='button' value='Save'  onclick='document.execCommand(\"SaveAs\",null,\".html\")' />";
    generator.document.write(stylesheet + printbutton + content);
	generator.document.close();
}

function exportGrid() {
	viewport.getEl().mask("正在获取数据....");//<SIAT_zh_CN original="Getting Data">正在获取数据</SIAT_zh_CN>

	Ext.get("exportgridform").dom.submit();
	setTimeout('viewport.getEl().unmask();', 10000);
}

function watchForSymbol(options) {
	var stopAt;

    if (!options || !options.symbol || !Object.isFunction(options.onSuccess)) {
		throw "Missing required options";
	}
	options.onTimeout = options.onTimeout || Prototype.K;
	options.timeout = options.timeout || 10;
	stopAt = (new Date()).getTime() + (options.timeout * 1000);
    new PeriodicalExecuter(function (pe) {
            if (typeof window[options.symbol] != "undefined") {
			pe.stop();
			options.onSuccess(options.symbol);
		}
            else if ((new Date()).getTime() > stopAt) {
			pe.stop();
			options.onTimeout(options.symbol);
		}
			}
	, 0.25);
}

//Called to run the Haploviewer
function getHaploview() {
	Ext.Ajax.request({						
		url: pageInfo.basePath+"/asyncJob/createnewjob",
		method: 'POST',
		success: function(result, request){
			RunHaploViewer(result, GLOBAL.CurrentSubsetIDs[1], GLOBAL.CurrentSubsetIDs[2], GLOBAL.CurrentGenes);
		},
		failure: function(result, request){
			Ext.Msg.alert('状态', '无法创建热图(heatmap)工作');//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>//<SIAT_zh_CN original="Unable to create the heatmap job.">无法创建热图(heatmap)工作</SIAT_zh_CN>
		},
		timeout: '1800000',
		params: {jobType:  "Haplo"}
	});	
}

function RunHaploViewer(result, result_instance_id1, result_instance_id2, genes) {
	var jobNameInfo = Ext.util.JSON.decode(result.responseText);					 
	var jobName = jobNameInfo.jobName;

	showJobStatusWindow(result);	
	document.getElementById("gplogin").src = pageInfo.basePath + '/analysis/gplogin';   // log into GenePattern
	Ext.Ajax.request(
		{						
			url: pageInfo.basePath+"/genePattern/runhaploviewer",
			method: 'POST',
			timeout: '1800000',
			params: {result_instance_id1: result_instance_id1,
				result_instance_id2:  result_instance_id2,
				genes: genes,
				jobName: jobName
			}
	});
	checkJobStatus(jobName);
}

function searchByTagBefore() {
	var tagterm=document.getElementById("tagterm");
	var tagtype=document.getElementById("tagtype");
	var searchterm = document.getElementById('ontsearchterm').value;
	var a=searchterm.trim();
    if (a.length > 0 && a.length < 3) {
		alert("请输入一个更长的搜索术语");//<SIAT_zh_CN original="Please enter a longer search term.">请输入一个更长的搜索术语</SIAT_zh_CN>
		return false;
	}
    if (a.length == 0 && tagtype.selectedIndex == 0) {
		alert("请选择一个搜索术语");//<SIAT_zh_CN original="Please select a search term.">请选择一个搜索术语</SIAT_zh_CN>
		return false;
	}
    if (a.length == 0 && tagtype.selectedIndex != 0) {
        if (tagterm.selectedIndex == -1) {
			alert("请选择一个搜索术语");//<SIAT_zh_CN original="Please select a search term.">请选择一个搜索术语</SIAT_zh_CN>
			return false;
		}
	}
    for (c = treeRoot.childNodes.length - 1;
	c >= 0;
         c--) {
        treeRoot.childNodes[c].remove();
	}
    ontTree.render();
	viewport.el.mask("正在搜索...")//<SIAT_zh_CN original="Searching">正在搜索</SIAT_zh_CN>
	return true;
}
function searchByTagComplete(response) {
	// shorthand
	var Tree = Ext.tree;
    var treeRoot = Ext.getCmp('navigateTermsPanel').getRootNode();

	viewport.el.unmask();
    var concepts = response.searchResults; //Response is an array of concept paths
    var uniqueLeaves = response.uniqueLeaves;

	var length;
	var leaf = false;
	var draggable = false;

    for (c = treeRoot.childNodes.length - 1;
         c >= 0;
         c--) {
        treeRoot.childNodes[c].remove();
    }

    jQuery('#noAnalyzeResults').hide();

    //Clear path to expand and unique leaves
    GLOBAL.PathToExpand = '';
    GLOBAL.UniqueLeaves = '';

    if (GLOBAL.DefaultPathToExpand != "") {
        GLOBAL.PathToExpand += GLOBAL.DefaultPathToExpand + ",";
    }

    if (concepts != undefined) {
        if (concepts.length < GLOBAL.MaxSearchResults) {
			length = concepts.length;
		}
        else {
			length = GLOBAL.MaxSearchResults;
		}
        for (var c = 0; c < length; c++) {
            GLOBAL.PathToExpand += concepts[c] + ",";
		}

        for (var c = 0; c < uniqueLeaves.length; c++) {
            GLOBAL.UniqueLeaves += uniqueLeaves[c] + ",";
	}

        if (concepts.length == 0) {
            jQuery('#noAnalyzeResults').show();
            Ext.getCmp('navigateTermsPanel').render();
            onWindowResize();
}
        else {
            //Get the categories with the new path to expand
            getCategories();
        }

    }
}

function showHaploviewGeneSelection() {
	var win = new Ext.Window({
		id: 'showHaploviewGeneSelection',
		title: 'Haploview-基因选择',//<SIAT_zh_CN original="Haploview-Gene Selection">Haploview-基因选择</SIAT_zh_CN>
		layout:'fit',
		width:250,
		height:250,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		          {
		        	  id: 'haploviewGeneSelectionOKButton',
		        	  text: '确认',//<SIAT_zh_CN original="OK">确认</SIAT_zh_CN>
		        	  handler: function(){
                    if (Ext.get('haploviewgenes') == null) {
		        		  win.close();
		        		  return;
		        	  }
		        	  var ob=Ext.get('haploviewgenes').dom;
		        	  var selected = new Array();
		        	  for (var i = 0; i < ob.options.length; i++)
		        		  if (ob.options[i].selected)
		        			  selected.push(ob.options[i].value);
		        	  GLOBAL.CurrentGenes=selected.join(',');
		        	  getHaploview();
                    win.close();
		          }
            }
            ,
            {
		        	  text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
		        	  handler: function(){
                    win.close();
                }
            }
        ],
		          resizable: false,
        autoLoad: {
		url: pageInfo.basePath+'/analysis/showHaploviewGeneSelector',
		scripts: true,
		nocache:true,
		discardUrl:true,
		method:'POST',
		params: {result_instance_id1: GLOBAL.CurrentSubsetIDs[1],
		result_instance_id2: GLOBAL.CurrentSubsetIDs[2]}
		          },
        tools: [
            {
			id:'help',
			qtip:'点击获取上下文敏感的相关帮助',//<SIAT_zh_CN original="Click for context sensitive help">点击获取上下文敏感的相关帮助</SIAT_zh_CN>
		    handler: function(event, toolEl, panel){
		   	D2H_ShowHelp("1174",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
            }
        ]
	});
	//  }
	win.show(viewport);
}

function genePatternLogin() {
    document.getElementById("gplogin").src = pageInfo.basePath + '/analysis/gplogin';
}

function showWorkflowStatusWindow() {
	wfsWindow = new Ext.Window({
		id: 'showWorkflowStatus',
		title: '工作流状态',//<SIAT_zh_CN original="Workflow Status">工作流状态</SIAT_zh_CN>
		layout:'fit',
		width:300,
		height:300,
		closable: false,
		plain: true,
		modal: true,
		border:false,
		buttons: [
		         {
		        	  text: '取消工作',//<SIAT_zh_CN original="Cancel Job">取消工作</SIAT_zh_CN>
		        	  handler: function(){
		        	  runner.stopAll();
		        	  terminateWorkflow();
                    wfsWindow.close();
                }
            }
        ],
		          resizable: false,
        autoLoad: {
					url: pageInfo.basePath+'/asyncJob/showWorkflowStatus',
					scripts: true,
					nocache:true,
					discardUrl:true,
					method:'POST'
		          }
	});
	//  }
	wfsWindow.show(viewport);
	
	var updateStatus = function(){
		Ext.Ajax.request(
				{
					url : pageInfo.basePath+"/asyncJob/checkWorkflowStatus",
					method : 'POST',
                success: function (result, request) {
						workflowStatusUpdate(result);
                },
                failure: function (result, request) {
                },
				timeout : '300000'
				}
		);
  	} 
  	
  	var task = {
  	    run: updateStatus,
  	    interval: 4000 //4 second
  	}
 
  	runner.start(task);
  	

}

function terminateWorkflow(){
	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/asyncJob/cancelJob",
				method : 'POST',
            success: function (result, request) {
					
            },
            failure: function (result, request) {
            },
			timeout : '300000'
			}
	);
}
function workflowStatusUpdate(result){
	var response=eval("(" + result.responseText + ")");	
	var inserthtml = response.statusHTML;
	var divele = Ext.fly("divwfstatus");
	if(divele!=null){
		divele.update(inserthtml);
	}
	var status = response.wfstatus;
	if(status =='completed'){
		runner.stopAll();		
		if(divele!=null){
			divele.update("");
		}		
		if(wfsWindow!=null){
			wfsWindow.close();
			wfsWindow =null;
		}		
		showWorkflowResult(result);
	} 
}

function showWorkflowResult(result) {
	var response=eval("(" + result.responseText + ")");
	var jobNumber = response.jobNumber;
	var viewerURL = response.viewerURL;
	var altviewerURL = response.altviewerURL;
	var gctURL = response.gctURL;
	var cdtURL = response.cdtURL;
	var gtrURL = response.gtrURL;
	var atrURL = response.atrURL;
	var error = response.error;
	var snpGeneAnnotationPage = response.snpGeneAnnotationPage;

	if (error != undefined) {
		alert(error);
	} 
	else {
		if (snpGeneAnnotationPage != undefined && snpGeneAnnotationPage.length != 0) {
			showSnpGeneAnnotationPage(snpGeneAnnotationPage);
		}
		runVisualizerFromSpan(viewerURL, altviewerURL);
	}
}

function showSnpGeneAnnotationPage(snpGeneAnnotationPage) {
	var resultWin = window.open('', 'Snp_Gene_Annotation_' + (new Date()).getTime(), 
		'width=600,height=800,scrollbars=yes,resizable=yes,location=no,toolbar=no,status=no,menubar=no,directories=no');
	resultWin.document.write(snpGeneAnnotationPage);
}

function saveComparison() {

	Ext.Ajax.request(
			{
				url : pageInfo.basePath+"/comparison/save",
				method : 'POST',
            success: function (result, request) {
				saveComparisonComplete(result);
            },
            failure: function (result, request) {
				saveComparisonComplete(result);
            },
			timeout : '600000',
			params : Ext.urlEncode(
					{
						result_instance_id1 : GLOBAL.CurrentSubsetIDs[1],
						result_instance_id2 : GLOBAL.CurrentSubsetIDs[2],
						genes: GLOBAL.CurrentGenes
					}
			) // or a URL encoded string
			}
	);
}

function saveComparisonComplete(result) {
	var mobj=result.responseText.evalJSON();
	
	//If the window is already open, close it.
	if(this.saveComparisonWindow) saveComparisonWindow.close();
	
	//Draw the window with the link to the comparison.
	saveComparisonWindow = new Ext.Window
	({
        id: 'saveComparisonWindow',
        title: '保存比较',//<SIAT_zh_CN original="Saved Comparison">保存比较</SIAT_zh_CN>
        autoScroll:true,
        closable: true,
        tools: [
                  {
                id: 'sampleExplorerHelpButton',
						qtip: '点击获取保存比较窗口的相关帮助',//<SIAT_zh_CN original="Click for Saved Camparison Window Help">点击获取保存比较窗口的相关帮助</SIAT_zh_CN>
						disabled : false,
                handler: function () {
						    D2H_ShowHelp("1474",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
						}
                  }
                 ],
        resizable: true,
        width: 200,
        html: mobj.link
	});	
	
	//Show the window we just created.
	saveComparisonWindow.show(viewport);	
}

function ontFilterLoaded(el, success, response, options) {
    if (GLOBAL.preloadStudy != "") {
			Ext.get("ontsearchterm").dom.value = GLOBAL.preloadStudy;
			Ext.get("ontSearchButton").dom.click();
		}
}

function clearQuery() {
    if (confirm("您确认要清除当前的分析吗？")) {//<SIAT_zh_CN original="Are you sure you want to clear your current analysis?">您确认要清除当前的分析吗？</SIAT_zh_CN>
        clearAnalysisPanel();
        resetQuery();
        clearDataAssociation();
    }
}

//check that an array a contains an object obj
function contains(a, obj) {
    var l = a.replace("[", "").replace("]", "").split(", ");
    var i = l.length;
    while (i--) {
        if (l[i] == obj) {
            return true;
        }
    }
    return false;
}
