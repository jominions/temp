</head>
<body>
<div id="header-div">
    <g:render template="/layouts/commonheader" model="['app': 'uploaddata']"/>

    <br/><br/>

    <div class="uploadwindow">

        <div>此文件已成功上传并加入案例(Study)<!--<SIAT_zh_CN original="The file was uploaded successfully and has been added to the study">此文件已成功上传并加入案例(Study)</SIAT_zh_CN>-->.
        </div>
        <br/>
        <a href="${createLink([action: 'index', controller: 'uploadData'])}">上传新文件<!--<SIAT_zh_CN original="Upload another file">上传新文件</SIAT_zh_CN>--></a>
        <br/><br/>
        <a href="${createLink([action: 'index', controller: 'RWG'])}">返回搜索页面<!--<SIAT_zh_CN original="Return to the search page">返回搜索页面</SIAT_zh_CN>--></a>
    </div>

</div>

</body>
</html>