<g:if test="${hide}"><g:set var="csshide">display: none</g:set></g:if>

<div id="box-search" style="${csshide}">
    <div id="title-search-div" class="ui-widget-header boxtitle">
        <h2 style="float:left" class="title">
            激活的过滤器<!--<SIAT_zh_CN original="Active Filters">激活的过滤器</SIAT_zh_CN>-->
            <g:if test="${!globalOperator}">
                <g:set var="globalOperator" value="and"/>
            </g:if>
            <div id="globaloperator" class="andor ${globalOperator.toLowerCase()}">&nbsp;</div>
        </h2>

        <h2 style="float:right; padding-right:5px;" class="title">
            <a href="#" onclick="clearSearch();
            return false;">清除<!--<SIAT_zh_CN original="Clear">清除</SIAT_zh_CN>--></a>
        </h2>

        <div id="filterbutton" class="greybutton filterbrowser">
            <img src="${resource(dir: 'images', file: 'filter.png')}"/> 过滤器<!--<SIAT_zh_CN original="Filter">过滤器</SIAT_zh_CN>-->
        </div>
    </div>

    <div id="active-search-div" class="boxcontent">
        &nbsp;
    </div>
</div>