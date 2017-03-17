<table class="searchform">
    <tr><td>选择基因:<!--<SIAT_zh_CN original="Select Genes">选择基因</SIAT_zh_CN>--></td><tr>
    <tr>
        <td>
            <g:if test="${genes.size() != 0}">
                <g:select name="haploviewgenes" id="haploviewgenes" from="${genes}" multiple="multiple"
                          size="5"></g:select>
            </g:if>
            <g:if test="${genes.size() == 0}">
                对于这些子集，未存在snp数据.<!--<SIAT_zh_CN original="No snp data found for these subsets.">对于这些子集，未存在snp数据.</SIAT_zh_CN>-->
            </g:if>
        </td>
    </tr>
</table>
