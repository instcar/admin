<div class="navbar navbar-default" id="navbar">
<script type="text/javascript">
    try {
        ace.settings.check('navbar', 'fixed')
    } catch (e) {
    }
</script>

<div class="navbar-container" id="navbar-container">
<div class="navbar-header pull-left">
    <a href="#" class="navbar-brand">
        <small>
            易行后台管理系统
        </small>
    </a><!-- /.brand -->
</div>
<!-- /.navbar-header -->

<div class="navbar-header pull-right" role="navigation">
<ul class="nav ace-nav">

<li class="light-blue">
    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
        <img class="nav-user-photo" src="{{ user["headpic"] }}_i.jpg" alt="Jason's Photo"/>
	    <span class="user-info">
	      <small>欢迎光临,</small>
            {{ user["name"] }}
	    </span>

        <i class="icon-caret-down"></i>
    </a>

    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
        <li>
            <a href="#">
                <i class="icon-cog"></i>
                设置
            </a>
        </li>

        <li>
            <a href="{{ url('admin/user/note') }}">
                <i class="icon-pencil"></i>
                个人笔记
            </a>
        </li>

        <li>
            <a href="{{ url('admin/user/profile') }}">
                <i class="icon-user"></i>
                个人资料
            </a>
        </li>

        <li class="divider"></li>

        <li>
            <a href="{{ url('admin/login/dologout') }}">
                <i class="icon-off"></i>
                退出
            </a>
        </li>
    </ul>
</li>
</ul>
<!-- /.ace-nav -->
</div>
<!-- /.navbar-header -->
</div>
<!-- /.container -->
</div>
