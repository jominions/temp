<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="genesigmain" />
    <title>搜索基因印记<!--<SIAT_zh_CN original="Gene Signature Search">搜索基因印记</SIAT_zh_CN>--></title>

    <!-- override main.css -->
    <style type="text/css">
    .detail td a {
        padding-left: 10px;
        vertical-align: top;
    }

    .detail td a:hover {
        white-space: normal;
    }
    </style>

    <script language="javascript" type="text/javascript">

        function handleActionItem(actionItem, id) {
            var action = actionItem.value;
            var url
            if(action=="") return false;

            // clone existing object and bring into edit wizard
            if(action=="clone") {
                url = "${createLink(action: 'cloneWizard')}/"+id+"";
            }

            // set delete flag
            if(action=="delete") {
                var del=confirm("确认删除？")//<SIAT_zh_CN original="Are you sure you want to delete?">确认删除？</SIAT_zh_CN>

                if(del) {
                    url="${createLink(action: 'delete')}/"+id;
                    window.location.href=url;
                } else {
                    return false;
                }
            }

            // edit wizard
            if(action=="edit") {
                url = "${createLink(action: 'editWizard')}/"+id+"";
            }

            if(action=="showEditItems") {
                url = "${createLink(action: 'showEditItems')}/"+id+"";
            }

            // export to Excel
            if(action=="export") {
                url = "${createLink(action: 'downloadExcel')}/"+id+"";
            }

            // get GMT file
            if(action=="gmt") {
                url = "${createLink(action: 'downloadGMT')}/"+id+"";
            }

            // public action
            if(action=="public") {
                url = "${createLink(action: 'makePublic')}/"+id;
            }

            // private action
            if(action=="private") {
                url = "${createLink(action: 'makePrivate')}/"+id;
            }

            // send to url
            window.location.href=url;
        }

    </script>
    <script type="text/javascript" src="${resource(dir:'js', file:'help/D2H_ctxt.js')}"></script>
    <script language="javascript">
        helpURL = '${grailsApplication.config.com.recomdata.adminHelpURL}';
    </script>
</head>
<body>
<div class="body">
    <g:form frm="GenSignatureFrm" method="post">
        <g:hiddenField name="id" value="" />

        <!--  show message -->
        <g:if test="${flash.message}"><div class="message">${flash.message}</div><br></g:if>

        <p style="text-align: right;"><span class="button"><g:actionSubmit class="edit" action="createWizard" value="添加印记"/></span></p><!--<SIAT_zh_CN original="New Signature">添加印记</SIAT_zh_CN>-->
        <h1>基因印记列表 &nbsp;&nbsp;<!--<SIAT_zh_CN original="Gene Signature List">基因印记列表</SIAT_zh_CN>--><a HREF="JavaScript:D2H_ShowHelp('1259',helpURL,'wndExternal',CTXT_DISPLAY_FULLHELP )">
            <img src="${resource(dir:'images',file:'help/helpicon_white.jpg')}" alt="Help" border=0 width=18pt style="vertical-align:middle;margin-left:5pt;"/>
        </a></h1>

        <!-- show my signatures -->
        <table id="mySignatures"  class="detail" style="width: 100%">
            <g:tableHeaderToggle label="我的印记 (${myItems.size()})" divPrefix="my_signatures" status="open" colSpan="${12}"/><!--<SIAT_zh_CN original="My Signatures">我的印记</SIAT_zh_CN>-->

            <tbody id="my_signatures_detail" style="display: block;">
            <tr>
                <th>名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></th>
                <th>作者<!--<SIAT_zh_CN original="Author">作者</SIAT_zh_CN>--></th>
                <th>创建日期<!--<SIAT_zh_CN original="Date Created">创建日期</SIAT_zh_CN>--></th>
                <th>种类<!--<SIAT_zh_CN original="Species">种类</SIAT_zh_CN>--></th>
                <th>技术平台<!--<SIAT_zh_CN original="Tech Platform">技术平台</SIAT_zh_CN>--></th>
                <th>组织类型<!--<SIAT_zh_CN original="Tissue Type">组织类型</SIAT_zh_CN>--></th>
                <th>公开<!--<SIAT_zh_CN original="Public">公开</SIAT_zh_CN>--></th>
                <th>基因列表<!--<SIAT_zh_CN original="Gene List">基因列表</SIAT_zh_CN>--></th>
                <th># 基因<!--<SIAT_zh_CN original="Genes">基因</SIAT_zh_CN>--></th>
                <th># 上调<!--<SIAT_zh_CN original="Up-Regulated">上调</SIAT_zh_CN>--></th>
                <th># 下调<!--<SIAT_zh_CN original="Down-Regulated">下调</SIAT_zh_CN>--></th>
                <th>&nbsp;</th>
            </tr>

            <g:each var="gs" in="${myItems}" status="idx">
                <g:render template="/geneSignature/summary_record" model="[gs:gs, idx: idx]" />
            </g:each>
            </tbody>
        </table>

        <!--  public signatures -->
        <br>
        <table id="publicSignatures"  class="detail" style="width: 100%">
            <g:tableHeaderToggle label="${adminFlag ? ('其他印记 ('+pubItems.size()+')') : ('公开印记 ('+pubItems.size()+')')}" divPrefix="pub_signatures" colSpan="${12}" /><!--<SIAT_zh_CN original="Other Signatures">其他印记</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Public Signatures">公开印记</SIAT_zh_CN>-->

            <tbody id="pub_signatures_detail" style="display: none;">
            <tr>
                <th>名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>--></th>
                <th>作者<!--<SIAT_zh_CN original="Author">作者</SIAT_zh_CN>--></th>
                <th>创建日期<!--<SIAT_zh_CN original="Date Created">创建日期</SIAT_zh_CN>--></th>
                <th>种类<!--<SIAT_zh_CN original="Species">种类</SIAT_zh_CN>--></th>
                <th>技术平台<!--<SIAT_zh_CN original="Tech Platform">技术平台</SIAT_zh_CN>--></th>
                <th>组织类型<!--<SIAT_zh_CN original="Tissue Type">组织类型</SIAT_zh_CN>--></th>
                <th>公开<!--<SIAT_zh_CN original="Public">公开</SIAT_zh_CN>--></th>
                <th>基因列表<!--<SIAT_zh_CN original="Gene List">基因列表</SIAT_zh_CN>--></th>
                <th># 基因<!--<SIAT_zh_CN original="Genes">基因</SIAT_zh_CN>--></th>
                <th># 上调<!--<SIAT_zh_CN original="Up-Regulated">上调</SIAT_zh_CN>--></th>
                <th># 下调<!--<SIAT_zh_CN original="Down-Regulated">下调</SIAT_zh_CN>--></th>
                <th>&nbsp;</th>
            </tr>

            <g:each var="gs" in="${pubItems}" status="idx">
                <g:render template="/geneSignature/summary_record" model="[gs:gs, idx: idx]" />
            </g:each>

            </tbody>
        </table>

    </g:form>
</div>
</body>
</html>
