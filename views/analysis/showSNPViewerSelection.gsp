<p><span style="color: red; ">${warningMsg}</span></p>
<table class="searchform">
    <tr><td style='white-space: nowrap'>子集1中的SNP数据集:<!--<SIAT_zh_CN original="SNP Datasets in Subset 1">子集1中的SNP数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_1}</td>
    </tr>
    <tr><td style='white-space: nowrap'>子集2中的SNP数据集:<!--<SIAT_zh_CN original="SNP Datasets in Subset 2">子集2中的SNP数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_2}</td>
    </tr>
    <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td></tr>
    <tr><td valign='top' style='white-space: nowrap'>选择染色体:<!--<SIAT_zh_CN original="Select Chromosomes">选择染色体</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
        <g:select name="snpViewChroms" id="snpViewChroms" from="${chroms}" value="${chromDefault}" multiple="multiple"
                  size="5"></g:select>
    </td>
    </tr>
    <tr><td valign='top' style='white-space: nowrap'>选择基因:<!--<SIAT_zh_CN original="Selected Genes">选择基因</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><input type="text" size="35" id="selectedGenesSNPViewer"
                                                    autocomplete="off"/>

        <div id="divPathwaySNPViewer"
             style="width:100%; font:11px tahoma, arial, helvetica, sans-serif"><br>增加一个基因:<!--<SIAT_zh_CN original="Add a Gene">增加一个基因</SIAT_zh_CN>--><br>
            <input type="text" size="35" id="searchPathwaySNPViewer" autocomplete="off"/>
            <input type="hidden" id="selectedGenesAndIdSNPViewer"/>
        </div>
    </td>
    </tr>
    <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td></tr>
    <tr><td valign='top' style='white-space: nowrap'>选择SNPs:<!--<SIAT_zh_CN original="Selected SNPs">选择SNPs</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><input type="text" size="35" id="selectedSNPs" autocomplete="off"/></td>
    </tr>
</table>

<script type="text/javascript">
    showPathwaySearchBox('selectedGenesSNPViewer', 'selectedGenesAndIdSNPViewer', 'searchPathwaySNPViewer', 'divPathwaySNPViewer');
</script>