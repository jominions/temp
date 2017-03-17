<div style="text-align: center;">
    <div class="welcome"
         style="margin: 40px auto; background: #F4F4F4; border: 1px solid #DDD; padding: 20px; width: 400px; text-align: center; border-top-left-radius: 20px; border-bottom-right-radius: 20px">
        <g:set var="projectName" value="${grailsApplication.config?.com?.recomdata?.projectName}"/>
        <g:set var="providerName" value="${grailsApplication.config?.com?.recomdata?.providerName}"/>
        <p><b>欢迎使用 <g:if test="${projectName}">基于${projectName}的<!--<SIAT_zh_CN original="for ${projectName}">基于${projectName}的</SIAT_zh_CN>--></g:if>tranSMART<!--<SIAT_zh_CN original="Welcome to tranSMART">欢迎来到tranSMART</SIAT_zh_CN>--></b></p>
        <p>你可以在<b>浏览</b>窗口搜索并浏览tranSMART包含的信息，包括项目、案例、分析手段以及相关的分析结果,和学科级数据信息以及相关的原始文件。<br/>你也可以在该窗口内导出tranSMART中的相关文件。注：如需要编辑项目、案例或者分析手段等信息，你必须以管理员身份登入本系统。<!--<SIAT_zh_CN original="The <b>Browse</b> window lets you search and dive into the information contained in tranSMART, including Programs, Studies, Assays and the associated Analyses Results, Subject Level Data and Raw Files. This is also the location to export files stored in tranSMART. Note: to edit the Program, Study, or Assay information, you must be logged in as an Administrator.">你可以在<b>浏览</b>窗口搜索并浏览tranSMART包含的信息，包括项目、案例、分析手段以及相关的分析结果，和学科级数据信息以及相关的原始文件。<br/>你也可以在该窗口内导出tranSMART中的相关文件。注：如需要编辑项目、案例或者分析手段等信息，你必须以管理员身份登入本系统。</SIAT_zh_CN>-->
        </p>

        <p>此外，你可以在<b>分析</b>窗口执行一系列的相关数据分析，这些数据可来自你在浏览窗口选择的相应案例，也可来自在全局搜索框的搜索结果。该全局搜索框位于当前屏幕的上方导航栏中。<br/>有关可执行分析的更多信息，请选择位于“其他”菜单中的“帮助”以查看相关内容。<!--<SIAT_zh_CN original="<p>The <b>Analyze</b> window lets you perform a number of analyses either on studies selected in the Browse window, or from the global search box located in the top ribbon of your screen. More information about the analyses you can perform is available in the “Help ? section of the "Utilities" menu.">此外，你可以在<b>分析</b>窗口执行一系列的相关数据分析，这些数据可来自你在浏览窗口选择的相应案例，也可来自在全局搜索框的搜索结果。该全局搜索框位于当前屏幕的上方导航栏中。<br/>有关可执行分析的更多信息，请选择位于“其他”菜单中的“帮助”以查看相关内容。</SIAT_zh_CN>-->
        </p>
        <br><br>

        <div>
            <g:if test="${projectName}">
                <img src="${resource(dir: 'images', file: 'project_logo.png')}" alt="${projectName}"
                     style="height:35px;vertical-align:middle;margin-bottom: 12px;">
            </g:if>
            <g:if test="${projectName && providerName}">
                <span style="font-size:20px;display: inline-block;line-height: 35px; height: 35px;">&nbsp;+&nbsp;</span>
            </g:if>
            <g:if test="${providerName}">
                <a id="providerpowered" target="_blank" href="${grailsApplication.config?.com?.recomdata?.providerURL}"
                   style="text-decoration: none;">
                    <img src="${resource(dir: 'images', file: 'provider_logo.png')}" alt="${providerName}"
                         style="height:35px;vertical-align:middle;margin-bottom: 12px;">
                </a>
            </g:if>
        </div>
    </div>


    <sec:ifAnyGranted roles="ROLE_ADMIN">
        <div style="margin: auto; padding: 0px 16px 16px 16px; border-radius: 8px; border: 1px solid #DDD; width: 20%">
            <h4>管理员工具<!--<SIAT_zh_CN original="Admin Tools">管理员工具</SIAT_zh_CN>--></h4>
            <span class="greybutton buttonicon addprogram">添加新项目<!--<SIAT_zh_CN original="Add new program">添加新项目</SIAT_zh_CN>--></span>
        </div>
    </sec:ifAnyGranted>

    <br/><br/>
</div>