<p><span style="color: red; ">${warningMsg}</span></p>
<table class="searchform">
    <tr><td style='white-space: nowrap'>子集1中的SNP数据集:<!--<SIAT_zh_CN original="SNP Datasets in Subset 1">子集1中的SNP数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_1}</td>
    </tr>
    <tr><td style='white-space: nowrap'>子集2中的SNP数据集:<!--<SIAT_zh_CN original="SNP Datasets in Subset 2">子集2中的SNP数据集</SIAT_zh_CN>--></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${snpDatasetNum_2}</td>
    </tr>
    <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;</td></tr>
    <tr><td valign='top' style='white-space: nowrap'>选择染色体:<!--<SIAT_zh_CN original="Select Chromosomes">选择染色体</SIAT_zh_CN>--></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
        <g:select name="gwasChroms" id="gwasChroms" from="${chroms}" value="${chromDefault}" multiple="multiple"
                  size="5"></g:select>
    </td>
</table>
