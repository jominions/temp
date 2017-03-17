function createMainTabPanel() {

    // create toolbar
    var toolbar = createMainToolbar();

    // create search tabgs
    var tabpanel = createSearchTabs(toolbar);

    return tabpanel;
}

// create search tabs with TEA
function createSearchTabs(toolbar) {

    // create search tabs
    var tabpanel = new Ext.TabPanel({
        id: "tab-panel",
        tbar: toolbar,
        activeTab: pageData.activeTab,
        autoScroll: true,
        //region: "center",
        items: [ 
            {
                id: "tab1",
                iconCls: "clinicalTrialgovTab",
                title: "临床试验 (" + pageData.trial.analysisCount + ", " + pageData.trial.count + ")",//<SIAT_zh_CN original="Clinical Trials">临床试验</SIAT_zh_CN>
                listeners: {activate: activateTab},
                layout: "card",
                activeItem: (pageData.trial.analysisCount>0) ? 0 : 2,
                items: [
                    {
                        id: "trial-tea-results-panel",
                        autoLoad: {
                            url: pageData.trial.teaResultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    },
                    {
                        id: "trial-filter-panel",
                        autoLoad: {
                            url: pageData.trial.filterUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    },{
                        id: "trial-results-panel",
                        autoLoad: {
                            url: pageData.trial.resultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }
                ]
            }, 
            {
                id: "tab2",
                iconCls: "expTab",
                title: "mRNA分析 (" + pageData.pretrial.mRNAAnalysisCount + ", " + pageData.pretrial.count + ")",//<SIAT_zh_CN original="mRNA Analysis">mRNA分析</SIAT_zh_CN>
                listeners: {activate: activateTab},
                layout: "card",
                layoutConfig: { deferredRender: true },
                activeItem: (pageData.pretrial.mRNAAnalysisCount>0) ? 0 : 2,
                items: [
                    {
                        id: "pretrial-tea-results-panel",
                        autoLoad: {
                            url: pageData.pretrial.teaResultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST",
                            timeout: 300000
                        }
                    },
                    {
                        id: "pretrial-filter-panel",
                        autoLoad: {
                            url: pageData.pretrial.filterUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    },{
                        id: "pretrial-results-panel",
                        autoLoad: {
                            url: pageData.pretrial.resultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }
                ]
             } ,             
             {
                id: "tab3",
                iconCls: "profTab",
                title: "mRNA概要 (" + pageData.profile.count + ")",//<SIAT_zh_CN original="mRNA Profiles">mRNA概要</SIAT_zh_CN>
                listeners: {activate: activateTab},
                layout: "card",
                activeItem: 0,
                items: [
                    {
                        id: "profile-results-panel",
                        autoLoad: {
                            url: pageData.profile.resultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }
                ]
            },
            {
                id: "tab4",
                iconCls: "jubTab",
                title: "文献 (" + pageData.jubilant.count + ")"//<SIAT_zh_CN original="Literature">文献</SIAT_zh_CN>
                listeners: {activate: activateTab},
                layout: "card",
                //layoutConfig: { deferredRender: true },
                activeItem: 0,
                items: [
                    {
                        id: "jubilant-results-panel",
                        autoLoad: {
                            url: pageData.jubilant.resultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }, {
                        id: "jubilant-filter-panel",
                        autoLoad: {
                            url: pageData.jubilant.filterUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }, {
                        id: "jubilant-summary-panel"
                    }
                ]
            },
            {
                id:"tab5",
                iconCls: "docTab",
                   title: "文件 (" + pageData.doc.count + ")",//<SIAT_zh_CN original="Documents">文件</SIAT_zh_CN>
                listeners: {
                    activate: activateTab
                },
                layout: "card",
                layoutConfig: { deferredRender: true },
                activeItem: 0,
                items: [
                    {
                        id: "documents-results-panel",
                        autoLoad: {
                            url: pageData.doc.resultsUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }, {
                        id: "documents-filter-panel",
                        autoLoad: {
                            url: pageData.doc.filterUrl,
                            nocache: true,
                            discardUrl: true,
                            method: "POST"
                        }
                    }
                ]
            },
            {
                id: "tab6",
                iconCls: "pictorTab",
                title: "Pictor",//<SIAT_zh_CN original="Pictor">Pictor</SIAT_zh_CN>
                listeners: {activate: activateTab},
                xtype: "iframepanel",
                closable: false,
                loadMask: true,
                defaultSrc: pageData.pictor.resultsUrl
            },
            {
                id: "tab7",
                iconCls: "resnetTab",
                title: "ResNet",//<SIAT_zh_CN original="ResNet">ResNet</SIAT_zh_CN>
                listeners: {activate: activateTab},
                xtype: "iframepanel",
                closable: false,
                loadMask: true,
                defaultSrc: pageData.resnet.resultsUrl,
                tabTip: pageData.resnet.credentials
            } 
            , 
            {
                id: "tab8",
                iconCls: "genegoTab",
                title: "GeneGo",//<SIAT_zh_CN original="GeneGo">GeneGo</SIAT_zh_CN>
                listeners: {activate: activateTab},
                xtype: "iframepanel",
                closable: false,
                loadMask: true,
                defaultSrc: pageData.genego.resultsUrl,
                tabTip: pageData.genego.credentials
            }
            
        ]
    });
    return tabpanel;
}

// create toolbar below search tabs
function createMainToolbar() {

    var toolbar = new Ext.Toolbar([
           {
               id: "filters-show-button",
               text: "显示过滤器",//<SIAT_zh_CN original="Show Filters">显示过滤器</SIAT_zh_CN>
               handler: showFilters,
               cls: "x-btn-text-icon",
               iconCls: "filtersBtn"
           }, {
               id: "filters-hide-button",
               text: "隐藏过滤器",//<SIAT_zh_CN original="Hide Filters">隐藏过滤器</SIAT_zh_CN>
               handler: showFilters,
               cls: "x-btn-text-icon",
               hidden: true,
               iconCls: "filtersBtn"
           }, {
               id: "summary-show-button",
               text: "显示总结",//<SIAT_zh_CN original="Show Summary">显示总结</SIAT_zh_CN>
               handler: showSummary,
               cls: "x-btn-text-icon",
               iconCls: "summaryBtn"
           }, {
               id: "summary-hide-button",
               text: "显示搜索结果",//<SIAT_zh_CN original="Show Search Results">显示搜索结果</SIAT_zh_CN>
               handler: showSummary,
               cls: "x-btn-text-icon",
               hidden: true,
               iconCls: "summaryBtn"
           }, {
               id: "heatmap-button",
               text: "Heatmap",//<SIAT_zh_CN original="Heatmap">Heatmap</SIAT_zh_CN>
               handler: showHeatmap,
               cls: "x-btn-text-icon",
               iconCls: "heatmapBtn"
           },
           {
               id: "tea-button",
               text: "分析显示",//<SIAT_zh_CN original="Analysis View">分析显示</SIAT_zh_CN>
               handler: showTEAView,
               cls: "x-btn-text-icon",
               iconCls: "teaBtn"
           },
           {
               id: "studyview-button",
               text: "案例显示",//<SIAT_zh_CN original="Study View">案例显示</SIAT_zh_CN>
               handler: showStudyView,
               cls: "x-btn-text-icon",
               iconCls: "studyBtn"
           },
           {
               id: "exportsummary-button",
               text: "导出结果",//<SIAT_zh_CN original="Export Results">导出结果</SIAT_zh_CN>
               handler: exportSummary,
               cls: "x-btn-text-icon",
               iconCls: "exportSummaryBtn"
           },
           {
               id: "exportresnet-button",
               text: "导出至ResNet",//<SIAT_zh_CN original="Export to ResNet">导出至ResNet</SIAT_zh_CN>
               handler: exportResNet,
               cls: "x-btn-text-icon",
               iconCls: "exportResNetBtn"               
           },
           {
                id:'contextHelp-button',
                handler: function(event, toolEl, panel){
                    D2H_ShowHelp(filterContextHelpId,helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
                },
                cls: "x-btn-text-icon",
                iconCls: "contextHelpBtn"  
           },
           {
               xtype: "tbfill"
           }
       ]);
    return toolbar;
}

function activateTab(tab) {
    switch (tab.id) {
    case "tab1":
        setButtonVisibility("filters", true);
        setButtonVisibility("summary", false);
        if(pageData.trial.count>0) {
            setButtonVisibility("heatmap", true);
            setButtonVisibility("studyview", true);

            if(pageData.trial.analysisCount>0) {
                setButtonVisibility("tea",true);
            } else {
                setButtonVisibility("tea",false);
            }
        } else {
            setButtonVisibility("heatmap", false);
            setButtonVisibility("tea",false);
            setButtonVisibility("studyview", false);
        }
        setButtonVisibility("exportsummary", true);
        setButtonVisibility("exportresnet", false);
        
        var contextHelpVisibility = false;
        if(pageData.trial.analysisCount>0 || pageData.trial.count>0){
            contextHelpVisibility = true
        }
        setButtonVisibility("contextHelp", contextHelpVisibility);
        filterContextHelpId = (pageData.trial.analysisCount>0) ? "1027" : "1028";
        break;
    case "tab2":
        setButtonVisibility("filters", true);

        // experiment views
        if(pageData.pretrial.count>0){
            setButtonVisibility("studyview", true)
        } else {
            setButtonVisibility("studyview", false)
        }

        // tea analysis view
        if(pageData.pretrial.mRNAAnalysisCount>0){
            setButtonVisibility("tea", true)
        } else {
            setButtonVisibility("tea", false)
        }
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", true);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("contextHelp", true);
        
        var contextHelpVisibility = false;
        if(pageData.pretrial.mRNAAnalysisCount>0 || pageData.pretrial.count>0){
            contextHelpVisibility = true
        }
        setButtonVisibility("contextHelp", contextHelpVisibility);
        filterContextHelpId = (pageData.pretrial.mRNAAnalysisCount>0) ? "1023" : "1023";
        break;
    case "tab3":
        setButtonVisibility("filters", false);
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", false);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        setButtonVisibility("contextHelp", true);
        filterContextHelpId="1040";
        break;
    case "tab4":
        setButtonVisibility("filters", true);
        setButtonVisibility("summary", pageData.jubilant.litJubOncAltCount > 0);
        setButtonVisibility("heatmap", false);
        if (pageData.jubilant.count < 1)    {
            setButtonVisibility("exportsummary", false);
        } else  {
            setButtonVisibility("exportsummary", true);
        }
        if (pageData.hideInternal==true || pageData.jubilant.count < 1)  {
            setButtonVisibility("exportresnet", false);
        } else  {
            setButtonVisibility("exportresnet", true);
        }
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        setButtonVisibility("contextHelp", true);
        filterContextHelpId="1042";
        break;
    case "tab5":
        setButtonVisibility("filters", true);
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", false);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        setButtonVisibility("contextHelp", true);
        filterContextHelpId="1047";
        break;
    case "tab6":
        setButtonVisibility("filters", false);
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", false);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        if (pageData.pictor.resultsUrl.length > 1980) {
            window.alert("注意: 此Pictor搜索URL长度已超过IE所能支持的最大值，一些基因可能将被排除查询.");//<SIAT_zh_CN original="Note: The length of the URL for the Pictor query has exceeded the maximum supported by Internet Explorer and some genes may have been excluded from the query.">注意: 此Pictor搜索URL长度已超过IE所能支持的最大值, 一些基因可能将被排除查询.</SIAT_zh_CN>
        }
        setButtonVisibility("contextHelp", false);
        break;

    case "tab7":
        setButtonVisibility("filters", false);
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", false);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        setButtonVisibility("contextHelp", false);
        break;

    case "tab8":
        setButtonVisibility("filters", false);
        setButtonVisibility("summary", false);
        setButtonVisibility("heatmap", false);
        setButtonVisibility("exportsummary", false);
        setButtonVisibility("exportresnet", false);
        setButtonVisibility("studyview", false)
        setButtonVisibility("tea",false);
        setButtonVisibility("contextHelp", false);
        break;
    }
}

/**
 * @activetab: The tab which is currently active.
 * @item: The item for which help is provided.
 */
function showContextSpecificHelp(activetab, button){
    var contextHelpButton = Ext.getCmp("contextHelp-button");
    switch (activetab.getId()) {
    case "tab1":
        switch (button.id){
        case "filters-show-button":
                filterContextHelpId = "1025";
                contextHelpButton.setVisible(true);
        break;
        case "filters-hide-button":
                contextHelpButton.setVisible(false);
        break;
        case "tea-button":
                filterContextHelpId="1027";
                contextHelpButton.setVisible(true);
        break;
        case "studyview-button":
                filterContextHelpId="1028";
                contextHelpButton.setVisible(true);
        break;
        default:
            contextHelpButton.setVisible(false);
        }

    break;
    case "tab2":
        switch (button.id){
        case "filters-show-button":
            filterContextHelpId = "1033";
            contextHelpButton.setVisible(true);
        break;
        case "filters-hide-button":
            contextHelpButton.setVisible(false);
        break;
        case "tea-button":
            filterContextHelpId="1034";
            contextHelpButton.setVisible(true);
        break;
        case "studyview-button":
            filterContextHelpId="1035";
            contextHelpButton.setVisible(true);
        break;
        default:
            contextHelpButton.setVisible(false);
        }
    break;
    case "tab4":
        switch(button.id){
        case "filters-show-button":
            filterContextHelpId = "1043";
            contextHelpButton.setVisible(true);
        break;
        case "filters-hide-button":
            filterContextHelpId = "1042";
            contextHelpButton.setVisible(true);
        break;
        case "summary-show-button":
            filterContextHelpId = "1319";
            contextHelpButton.setVisible(true);
        break;
        case "summary-hide-button":
            filterContextHelpId = "1042";
            contextHelpButton.setVisible(true);
        break;
        default:
            contextHelpButton.setVisible(false);
        }
    break;
    case "tab5":
        switch(button.id){
        case "filters-show-button":
            filterContextHelpId = "1049";
            contextHelpButton.setVisible(true);
        break;
        case "filters-hide-button":
            filterContextHelpId = "1047";
            contextHelpButton.setVisible(true);
        break;
        default:
            contextHelpButton.setVisible(false);
        }
    break;
    default:
        contextHelpButton.setVisible(false);
    }
}

function showFilters(button) {
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    var activeitem = layout.activeItem;
    if (activeitem.id.indexOf("-results-") > -1 || activeitem.id.indexOf("-summary-") > -1) {
        if (activetab.id == "tab1" && !Ext.getCmp("trialfilter-tree")) {
            showTrialFilterTree(pageData.trialFilterUrl);
        }
        layout.setActiveItem(1);
    } else {
        layout.setActiveItem(0);
    }

    var showFiltersButton = Ext.getCmp("filters-show-button");
    var hideFiltersButton = Ext.getCmp("filters-hide-button");
    if (showFiltersButton != null) {
        if (activetab.id == "tab1" || activetab.id == "tab2")   {
        //  var exportSummaryButton = Ext.getCmp( "exportsummary-button");
        //  exportSummaryButton.setVisible(showFiltersButton.hidden);
        } else if(activetab.id == "tab4") {
            var showSummaryButton = Ext.getCmp("summary-show-button");
            var hideSummaryButton = Ext.getCmp( "summary-hide-button");
            var exportSummaryButton = Ext.getCmp( "exportsummary-button");
            var exportResnetButton = Ext.getCmp( "exportresnet-button");
            showSummaryButton.setVisible(showFiltersButton.hidden);
            exportSummaryButton.setVisible(showFiltersButton.hidden);
            if (pageData.jubilant.litJubOncIntCount > 0 || pageData.jubilant.litJubAsthmaCount > 0) {
                exportResnetButton.setVisible(showFiltersButton.hidden);
            } else  {
                exportResnetButton.setVisible(false);
            }

            hideSummaryButton.setVisible(false);
        }
        showFiltersButton.setVisible(showFiltersButton.hidden);
    }
    if (hideFiltersButton != null) {
        hideFiltersButton.setVisible(hideFiltersButton.hidden);
    }
    showContextSpecificHelp(activetab, button);
}


function showSummary(button) {
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    var activeitem = layout.activeItem;
    if (activeitem.id.indexOf("-results-") > -1) {
        if (activetab.id == "tab4") {
            var sum;
            if (Ext.getCmp("jubilant-summary-gridpanel") == null) {
                sum = createJubSummary();
            } else {
                sum = Ext.getCmp("jubilant-summary-gridpanel");
            }
//            var datatype = getResultType();
//            var titles = {
//                "JUBILANT_ONCOLOGY_ALTERATION":"Jubilant Oncology Alteration Summary",
//                "JUBILANT_ONCOLOGY_INHIBITOR":"Jubilant Oncology Inhibitor Summary",
//                "JUBILANT_ONCOLOGY_INTERACTION":"Jubilant Oncology Interaction Summary"
//            };
            sum.setTitle("Jubilant肿瘤学变更总结");//<SIAT_zh_CN original="Jubilant Oncology Alteration Summary">Jubilant肿瘤学变更总结</SIAT_zh_CN>
            sum.getStore().load({params: {offset:0, max:20}});
        }
        layout.setActiveItem(2);
    } else {
        layout.setActiveItem(0);
    }

    var showbutton = Ext.getCmp("summary-show-button");
    var hidebutton = Ext.getCmp("summary-hide-button");
    if (showbutton != null) {
        showbutton.setVisible(showbutton.hidden);
    }
    if (hidebutton != null) {
        hidebutton.setVisible(hidebutton.hidden);
    }
    showContextSpecificHelp(activetab, button);
}


function showTEAView(button){
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    var activeitem = layout.activeItem;
    layout.setActiveItem(0);
    showContextSpecificHelp(activetab, button);
}

function showStudyView(button){
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    var activeitem = layout.activeItem;
    layout.setActiveItem(2);
    showContextSpecificHelp(activetab, button);
}

function setButtonVisibility(id, visibility) {
    var showbutton = Ext.getCmp(id + "-show-button");
    var hidebutton = Ext.getCmp(id + "-hide-button");
    var button = Ext.getCmp(id + "-button");
    if (showbutton != null) {
        showbutton.setVisible(visibility);
    }
    if (hidebutton != null) {
        hidebutton.setVisible(false);
    }
    if (button != null) {
        button.setVisible(visibility);
    }
}

function showHeatmap(button) {
    var w = window.open(pageData.heatmapUrl, "_trialHeatmap", "width=900,height=800,scrollbars,resizable");
    w.focus();
}

function exportSummary(button) {
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    var activeitem = layout.activeItem;
    switch (activetab.getId()) {
    case "tab1":
        if (activeitem.id.indexOf("-tea-") > -1) {
            window.location = pageData.downloadTrialAnalysisUrl;
        } else  {
            window.location = pageData.downloadTrialStudyUrl;
        }
        break;
    case "tab2":
        if (activeitem.id.indexOf("-tea-")  > -1)   {
            window.location = pageData.downloadEaTEAUrl;
        } else  {
            window.location = pageData.downloadEaUrl;
        }
        break;
    case "tab4":
        window.location = pageData.downloadJubSummaryUrl;
        break;
    }
}

function exportResNet(button) {
    window.location = pageData.downloadResNetUrl;
}

function createJubSummary() {

    var store = new Ext.data.JsonStore({
        root: "rows",
        totalProperty: 'count',
        remoteSort: true,
        listeners: {
            "beforeload" : {
                fn: function(obj, options) {
                    var el = Ext.getDom("resultType");
                    if (el != null) {
                        obj.baseParams.datatype = el.value;
                    }
                    return true;
                },
                scope: this
            }
        },
        fields: [
         {name: 'dataType'},
         {name: 'alterationType'},
         {name: 'totalFrequency'},
         {name: 'totalAffectedCases'},
         {name: 'summary'},
         {name: 'target'},
         {name: 'variant'},
         {name: 'diseaseSite'}
        ],
        proxy: new Ext.data.ScriptTagProxy({ url: pageData.jubSummaryUrl })
    });
    store.setDefaultSort('dataType', 'ASC');

    var pagingBar = new Ext.PagingToolbar({
        pageSize: 20,
        store: store,
        displayInfo: true,
        displayMsg: "显示记录 {0} - {1} of {2}",//<SIAT_zh_CN original="Displaying records">显示记录</SIAT_zh_CN>
        emptyMsg: "无记录显示",//<SIAT_zh_CN original="No records to display">无记录显示</SIAT_zh_CN>
        paramNames: {start: 'offset', limit: 'max'}
    });

    // create the Grid
    var grid = new Ext.grid.GridPanel({
        id: "jubilant-summary-gridpanel",
        title: "Jubilant肿瘤学总结",//<SIAT_zh_CN original="Jubilant Oncology Summary">Jubilant肿瘤学总结</SIAT_zh_CN>
        store: store,
        trackMouseOver: false,
        disableSelection: true,
        columns: [
           {header: "数据类型", width: 75, sortable: true, dataIndex: 'dataType', menuDisabled: true},//<SIAT_zh_CN original="Data Type">数据类型</SIAT_zh_CN>
            {header: "变更类型", width: 150, sortable: true, dataIndex: 'alterationType', menuDisabled: true},//<SIAT_zh_CN original="Alteration Type">变更类型</SIAT_zh_CN>
            {header: "疾病地点", width: 200, sortable: true, dataIndex: 'diseaseSite', menuDisabled: true},//<SIAT_zh_CN original="Disease Site">疾病地点</SIAT_zh_CN>
            {id: "总结", header: "Summary", width: 300, sortable: true, dataIndex: 'summary', menuDisabled: true}, //<SIAT_zh_CN original="summary">总结</SIAT_zh_CN>
            {header: "目标", width: 75, sortable: true, dataIndex: 'target', menuDisabled: true}, //<SIAT_zh_CN original="Target">目标</SIAT_zh_CN>
            {header: "变体", width: 75, sortable: true, dataIndex: 'variant', menuDisabled: true}, //<SIAT_zh_CN original="Variant">变体</SIAT_zh_CN>
            {header: "频率", width: 75, sortable: true, dataIndex: 'totalFrequency', menuDisabled: true},//<SIAT_zh_CN original="Frequency">频率</SIAT_zh_CN>
            {header: "实例", width: 75, sortable: true, dataIndex: 'totalAffectedCases', menuDisabled: true}//<SIAT_zh_CN original="Cases">实例</SIAT_zh_CN>
        ],
        autoScroll: true,
        stripeRows: true,
        enableHdMenu: false,
        autoExpandColumn: "summary",
        bbar: pagingBar
    });

    var panel = Ext.getCmp("jubilant-summary-panel");
    panel.add(grid);
    panel.doLayout();
    return grid;
}

function selectJubilantPanel(index) {
    var tabpanel = Ext.getCmp("tab-panel");
    var activetab = tabpanel.getActiveTab();
    var layout = activetab.getLayout();
    layout.setActiveItem(index);
}

function onItemCheck(item, checked){
    ;
}

function popupWindow(mylink, windowname) {
    if (!window.focus)
    return true;

    var href;
    if (typeof(mylink) == 'string')
        href = mylink;
    else
        href = mylink.href;

    try {
        var w = window.open(href, windowname, 'width=800,height=800,scrollbars=yes');
        w.focus();
    } catch (er) {
        if (Ext.isIE) {
            alert("无法开启url:\n" + href);//<SIAT_zh_CN original="Unable to open the following url">无法开启url</SIAT_zh_CN>
        } else {
            alert("无法开启url:\n" + href + "\n这是因为非IE浏览器的安全问题.");//<SIAT_zh_CN original="Unable to open the following url">无法开启url</SIAT_zh_CN><SIAT_zh_CN original="This may be caused by security issues with non Internet Explorer browsers">这是因为非IE浏览器的安全问题</SIAT_zh_CN>
        }
    }
    return false;
}

// Show a dialog window animated from the specified id parameter with
// title and url contained in the value parameter.
function showDialog(id, value) {
    // Attempt to get existing window with id.
    var win = Ext.getCmp(id + '-win');

    if(win==null){
    win = new Ext.Window({
        id: id + '-win',
        animateTarget: id,
        autoScroll: true,
        width: 550,
        height: 350,
        closeAction: 'hide',
        bodyBorder: false,
        plain: true,
        constrain: true,
        title: value.title,
       // contentEl: value.element
        autoLoad: {
            url: value.url,
            nocache: false,
            discardUrl: false,
            method: "POST"
        }
    });
    }

    win.show();
    win.toFront();
    var anchor = id + '_anchor';
    if (document.getElementById(anchor) != null) {
        win.alignTo(anchor, 'bl-tl?');
    }
}

//Show a dialog window animated from the specified id parameter with
//title and content contained in value parameter.
function showDialogDiv(id, value) {
    // Attempt to get existing window with id.
    var win = Ext.getCmp(id + '-win');

    if(win==null){
 win = new Ext.Window({
     id: id + '-win',
     animateTarget: id,
     autoScroll: true,
     width: 550,
     height: 350,
     closeAction: 'hide',
     bodyBorder: false,
     plain: true,
     constrain: true,
     title: value.title,
     contentEl: value.element
 });
    }

 win.show();
 win.toFront();
 var atitle = id+'_anchor';
// alert(atitle);
//  var anchor = document.getElementById(value.title+'_anchor');
 win.alignTo(atitle,'bl-tl?');
}
function selectOnChange(url, id, name, value) {
    return new Ajax.Updater(id, url, {asynchronous:true, evalScripts:true, parameters:name + '=' + value});
}

function getResultType() {
    var resultType = "JUBILANT_ONCOLOGY_ALTERATION";
    var el = Ext.getDom("resultType");
    if (el != null) {
        resultType = el.value;
    }
    return resultType;
}

function validateDocumentFilters() {
    var form = document.documentfilters;
    if (form != null) {
        if (!form.repository_biomarker.checked &&
                !form.repository_conferences.checked &&
                !form.repository_dip.checked &&
                !form.repository_jubilant_oncology.checked) {
            alert("请选择至少一个存储库.");//<SIAT_zh_CN original="Please select at least one Repository">请选择至少一个存储库</SIAT_zh_CN>
            return false;
        }
        if (!form.type_excel.checked &&
                !form.type_html.checked &&
                !form.type_pdf.checked &&
                !form.type_powerpoint.checked &&
                !form.type_text.checked &&
                !form.type_word.checked &&
                !form.type_other.checked) {
            alert("请选择至少一个文件.");//<SIAT_zh_CN original="Please select at least one Document Type">请选择至少一个文件</SIAT_zh_CN>
            return false;
        }
    }
    return true;
}
