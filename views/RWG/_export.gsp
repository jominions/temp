<div style="margin: 16px;">
    <div>
        <div style="float: right;">
            <span id="closeexport" class="greybutton buttonicon close">关闭<!--<SIAT_zh_CN original="Close">关闭</SIAT_zh_CN>--></span>
        </div>

        <h3 class="rdc-h3">导出文件<!--<SIAT_zh_CN original="Export Files">导出文件</SIAT_zh_CN>--></h3>
    </div>

    <g:if test="${files}"><p>这是被添加至导出暂存区的文件,请选择欲导出的文件.<!--<SIAT_zh_CN original="These are the files that have been added to the cart. Please select the files to export.">这是被添加至导出暂存区的文件,请选择欲导出的文件.</SIAT_zh_CN>--></p></g:if>
    <g:else>导出暂存区内尚无文件.<!--<SIAT_zh_CN original="No files have been added to the export cart.">导出暂存区内尚无文件.</SIAT_zh_CN>--></g:else>

    <table style="width: 100%;" class="exporttable" id="exporttable">
        <g:each in="${files}" var="file">
            <tr>
                <td>${file.folder}</td>
                <td><g:checkBox name="${file.id}" onclick="updateExportCount();" value="true"/></td>
                <td><span class="fileicon ${file.fileType}"></span>&nbsp;${file.displayName}</td>
                <td><span class="greybutton remove">移除<!--<SIAT_zh_CN original="Remove">移除</SIAT_zh_CN>--></span></td>
            </tr>
        </g:each>
    </table>
    <br/>
    <g:if test="${files}"><span id="exportbutton"
                                class="greybutton export">导出选中文件 <!--<SIAT_zh_CN original="Export selected files">导出选中文件</SIAT_zh_CN>-->(${files.size()})</span></g:if>
</div>