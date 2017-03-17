<%@ page import="org.transmart.searchapp.SecureObject; org.transmart.searchapp.SecureAccessLevel" %>




<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="admin"/>
    <title>管理案例(Study)访问权限<!--<SIAT_zh_CN original="Manage Study Access">管理案例(Study)访问权限</SIAT_zh_CN>--></title>
    <script type="text/javascript">

    </script>
</head>

<body>
<div class="body">
    <h1>管理案例(Study)访问权限<!--<SIAT_zh_CN original="Manage Study Access">管理案例(Study)访问权限</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${secureObjectInstance}">
        <div class="errors">
            <g:renderErrors bean="${secureObjectInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="dialog">
        <g:form method="post" name="secobjaccessform" action="manageAccessBySecObj">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secureobjectid">案例(Study)<!--<SIAT_zh_CN original="Study">案例(Study)</SIAT_zh_CN>-->:</label>
                        <g:select optionKey="id" optionValue="displayName"
                                  from="${SecureObject.listOrderByDisplayName()}"
                                  name="secureobjectid"
                                  value="${secureObjectInstance?.id}"
                                  onchange="document.secobjaccessform.submit();"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accesslevelid">访问级别<!--<SIAT_zh_CN original="Access Level">访问级别</SIAT_zh_CN>-->:</label>
                        <g:select optionKey="id" optionValue="accessLevelName"
                                  from="${SecureAccessLevel.list()}"
                                  name="accesslevelid" value="${accesslevelid}"
                                  onchange="document.secobjaccessform.submit();"/>
                    </td>
                </tr>
                </tbody>
            </table>

            <tr><td>&nbsp;</td><td>&nbsp;</td><td><input name="searchtext" id="searchtext">
                <input type="submit" value="Search User/Groups"/></td></tr>
        </g:form>
        <div>
            <table>
                <tbody>
                <tr><td><b>允许使用的用户/用户组<!--<SIAT_zh_CN original="User/Group Assigned Access">允许使用的用户/用户组</SIAT_zh_CN>--></b></td><td></td><td><b>不被允许使用的用户/用户组<!--<SIAT_zh_CN original="User/Group Without Access">不被允许使用的用户/用户组</SIAT_zh_CN>--></b></td></tr>
                <tr id="groups">
                    <g:render template="addremovePrincipal"
                              model="['userwithoutaccess': userwithoutaccess, 'secureObjectAccessList': secureObjectAccessList]"/>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
