function getJobsData(tab) {
    jobsstore = new Ext.data.JsonStore(
        {
            url: pageInfo.basePath + '/asyncJob/getjobs',
            root: 'jobs',
            totalProperty: 'totalCount',
            fields: ['name', 'type', 'status', 'runTime', 'startDate', 'viewerURL', 'altViewerURL']
        }
    );
    jobsstore.on('load', jobsstoreLoaded);
    var myparams = Ext.urlEncode({disableCaching: true});
    jobsstore.load(
        {
            params: myparams
        }
    );
}

function jobsstoreLoaded() {
    var ojobs = Ext.getCmp('ajobsgrid');
    if (ojobs != null) {
        analysisJobsPanel.remove(ojobs);
    }

    // Filter for job types that are retrievable
    jobsstore.filterBy(function(record) {
        var allowedTypes = ['aCGHSurvivalAnalysis', 'aCGHgroupTest', 'RNASeqgroupTest', 'acghFrequencyPlot'];
        return allowedTypes.indexOf(record.json.type) >= 0;
    });

    var jobsGrid = new Ext.grid.GridPanel({
        store: jobsstore,
        id: 'ajobsgrid',
        columns: [
        
            {name: 'name', header: "Name", width: 120, sortable: true, dataIndex: 'name', css: 'text-decoration: underline; color: blue;'},//<SIAT_zh_CN original="Name">Name</SIAT_zh_CN>
            {name: 'status', header: "状态", width: 120, sortable: true, dataIndex: 'status'},//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>
            {name: 'runTime', header: "运行时间", width: 120, sortable: true, dataIndex: 'runTime'}, //<SIAT_zh_CN original="Run Time">运行时间</SIAT_zh_CN>
            {name: 'startDate', header: "开始于", width: 120, sortable: true, dataIndex: 'startDate'},//<SIAT_zh_CN original="Started On">开始于</SIAT_zh_CN>
            {name: 'viewerURL', header: "视图URL", width: 120, sortable: false, dataIndex: 'viewerURL', hidden: true}, //<SIAT_zh_CN original="Viewer URL">视图URL</SIAT_zh_CN>
            {name: 'altViewerURL', header: "Alt视图URL", width: 120, sortable: false, dataIndex: 'altViewerURL', hidden: true}    //<SIAT_zh_CN original="Alt Viewer URL">Alt视图URL</SIAT_zh_CN>
        ],
        listeners: {cellclick: function (grid, rowIndex, columnIndex, e) {
            var colHeader = grid.getColumnModel().getColumnHeader(columnIndex);
            if (colHeader == "Name") {
                var record = grid.getStore().getAt(rowIndex);
                var viewerURL = record.get('viewerURL');
                var altViewerURL = record.get('altViewerURL');
                if (altViewerURL == null) {
                    altViewerURL = "";
                }
                var jobName = record.get('name');
                var jobType = record.get('type');
                var status = record.get('status');

                if (status == "Completed") {
                    // First, we check all of the general heatmaps that store a URL
                    // Second, we check for special cases where the results are stored in JOB_RESULTS field
                    if (viewerURL != null) {
                        // at the moment specific to these two analysis will load the analysis page
                        if (jobType == 'aCGHSurvivalAnalysis' ||
                            jobType == 'aCGHgroupTest' ||
                            jobType == 'RNASeqgroupTest' ||
                            jobType == 'acghFrequencyPlot') {
                            resultsTabPanel.setActiveTab('dataAssociationPanel');
                            loadAnalysisPage(jobType, true, jobName);
                            return;
                        } else { // otherwise .. using visualizer
                            runVisualizerFromSpan(viewerURL, altViewerURL);
                        }
                    } else {
                        Ext.Ajax.request({
                            url: pageInfo.basePath + "/asyncJob/getjobresults",
                            method: 'POST',
                            success: function (result, request) {
                                var jobResultsInfo = Ext.util.JSON.decode(result.responseText);
                                var jobResults = jobResultsInfo.jobResults;
                                if (jobType == "Survival") {
                                    showSurvivalAnalysisWindow(jobResults);
                                } else {
                                    showHaploViewWindow(jobResults);
                                }
                            },
                            failure: function (result, request) {
                                Ext.Msg.alert('请联络tranSMART管理员', '无法显示结果.');//<SIAT_zh_CN original="Please, Contact a tranSMART Administrator"></SIAT_zh_CN>请联络tranSMART管理员<SIAT_zh_CN original="Unable to show the results">无法显示结果</SIAT_zh_CN>
                            },
                            timeout: '1800000',
                            params: {jobname: jobName}
                        });
                    }
                } else if (status == "Error") {
                    Ext.Msg.alert("工作失败", "生成此heatmap时产生错误");//<SIAT_zh_CN original="Job Failure">工作失败</SIAT_zh_CN><SIAT_zh_CN original="Unfortunately, an error occurred generating this heatmap">生成此heatmap时产生错误</SIAT_zh_CN>
                } else if (status == "Cancelled") {
                    Ext.Msg.alert("工作取消", "此项工作已取消");//<SIAT_zh_CN original="Job Cancelled">工作取消</SIAT_zh_CN><SIAT_zh_CN original="The job has been cancelled">此项工作已取消</SIAT_zh_CN>
                } else {
                    Ext.Msg.alert("工作处理中", "此项工作正在进行中, 请稍后");//<SIAT_zh_CN original="Job Processing">工作处理中</SIAT_zh_CN><SIAT_zh_CN original="The job is still processing, please wait">此项工作正在进行中, 请稍后</SIAT_zh_CN>
                }
            }
        }
        },
        viewConfig: {
            forceFit: true
        },
        sm: new Ext.grid.RowSelectionModel({singleSelect: true}),
        layout: 'fit',
        width: 600,
        buttons: [
            {
                text: '刷新',//<SIAT_zh_CN original="Refresh">刷新</SIAT_zh_CN>
                handler: function () {
                    jobsstore.reload();
                }
            }
        ],
        buttonAlign: 'center',
        tbar: ['->', {
            id: 'help',
            tooltip: '点击取得帮助',//<SIAT_zh_CN original="Click for Jobs help">点击取得帮助</SIAT_zh_CN>
            iconCls: "contextHelpBtn",
            handler: function (event, toolEl, panel) {
                D2H_ShowHelp("1476", helpURL, "wndExternal", CTXT_DISPLAY_FULLHELP);
            }
        }]
    });
    analysisJobsPanel.add(jobsGrid);
    analysisJobsPanel.doLayout();
}

//Called to show the new job status window
function showJobStatusWindow(result, messages) {
    var jobInfo = Ext.util.JSON.decode(result.responseText);
    var jobName = jobInfo.jobName;
    var sb = Ext.getCmp('asyncjob-statusbar');
    sb.setVisible(false);   // Initially, hide the status bar unless the user selects to run in the background

    var jobWindow = new Ext.Window({
        id: 'showJobStatus',
        title: '工作状态',//<SIAT_zh_CN original="Job Status">工作状态</SIAT_zh_CN>
        layout: 'fit',
        width: 350,
        height: 400,
        closable: false,
        plain: true,
        modal: true,
        border: false,
        resizable: false,
        buttons: [
            {
                text: '取消工作',//<SIAT_zh_CN original="Cancel Job">取消工作</SIAT_zh_CN>
                handler: function () {
                    cancelJob(jobName);
                    sb.setVisible(true);
                    if (messages && messages.cancelMsg) {
                        Ext.Msg.alert("工作被取消", messages.cancelMsg);//<SIAT_zh_CN original="Job Cancelled">工作被取消</SIAT_zh_CN>
                        Ext.MessageBox.hide.defer(5000, this);
                    }
                    jobWindow.close();
                }
            },
            {
                text: '后台运行',//<SIAT_zh_CN original="Run in Background">后台运行</SIAT_zh_CN>
                handler: function () {
                    sb.setVisible(true);
                    if (messages && messages.backgroundMsg) {
                        Ext.Msg.alert("后台处理工作中", messages.backgroundMsg);//<SIAT_zh_CN original="Job processing in background">后台处理工作中</SIAT_zh_CN>
                        Ext.MessageBox.hide.defer(5000, this);
                    }
                    jobWindow.close();
                }
            }
        ],
        autoLoad: {
            url: pageInfo.basePath + '/asyncJob/showJobStatus',
            scripts: true,
            nocache: true,
            discardUrl: true,
            method: 'POST',
            params: {jobName: jobName}
        }
    });
    jobWindow.show(viewport);
}

// Used to cancel a given job, this can be called from the Job Status window or the progress toolbar
function cancelJob(jobName) {
    Ext.Ajax.request(
        {
            url: pageInfo.basePath + "/asyncJob/canceljob",
            method: 'POST',
            timeout: '300000',
            params: {jobName: jobName}
        }
    );
}

// Called to check the heatmap job status 
function checkJobStatus(jobName) {
    var sb = Ext.getCmp('asyncjob-statusbar');
    var cancBtn = Ext.getCmp('cancjob-button');
    var jWindow = Ext.getCmp('showJobStatus');
    var secCount = 0;
    var pollInterval = 3000;   // 4 second
    var singletonflag = 0; // make sure we don't invoke heatmap more than once on job completion

    // Add the handler for the cancel button in the statusbar
    cancBtn.setVisible(true);
    cancBtn.setHandler(function () {
        runner.stopAll();
        sb.setStatus({
            text: '工作已取消',//<SIAT_zh_CN original="Job cancelled">工作已取消</SIAT_zh_CN>
            clear: true
        });
        cancBtn.setVisible(false);
        cancelJob(jobName);
    });

    var updateJobStatus = function () {

        secCount = secCount + 3; // 3 seconds

        Ext.Ajax.request(
            {
                url: pageInfo.basePath + "/asyncJob/checkJobStatus",
                method: 'POST',
                success: function (result, request) {
                    var jobStatusInfo = Ext.util.JSON.decode(result.responseText);
                    var status = jobStatusInfo.jobStatus;
                    var viewerURL = jobStatusInfo.jobViewerURL;
                    var altViewerURL = jobStatusInfo.jobAltViewerURL;
                    var exception = jobStatusInfo.jobException;
                    var newHTML = jobStatusInfo.jobStatusHTML;
                    var resultType = jobStatusInfo.resultType;
                    var jobResults = jobStatusInfo.jobResults;

                    if (newHTML != null) {
                        if (jWindow != null && jWindow.isVisible()) {
                            jWindow.body.update(newHTML);
                        }
                    }

                    if (status == 'Error') {
                        if (jWindow != null && jWindow.isVisible()) {
                            jWindow.close();
                        }
                        Ext.Msg.alert('请联系tranSMART管理员', '无法完成: ' + exception);//<SIAT_zh_CN original="Please, Contact a tranSMART Administrator">请联系tranSMART管理员</SIAT_zh_CN><SIAT_zh_CN original="Unable to complete">无法完成</SIAT_zh_CN>
                        runner.stopAll();

                        sb.setStatus({
                            text: "状态: 错误",//<SIAT_zh_CN original="Status: Error">状态: 错误</SIAT_zh_CN>
                            clear: true
                        });
                        cancBtn.setVisible(false);
                    } else if (status == 'Completed') {
                        singletonflag++;

                        if (jWindow != null && jWindow.isVisible()) {
                            jWindow.close();
                        }

                        runner.stopAll();

                        sb.setStatus({
                            text: "状态: " + status,//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN>
                            clear: true
                        });
                        cancBtn.setVisible(false);
                        if (singletonflag == 1) {
                            if (resultType == null) {
                                // resultType is only used for special cases (surivival, haploview, snp, igv, plink)
                                // Here lies the Venkat rule for standard heatmaps
                                // < 120 seconds, just popup the heatmap.
                                // >= 120 seconds then popup a message to indicate that the heatmap is finished.
                                if (secCount < 120) {
                                    //runVisualizerFromSpan(viewerURL, altViewerURL);
                                    window.location.href = pageInfo.basePath + "/dataExport/downloadFile?jobname=" + jobName;
                                } else {
                                    Ext.Msg.buttonText.yes = '现在检视';//<SIAT_zh_CN original="View Now">现在检视</SIAT_zh_CN>
                                    Ext.Msg.buttonText.no = '稍后检视';//<SIAT_zh_CN original="View Later">稍后检视</SIAT_zh_CN>
                                    Ext.Msg.show({
                                        title: '结果已可显示',//<SIAT_zh_CN original="Results Are Ready For Viewing">结果已可显示</SIAT_zh_CN>
                                        msg: '您希望现在或稍后通过"工作"页签检视结果吗?',//<SIAT_zh_CN original="Would you like to view results now or later through the Jobs tab">您希望现在或稍后通过"工作"页签检视结果吗</SIAT_zh_CN>
                                        buttons: Ext.Msg.YESNO,
                                        fn: function (btn) {
                                            if (btn == 'yes') {
                                                //runVisualizerFromSpan(viewerURL, altViewerURL);
                                                window.location.href = pageInfo.basePath + "/dataExport/downloadFile?jobname=" + jobName;
                                            }
                                        },
                                        icon: Ext.MessageBox.QUESTION
                                    });
                                }
                            } else if (resultType == "Survival") {
                                showSurvivalAnalysisWindow(jobResults);
                            } else if (resultType == "GWAS") {
                                showGwasWindow(jobResults);
                            } else if (resultType == "Haplo") {
                                showHaploViewWindow(jobResults);
                            }
                        }
                    } else if (status == 'Cancelled') {
                        if (jWindow != null && jWindow.isVisible()) {
                            jWindow.close();
                        }
                        runner.stopAll();
                        sb.setStatus({
                            text: '工作已取消',//<SIAT_zh_CN original="Job cancelled">工作已取消</SIAT_zh_CN>
                            clear: true
                        });
                        cancBtn.setVisible(false);
                    } else {
                        var secLabel = " seconds"
                        if (secCount == 1) {
                            secLabel = " second"
                        }
                        sb.showBusy("状态: " + jobStatusInfo.jobStatus + ", 为运行 " + String(secCount) + secLabel);//<SIAT_zh_CN original="Status">状态</SIAT_zh_CN><SIAT_zh_CN original="running for">为运行</SIAT_zh_CN>
                    }
                },
                failure: function (result, request) {
                    Ext.Msg.alert('失败', '无法完成此工作, 请联系管理员');//<SIAT_zh_CN original="Failed">失败</SIAT_zh_CN><SIAT_zh_CN original="Could not complete the job, please contact an administrator">无法完成此工作, 请联系管理员</SIAT_zh_CN>
                    runner.stopAll();
                    sb.setStatus({
                        text: "状态: 失败",//<SIAT_zh_CN original="Status: Failed">状态: 失败</SIAT_zh_CN>
                        clear: true
                    });
                    cancBtn.setVisible(false);
                },
                timeout: '300000',
                params: {jobName: jobName
                }
            }
        );
    }

    var checkTask = {
        run: updateJobStatus,
        interval: pollInterval
    }
    var runner = new Ext.util.TaskRunner();
    runner.start(checkTask);
}

