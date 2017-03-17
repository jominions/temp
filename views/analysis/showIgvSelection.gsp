<p><span style="color: red; ">${warningMsg}</span></p>
<table class="searchform">
    <tr><td style='white-space: nowrap'>子集1中的IGV数据集:<!--<SIAT_zh_CN original="IGV Datasets in Subset 1">子集1中的IGV数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_1}</td>
    </tr>
    <tr><td style='white-space: nowrap'>子集2中的IGV数据集:<!--<SIAT_zh_CN original="IGV Datasets in Subset 2">子集2中的IGV数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_2}</td>
    </tr>
    <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td></tr>
    <tr><td valign='top' style='white-space: nowrap'>选择染色体:<!--<SIAT_zh_CN original="Select Chromosomes">选择染色体</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
        <g:select name="igvChroms" id="igvChroms" from="${chroms}" value="${chromDefault}" multiple="multiple"
                  size="5"></g:select>
    </td>
    </tr>
    <tr><td valign='top' style='white-space: nowrap'>选择基因:<!--<SIAT_zh_CN original="Selected Genes">选择基因</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><input type="text" size="35" id="selectedGenesIgv" autocomplete="off"/>

        <div id="divPathwayIgv" style="width:100%; font:11px tahoma, arial, helvetica, sans-serif"><br>添加一个基因:<!--<SIAT_zh_CN original="Add a Gene">添加一个基因</SIAT_zh_CN>--><br>
            <input type="text" size="35" id="searchPathwayIgv" autocomplete="off"/>
            <input type="hidden" id="selectedGenesAndIdIgv"/>
        </div>
    </td>
    </tr>
    <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td></tr>
    <tr><td valign='top' style='white-space: nowrap'>选择 SNPs:<!--<SIAT_zh_CN original="Selected SNPs">选择 SNPs</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><input type="text" size="35" id="selectedSNPsIgv" autocomplete="off"/></td>
    </tr>
</table>

<script type="text/javascript">
    showPathwaySearchBox('selectedGenesIgv', 'selectedGenesAndIdIgv', 'searchPathwayIgv', 'divPathwayIgv');
</script>