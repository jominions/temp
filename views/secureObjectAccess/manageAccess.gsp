<g:setProvider library="prototype"/>
<%@ page import="org.springframework.web.util.JavaScriptUtils; org.transmart.searchapp.SecureObjectAccess" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>管理案例(Study)访问权限<!--<SIAT_zh_CN original="Manage Study Access">管理案例(Study)访问权限</SIAT_zh_CN>--></title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jQuery/jquery.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jQuery/jquery-ui-1.9.1.custom.min.js')}"></script>
    <script type="text/javascript">
        var $j = jQuery.noConflict();
    </script>
    <g:setProvider library="prototype"/>
    <g:javascript library="prototype"/>

    <style>
    p {
        width: 430px;
    }

    .ext-ie .x-form-text {
        position: static !important;
    }
    </style>

</head>

<body>
<div class="body">
    <h1>管理案例(Study)访问用户/用户组<!--<SIAT_zh_CN original="Manage Study Access for User/Group">管理案例(Study)访问用户/用户组</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div id="divuser"
         style="width:100%; font:11px tahoma, arial, helvetica, sans-serif"><br><b>搜索用户/用户组<!--<SIAT_zh_CN original="Search User/Group">搜索用户/用户组</SIAT_zh_CN>--></b><br>
        <input type="text" size="80" id="searchUsers" autocomplete="off"/></div>

    <r:script>
var pageInfo = {
    basePath: '${JavaScriptUtils.javaScriptEscape(request.getContextPath())}'
}
createUserSearchBox(pageInfo.basePath +
        '/userGroup/ajaxGetUsersAndGroupsSearchBoxData',
        440,
        '${JavaScriptUtils.javaScriptEscape(principalInstance?.name)}');

  function searchtrial(){
    var pid = jQuery('#currentprincipalid').val();
    if (!pid) {
	alert("Please select a user/group first");
	return false;
	}
    var form = $(this).closest('form');
        ${remoteFunction(controller: 'secureObjectAccess',
                action: 'listAccessForPrincipal',
                update: [success: 'permissions', failure: ''],
                params: "form.serialize()")};
	return false;
  }
    </r:script>

    <g:form name="accessform" action="manageAccess">
        <table>
            <tr>
                <td>
                    <label for="accesslevelid"><b>访问级别<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>--></b></label>
                    <g:select optionKey="id"
                              optionValue="accessLevelName"
                              from="${accessLevelList}"
                              name="accesslevelid"
                              value="${accesslevelid}"
                              onchange="document.accessform.submit();"/>
                    <input type="hidden" name="currentprincipalid" id="currentprincipalid"
                           value="${principalInstance?.id}"/>
                </td>
                <td>&nbsp;</td>
                <td>
                    <input name="searchtext" id="searchtext"><button class=""
                                                                     onclick="return searchtrial.call(this);"><!--<SIAT_zh_CN original="Search Study">搜索研究</SIAT_zh_CN>--></button>
                </td>
            </tr>
            <tr>
                <td>已访问案例(Study)<!--<SIAT_zh_CN original="Has Access for these studies">已访问案例(Study)</SIAT_zh_CN>--></td>
                <td></td>
                <td>可选择案例(Study)<!--<SIAT_zh_CN original="Available studies">可选择案例(Study)</SIAT_zh_CN>-->:</td>
            </tr>
            <tr id="permissions">
                <g:render template="addremoveAccess"
                          model="[secureObjectInstance  : secureObjectInstance,
                                  secureObjectAccessList: secureObjectAccessList,
                                  objectswithoutaccess  : objectswithoutaccess]"/>
            </tr>
        </table>
    </g:form>
</div>
</td>
</tr>
</tbody>

</body>
</html>