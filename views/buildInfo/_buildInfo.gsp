<h1>编译环境<!--<SIAT_zh_CN original="Compilation context">编译环境</SIAT_zh_CN>--></h1>

<g:if test="${!grails.util.Metadata.getCurrent().isWarDeployed()}">
    <p><i>您正在执行的tranSMART是从其源码编译而来的。一旦您部署了一个编译的WAR文档的这些信息都是可用的。<!--<SIAT_zh_CN original="You are executing tranSMART from its source. These information will be available as soon as you deploy a compiled WAR archive.">您正在执行的tranSMART是从其源码编译而来的。一旦您部署了一个编译的WAR文档的这些信息都是可用的。</SIAT_zh_CN>--></i>
    </p>
</g:if>
<g:else>
    <table>
        <thead>
        <tr style="height: 30px;">
            <th style="vertical-align: middle; width: 250px;"><g:message code="buildInfo.prop" default="属性"/><!--<SIAT_zh_CN original="Property">属性</SIAT_zh_CN>--></th>
            <th style="vertical-align: middle; width: 400px;"><g:message code="buildInfo.value" default="值"/><!--<SIAT_zh_CN original="Value">值</SIAT_zh_CN>--></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${buildInfoProperties}" status="i" var="prop">
            <g:if test="${g.meta(name: prop)}">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="height: 30px;">
                    <td><g:message code="${prop}"/></td><td><g:meta name="${prop}"/></td>
                </tr>
            </g:if>
        </g:each>
        </tbody>
    </table>
</g:else>