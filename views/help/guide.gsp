<head>
    <meta name='layout' content='main'/>
    <title>${grailsApplication.config.com.recomdata.appTitle}</title>
</head>

<body>

<div style="width: 600px; margin: 50px auto 50px auto;">
    <h3>培训指南<!--<SIAT_zh_CN original="Training Guide">培训指南</SIAT_zh_CN>--></h3>
    &nbsp;
    <br>
    <sec:ifAnyGranted roles="ROLE_PUBLIC_USER">
        <table class="detail">
            <tr>
            <td><a style="color:blue" href="${resource(dir: 'help', file: 'PublicTrainingTutorials-Basic.pdf')}">基本训练指南<!--<SIAT_zh_CN original="Basic Training Guide">基本训练指南</SIAT_zh_CN>--></a>
    </td></tr><tr>
        <td><a style="color:blue"
               href="${resource(dir: 'help', file: 'PublicTrainingTutorials-Advanced.pdf')}">高级训练指南<!--<SIAT_zh_CN original="Advanced Training Guide">高级训练指南</SIAT_zh_CN>--></a>
        </td></tr>
    </table>
    </sec:ifAnyGranted>

    <sec:ifNotGranted roles="ROLE_PUBLIC_USER">
        <table class="detail">
        <tr>
        <td><a style="color:blue" href="${resource(dir: 'help', file: 'TransmartTrainingTutorials-Basic.pdf')}">Transmart 基本训练指南<!--<SIAT_zh_CN original="Transmart Basic Training Guide">Transmart 基本训练指南</SIAT_zh_CN>--></a>
    </td></tr><tr>
        <td><a style="color:blue"
               href="${resource(dir: 'help', file: 'TransmartTrainingTutorials-Advanced.pdf')}">Transmart 高级训练指南<!--<SIAT_zh_CN original="Transmart Advanced Training Guide">Transmart 高级训练指南</SIAT_zh_CN>--></a>
        </td></tr>
    </table>
    </sec:ifNotGranted>
</div>

</body>
