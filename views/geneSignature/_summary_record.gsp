<tr class="${(idx % 2) == 0 ? 'odd' : 'even'}">
    <g:set var="dtlLink" value="${createLink(action: 'show', id: gs.id)}"/>
    <g:set var="ownerFlag" value="${adminFlag || user.id == gs.createdByAuthUser.id}"/>
    <g:set var="ctLkup" value="${ctMap.get(gs.id)}"/>

    <td><a onclick="showDialog('GeneSigDetail_${gs.id}', { title: 'Gene Signature Detail [${gs.name?.replaceAll("'","\\\\'").encodeAsHTML()}]', url: '${dtlLink}'})">
        <img alt="detail" style="vertical-align:middle;"
             src="${resource(dir: 'images', file: 'grid.png')}">&nbsp;${gs.name?.replaceAll("'", "\\\\'").encodeAsHTML()}
    </a></td>
    <td>${gs.createdByAuthUser.userRealName?.encodeAsHTML()}</td>
    <td><g:formatDate format="yyyy-MM-dd" date="${gs.dateCreated}"/></td>
    <td>${gs.speciesConceptCode?.codeName?.encodeAsHTML()}</td>
    <td>${gs.techPlatform?.accession?.encodeAsHTML()}</td>
    <td>${gs.tissueTypeConceptCode?.codeName?.encodeAsHTML()}</td>
    <td style="text-align:center;">${gs.publicFlag ? '是' : '否'}</td><!--<SIAT_zh_CN original="Yes">是</SIAT_zh_CN>--><!--<SIAT_zh_CN original="No">否</SIAT_zh_CN>-->
    <td style="text-align:center;">${(gs.foldChgMetricConceptCode?.bioConceptCode == 'NOT_USED') ? '是' : '否'}</td><!--<SIAT_zh_CN original="Yes">是</SIAT_zh_CN>--><!--<SIAT_zh_CN original="No">否</SIAT_zh_CN>-->
    <g:if test="${ctLkup != null}">
        <td style="text-align:center;">${ctLkup?.getAt(1)}</td>
        <td style="text-align:center;">${ctLkup?.getAt(2)}</td>
        <td style="text-align:center;">${ctLkup?.getAt(3)}</td>
    </g:if>
    <g:else>
        <td style="text-align:center;">0</td>
        <td style="text-align:center;">0</td>
        <td style="text-align:center;">0</td>
    </g:else>
    <td><select name="action_${gs.id}" style="font-size: 10px;" onchange="handleActionItem(this, ${gs.id});">
        <option value="">-- 选择操作<!--<SIAT_zh_CN original="Select Action">选择操作</SIAT_zh_CN>--> --</option>
        <option value="clone">克隆<!--<SIAT_zh_CN original="Clone">克隆</SIAT_zh_CN>--></option>
        <g:if test="${!gs.deletedFlag && ownerFlag}"><option value="delete">Delete<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>--></option></g:if>
        <g:if test="${ownerFlag}"><option value="edit">编辑<!--<SIAT_zh_CN original="Edit">编辑</SIAT_zh_CN>--></option></g:if>
        <g:if test="${ownerFlag}"><option value="showEditItems">编辑选项<!--<SIAT_zh_CN original="Edit Items">编辑选项</SIAT_zh_CN>--></option></g:if>
        <option value="export">下载为Excel<!--<SIAT_zh_CN original="Excel Download">下载为Excel</SIAT_zh_CN>--></option>
        <option value="gmt">下载为.GMT文件<!--<SIAT_zh_CN original="Download .GMT file">下载为.GMT文件</SIAT_zh_CN>--></option>
        <g:if test="${!gs.publicFlag && ownerFlag}"><option value="public">公开<!--<SIAT_zh_CN original="Make Public">公开</SIAT_zh_CN>--></option></g:if>
        <g:if test="${gs.publicFlag && ownerFlag}"><option value="private">私有<!--<SIAT_zh_CN original="Make Private">私有</SIAT_zh_CN>--></option></g:if>
    </select>
    </td>
</tr>            
