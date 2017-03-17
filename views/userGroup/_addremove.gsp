<g:setProvider library="jquery"/>

<td><g:select class="addremoveselect" name="userstoremove"
              from="${userGroupInstance?.members.sort { it.name.toUpperCase() }}"
              size="15" multiple="yes" optionKey="id"/></td>
<td class="addremovebuttonholder">
    <button class="ltarrowbutton"
            onclick="${remoteFunction(action:'addUsersToUserGroup',update:[success:'groupmembers', failure:''], id:userGroupInstance?.id, params:'jQuery(\'#userstoadd\').serialize()+\'&searchtext=\'+document.getElementById(\'searchtext\').value'  )};
            return false;">&LT;&LT;添加<!--<SIAT_zh_CN original="Add">添加</SIAT_zh_CN>--></button><br>
    <button class="ltarrowbutton"
            onclick="${remoteFunction(action:'removeUsersFromUserGroup',update:[success:'groupmembers', failure:''], id:userGroupInstance?.id, params:'jQuery(\'#userstoremove\').serialize()+\'&searchtext=\'+document.getElementById(\'searchtext\').value'  )};
            return false;">移除<!--<SIAT_zh_CN original="Remove">移除</SIAT_zh_CN>-->&GT;&GT;</button>
</td>
<td>
    <div id="addfrombox">
        <g:select class="addremoveselect" width="100px" size="15" name="userstoadd"
                  from="${usersToAdd}" multiple="yes" optionKey="id"></g:select>
</td>
</div>
</td>


