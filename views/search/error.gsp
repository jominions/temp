<html>
<head>
    <title>${grailsApplication.config.com.recomdata.appTitle} - ${title}</title>
    <style type="text/css">
    .message {
        border: 1px solid black;
        padding: 5px;
        background-color: #E9E9E9;
    }

    .stack {
        border: 1px solid black;
        padding: 5px;
        overflow: auto;
        height: 300px;
    }

    .snippet {
        padding: 5px;
        background-color: white;
        border: 1px solid black;
        margin: 3px;
        font-family: courier;
    }
    </style>
</head>

<body>
<h1>${title}</h1>

<h2>错误细节<!--<SIAT_zh_CN original="Error Details">错误细节</SIAT_zh_CN>--></h2>

<div class="message">
    <strong>消息<!--<SIAT_zh_CN original="Message">消息</SIAT_zh_CN>-->:</strong> ${message}
</div>
</body>
</html>
