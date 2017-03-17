<!-- render graph when successful -->
<g:if test="${epr.graphURL!=null && epr.graphURL != 'empty'}">

    <table>
        <tr><td><img src="${epr.graphURL}"/></td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td style="text-align: center;"><center>
            <g:set var="printURL" value="${createLink(action:'printChart') + '?' + epr.graphURL.substring(epr.graphURL.indexOf('filename='))}" />
            <a href="#" onclick="window.open('${printURL}','_boxplot','width=850,height=600,resizable=yes,scrollbars=yes,location=no,menubar=yes');">
                <img src="${resource(dir:'images',file:'print.png')}" />
                打印图表<!--<SIAT_zh_CN original="Print Chart">打印图表</SIAT_zh_CN>-->
            </a>
        </td></tr>
    </table>
    <br>


    <!-- override main.css -->
    <style type="text/css">

    .list td a:hover {
        font-size: 12px;
        white-space: normal;
    }

    </style>

    <div id="dataset_div" class="body">
        <h1 style="font-weight: bold; border-bottom-style: inset;">个体数据集中的信息<!--<SIAT_zh_CN original="Information on individual datasets">个体数据集中的信息</SIAT_zh_CN>--></h1>
        <br>
        <table class="list" width="98%">
            <thead>
            <tr style="background-color: black;">
                <th>数据集<!--<SIAT_zh_CN original="Dataset">数据集</SIAT_zh_CN>--></th>
                <th style="white-space: nowrap;">No. 样本<!--<SIAT_zh_CN original="No. Samples">No. 样本</SIAT_zh_CN>--></th>
                <th>实验<!--<SIAT_zh_CN original="Experiment">实验</SIAT_zh_CN>--></th>
            </tr>
            </thead>
            <tbody>

            <g:each in="${epr.datasetItems}" status="i" var="ds">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td style="vertical-align: top;">${ds.dataset.name}</td>
                    <td style="text-align: center; vertical-align: top;">${ds.sampleCount}</td>

                    <td style="vertical-align: top;">
                        <a onclick="showDialog('ExpDetail_${ds.experiment.id}', { title: '${ds.experiment.accession}', url: '${createLink(controller:'experimentAnalysis', action:'expDetail', id:ds.experiment.id)}' });">
                            <img alt="Experiment Detail" src="${resource(dir:'images',file:'view_detailed.png')}"/>&nbsp;<span style="font-weight: bold; color: #339933; white-space: nowrap;">${ds.experiment.accession}:</span>&nbsp;&nbsp;${ds.experiment.title}</a></td>
                </tr>
            </g:each>

            </tbody>
        </table>
    </div>

</g:if>
<g:else>
    <!-- problem creating graph -->
    <g:if test="${epr.graphURL==null}">
        <br><br>
        <span style="text-align: center; font-weight: bold;">&nbsp;作图服务尚不可用<!--<SIAT_zh_CN original="Graph service is not available">作图服务尚不可用</SIAT_zh_CN>--></span>
    </g:if>
    <g:else>
        <br><br>
        <span style="text-align: center; font-weight: bold;">&nbsp;无数据可用于您的选择<!--<SIAT_zh_CN original="No data available for your selections">无数据可用于您的选择</SIAT_zh_CN>--></span>
    </g:else>
</g:else>
