<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8"/>
    <title>易行 后台管理系统</title>
    <meta name="keywords" content="易行后台管理"/>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- basic styles -->

    <link href="/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/assets/css/font-awesome.min.css"/>

    <!--[if IE 7]>
    <link rel="stylesheet" href="/assets/css/font-awesome-ie7.min.css"/>
    <![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->

    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300"/>

    <!-- ace styles -->

    <link rel="stylesheet" href="/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="/assets/css/ace-rtl.min.css"/>

    <!--[if lte IE 8]>
    <link rel="stylesheet" href="/assets/css/ace-ie.min.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
    <script src="/assets/js/html5shiv.js"></script>
    <script src="/assets/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-layout">
<div class="main-container">
<div class="main-content">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<div class="login-container">
<div class="center">
    <h1>
        <i class="green"></i>
        <span class="red">易行</span><span class="white">后台管理系统</span>
    </h1>
    <h4 class="blue">&copy; 2013 - {{ date("Y") }} Instcar Inc.</h4>
</div>

<div class="space-6"></div>

<div class="position-relative">
<div id="login-box" class="login-box visible widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header blue lighter bigger">
                <i class="icon-coffee green"></i>
                请输入您的用户名和密码
            </h4>

            <div class="space-6"></div>

            <form method="POST" action="{{ url("admin/login/dologin") }}">
                <fieldset>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="text" class="form-control"
                                     placeholder="Username" name="username" required/>
                              <i class="icon-user"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password"
                                     class="form-control"
                                     placeholder="Password" name="password" required/>
                              <i class="icon-lock"></i>
                            </span>
                    </label>

                    <div class="space"></div>

                    <div class="clearfix">
                        <label class="inline">
                            <input type="checkbox" class="ace"/>
                            <span class="lbl"> 记住我 </span>
                        </label>

                        <button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
                            <i class="icon-key"></i>
                            登 录
                        </button>
                    </div>

                    <div class="space-4"></div>
                </fieldset>
            </form>

            <div class="social-or-login center">
                <span class="bigger-110">Or Login Using</span>
            </div>


            <div class="social-login center">
                <a class="btn btn-primary">
                    <i class="icon-facebook"></i>
                </a>

                <a class="btn btn-info">
                    <i class="icon-twitter"></i>
                </a>

                <a class="btn btn-danger">
                    <i class="icon-google-plus"></i>
                </a>
            </div>
        </div>
        <!-- /widget-main -->

        <div class="toolbar clearfix">
            <div>
                <a href="#" onclick="show_box('forgot-box'); return false;" class="forgot-password-link">
                    <i class="icon-arrow-left"></i>
                    忘记密码
                </a>
            </div>

            <div>
                <a href="#" onclick="show_box('signup-box'); return false;" class="user-signup-link">
                    新用户注册
                    <i class="icon-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
    <!-- /widget-body -->
</div>
<!-- /login-box -->

<div id="forgot-box" class="forgot-box widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header red lighter bigger">
                <i class="icon-key"></i>
                找回密码
            </h4>

            <div class="space-6"></div>
            <p>
                输入您的邮箱，并按邮件内容操作
            </p>

            <form>
                <fieldset>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="email" class="form-control" placeholder="Email"/>
                              <i class="icon-envelope"></i>
                            </span>
                    </label>

                    <div class="clearfix">
                        <button type="button" class="width-35 pull-right btn btn-sm btn-danger">
                            <i class="icon-lightbulb"></i>
                            发送
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>
        <!-- /widget-main -->

        <div class="toolbar center">
            <a href="#" onclick="show_box('login-box'); return false;" class="back-to-login-link">
                返回登录
                <i class="icon-arrow-right"></i>
            </a>
        </div>
    </div>
    <!-- /widget-body -->
</div>
<!-- /forgot-box -->

<div id="signup-box" class="signup-box widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                新用户注册
            </h4>

            <div class="space-6"></div>
            <p>填写表单: </p>

            <form>
                <fieldset>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="email" class="form-control" placeholder="Email"/>
                              <i class="icon-envelope"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="text" class="form-control" placeholder="Username" required/>
                              <i class="icon-user"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password" class="form-control" placeholder="Password" required/>
                              <i class="icon-lock"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password" class="form-control" placeholder="Repeat password"/>
                              <i class="icon-retweet"></i>
                            </span>
                    </label>

                    <label class="block">
                        <input type="checkbox" class="ace"/>
                            <span class="lbl">
                              接受
                              <a href="#">易行后台管理协议</a>
                            </span>
                    </label>

                    <div class="space-24"></div>

                    <div class="clearfix">
                        <button type="reset" class="width-30 pull-left btn btn-sm">
                            <i class="icon-refresh"></i>
                            重置表单
                        </button>

                        <button type="button" class="width-65 pull-right btn btn-sm btn-success">
                            点击注册
                            <i class="icon-arrow-right icon-on-right"></i>
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>

        <div class="toolbar center">
            <a href="#" onclick="show_box('login-box'); return false;" class="back-to-login-link">
                <i class="icon-arrow-left"></i>
                返回登录
            </a>
        </div>
    </div>
    <!-- /widget-body -->
</div>
<!-- /signup-box -->
</div>
<!-- /position-relative -->
</div>
</div>
<!-- /.col -->
</div>
<!-- /.row -->
</div>
</div>
<!-- /.main-container -->

<!-- basic scripts -->

<!--[if !IE]> -->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

<!--[if !IE]> -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='/assets/js/jquery-1.10.2.min.js'>" + "<" + "/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>

<!-- inline scripts related to this page -->

<script type="text/javascript">
    function show_box(id) {
        jQuery('.widget-box.visible').removeClass('visible');
        jQuery('#' + id).addClass('visible');
    }
</script>
</body>
</html>
