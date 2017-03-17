<!--suppress ALL -->
<table id="subsets" style="width:100%;" class="detail">
    <thead>
    <tr>
        <th style="text-align:left;">
            描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>-->
        </th>
        <th style="text-align:left;">
            案例<!--<SIAT_zh_CN original="Study">案例</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            查询<!--<SIAT_zh_CN original="Query">查询</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            使用<!--<SIAT_zh_CN original="Use">使用</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            邮件<!--<SIAT_zh_CN original="Email">邮件</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            链接<!--<SIAT_zh_CN original="Link">链接</SIAT_zh_CN>-->
        </th>
        <th style="text-align:left;">
            创建者<!--<SIAT_zh_CN original="Created by">创建者</SIAT_zh_CN>-->
        </th>
        </th>
        <th style="text-align:center;">
            删除<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            公开<!--<SIAT_zh_CN original="Public">公开</SIAT_zh_CN>-->
        </th>
        <th style="text-align:left;">
            创建日期<!--<SIAT_zh_CN original="Create Date">创建日期</SIAT_zh_CN>-->
        </th>
    </tr>
    </thead>
    <tbody>
    <g:each var="subset" in="${subsets}">
        <tr id="subsetRow${subset.id}" style="height:30px;">
            <td><span id="subsetDescriptionDisplay${subset.id}">
                ${subset.description}
                <g:if test="${subset.creatingUser == currentUser}">
                    <a style="float:right;" id="editSubset${subset.id}" class="ui-icon ui-icon-pencil" href="#"
                       onmouseenter="handleMouseEnter('editSubset${subset.id}');"
                       OnFocus="handleMouseEnter('editSubset${subset.id}');"
                       onmouseout="handleMouseOut('editSubset${subset.id}');"
                       OnBlur="handleMouseOut('editSubset${subset.id}');"
                       onclick="editDescription('${subset.id}')">
                    </a>
                </g:if>
            </span>
                <input type="text" class="editSubsetDescriptionBox" text="Edit Subset Description Box"
                       id="editDescriptionBox${subset.id}" value="${subset.description}" style="width:90%"
                       onkeypress="handleKeyPress(event, '${subset.id}', 'subset')"
                       onblur="updateDescription('${subset.id}')"/>
            </td>

            <td>${subset.study}</td>

            <td style="padding:5px 20px 5px 30px;"><a id="displaySubset${subset.id}" class="ui-icon ui-icon-document"
                                                      href="#"
                                                      onmouseenter="handleMouseEnter('displaySubset${subset.id}'); displayQuery(event, '${subset.id}');"
                                                      OnFocus="handleMouseEnter('displaySubset${subset.id}');
                                                      displayQuery(event, '${subset.id}');"
                                                      onmouseout="handleMouseOut('displaySubset${subset.id}');
                                                      hideQuery();"
                                                      OnBlur="handleMouseOut('displaySubset${subset.id}');
                                                      hideQuery();"></a>
            </td>

            <td style="padding:5px 20px 5px 30px;">
                <g:if test="${subset.id == selectedSubsetId}">
                    <input type="radio" id="applySubset${subset.id}" name="applySubset" value="${subset.id}"
                           onclick="applySubsets('${subset.id}', '${subset.study}')" checked="true"
                           title="Apply Subset">
                </g:if>
                <g:else>
                    <input type="radio" id="applySubset${subset.id}" name="applySubset" value="${subset.id}"
                           onclick="applySubsets('${subset.id}', '${subset.study}')" title="Apply Subset">
                </g:else>
            </td>

            <td style="padding:5px 20px 5px 30px;"><a id="emailSubset${subset.id}" class="ui-icon ui-icon-mail-closed"
                                                      href="${subset.emailLink}"
                                                      onmouseenter="handleMouseEnter('emailSubset${subset.id}');"
                                                      OnFocus="handleMouseEnter('emailSubset${subset.id}');"
                                                      onmouseout="handleMouseOut('emailSubset${subset.id}');"
                                                      OnBlur="handleMouseOut('emailSubset${subset.id}');"></a>
            </td>

            <td style="padding:5px 20px 5px 30px;"><a id="linkifySubset${subset.id}" class="ui-icon ui-icon-link"
                                                      href="#"
                                                      onmouseenter="handleMouseEnter('linkifySubset${subset.id}');"
                                                      OnFocus="handleMouseEnter('linkifySubset${subset.id}');"
                                                      onmouseout="handleMouseOut('linkifySubset${subset.id}');"
                                                      OnBlur="handleMouseOut('linkifySubset${subset.id}');"
                                                      onclick="linkifySubsets('${subset.link}')"></a>
            </td>

            <td>${subset.creatingUser}</td>

            <td style="padding:5px 20px 5px 30px;">
                <g:if test="${subset.creatingUser == currentUser}">
                    <a id="deleteSubset${subset.id}" class="ui-icon ui-icon-trash" href="#"
                       onmouseenter="handleMouseEnter('deleteSubset${subset.id}');"
                       OnFocus="handleMouseEnter('deleteSubset${subset.id}');"
                       onmouseout="handleMouseOut('deleteSubset${subset.id}');"
                       OnBlur="handleMouseOut('deleteSubset${subset.id}');"
                       onclick="deleteSubset('${subset.id}')"></a>
                </g:if>
            </td>

            <td style="padding:5px 20px 5px 30px;">
                <g:if test="${subset.creatingUser == currentUser}">
                    <g:if test="${subset.publicFlag == true}">
                        <a id="publicFlag${subset.id}" class="ui-icon ui-icon-unlocked" href="#"
                           onmouseenter="handleMouseEnter('publicFlag${subset.id}');"
                           OnFocus="handleMouseEnter('publicFlag${subset.id}');"
                           onmouseout="handleMouseOut('publicFlag${subset.id}');"
                           OnBlur="handleMouseOut('publicFlag${subset.id}');"
                           onclick="togglePublicFlag('${subset.id}')"></a>
                    </g:if>
                    <g:else>
                        <a id="publicFlag${subset.id}" class="ui-icon ui-icon-locked" href="#"
                           onmouseenter="handleMouseEnter('publicFlag${subset.id}');"
                           OnFocus="handleMouseEnter('publicFlag${subset.id}');"
                           onmouseout="handleMouseOut('publicFlag${subset.id}');"
                           OnBlur="handleMouseOut('publicFlag${subset.id}');"
                           onclick="togglePublicFlag('${subset.id}')"></a>
                    </g:else>
                </g:if>
                <g:else>
                    <g:if test="${subset.publicFlag == true}">
                        <a id="publicFlag${subset.id}" class="ui-icon ui-icon-unlocked" href="#"
                           onmouseenter="handleMouseEnter('publicFlag${subset.id}');"
                           OnFocus="handleMouseEnter('publicFlag${subset.id}');"
                           onmouseout="handleMouseOut('publicFlag${subset.id}');"
                           OnBlur="handleMouseOut('publicFlag${subset.id}');"></a>
                    </g:if>
                    <g:else>
                        <a id="publicFlag${subset.id}" class="ui-icon ui-icon-locked" href="#"
                           onmouseenter="handleMouseEnter('publicFlag${subset.id}');"
                           OnFocus="handleMouseEnter('publicFlag${subset.id}');"
                           onmouseout="handleMouseOut('publicFlag${subset.id}');"
                           OnBlur="handleMouseOut('publicFlag${subset.id}');"></a>
                    </g:else>
                </g:else>

            </td>

            <td>${subset.displayDate}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<div id="workspaceQueryDisplayDialog" title="Query Summary"></div>

<div id="workspaceLinkDisplayDialog" title="Subset Link"></div>

<h3 class="workspaceheader">&nbsp;</h3>

<table class="detail" id="reports" style="width:100%;">
    <thead>
    <tr>
        <th style="text-align:left;">
            报告名称<!--<SIAT_zh_CN original="Report Name">报告名称</SIAT_zh_CN>-->
        </th>
        <th style="text-align:left;">
            案例<!--<SIAT_zh_CN original="Study">案例</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            查询<!--<SIAT_zh_CN original="Query">查询</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            Run
        </th>
        <th style="text-align:left;">
            创建者<!--<SIAT_zh_CN original="Created by">创建者</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            删除<!--<SIAT_zh_CN original="Delete">删除</SIAT_zh_CN>-->
        </th>
        <th style="text-align:center;">
            公开<!--<SIAT_zh_CN original="Public">公开</SIAT_zh_CN>-->
        </th>
        <th style="text-align:left;">
            创建日期<!--<SIAT_zh_CN original="Create Date">创建日期</SIAT_zh_CN>-->
        </th>
    </tr>
    </thead>
    <tbody>
    <g:each var="report" in="${reports}">
        <tr id="reportRow${report.id}" style="height:30px;">
            <td>
                <span id="reportNameDisplay${report.id}">
                    ${report.name}
                    <g:if test="${report.creatingUser == currentUser}">
                        <a style="float:right;" id="editReport${report.id}" class="ui-icon ui-icon-pencil" href="#"
                           OnFocus="handleMouseEnter('editReport${report.id}');"
                           onmouseenter="handleMouseEnter('editReport${report.id}');"
                           onmouseout="handleMouseOut('editReport${report.id}');"
                           OnBlur="handleMouseOut('editReport${report.id}');"
                           onclick="editReportName('${report.id}')">
                        </a>
                    </g:if>
                </span>
                <input type="text" hidden="hidden" class="editReportDescriptionBox" id="editReportNameBox${report.id}"
                       value="${report.name}" style="width:90%"
                       onkeypress="handleKeyPress(event, '${report.id}', 'report')"
                       onblur="updateReportName('${report.id}')"/>
            </td>

            <td>${report.study}</td>

            <td style="padding:5px 20px 5px 30px;"><a id="displayReportCodes${report.id}"
                                                      class="ui-icon ui-icon-document" href="#"
                                                      onmouseenter="handleMouseEnter('displayReportCodes${report.id}'); displayReportCodes(event, '${report.id}');"
                                                      OnFocus="handleMouseEnter('displayReportCodes${report.id}');
                                                      displayReportCodes(event, '${report.id}');"
                                                      onmouseout="handleMouseOut('displayReportCodes${report.id}');
                                                      hideReportCodes();"
                                                      OnBlur="handleMouseOut('displayReportCodes${report.id}');
                                                      hideReportCodes();">
            </a>
            </td>

            <td style="padding:5px 20px 5px 30px;"><a id="runReport${report.id}" class="ui-icon ui-icon-play" href="#"
                                                      onmouseenter="handleMouseEnter('runReport${report.id}');"
                                                      OnFocus="handleMouseEnter('runReport${report.id}');"
                                                      onmouseout="handleMouseOut('runReport${report.id}');"
                                                      OnBlur="handleMouseOut('runReport${report.id}');"
                                                      onclick="generateReportFromId('${report.id}', 'trial:${report.study}')"></a>
            </td>

            <td>${report.creatingUser}</td>

            <td style="padding:5px 20px 5px 30px;">
                <g:if test="${report.creatingUser == currentUser}">
                    <a id="deleteReport${report.id}" class="ui-icon ui-icon-trash" href="#"
                       onmouseenter="handleMouseEnter('deleteReport${report.id}');"
                       OnFocus="handleMouseEnter('deleteReport${report.id}');"
                       onmouseout="handleMouseOut('deleteReport${report.id}');"
                       OnBlur="handleMouseOut('deleteReport${report.id}');"
                       onclick="deleteReportFromId('${report.id}')"></a>
                </g:if>
            </td>

            <td style="padding:5px 20px 5px 30px;">
                <g:if test="${report.creatingUser == currentUser}">
                    <g:if test="${report.publicFlag == 'Y'}">
                        <a id="reportPublicFlag${report.id}" class="ui-icon ui-icon-unlocked" href="#"
                           onmouseenter="handleMouseEnter('reportPublicFlag${report.id}');"
                           OnFocus="handleMouseEnter('reportPublicFlag${report.id}');"
                           onmouseout="handleMouseOut('reportPublicFlag${report.id}');"
                           OnBlur="handleMouseOut('reportPublicFlag${report.id}');"
                           onclick="toggleReportPublicFlag('${report.id}')"></a>
                    </g:if>
                    <g:else>
                        <a id="reportPublicFlag${report.id}" class="ui-icon ui-icon-locked" href="#"
                           onmouseenter="handleMouseEnter('reportPublicFlag${report.id}');"
                           OnFocus="handleMouseEnter('reportPublicFlag${report.id}');"
                           onmouseout="handleMouseOut('reportPublicFlag${report.id}');"
                           OnBlur="handleMouseOut('reportPublicFlag${report.id}');"
                           onclick="toggleReportPublicFlag('${report.id}')"></a>
                    </g:else>
                </g:if>
                <g:else>
                    <g:if test="${report.publicFlag == 'Y'}">
                        <a id="reportPublicFlag${report.id}" class="ui-icon ui-icon-unlocked" href="#"
                           onmouseenter="handleMouseEnter('reportPublicFlag${report.id}');"
                           OnFocus="handleMouseEnter('reportPublicFlag${report.id}');"
                           onmouseout="handleMouseOut('reportPublicFlag${report.id}');"
                           OnBlur="handleMouseOut('reportPublicFlag${report.id}');"></a>
                    </g:if>
                    <g:else>
                        <a id="reportPublicFlag${report.id}" class="ui-icon ui-icon-locked" href="#"
                           onmouseenter="handleMouseEnter('reportPublicFlag${report.id}');"
                           OnFocus="handleMouseEnter('reportPublicFlag${report.id}');"
                           onmouseout="handleMouseOut('reportPublicFlag${report.id}');"
                           OnBlur="handleMouseOut('reportPublicFlag${report.id}');"></a>
                    </g:else>
                </g:else>
            </td>

            <td>${report.displayDate}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<div id="workspaceReportCodesDisplayDialog" title="Report Query Summary"></div>