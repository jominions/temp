<html>
<head>
    <title>Centocor研究存储库(原型) - 请求协助<!--<SIAT_zh_CN original="Centocor research subject data repository (Prototype) - Request Consult">Centocor研究存储库(原型) - 请求协助</SIAT_zh_CN>--></title>
    <meta name="layout" content="main"/>
</head>

<body>
<g:render template="/layouts/commonheader" model="['app': 'consult']"/>
<div class="body" style="float:left;">
    <br>

    <h2>请说明需要取得的数据内容<!--<SIAT_zh_CN original="Please specify what data to be retrieved from the repository">请说明需要取得的数据内容</SIAT_zh_CN>--></h2>

    <div class="dialog">
        <table style="border:0px">
            <tbody>
            <g:form controller="reqconsult">
                <tr class="prop">

                    <td><g:textArea name="consulttext" value="" style="width:400px; height:200px"/></td>
                </tr>
                <tr><td>
                    <g:actionSubmit class="search" value="提交" action="Saverequest"/><!--<SIAT_zh_CN original="Submit">提交</SIAT_zh_CN>-->
                </td></tr>
            </g:form>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>