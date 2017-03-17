<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <r:require module="main_mod"/>
    <r:require module="jqueryui"/>
    <title>更改我的密码<!--<SIAT_zh_CN original="Change My Password">更改我的密码</SIAT_zh_CN>--></title>
    <r:layoutResources/>
</head>

<body>
<div id="header-div">
    <g:render template="/layouts/commonheader" model="['app': 'changeMyPassword']"/>
</div>

<div class="body" style="padding-left: 15%">
    <h1>更改我的密码<!--<SIAT_zh_CN original="Change My Password">更改我的密码</SIAT_zh_CN>--></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${command}">
        <div class="errors">
            <g:renderErrors bean="${command}" as="list"/>
        </div>
    </g:hasErrors>

    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name"><label for="oldPassword">当前密码:<!--<SIAT_zh_CN original="Current Password">当前密码</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value">
                        <input type="password" id="oldPassword" name="oldPassword"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><label for="newPassword">新密码:<!--<SIAT_zh_CN original="New Password">新密码</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value">
                        <input type="password" id="newPassword" name="newPassword"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name"><label for="newPasswordRepeated">重复新密码:<!--<SIAT_zh_CN original="Repeat New Password">重复新密码</SIAT_zh_CN>--></label></td>
                    <td valign="top" class="value">
                        <input type="password" id="newPasswordRepeated" name="newPasswordRepeated" value=""/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button">
                <input class="save" type="submit" value="更新"/><!--<SIAT_zh_CN original="Update">更新</SIAT_zh_CN>-->
            </span>
        </div>
    </g:form>
    <r:layoutResources/>
</div>
</body>
</html>
