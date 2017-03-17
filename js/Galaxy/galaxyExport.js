
function getJobsDataForGalaxy(tab)
{
    galaxyjobsstore = new Ext.data.JsonStore({
        url : pageInfo.basePath+'/RetrieveData/getjobs',
        root : 'jobs',
        fields : ['name', 'status', 'lastExportName', 'lastExportTime', 'exportStatus']
    });

    galaxyjobsstore.on('load', galaxyjobsstoreLoaded);
    var myparams = Ext.urlEncode({jobType: 'DataExport',disableCaching: true});
    galaxyjobsstore.load({ params : myparams  });
}

function galaxyjobsstoreLoaded()
{
    var foo = galaxyjobsstore;
    var ojobs = Ext.getCmp('ajobsgrid');
    if(ojobs!=null)
    {
        GalaxyPanel.remove(ojobs);
    }
    var jobs = new Ext.grid.GridPanel({
        store: galaxyjobsstore,
        id:'ajobsgrid',
        columns: [
            {name:'name', header: "Name", width: 120, sortable: true, dataIndex: 'name',
                renderer: function(value, metaData, record, rowIndex, colIndex, store) {
                    var changedName;
                    if (store.getAt(rowIndex).get('status') == 'Completed') {
                        changedName = '<a href="#">'+value+'</a>';
                    } else {
                        changedName = value;
                    }
                    return changedName;
                }
            },
            

            
            {name:'status', header: "状态", width: 120, sortable: true, dataIndex: 'status'},//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>       
            {name:'runTime', header: "运行时间", width: 120, sortable: true, dataIndex: 'runTime', hidden: true}, //<SIAT_zh_CN original="Run Time">运行时间</SIAT_zh_CN>
            {name:'startDate', header: "开始于", width: 120, sortable: true, dataIndex: 'startDate', hidden: true},//<SIAT_zh_CN original="Started On">开始于</SIAT_zh_CN>
            {name:'viewerURL', header: "视图URL", width: 120, sortable: false, dataIndex: 'viewerURL', hidden: true},  //<SIAT_zh_CN original="Viewer URL">视图URL</SIAT_zh_CN>
            {name:'altViewerURL', header: "Alt视图URL", width: 120, sortable: false, dataIndex: 'altViewerURL', hidden: true},//<SIAT_zh_CN original="Alt Viewer URL">Alt视图URL</SIAT_zh_CN>
            {name:'lastExportName', header: "上次导出名称", width: 120, sortable: true, dataIndex: 'lastExportName'},//<SIAT_zh_CN original="lastExportName">上次导出名称</SIAT_zh_CN>
            {name:'lastExportTime', header: "上次导出时间", width: 120, sortable: true, dataIndex: 'lastExportTime' }, //<SIAT_zh_CN original="lastExportTime">上次导出时间</SIAT_zh_CN>
            {name:'exportStatus', header: "导出状态", width: 120, sortable: true, dataIndex: 'exportStatus' }//<SIAT_zh_CN original="exportStatus">导出状态</SIAT_zh_CN>

        ],
        listeners : {cellclick : function (grid, rowIndex, columnIndex, e){
            var colHeader = grid.getColumnModel().getColumnHeader(columnIndex);
            if (colHeader == "Name") {
                var status = grid.getStore().getAt(rowIndex).get('status');
                if (status == "Error")  {
                Ext.Msg.alert("工作失败", "工作产生错误.");//<SIAT_zh_CN original="Job Failure">工作失败</SIAT_zh_CN><SIAT_zh_CN original="Unfortunately, an error occurred on this job">工作产生错误</SIAT_zh_CN>
                } else if (status == "Cancelled")   {
                Ext.Msg.alert("工作取消", "工作已被取消");}//<SIAT_zh_CN original="Job Cancelled">工作取消</SIAT_zh_CN><SIAT_zh_CN original="The job has been cancelled">工作已被取消</SIAT_zh_CN>
                else if (status == "Completed") {
                    Ext.Msg.prompt('Name', '已汇出的图书馆(Library)名称:', function(btn, text){//<SIAT_zh_CN original="Name of the Library to be exported">已汇出的图书馆(Library)名称</SIAT_zh_CN>
                        if (btn == 'ok'){
                            var nameOfTheLibrary = text;
                            var nameOfTheExportJob = grid.getStore().getAt(rowIndex).get('name');
                            Ext.Ajax.request({
                                url: pageInfo.basePath+'/RetrieveData/JobExportToGalaxy',
                                method: 'POST',
                                params: {
                                    "nameOfTheLibrary" : nameOfTheLibrary,
                                    "nameOfTheExportJob" : nameOfTheExportJob
                                },
                                success: function(response) {
                                    if (200 == response.status){
                                        Ext.Msg.show({
                                            title:'要求已送出',//<SIAT_zh_CN original="Request Sent">要求已送出</SIAT_zh_CN>
                                            msg: '导出要求已送至Galaxy',//<SIAT_zh_CN original="The export request has been sent to Galaxy">导出要求已送至Galaxy</SIAT_zh_CN>
                                            buttons: Ext.Msg.OK,
                                            animEl: 'elId'
                                        });
                                    }
                                    else{
                                        Ext.Msg.alert("工作失败", "工作产生错误, 错误="+ response.status.toString());//<SIAT_zh_CN original="Job Failure">工作失败</SIAT_zh_CN><SIAT_zh_CN original="Unfortunately, an error occurred on this job. Error">工作产生错误, 错误</SIAT_zh_CN>
                                    }
                                }
                            });
                        }
                    })
                 }
                else if (status != "Completed") {
                    Ext.Msg.alert("工作处理中", "此项工作仍在处理中, 请稍后");//<SIAT_zh_CN original="Job Processing">工作处理中</SIAT_zh_CN><SIAT_zh_CN original="The job is still processing, please wait">此项工作仍在处理中, 请稍后</SIAT_zh_CN>
                }
            }
        }
        },
        viewConfig: {
            forceFit : true
        },
        sm : new Ext.grid.RowSelectionModel({singleSelect : true}),
        layout : 'fit',
        width : 600,
        buttons: [{
            text:'Refresh',
            handler: function() {
                galaxyjobsstore.reload();
            }
        }],
        buttonAlign:'center',
        tbar:['->',{
            id:'help',
            tooltip:'点击取得帮助',//<SIAT_zh_CN original="Click for Jobs help">点击取得帮助</SIAT_zh_CN>
            iconCls: "contextHelpBtn",
            handler: function(event, toolEl, panel){
                D2H_ShowHelp("1456",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
            }
        }]
    });
    GalaxyPanel.add(jobs);
    GalaxyPanel.doLayout();
}
