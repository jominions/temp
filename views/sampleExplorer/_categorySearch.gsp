<div style="background-color:white;height:100%;width:100%;">
    <br/>
    <br/>
    <span style="font: 12px tahoma,verdana,helvetica;color:#800080;font-weight:bold;">最近的更新(需要更多的信息请点击更新)<!--<SIAT_zh_CN original="Recent Updates (click update for more info)">最近的更新（需要更多的信息请点击更新）</SIAT_zh_CN>--></span>
    <br/>
    <hr/>
    <br/>

    <g:if test="${newsUpdates != null && !newsUpdates.isEmpty()}">
        <g:each var="newsUpdate" in="${newsUpdates}" status="iterator">

            <a href="#" onClick="showNewsUpdateDetail('${newsUpdate.id}')">
                数据集<!--<SIAT_zh_CN original="Data Set">数据集</SIAT_zh_CN>--> <i>${newsUpdate.dataSetName}</i> 修改于<!--<SIAT_zh_CN original="modified on">修改于</SIAT_zh_CN>--> <i><g:formatDate format="yyyy-MM-dd"
                                                                                       date="${newsUpdate.updateDate}"></g:formatDate></i>
            </a>

            <br/>
            <br/>
        </g:each>
    </g:if>
    <g:else>
        没有更新可用.<!--<SIAT_zh_CN original="No updates available">没有更新可用</SIAT_zh_CN>-->
    </g:else>

    <br/>
    <br/>

</div>