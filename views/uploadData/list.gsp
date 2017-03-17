</head>
<body>
<div id="header-div">
    <g:render template="/layouts/commonheader" model="['app': 'uploaddata']"/>

    <br/><br/>

    <div class="uploadwindow" style="width: 95%">
        <div>最近上传的20个数据列表<!--<SIAT_zh_CN original="List of the 20 most recent data uploads">最近上传的20个数据列表</SIAT_zh_CN>-->
        </div>
        <table class="uploadfieldtable" style="margin:0px">
            <thead>
            <tr>
                <th>id<!--<SIAT_zh_CN original="id">id</SIAT_zh_CN>--></th>
                <th>案例(Study)<!--<SIAT_zh_CN original="study">案例(Study)</SIAT_zh_CN>--></th>
                <th>数据类型<!--<SIAT_zh_CN original="dataType">数据类型</SIAT_zh_CN>--></th>
                <th>分析名称<!--<SIAT_zh_CN original="analysisName">分析名称</SIAT_zh_CN>--></th>
                <th>表型IDs(phenotypeIds)<!--<SIAT_zh_CN original="phenotypeIds">表型Ids</SIAT_zh_CN>--></th>
                <th>genotypePlatformIds<!--<SIAT_zh_CN original="genotypePlatformIds">genotypePlatformIds</SIAT_zh_CN>--></th>
                <th>expressionPlatformIds<!--<SIAT_zh_CN original="expressionPlatformIds">expressionPlatformIds</SIAT_zh_CN>--></th>
                <th>统计试验<!--<SIAT_zh_CN original="statisticalTest">统计试验</SIAT_zh_CN>--></th>
                <th>研究单元<!--<SIAT_zh_CN original="researchUnit">研究单元</SIAT_zh_CN>--></th>
                <th>样本大小<!--<SIAT_zh_CN original="sampleSize">样本大小</SIAT_zh_CN>--></th>
                <th>cellType<!--<SIAT_zh_CN original="cellType">cellType</SIAT_zh_CN>--></th>
                <th>模型名称<!--<SIAT_zh_CN original="modelName">模型名称</SIAT_zh_CN>--></th>
                <th>p值切断<!--<SIAT_zh_CN original="pValueCutoff">p值切断</SIAT_zh_CN>--></th>
                <th>etlDate<!--<SIAT_zh_CN original="etlDate">etlDate</SIAT_zh_CN>--></th>
                <th>处理日期<!--<SIAT_zh_CN original="processDate">处理日期</SIAT_zh_CN>--></th>
                <th>文件名称<!--<SIAT_zh_CN original="filename">文件名称</SIAT_zh_CN>--></th>
                <th>状态<!--<SIAT_zh_CN original="status">状态</SIAT_zh_CN>--></th>
                <th>sensitiveFlag<!--<SIAT_zh_CN original="sensitiveFlag">sensitiveFlag</SIAT_zh_CN>--></th>
                <th>sensitiveDesc<!--<SIAT_zh_CN original="sensitiveDesc">sensitiveDesc</SIAT_zh_CN>--></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${uploads}" var="upload">
                <tr>
                    <td>${upload.id}</td>
                    <td>${upload.study}</td>
                    <td>${upload.dataType}</td>
                    <td>${upload.analysisName}</td>
                    <td><g:each in="${upload.phenotypeIds?.split(';')}" var="me">${me}<br/></g:each></td>
                    <td>${upload.genotypePlatformIds}</td>
                    <td>${upload.expressionPlatformIds}</td>
                    <td>${upload.statisticalTest}</td>
                    <td>${upload.researchUnit}</td>
                    <td>${upload.sampleSize}</td>
                    <td>${upload.cellType}</td>
                    <td>${upload.modelName}</td>
                    <td>${upload.pValueCutoff}</td>
                    <td>${upload.etlDate}</td>
                    <td>${upload.processDate}</td>
                    <td>${upload.filename}</td>
                    <td>${upload.status}</td>
                    <td>${upload.sensitiveFlag}</td>
                    <td>${upload.sensitiveDesc}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>