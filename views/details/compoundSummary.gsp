<html>
<head>
    <title>${grailsApplication.config.com.recomdata.appTitle}</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
</head>

<body>

<div id="summary">

    <g:if test="${compound == null}">

        <table class="snoborder" width="100%">
            <tbody>
            <tr>
                <td width="100%" style="text-align: center; font-size: 14px; font-weight: bold">
                    没有总结数据可用<!--<SIAT_zh_CN original="No summary data available">没有总结数据可用</SIAT_zh_CN>-->
                </td>
            </tr>
            </tbody>
        </table>
    </g:if>
    <g:else>
        <p class="Title">
            <span class="Title">
                ${compound.genericName} 也被称为<!--<SIAT_zh_CN original="also known as">也被称为</SIAT_zh_CN>--> ${compound.codeName}
            </span>
        </p>

        <div id="SummaryHeader">
            <span class="SummaryHeader">总结<!--<SIAT_zh_CN original="Summary">总结</SIAT_zh_CN>--></span>
        </div>
        <table class="SummaryTable" width="100%">
            <tbody>
            ${createPropertyTableRow(width: '20%', label: '原始名称', value: compound.genericName)}<!--<SIAT_zh_CN original="Generic Name">原始名称</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '编码名称', value: compound.codeName)}<!--<SIAT_zh_CN original="Code Name">编码名称</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '商标名称', value: compound.brandName)}<!--<SIAT_zh_CN original="Brand Name">商标名称</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '化学名称', value: compound.chemicalName)}<!--<SIAT_zh_CN original="Chemical Name">化学名称</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '描述', value: compound.description)}<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '机制', value: compound.mechanism)}<!--<SIAT_zh_CN original="Mechanism">机制</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '产品类别', value: compound.productCategory)}<!--<SIAT_zh_CN original="Product Category">产品类别</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: 'CAS注册编号', value: compound.casRegistry)}<!--<SIAT_zh_CN original="CAS Registry Number">CAS注册编号</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: 'CNTO编号', value: compound.cntoNumber)}<!--<SIAT_zh_CN original="CNTO Number">CNTO编号</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '编号', value: compound.number)}<!--<SIAT_zh_CN original="Number">编号</SIAT_zh_CN>-->
            </tbody>
        </table>
        <br/>
    </g:else>

</div>
</body>
</html>
