<g:set var="sectionCounter" value="0"/>

<g:each var="contact" in="${allSamplesByContact}">

    <div style="font-size:1.5em;text-align:center;padding:10px;">
        <g:if test="${contact.key == 'NO_CONTACT'}">
            尚无这些样品的联系信息.<!--<SIAT_zh_CN original="Contact Information unavailable for these samples">尚无这些样品的联系信息</SIAT_zh_CN>-->
        </g:if>
        <g:else>
            联系电子邮箱<!--<SIAT_zh_CN original="Contact E-Mail">联系电子邮箱</SIAT_zh_CN>--> : <a
                href="mailto:${contact.key}?Subject=Sample Information&body=Sample%20IDs%20${contactSampleIdMap[contact.key].join(',')}"
                target="_top">${contact.key}</a>
        </g:else>
    </div>

    <br/>

    &nbsp;&nbsp;&nbsp;<a href="#"
                         onclick="toggleContactSampleSection(document.getElementById('sampleSection${sectionCounter}'))">切换样品信息<!--<SIAT_zh_CN original="Toggle Sample Information">切换样品信息</SIAT_zh_CN>--></a>

    &nbsp;&nbsp;&nbsp;样品ID列表<!--<SIAT_zh_CN original="Sample ID List">样品ID列表</SIAT_zh_CN>--> - <input type="text" value="${contactSampleIdMap[contact.key].join(',')}"/>

    <div id="divSample${sectionCounter}" class="detailedSampleInformation">
        <div id="sampleSection${sectionCounter}" style="display:none;">
            <g:each var="sample" in="${contact.value}">
                <table class="biobankResults">
                    <g:each var="sampleAttribute" in="${sample}">
                        <g:if test="${sampleAttribute.key != 'count'}">
                            <tr>
                                <th>
                                    ${columnPrettyNameMapping[sampleAttribute.key]}
                                </th>
                                <td style='vertical-align:middle;border-color:black;border-width:1px;border-style:solid;padding: 3px;'>
                                    ${sampleAttribute.value}
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                </table>

                <br/>
                <br/>

            </g:each>
        </div>
    </div>

    <g:set var="sectionCounter" value="${sectionCounter + 1}"/>

</g:each>