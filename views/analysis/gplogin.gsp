<html>
<head>

    <!--
		<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'ext/adapter/ext/ext-base.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'ext/ext-all.js')}"></script>
	 -->
    <script type="text/javascript" language="javascript">

        function extractCookie(result, request) {
            alert("结果是 " + result);//<SIAT_zh_CN original="result is ">结果是</SIAT_zh_CN>
            parent.gpCookie = result;
        }

        function submitFormDelayed() {
            setTimeout("submitForm()", 50);
        }

        function submitForm() {
            document.forms["loginForm"].submit();

            //var gpurl = "${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}/gp/pages/login.jsf";

            //alert("gp url: " + gpurl);

            //Ext.Ajax.request({
            //	url: gpurl,
            //	params: { loginForm: 'loginForm',
            //			  'javax.faces.ViewState': 'j_id1',
            //			  username: 'biomart',
            //			  'loginForm:signIn': 'Sign in' },
            //	method: "POST",
            //	success: extractCookie,
            //	failure: extractCookie
            //});

        }

    </script>

</head>

<body onload="submitForm();">

<!-- load an image to force browser to get a session cookie... -->
<img src="${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}/gp/images/GP-logo.gif"
     alt="GenePattern" height="48" style="border: 0;" width="229"/>

<form id="loginForm" name="loginForm" method="get"
      action="${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}/gp/pages/login.jsf"
      enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="loginForm" value="登录表单"/><!--<SIAT_zh_CN original="loginForm">登录表单</SIAT_zh_CN>-->
    <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1"/>
    <input type="hidden" id="username" name="username" type="text" value="${userName}"/>
    <input type="hidden" id="loginForm:signIn" type="text" name="loginForm:signIn" value="登录"/><!--<SIAT_zh_CN original="Sign in">登录</SIAT_zh_CN>-->
    <input id="loginForm:signIn" type="submit" name="loginForm:signIn" value="登录"/><!--<SIAT_zh_CN original="Sign in">登录</SIAT_zh_CN>-->
    <br/>
</form>

</body>

</html>