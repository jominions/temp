</head>
<body>
<div id="header-div">
    <g:render template="/layouts/commonheader" model="['app': 'uploaddata']"/>

    <br/><br/>

    <div class="uploadwindow">
        <g:if test="${result.success == true}">
            <div>文件上传成功并于队列中等待处理<!--<SIAT_zh_CN original="The file was uploaded successfully and has been submitted to the queue for processing">文件上传成功并于队列中等待处理</SIAT_zh_CN>-->.
                <br/>
                此分析工作预计于晚间处理，明日完成工作<!--<SIAT_zh_CN original="This analysis will be processed overnight and should be available by tomorrow">此分析工作预计于晚间处理，明日完成工作</SIAT_zh_CN>-->.
            </div>
            <br/>
            <a href="${createLink([action: 'index', controller: 'uploadData'])}">上传新文件<!--<SIAT_zh_CN original="Upload another file">上传新文件</SIAT_zh_CN>--></a>
        </g:if>
        <g:else>
            <div>元数据(metadata)已储存，但上传文件发生问题<!--<SIAT_zh_CN original="The metadata has been saved, but there was a problem uploading the file">元数据(metadata)已储存，但上传文件发生问题</SIAT_zh_CN>-->:</div>

            <div class="uploaderror">${result.error}</div>
            <g:if test="${result.requiredFields}">
                <table class="uploadfieldtable">
                    <tr>
                        <td class="datalabel">文件中栏位<!--<SIAT_zh_CN original="Fields in file">文件中栏位</SIAT_zh_CN>--></td>
                        <td>${result.providedFields.join(", ")}</td>
                    </tr>
                    <tr>
                        <td class="datalabel">需要的栏位<!--<SIAT_zh_CN original="Required fields">需要的栏位</SIAT_zh_CN>--></td>
                        <td>${result.requiredFields.join(", ")}</td>
                    </tr>
                    <tr>
                        <td class="datalabel">缺少的栏位<!--<SIAT_zh_CN original="Missing fields">缺少的栏位</SIAT_zh_CN>--></td>
                        <td class="uploaderror">${result.missingFields.join(", ")}</td>
                    </tr>
                </table>
            </g:if>
            <br/>
            <a href="${createLink([action: 'edit', controller: 'uploadData', id: uploadDataInstance.id])}">编辑/重新提交<!--<SIAT_zh_CN original="Edit/resubmit this upload">编辑/重新提交</SIAT_zh_CN>--></a>
        </g:else>
        <br/><br/>
        <a href="${createLink([action: 'index', controller: 'RWG'])}">返回搜索页面<!--<SIAT_zh_CN original="Return to the search page">返回搜索页面</SIAT_zh_CN>--></a>
    </div>

</div>

</body>
</html>