<body>
<div id="divjobstatus" style="background:#fff;height:100%;padding:5px; font:12px tahoma, arial, helvetica, sans-serif;">
    <h3>步骤<!--<SIAT_zh_CN original="Step">步骤</SIAT_zh_CN>--> ${statusIndex + 1} 的<!--<SIAT_zh_CN original="of">的</SIAT_zh_CN>--> ${jobStatuses.size()}</h3>
    <table width="100%" style="background:#fff;">
        <g:each status="i" in="${jobStatuses}" var="jobStatus">
            <tr>
                <td>${jobStatus}
                    <g:if test="${i < statusIndex}">
                        <img src="${resource(dir: 'images', file: 'green_check.png')}"/>
                    </g:if>
                    <g:elseif test="${i == statusIndex}">
                        <img src="${resource(dir: 'images', file: 'loading-balls.gif')}"/>
                    </g:elseif>
                </td>
            </tr>
        </g:each>
    </table>
</div>
</body>


