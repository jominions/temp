<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="genesigmain" />
    <g:if test="${wizard.wizardType==1}">
        <title>编辑基因印记<!--<SIAT_zh_CN original="Gene Signature Edit">编辑基因印记</SIAT_zh_CN>--></title>
    </g:if>
    <g:else>
        <title>创建基因印记<!--<SIAT_zh_CN original="Gene Signature Create">创建基因印记</SIAT_zh_CN>--></title>
    </g:else>

    <script type="text/javascript">
        function validate() {
            // list name required
            if(document.geneSignatureFrm.name.value=="") {
                alert("必须指定列表名称！");//<SIAT_zh_CN original="You must specify a list name">必须指定列表名称！</SIAT_zh_CN>
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<div class="body">
    <!-- initialize -->
    <g:set var="gs" value="${wizard.geneSigInst.properties}" />

    <g:if test="${wizard.wizardType==0}"><h1>创建基因印记<!--<SIAT_zh_CN original="Gene Signature Create">创建基因印记</SIAT_zh_CN>--></h1></g:if>
    <g:if test="${wizard.wizardType==1}"><h1>编辑基因印记<!--<SIAT_zh_CN original="Gene Signature Edit">编辑基因印记</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>
    <g:if test="${wizard.wizardType==2}"><h1>复制基因印记<!--<SIAT_zh_CN original="Gene Signature Clone">克隆基因印记</SIAT_zh_CN>-->: ${gs.name}</h1></g:if>

<!-- instructions -->
    <g:render template="instructions" />
    <br>

    <g:form name="geneSignatureFrm" method="post">
        <g:hiddenField name="page" value="1" />

        <!-- list definition block -->
        <p style="font-weight: bold;">页面 1: 定义:<!--<SIAT_zh_CN original="Page 1: Definition:">页面 1: 定义:</SIAT_zh_CN>--></p>
        <table class="detail">
            <tr class="prop">
                <td class="name">印记/列表 名称<!--<SIAT_zh_CN original="Signature/List Name">印记/列表 名称</SIAT_zh_CN>--><g:requiredIndicator/></td>
                <td class="value"><g:textField name="name" value="${gs.name}" size="100%" maxlength="100" /></td>
            </tr>
            <tr>
            <tr class="prop">
                <td class="name">描述<!--<SIAT_zh_CN original="Description">描述</SIAT_zh_CN>--></td>
                <td class="value"><g:textArea name="description" value="${gs.description}" rows="6" cols="85" /></td>
            </tr>
            <g:if test="${wizard.wizardType==1}">
                <tr class="prop">
                    <td class="name">公开？<!--<SIAT_zh_CN original="Public?">公开？</SIAT_zh_CN>--></td>
                    <td class="value">
                        <g:radioGroup name="publicFlag" values="[true,false]" labels="['Yes','No']" value="${gs.publicFlag}" >
                            ${it.radio}&nbsp;<g:message code="${it.label}" />&nbsp;
                        </g:radioGroup>
                    </td>
                </tr>
            </g:if>
            <tr>
                <g:if test="${wizard.wizardType==1}">
                    <td style="font-weight: bold; font-style: italic;" colspan=2>注意，该印记由作者'${gs.createdByAuthUser?.userRealName}'于${gs.dateCreated}创建。<!--<SIAT_zh_CN original="Note, the creator of this signature was '${gs.createdByAuthUser?.userRealName}' on ${gs.dateCreated}">Note, the creator of this signature was '${gs.createdByAuthUser?.userRealName}' on ${gs.dateCreated}">注意，该印记由作者'${gs.createdByAuthUser?.userRealName}'于${gs.dateCreated}创建。</SIAT_zh_CN>--></td>
                </g:if>
                <g:else>
                    <td style="font-weight: bold; font-style: italic;" colspan=2>注意，该印记将由作者'<sec:loggedInUserInfo field="userRealName"/>'于当前系统时间创建<!--<SIAT_zh_CN original="Note, the creator of this signature will be '<sec:loggedInUserInfo field="userRealName"/>' at the current system time">注意，该印记将由作者'<sec:loggedInUserInfo field="userRealName"/>'于当前系统时间创建。</SIAT_zh_CN>-->
                    </td>
                </g:else>
            </tr>
        </table>

        <div class="buttons">
            <g:actionSubmit class="next" action="${(wizard.wizardType==1 || wizard.wizardType==2) ? 'edit2' : 'create2'}" value="元数据" onclick="return validate();" /><!--<SIAT_zh_CN original="Meta-Data">元数据</SIAT_zh_CN>-->
            <g:actionSubmit class="cancel" action="refreshSummary" onclick="return confirm('确认离开？')" action="Cancel" value="取消" /><!--<SIAT_zh_CN original="Are you sure you want to exit?">确认离开？</SIAT_zh_CN>--><!--<SIAT_zh_CN original="Cancel">取消</SIAT_zh_CN>-->
        </div>

        <br>
    </g:form>
</div>
</body>
</html>
