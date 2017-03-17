<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            访问日志<!--<SIAT_zh_CN original="Access Log">访问日志</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="accessLog"
                                                      action="list">查看访问日志<!--<SIAT_zh_CN original="View Access Log">查看访问日志</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            分组<!--<SIAT_zh_CN original="Groups">分组</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="userGroup"
                                                      action="list">分组清单<!--<SIAT_zh_CN original="Group List">分组清单</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="userGroup"
                                                      action="create">新建分组<!--<SIAT_zh_CN original="Create Group">新建分组</SIAT_zh_CN>--></g:link></span>
            </li>

            <li>
                <span class="adminMenuButton"><g:link class="create" controller="userGroup"
                                                      action="membership">组成员身份<!--<SIAT_zh_CN original="Group Membership">组成员身份</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            用户<!--<SIAT_zh_CN original="Users">用户</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="authUser"
                                                      action="list">用户列表<!--<SIAT_zh_CN original="User List">用户列表</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="authUser"
                                                      action="create">新建用户<!--<SIAT_zh_CN original="Create User">新建用户</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<g:if test="${!!grailsApplication.getControllerClass('blend4j.plugin.GalaxyUserDetailsController')}">
    <g:if test="${grailsApplication.config.com.galaxy.blend4j.galaxyEnabled}">
        <div class="navbarBox">
            <div class="navcontainer1">
                <h1 class="panelHeader">
                    Galaxy用户<!--<SIAT_zh_CN original="Galaxy Users">Galaxy用户</SIAT_zh_CN>-->
                </h1>
                <ul class="navlist">
                    <li>
                        <span class="adminMenuButton"><g:link class="list" controller="GalaxyUserDetails"
                                                              action="list">用户列表<!--<SIAT_zh_CN original="User List">用户列表</SIAT_zh_CN>--></g:link></span>
                    </li>
                    <li>
                        <span class="adminMenuButton"><g:link class="create" controller="GalaxyUserDetails"
                                                              action="create">新建用户<!--<SIAT_zh_CN original="Create User">新建用户</SIAT_zh_CN>--></g:link></span>
                    </li>
                </ul>
            </div>
        </div>
    </g:if>
</g:if>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            访问控制<!--<SIAT_zh_CN original="Access Control">访问控制</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="secureObjectAccess"
                                                      action="manageAccess">组访问控制<!--<SIAT_zh_CN original="Access Control by Group">组访问控制</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="secureObjectAccess"
                                                      action="manageAccessBySecObj">案例访问控制<!--<SIAT_zh_CN original="Access Control by Study">案例访问控制</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            案例<!--<SIAT_zh_CN original="Study">案例</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="secureObject"
                                                      action="list">案例列表<!--<SIAT_zh_CN original="Study List">案例列表</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="secureObject"
                                                      action="create">添加案例列表<!--<SIAT_zh_CN original="Add Study List">添加案例列表</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            安全对象路径<!--<SIAT_zh_CN original="Secure Object Paths">安全对象路径</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="secureObjectPath"
                                                      action="list">安全对象路径列表<!--<SIAT_zh_CN original="SecureObjectPath List">安全对象路径列表</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="secureObjectPath"
                                                      action="create">添加安全对象路径<!--<SIAT_zh_CN original="Add SecureObjectPath">添加安全对象路径</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            角色<!--<SIAT_zh_CN original="Roles">角色</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="role"
                                                      action="list">角色列表<!--<SIAT_zh_CN original="Role List">角色列表</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="role"
                                                      action="create">新建角色<!--<SIAT_zh_CN original="Create Role">新建角色</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            设定Requestmap<!--<SIAT_zh_CN original="RequestMap Setup">设定Requestmap</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="requestmap"
                                                      action="list">Requestmap列表<!--<SIAT_zh_CN original="Requestmap List">Requestmap列表</SIAT_zh_CN>--></g:link></span>
            </li>
            <li>
                <span class="adminMenuButton"><g:link class="create" controller="requestmap"
                                                      action="create">创建Requestmap<!--<SIAT_zh_CN original="Requestmap Create">创建Requestmap</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>

<g:if test="${!!grailsApplication.getControllerClass('ImportXnatController')}">
    <g:if test="${grailsApplication.config.org.transmart.xnatImporterEnabled}">
        <div class='navbarBox'>
            <div class="navcontainer1">
                <h1 class="panelHeader">
                    导入XNAT临床数据<!--<SIAT_zh_CN original="Import XNAT clinical data">导入XNAT临床数据</SIAT_zh_CN>-->
                </h1>
                <ul class="navlist">
                    <li>
                        <span class="adminMenuButton"><g:link class="list" controller="importXnat" action="list">配置列表<!--<SIAT_zh_CN original="Configuration List">配置列表</SIAT_zh_CN>--></g:link></span>
                    </li>
                    <li>
                        <span class="adminMenuButton"><g:link class="create" controller="importXnat" action="create">创建配置<!--<SIAT_zh_CN original="Create Configuration">创建配置</SIAT_zh_CN>--></g:link></span>
                    </li>
                </ul>
            </div>
        </div>
    </g:if>
</g:if>


<div class='navbarBox'>
    <div class="navcontainer1">
        <h1 class="panelHeader">
            包<!--<SIAT_zh_CN original="Package">包</SIAT_zh_CN>-->
        </h1>
        <ul class="navlist">
            <li>
                <span class="adminMenuButton"><g:link class="list" controller="buildInfo"
                                                      action="index">构建信息<!--<SIAT_zh_CN original="Build Information">构建信息</SIAT_zh_CN>--></g:link></span>
            </li>
        </ul>
    </div>
</div>
