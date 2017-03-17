function getExportJobs(tab)
{
	//TODO : point it to /asyncJob/getjobs : somehow the UI in "Export Jobs" tab seems to be not showing the list of jobs
	exportjobsstore = new Ext.data.JsonStore({
		url : pageInfo.basePath+'/asyncJob/getjobs',
		root : 'jobs',
		totalProperty : 'totalCount',
		fields : ['name', 'status', 'runTime', 'startDate', 'viewerURL', 'altViewerURL']
	});
	exportjobsstore.on('load', exportjobsstoreLoaded);
	var myparams = Ext.urlEncode({jobType: 'DataExport', disableCaching: true});
	exportjobsstore.load({params : myparams});
}

function exportjobsstoreLoaded()
{
	var foo = exportjobsstore;

//	if(window.exportJobs)
//	{
//		analysisExportJobsPanel.remove(exportJobs);
//	}
	var ojobs = Ext.getCmp('exportJobsgrid');
	if(ojobs!=null)
	{
		analysisExportJobsPanel.remove(ojobs);
	}
    var jobs = new Ext.grid.GridPanel({    		
		store: exportjobsstore,
		id:'exportJobsgrid',
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
	         
		          {name:'altViewerURL', header: "查询总结", width: 120, sortable: false, dataIndex: 'altViewerURL'},//<SIAT_zh_CN original="Query Summary">查询总结</SIAT_zh_CN>
		          {name:'status', header: "状态", width: 60, sortable: true, dataIndex: 'status'},//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>
		          {name:'runTime', header: "运行时间", width: 80, sortable: true, dataIndex: 'runTime', hidden: true},//<SIAT_zh_CN original="Run Time">运行时间</SIAT_zh_CN>
		          {name:'startDate', header: "开始于", width: 80, sortable: true, dataIndex: 'startDate'},//<SIAT_zh_CN original="Started On">开始于</SIAT_zh_CN>
		          {name:'viewerURL', header: "视图URL", width: 120, sortable: false, dataIndex: 'viewerURL', hidden: true} //<SIAT_zh_CN original="Viewer URL">视图URL</SIAT_zh_CN>
		],
		listeners : {cellclick : function (grid, rowIndex, columnIndex, e) 
			{
				var colHeader = grid.getColumnModel().getColumnHeader(columnIndex);
				if (colHeader == "Name") {//<SIAT_zh_CN original="Name">Name</SIAT_zh_CN>
					var status = grid.getStore().getAt(rowIndex).get('status');
					if (status == "Error")	{
						Ext.Msg.alert("工作失败", "抱歉，在产生此数据导出时发生错误。");//<SIAT_zh_CN original="Job Failure">工作失败</SIAT_zh_CN>//<SIAT_zh_CN original="Unfortunately, an error occurred generating this data-export">抱歉，在产生此数据导出时发生错误。</SIAT_zh_CN>	
					} else if (status == "Cancelled")	{
						Ext.Msg.alert("工作取消", "工作已被取消。");//<SIAT_zh_CN original="Job Cancelled">工作取消</SIAT_zh_CN>//<SIAT_zh_CN original="The job has been cancelled">工作已被取消。</SIAT_zh_CN>
					} else if (status == "Completed") {
						// this implementation is inside button handler on step 5
						Ext.Ajax.request({
								url: pageInfo.basePath+'/dataExport/downloadFileExists',
								method: 'POST',
								params: 'jobname=' + grid.getStore().getAt(rowIndex).get('name'),
								success: function(obj) {
									var resp = Ext.decode(obj.responseText);
									if (!resp.fileStatus) {
										Ext.MessageBox.alert('文件未找到！！！', resp.message);//<SIAT_zh_CN original="File not Found!!!">文件未找到！！！</SIAT_zh_CN>
									} else {
										try {
										    Ext.destroy(Ext.get('jobname'));
										} catch(e) {}
										var body = Ext.getBody();
									    var frame = body.createChild({tag:'iframe',cls:'x-hidden',id:'iframe',name:'iframe'});
									    //var params = {'jobname': grid.getStore().getAt(rowIndex).get('name')};
									    var form = body.createChild({tag:'form',cls:'x-hidden',id:'form',
									    	action:pageInfo.basePath+'/dataExport/downloadFile',
									        target:'iframe'
									    });
									    
									    var jobname = new Ext.form.Field({
										    	fieldLabel: '', id:'jobname', name:'jobname', labelSeparator: ' ', boxLabel:'', hidden: true, 
										    	value: grid.getStore().getAt(rowIndex).get('name'), renderTo: form
									    	});
									    form.dom.submit();
									}
								}
							});
					} else if (status != "Completed") {
						Ext.Msg.alert("工作正在处理", "工作仍在进行中，请耐心等候。");
					}		//<SIAT_zh_CN original="Job Processing">工作正在处理</SIAT_zh_CN>//<SIAT_zh_CN original="The job is still processing, please wait">工作仍在进行中，请耐心等候。</SIAT_zh_CN>			
				}
			}
		},
		viewConfig:	{
			forceFit : true
		},
		sm : new Ext.grid.RowSelectionModel({singleSelect : true}),
		layout : 'fit',
		width : 600,
		buttons: [{
			text:'刷新',//<SIAT_zh_CN original="Refresh">刷新</SIAT_zh_CN>
			handler: function()	{
      		  exportjobsstore.reload();
			}      	
       }],
        buttonAlign:'center',
        tbar:['->',{
            id:'help',
            tooltip:'点击以获取工作帮助',//<SIAT_zh_CN original="Click for Jobs help">点击以获取工作帮助</SIAT_zh_CN>
            iconCls: "contextHelpBtn",
            handler: function(event, toolEl, panel){
		    	D2H_ShowHelp("1456",helpURL,"wndExternal",CTXT_DISPLAY_FULLHELP );
		    }
        }]
	});                
    analysisExportJobsPanel.add(jobs);
    analysisExportJobsPanel.doLayout();
    analysisExportJobsPanel.body.unmask();
}
