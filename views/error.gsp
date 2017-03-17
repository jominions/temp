<!DOCTYPE HTML>
<html>
<head>
    <title><g:if env="development">Grails执行阶段错误<!--<SIAT_zh_CN original="Grails Runtime Exception">Grails执行阶段错误</SIAT_zh_CN>--></g:if><g:else>Error</g:else></title>
    <meta name="layout" content="main">
    <g:if env="development">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
    </g:if>
</head>

<body>
<g:if env="development">
    <g:renderException exception="${exception}"/>
</g:if>
<g:else>
    <ul class="errors">
        <li>产生错误<!--<SIAT_zh_CN original="An error has occurred">产生错误</SIAT_zh_CN>--></li>
    </ul>
</g:else>
</body>
</html>
