<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="genesigmain" />
    <title>编辑基因印记项<!--<SIAT_zh_CN original="Edit Gene Signature Items">编辑基因印记项</SIAT_zh_CN>--></title>

    <script type="text/javascript">

        // hide inidcated row
        function removeNewItem(rowNum) {
            var rowId = "new_item_"+rowNum;
            var geneId = "biomarker_"+rowNum;
            var probesetId = "probeset_"+rowNum;
            var metricId = "foldChgMetric_"+rowNum;

            // elements
            var rowItem = document.getElementById(rowId);
            var geneItem = document.getElementById(geneId);
            var probesetItem = document.getElementById(probesetId);
            var metricItem = document.getElementById(metricId);

            // remove and reset
            geneItem.value="";
            probesetItem.value="";
            metricItem.value=""
            rowItem.style.display="none";
        }

    </script>
</head>

<body>
<div class="body">
    <!-- user message -->
    <g:if test="${flash.message}">${flash.message}<br></g:if>

    <h1><g:link action="list">基因印记列表<!--<SIAT_zh_CN original="Gene Signature List">基因印记列表</SIAT_zh_CN>--></g:link> > 基因印记项编辑<!--<SIAT_zh_CN original="Gene Signature Items Edit">基因印记项编辑</SIAT_zh_CN>-->: '${gs.name}'</h1>

    <table class="detail" style="width: 100%">
        <g:tableHeaderToggle label="Gene Signature Info" divPrefix="${gs.id}_general" colspan="2" />

        <tbody id="${gs.id}_general_detail" style="display: none;">
        <tr class="prop">
            <td valign="top" class="name">名称<!--<SIAT_zh_CN original="Name">名称</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.name}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.description}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">公开状态<!--<SIAT_zh_CN original="Public Status">公开状态</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.publicFlag ? 'Public':'Private'}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">作者<!--<SIAT_zh_CN original="Author">作者</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.createdByAuthUser?.userRealName}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">Create Date<!--<SIAT_zh_CN original="Create Date">创建日期</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.dateCreated}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">修改者<!--<SIAT_zh_CN original="Modified By">修改者</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value">${gs.modifiedByAuthUser?.userRealName}</td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">修改日期<!--<SIAT_zh_CN original="Modified Date">修改日期</SIAT_zh_CN>-->:</td>
            <td valign="top" class="value"><g:if test="${gs.modifiedByAuthUser!=null}">${gs.lastUpdated}</g:if></td>
        </tr>
        </tbody>
    </table>
    <br>

    <g:form frm="geneSignatureItemFrm" method="post">
        <g:hiddenField name="id" value="${gs.id}" />

        <!-- existing items -->
        <table class="detail">
            <thead>
            <tr>
                <th>#</th>
                <g:if test="${gs?.fileSchema.id!=3}"> <th>基因符号<!--<SIAT_zh_CN original="Gene Symbol">基因符号</SIAT_zh_CN>--></th> </g:if>
                <g:if test="${gs?.fileSchema.id==3}"> <th>探测组 ID<!--<SIAT_zh_CN original="Probeset ID">探测组 ID</SIAT_zh_CN>--></th> </g:if>
                <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode!='NOT_USED'}"><th>倍数变化指标<!--<SIAT_zh_CN original="Fold-Change Metric">倍数变化指标</SIAT_zh_CN>--></th></g:if>
                <th style="text-align: center;">删除<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></th>
            </tr>
            </thead>
            <tbody>
            <g:each var="item" in="${gs.geneSigItems}" status="i">
                <tr>
                    <td style="color: gray;">${i+1}</td>
                    <g:if test="${gs?.fileSchema.id!=3}"> <td>${item.bioMarker?.name}</td> </g:if>
                    <g:if test="${gs?.fileSchema.id==3}"> <td>${item.probeset}</td> </g:if>
                    <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode!='NOT_USED'}"><td>${item.foldChgMetric}</td></g:if>
                    <td style="text-align: center;"><input type="checkbox" name="delete" value="${item.id}" /></td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <!-- new items -->
        <br>
        <table class="detail">
            <g:tableHeaderToggle label="Expand to Add Items" divPrefix="${gs.id}_new_items" colSpan="${(gs.foldChgMetricConceptCode.bioConceptCode!='NOT_USED') ? '4' : '3'}" />
            <tbody id="${gs.id}_new_items_detail" style="display: none;">
            <tr id="new_header">
                <th style="text-align: center;">#</th>
                <g:if test="${gs?.fileSchema.id!=3}"> <th style="text-align: center;">基因符号<!--<SIAT_zh_CN original="Gene Symbol">基因符号</SIAT_zh_CN>--></th> </g:if>
                <g:if test="${gs?.fileSchema.id==3}"> <th style="text-align: center;">探测集 ID<!--<SIAT_zh_CN original="Probeset ID">探测集 ID</SIAT_zh_CN>--></th> </g:if>
                <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode!='NOT_USED'}"><th style="text-align: center;">倍数变化指标<!--<SIAT_zh_CN original="Fold-Change Metric">倍数变化指标</SIAT_zh_CN>--></th></g:if>
                <th style="text-align: center;">移除<!--<SIAT_zh_CN original="Remove">移除</SIAT_zh_CN>--></th>
            </tr>

            <!-- hidden items for adding -->
            <g:set var="n" value="${0}"/>
            <g:while test="${n < 10}">
                <%n++%>
                <tr id="new_item_${n}">
                    <td style="color: gray;">${n}_a</td>

                <!-- check if coming from an error -->
                    <g:if test="${errorFlag}">
                        <g:if test="${gs?.fileSchema.id!=3}">
                            <td style="text-align: center;"><g:textField name="biomarker_${n}" value="${params.get('biomarker_'+n)}" maxlength="25" /></td>
                        </g:if>
                        <g:if test="${gs?.fileSchema.id==3}">
                            <td style="text-align: center;"><g:textField name="probeset_${n}" value="${params.get('probeset_'+n)}" maxlength="25" /></td>
                        </g:if>
                        <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode!='NOT_USED'}"><td><g:textField name="foldChgMetric_${n}" value="${params.get('foldChgMetric_'+n)}" maxlength="20" /></td></g:if>
                    </g:if>
                    <g:else>
                        <g:if test="${gs?.fileSchema.id!=3}">
                            <td><g:textField name="biomarker_${n}" maxlength="25" /></td>
                        </g:if>
                        <g:if test="${gs?.fileSchema.id==3}">
                            <td><g:textField name="probeset_${n}" maxlength="25" /></td>
                        </g:if>
                        <g:if test="${gs.foldChgMetricConceptCode?.bioConceptCode!='NOT_USED'}"><td><g:textField name="foldChgMetric_${n}" maxlength="20" /></td></g:if>
                    </g:else>

                    <td style="text-align: center;"><img alt="remove item" onclick="javascript:removeNewItem(${n});" src="${resource(dir:'images',file:'remove.png')}" /></td>
                </tr>
            </g:while>
            </tbody>
        </table>

        <div class="buttons">
            <g:actionSubmit class="save" action="addItems" value="" /><!--<SIAT_zh_CN original="Add Items">添加新项</SIAT_zh_CN>-->
            <g:actionSubmit class="delete" action="deleteItems" value="确认删除" onclick="return confirm('确认删除这些项目？')" /><!--<SIAT_zh_CN original="Delete Checked">确认删除</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Are you sure you want to delete these items?">确认删除这些项目？</SIAT_zh_CN>-->
            <g:actionSubmit class="cancel" action="refreshSummary" onclick="return confirm('确认离开？')" value="" /><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Are you sure you want to exit?">确认离开？</SIAT_zh_CN>-->
        </div>

    </g:form>
</div>
</body>
</html>
