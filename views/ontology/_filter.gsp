<g:setProvider library="prototype"/>

<g:formRemote name="ontTagFilterForm" id="ontTagFilterForm"
              url="[controller: 'ontology', action: 'ajaxOntTagFilter']"
              before="if(searchByTagBefore()==false) return false;"
              onSuccess="searchByTagComplete(e)">
    <table class="searchform" width="100%">
        <tr>
            <td valign="top"><b>搜索<!--<SIAT_zh_CN original="Search">搜索</SIAT_zh_CN>-->:</b><br> <g:textField
                    id="ontsearchterm" name="ontsearchterm" value=""
                    size="10"/><br>
            </td>
            <td valign="top"><br>并且<!--<SIAT_zh_CN original="AND">并且</SIAT_zh_CN>--></td>
            <td valign="top"><b>类型<!--<SIAT_zh_CN original="Type">类型</SIAT_zh_CN>-->:</b><br>
                <g:select
                        class="searchform" name="tagtype" id="tagtype"
                        from="${tagtypes}"
                        onchange="changeType();${remoteFunction(
                                controller: 'ontology',
                                action: 'ajaxGetOntTagFilterTerms',
                                params: '{tagtype:this.value}',
                                update: 'tagtermdiv')}"></g:select><br>

                <div id="tagtermdiv">
                    &nbsp;
                </div></td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td colspan="3" align="center"><input id="ontSearchButton"
                                                  type="SUBMIT" VALUE="搜索"
                                                  class="searchform"><!--<SIAT_zh_CN original="SEARCH">搜索</SIAT_zh_CN>--><input
                    type="reset" VALUE="清除" onclick="clearSearch();"
                    class="searchform"><!--<SIAT_zh_CN original="CLEAR">清除</SIAT_zh_CN>--><br>

                <div class="searchform" id="searchresultstext"></div>
            </td>
        </tr>
    </table>

</g:formRemote>
<script type="text/javascript">
    function clearSearch() {
        document.getElementById('searchresultstext').innerHTML = '';
        document.getElementById('tagtermdiv').innerHTML = '';
        ontFilterForm.setHeight(130);
        ontFilterPanel.doLayout();
    }
    function changeType() {
        var tagtype = document.getElementById("tagtype");
        if (tagtype.selectedIndex == 0) {
            ontFilterForm.setHeight(130);
        }
        else {
            ontFilterForm.setHeight(250);
        }
        ontFilterPanel.doLayout();
    }
</script>
