<html>
<head>
    <title>${grailsApplication.config.com.recomdata.appTitle}</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
</head>

<body>

<div id="summary">

    <g:if test="${pathway == null}">

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
                ${pathway.name}
            </span>
        </p>

        <div id="SummaryHeader">
            <span class="SummaryHeader">总结<!--<SIAT_zh_CN original="Summary">总结</SIAT_zh_CN>--></span>
        </div>
        <table class="SummaryTable" width="100%">
            ${createPropertyTableRow(width: '20%', label: 'Name', value: pathway.name)}<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '描述', value: pathway.description)}<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '生物体', value: pathway.organism)}<!--<SIAT_zh_CN original="Organism">生物体</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '首要', value: pathway.primarySourceCode)}<!--<SIAT_zh_CN original="Primary">首要</SIAT_zh_CN>-->
            ${createPropertyTableRow(width: '20%', label: '主要外部ID', value: pathway.primaryExternalId)}<!--<SIAT_zh_CN original="Primary External ID">主要外部ID</SIAT_zh_CN>-->
            <tr>
                <td width="20%"><b>基因:<!--<SIAT_zh_CN original="Genes">基因</SIAT_zh_CN>--></b></td>
                <td>
                    <g:each in="${genes}" status="i" var="gene">
                        <nobr>${gene.keyword}<g:if test="${i < genes.size() - 1}">,</g:if></nobr>
                    </g:each>
                </td>
            </tr>
        </table>
        <br/>
    </g:else>

</div>
</body>
</html>
