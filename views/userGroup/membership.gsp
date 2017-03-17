<%@ page import="org.transmart.searchapp.AuthUser" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>小组成员<!--<SIAT_zh_CN original="Group Membership">小组成员</SIAT_zh_CN>--></title>
    <style>
    p {
        width: 440px;
    }

    .ext-ie .x-form-text {
        position: static !important;
    }
    </style>
    <g:setProvider library="jquery"/>
</head>

<body>
<div class="body">
    <h1>管理小组成员<!--<SIAT_zh_CN original="Manage Group Membership">管理小组成员</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div id="divuser"
         style="width:100%; font:11px tahoma, arial, helvetica, sans-serif">
        <br> 请选择一个用户然后选择组<!--<SIAT_zh_CN original="please select a user then select groups">请选择一个用户然后选择组</SIAT_zh_CN>--></br>
        <br><b>搜素一个用户<!--<SIAT_zh_CN original="Search User">搜素一个用户</SIAT_zh_CN>--><b></b><br>
        <input type="text" size="80" id="searchUsers" autocomplete="off"/></div>
    <r:script>

        var pageInfo = {
            basePath: "${request.getContextPath()}"
        }
  
        createUserSearchBox2('${request.getContextPath()}/userGroup/ajaxGetUserSearchBoxData', 440);

        function searchgroup() {
            var pid = document.getElementById('currentprincipalid').value;
            if (pid == null || pid == '') {
                alert("Please select a user first");
                return false;
            }

        ${remoteFunction(action: 'searchGroupsWithoutUser', update: [success: 'groups', failure: ''], params: 'jQuery(\'#searchtext\').serialize()+\'&id=\'+pid')};
            return false;
        }
    </r:script>
    <table>
        <tr><td></td><td></td><td>
            <input name="searchtext" id="searchtext"/>
            <button class="" onclick="searchgroup();">搜索组<!--<SIAT_zh_CN original="Search Groups">搜索组</SIAT_zh_CN>--></button>
        </td>
        <tr><td><b>在这些组的成员<!--<SIAT_zh_CN original="Member of these groups">在这些组的成员</SIAT_zh_CN>--></b>
        </td><td></td><td><b>可用的组<!--<SIAT_zh_CN original="Available groups">可用的组</SIAT_zh_CN>--></b></td></tr>
        <tr id="groups">
            <g:render template="addremoveg"
                      model="['groupswithoutuser': groupswithoutuser]"/>
        </tr>
    </table>
</div>
</td>
</tr>
</tbody>
<input type="hidden" id="currentprincipalid">
</body>
</html>
