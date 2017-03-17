<html>

<body>
<div id="summary">
    <div id="SummaryHeader"><span class="SummaryHeader">请选择一个细胞系<!--<SIAT_zh_CN original="Please Select A Cell Line">请选择一个细胞系</SIAT_zh_CN>--></span></div>

    <table class="trborderbottom" width="100%">
        <thead>
        <tr>
            <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
            <th>名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></th>
            <th style="white-space: nowrap;">ATCC 序号<!--<SIAT_zh_CN original="ATCC Number">ATCC 序号</SIAT_zh_CN>--></th>
            <th>物种<!--<SIAT_zh_CN original="Species">物种</SIAT_zh_CN>--></th>
            <th>疾病<!--<SIAT_zh_CN original="Disease">疾病</SIAT_zh_CN>--></th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${cellLines}" var="cl" status="i">
            <tr style="border-bottom:1px solid #CCCCCC;padding-botton:2px;">
                <td>&nbsp;<g:radio name="cellLine" value="${cl.id}"
                                   onclick="selectCellLine(${cl.id},'${cl.cellLineName + ' (' + cl.attcNumber + ')'}');"/></td>
                <td>${cl.cellLineName}</td>
                <td>${cl.attcNumber}</td>
                <td>${cl.species}</td>
                <td>${cl.disease}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

</div>
</body>
</html>