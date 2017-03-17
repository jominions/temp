<div style="background-color:#EEEEEE;height:100%;font: 12px tahoma,verdana,helvetica;text-align:center;">
    <br/>
    <br/>
    <br/>
    <span style="font: 18px tahoma,verdana,helvetica;color:#800080;font-weight:bold;">选择主要的搜索过滤器<!--<SIAT_zh_CN original="Select a primary search filter">选择主要的搜索过滤器</SIAT_zh_CN>--></span>
    <hr style="width:30%;margin-left: auto;margin-right: auto;"/>
    <br/>
    <br/>

    <table style="margin-left: auto;margin-right: auto;width:75%; display:none;">
        <tr>
            <td style="height:15px;vertical-align:middle;">
                <span style="font-size:150%">过滤器搜索<!--<SIAT_zh_CN original="Search For Filter">过滤器搜索</SIAT_zh_CN>--></span>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <div id="search-categories"></div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="search-text"></div>
            </td>
        </tr>
    </table>


    <br/>
    <br/>
    <br/>

    <div style="margin-left: auto;margin-right: auto;width:75%;text-align:left;">
        <span style="font-size:150%">过滤器浏览<!--<SIAT_zh_CN original="Browse for filter">过滤器浏览</SIAT_zh_CN>--></span>
    </div>

    <br/>

    <table style="width:75%;text-align:left;padding:0;margin-left: auto;margin-right: auto;">
    <tr>
        <g:each var="term" in="${termsMap}" status="iterator">
            <td style="vertical-align:top;">
                <g:render template="categoryList"
                          model="[termName: term.key, termDisplayName: term.value.displayName, termList: term.value.counts]"/>
            </td>
            <g:if test="${((iterator + 1) % 3) == 0}">
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
            </g:if>
        </g:each>
    </tr>
    </table>
</div>