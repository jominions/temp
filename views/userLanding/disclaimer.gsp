<head>
    <meta name='layout' content='main'/>
    <title>${grailsApplication.config.com.recomdata.appTitle}</title>
</head>

<body>
<div style="text-align: center;">
    <div style="width: 400px; margin: 50px auto 50px auto;">
        <img style="display: block; margin: 12px auto;"
             src="${resource(dir: 'images', file: grailsApplication.config.com.recomdata.largeLogo)}"
             alt="Transmart"/>
        <div style="text-align: center;"><h3>注意: 用户来自<!--<SIAT_zh_CN original="ATTENTION: Users of">注意: 用户来自</SIAT_zh_CN>--> ${grailsApplication.config.com.recomdata.appTitle}</h3></div>

        <div style="text-align: justify; margin: 12px;">
            ${grailsApplication.config.com.recomdata.disclaimer}
        </div>
        <div style="text-align: center;">
            <g:form name="disclaimer" method="post" id="disclaimerForm">
                <g:actionSubmit value="我同意" action="agree"/><!--<SIAT_zh_CN original="I agree">我同意</SIAT_zh_CN>-->
                <g:actionSubmit value="我不同意" action="disagree"/><!--<SIAT_zh_CN original="I disagree">我不同意</SIAT_zh_CN>-->
            </g:form>
        </div>
    </div>
</div>
</body>
