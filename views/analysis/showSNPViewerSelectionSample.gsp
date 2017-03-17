<p><span style="color: red; ">
    ${warningMsg}
</span></p>
<table class="searchform">

    <g:each in="${snpDatasets}" status="i" var="snpSubset">
        <tr>
            <td style='white-space: nowrap'>子集中的SNP数据集<!--<SIAT_zh_CN original="SNP Datasets in Subset">子集中的SNP数据集</SIAT_zh_CN>--> ${snpSubset.key}:</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
                ${snpSubset.value}
            </td>
        </tr>
    </g:each>

    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td valign='top' style='white-space: nowrap'>选择染色体:<!--<SIAT_zh_CN original="Select Chromosomes">选择染色体</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><g:select name="snpViewChroms" id="snpViewChroms"
                      from="${chroms}" value="${chromDefault}" multiple="multiple" size="5"></g:select>
        </td>
    </tr>
    <tr>
        <td valign='top' style='white-space: nowrap'>选择基因:<!--<SIAT_zh_CN original="Select genes">选择基因</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><input type="text" size="35" id="selectedGenesSNPViewer"
                   autocomplete="off"/>

            <div id="divPathwaySNPViewer"
                 style="width: 100%; font: 11px tahoma, arial, helvetica, sans-serif"><br>
                增加一个基因:<!--<SIAT_zh_CN original="Add a Gene">增加一个基因</SIAT_zh_CN>--><br>
                <input type="text" size="35" id="searchPathwaySNPViewer"
                       autocomplete="off"/> <input type="hidden"
                                                   id="selectedGenesAndIdSNPViewer"/></div>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td valign='top' style='white-space: nowrap'>选择 SNPs:<!--<SIAT_zh_CN original="Selected SNPs">选择 SNPs</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><input type="text" size="35" id="selectedSNPs"
                   autocomplete="off"/></td>
    </tr>
</table>

<script type="text/javascript">
    showPathwaySearchBox('selectedGenesSNPViewer', 'selectedGenesAndIdSNPViewer', 'searchPathwaySNPViewer', 'divPathwaySNPViewer');
</script>