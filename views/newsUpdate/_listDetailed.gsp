<div style="background:#eee;height:100%;padding:5px; font:11px tahoma, arial, helvetica, sans-serif;">
    <table>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
                影响记录<!--<SIAT_zh_CN original="Records Affected :">影响记录</SIAT_zh_CN>--> :
            </td>
            <td style="background:white;">
                ${thisUpdate.rowsAffected}
            </td>
        </tr>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
                更新用户<!--<SIAT_zh_CN original="Updates run by user">更新用户</SIAT_zh_CN>--> :
            </td>
            <td style="background:white;">
                ${thisUpdate.ranByUser}
            </td>
        </tr>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
                已执行操作<!--<SIAT_zh_CN original="Operation performed">已执行操作</SIAT_zh_CN>--> :
            </td>
            <td style="background:white;">
                ${thisUpdate.operation}
            </td>
        </tr>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
            受变更影响的数据集<!--<SIAT_zh_CN original="Dataset associated with changes">受变更影响的数据集</SIAT_zh_CN>--> :
            </td>
            <td style="background:white;">
                ${thisUpdate.dataSetName}
            </td>
        </tr>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
                更新时间<!--<SIAT_zh_CN original="Date of update">更新时间</SIAT_zh_CN>--> :
            </td>
            <td style="background:white;">
                ${thisUpdate.updateDate}
            </td>
        </tr>
        <tr>
            <td style="background:#E8E8E8;text-align:right;">
                评论 <!--<SIAT_zh_CN original="Comments">评论</SIAT_zh_CN>-->:
            </td>
            <td style="background:white;">
                ${thisUpdate.commentField}
            </td>
        </tr>
    </table>
</div>