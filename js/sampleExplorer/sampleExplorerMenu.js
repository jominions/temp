function createMainExplorerWindow() 
{
    northPanel = new Ext.Panel({
        id : 'northPanel',
        region : 'north',
        split : false,
        border : true,
        contentEl : "header-div"
    });

    centerMainPanel = new Ext.Panel({
		id : 'centerMainPanel',
		region : 'center',
		layout : 'border'
	});
	
	centerMainPanel.add(createWestPanel());
	centerMainPanel.add(createCenterPanel());

	viewport = new Ext.Viewport({
		layout : 'border',
		items : [centerMainPanel, northPanel]
	});
}

//Create the west most panel. 
function createWestPanel()
{
	westPanel = new Ext.Panel({
		id : 'westPanel',
		region : 'west',
		autoLoad:
        {
        	url: pageInfo.basePath+'/sampleExplorer/showMainSearchPage',
           	method:'POST'
        },			
		width : 230,
		minwidth : 200,
		split : false,
		border : true,
		layout : 'border'
	});

	ontTabPanel = new Ext.FormPanel(
			{
				id : 'ontPanel',
				region : 'center',
				defaults :
				{
				hideMode : 'offsets'
				}
			,
			collapsible : false,
			height : 600,
			width : 230,
			items : [{}],
			deferredRender : false,
			split : true
			}
	);
	
	westPanel.add(ontTabPanel);

	return westPanel;
}

/*
 * This creates the center panel including toolbar, main category selection, result data grids. 
 */
function createCenterPanel()
{
	//Draw our toolbar. Some items are hidden till we select an initial category.
	var tb2 = new Ext.Toolbar(
			{
				id : 'maintoolbar',
				title : 'maintoolbar',
				items : [
						
						new Ext.Toolbar.Button({
							id : 'advancedbutton',
							text : '高级工作流',//<SIAT_zh_CN original="Advanced Workflow">高级工作流</SIAT_zh_CN>
							iconCls : 'comparebutton',
							hidden :true,
							menu : createAdvancedSubMenu(),
							handler : function() {

							}
						}),
						new Ext.Toolbar.Button({
							id : 'clearsearchbutton',
							text : '清除搜索',//<SIAT_zh_CN original="Clear Search">清除搜索</SIAT_zh_CN>
							iconCls : 'clearbutton',
							hidden : true,
							handler : clearSearch
						}),
						new Ext.Toolbar.Button({
							id : 'addsubset',
							text : '添加子集',//<SIAT_zh_CN original="Add Subset">添加子集</SIAT_zh_CN>
							iconCls : 'nextbutton',
							hidden : true,
							handler : addTabbedSubset
						}),								
						'->',
						new Ext.Toolbar.Button(
								{
									id : 'sampleExplorerHelpButton',
									iconCls : 'contextHelpBtn',
									qtip: '点击取得样本管理器帮助',//<SIAT_zh_CN original="Click for Sample Explorer Help">点击取得样本管理器帮助</SIAT_zh_CN>
									disabled : false,
									handler : function()
									{
									    D2H_ShowHelp("1438",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
									}
								}
						)						
						
						]
			});	
	
	//This is the table panel that holds our "Comparison/Jobs" Tabs.
	resultsTabPanel = new Ext.TabPanel(
			{
				id : 'resultsTabPanel',
				title : '分析/结果',//<SIAT_zh_CN original="Analysis/Results">分析/结果</SIAT_zh_CN>
				region : 'center',
				defaults :
				{
					hideMode : 'display'
				}
			,
			collapsible : false,
			deferredRender : false,
			activeTab : 0
			}
	);
	
	//This is the URL for our main "Comparison" tab.
    var centerPanelURL = false;
    if (!(/[?&]result_instance_id=/.test(location.href)))
        centerPanelURL = {
            url: pageInfo.basePath+'/sampleExplorer/showTopLevelListPage',
            method:'POST',
            callback: createSearchBox
        };

	//This is our main "Comparison" tab.
	queryPanel = new Ext.Panel(
			{
				id : 'queryPanel',
				title : '比较',//<SIAT_zh_CN original="Comparison">比较</SIAT_zh_CN>
				region : 'north',
				height : 800,
				autoScroll : true,
				split : true,					
		        autoLoad: centerPanelURL,
				collapsible : true,
				titleCollapse : false,
				animCollapse : false,
				bbar: new Ext.StatusBar({
					// Status bar to show the progress of generating heatmap and other advanced workflows
			        id: 'asyncjob-statusbar',
			        defaultText: '就绪',//<SIAT_zh_CN original="Ready">就绪</SIAT_zh_CN>
			        defaultIconCls: 'default-icon',
			        text: '就绪',//<SIAT_zh_CN original="Ready">就绪</SIAT_zh_CN>
			        statusAlign: 'right',
			        iconCls: 'ready-icon',
			        items: [{
			        	xtype: 'button',
			        	id: 'cancjob-button',
			        	text: '取消',//<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>
			        	hidden: true
			        }]				        
			    })
			}
	);
	
	//This is our Jobs tab.
	analysisJobsPanel = new Ext.Panel(
			{
				id : 'analysisJobsPanel',
				title : 'Jobs',//<SIAT_zh_CN original="Jobs">工作</SIAT_zh_CN>
				region : 'center',
				split : true,
				height : 500,
				layout : 'fit',
				hidden: GLOBAL.EnableGP!='true',
				autoLoad : getJobsData,
				collapsible : true						
			}
	);			
	
	resultsTabPanel.add(queryPanel);
	
	if(GLOBAL.EnableGP=='true'){
	resultsTabPanel.add(analysisJobsPanel);	
	}
	centerPanel = new Ext.Panel({
		id : 'centerPanel',
		region : 'center',
		width : 500,
		border : true,
		tbar : tb2	
	});

	centerPanel.add(resultsTabPanel);
	
	return centerPanel;
}

function createSearchBox()
{
    /*
	var combo = new Ext.app.SearchComboBox({
		id: "search-combobox",
		renderTo: "search-text",
		searchUrl: pageInfo.basePath+'/sampleExplorer/loadSearch',
		submitFn: function(param, text) {
			//When we pick an item from the list, load the menus.
			//The param is Category|Item.
			var splitArray = param.split("|");
			
			toggleMainCategorySelection(splitArray[1],splitArray[0])
		},
		value: "",
		width: 470,
        onSelect: function(record) {
			this.collapse();
			if (record != null) {
				this.submitFn(record.data.id, record.data.keyword);
			}
		},
        listeners: {
			"beforequery": {
				fn: function(queryEvent) {
		            var picklist = Ext.getCmp("categories");
		            if (picklist != null) {
			            var rec = picklist.getSelectedRecord();
						if (rec != null) {
							queryEvent.query = rec.id + ":" + queryEvent.query;
						}
					}
					
				},
				scope: this
			}
        }
	});
	combo.focus();	
	*/
	function searchOnClick() {
		var combo = Ext.getCmp("search-combobox");
		var param = combo.getSelectedParam();
		if (param != null) {
			combo.submitFn(param, param);
		}
	}

	function postSubmit() {
		var searchcombo = document.getElementById("search-combobox");
		searchcombo.className += " searchcombobox-disabled";
		searchcombo.style.width = "442px";						
	}
	/*
	var picklist = new Ext.app.PickList({
		id: "categories",
		cls: "categories-gray",
		storeUrl: pageInfo.basePath+'/sampleExplorer/loadCategories',
		renderTo: "search-categories",
		label: "Category:&nbsp;",
		disabledClass: "picklist-disabled",
		onSelect: function(record) {
	        var combo = Ext.getCmp("search-combobox");
	        combo.focus();
	        if ((record.id != "all") || (record.id == "all" && combo.getRawValue().length > 0)) {
				combo.doQuery(combo.getRawValue(), true);
	        }
		}
	});	
	*/
}

function createExportSubMenu()
{
	expmenu = new Ext.menu.Menu({
		id : 'exportMenu',
		minWidth : 250,
		items : [ {
			text : '总结统计',//<SIAT_zh_CN original="Summary Statistics">总结统计</SIAT_zh_CN>
			handler : function() {
				if ((typeof (grid) != 'undefined') && (grid != null)) {
					exportGrid();
				} else {
					alert("无数据汇出");//<SIAT_zh_CN original="Nothing to export">无数据汇出</SIAT_zh_CN>
				}
			}
		}, '-', {
			text : '基因 Expression/RBM 数据集',//<SIAT_zh_CN original="Gene Expression/RBM Datasets">基因 Expression/RBM 数据集</SIAT_zh_CN>
			handler : function() {
				exportDataSets();
			}
		} ]
	});	
	
	return expmenu;
}

function createAdvancedSubMenu()
{
	advmenu = new Ext.menu.Menu(
			{
				id : 'advancedMenu',
				minWidth : 250,
				items : [
						{
							text : 'Heatmap',//<SIAT_zh_CN original="Heatmap">Heatmap</SIAT_zh_CN>
							// when checked has a boolean value, it is assumed to be a CheckItem
							handler : function() {
								GLOBAL.HeatmapType = 'Compare';
								//We need to do some work before we can validate. Call our sample explorer heatmap code.
								validateHeatMapsSample(showGeneSelection);
								advancedWorkflowContextHelpId = "1085";
							}
						},
				         {
				        	 text : 'Hierarchical群集',//<SIAT_zh_CN original="Hierarchical Clustering">Hierarchical群集</SIAT_zh_CN>
				        	 // when checked has a boolean value, it is assumed to be a CheckItem
				        	 handler : function()
				        	 {
				        	 	GLOBAL.HeatmapType = 'Cluster';
				        	 	validateHeatMapsSample(showGeneSelection);
				        	 	advancedWorkflowContextHelpId="1085";
				        	 }
				         }
				         ,
				         {
				        	 text : 'K-Means群集',//<SIAT_zh_CN original="K-Means Clustering">K-Means群集</SIAT_zh_CN>
				        	 // when checked has a boolean value, it is assumed to be a CheckItem
				        	 handler : function()
				        	 {
				        	 	GLOBAL.HeatmapType = 'KMeans';
				        	 	validateHeatMapsSample(showGeneSelection);
				        	 	advancedWorkflowContextHelpId="1085";
				        	 }
				         }
				         ,

				         {
				        	 text : '比较标记选择 (Heatmap)',//<SIAT_zh_CN original="Comparative Marker Selection (Heatmap)">比较标记选择 (Heatmap)</SIAT_zh_CN>
				        	 // when checked has a boolean value, it is assumed to be a CheckItem
				        	 handler : function()
				        	 {
				        	 	GLOBAL.HeatmapType = 'Select';
				        	 	validateHeatMapsSample(showGeneSelection);
				        	 	advancedWorkflowContextHelpId="1085";
				        	 }
				         }
				         ,
				         '-'
				         ,
				         {
				        	 text : '主要组件分析',//<SIAT_zh_CN original="Principal Component Analysis">主要组件分析</SIAT_zh_CN>
				        	 // when checked has a boolean value, it is assumed to be a CheckItem
				        	 handler : function()
				        	 {
				        	 	GLOBAL.HeatmapType = 'PCA';
				        	 	validateHeatMapsSample(showGeneSelection);
				        	 	advancedWorkflowContextHelpId="1172";
				        	 }
				         }
				         ,
				         /*
				         '-'
				         ,
				         {
				        	 text : 'Haploview',
				        	 handler : function()	{
				        		 
				        		 //Get the Sample ID List from the subsets.
				        		 validateHeatMapsSample(showHaploviewGeneSelection);

				        		 return;
				        	}
				        }
				        ,
				        */
				        {
				        	 text : 'SNPViewer',
				        	 handler : function()	
				        	 {
				        		GLOBAL.HeatmapType = '';
				        		validateHeatMapsSample(showSNPViewerSelection);
				        	 	return;
				        	 }
				        }
				        ,
				        {
				        	 text : '整合式基因组检视器',//<SIAT_zh_CN original="Integrative Genome Viewer">整合式基因组检视器</SIAT_zh_CN>
				        	 handler : function()	
				        	 {
				        		GLOBAL.HeatmapType = '';
					        	validateHeatMapsSample(showIgvSelection);
				        	 	return;
				        	 }
				        },
				        {
				        	 text : '基因组关连案例'//<SIAT_zh_CN original="Genome-Wide Association Study">基因组关连案例</SIAT_zh_CN>
				        	 handler : function()	{
				        		GLOBAL.HeatmapType = '';				        		
					        	validateHeatMapsSample(showGwasSelection);
				        	 	return;			
				        	 }
				        }	
				]
			});

	return advmenu;

}


