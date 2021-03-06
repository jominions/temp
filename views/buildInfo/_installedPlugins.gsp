<h1>已安装的插件<!--<SIAT_zh_CN original="Installed Plugins">已安装的插件</SIAT_zh_CN>--></h1>

<table>
    <g:set var="pluginManager" value="${applicationContext.getBean('pluginManager')}"></g:set>
    <thead>
    <tr style="height: 30px;">
        <th style="vertical-align: middle; width: 250px;"><g:message code="buildInfo.plugin" default="插件"/><!--<SIAT_zh_CN original="Plugin">插件</SIAT_zh_CN>--></th>
        <th style="vertical-align: middle; width: 400px;"><g:message code="buildInfo.version" default="版本"/><!--<SIAT_zh_CN original="Version">版本</SIAT_zh_CN>--></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${pluginManager.allPlugins.sort({ it.name.toUpperCase() })}" status="i" var="plugin">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="height: 30px;">
            <td>${plugin.fileSystemShortName}</td><td>
            ${plugin.version}<br/>
            <g:if test="${g.meta(name: "plugin.${plugin.fileSystemShortName}.scm.version")}">
                <div class="pluginPropertiesBox"><i>
                    <g:each in="${buildInfoProperties}" var="prop">
                        <g:set var="absoluteProp" value="plugin.${plugin.fileSystemShortName}.${prop}"></g:set>
                        <g:if test="${g.meta(name: absoluteProp)}">
                            <g:message code="${prop}"/> : <g:meta name="${absoluteProp}"/><br/>
                        </g:if>
                    </g:each>
                </i></div>
            </g:if>
        </td>
        </tr>
    </g:each>
    </tbody>
</table>
