<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8"/>
    <title>易行-后台管理系统</title>
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
                用户登录
            </h4>

            <div class="space-6"></div>
            <div class="alert alert-danger hide" id="login_alert_danger"></div>
            <div class="alert alert-success hide" id="login_alert_success"></div>
            
            <form method="POST" id="login-form" action="{{ url("admin/login/dologin") }}">
                <fieldset>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="text" class="form-control"
                                     placeholder="手机号" name="phone" id="login-phone" required/>
                              <i class="icon-phone"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password"
                                     class="form-control"
                                     placeholder="密码" name="password" id="login-password" required/>
                              <i class="icon-lock"></i>
                            </span>
                    </label>

                    <div class="space"></div>

                    <div class="clearfix">
                        <label class="inline">
                            <input type="checkbox" id="login-remeber" class="ace"/>
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
                    用户注册
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
            
            <div class="alert alert-danger hide" id="find_alert_danger"></div>
            <div class="alert alert-success hide" id="find_alert_success"></div>
            
            <p>
                输入您的手机号，并输入手机验证码和新密码
            </p>

            <form method="post" id="reset-form" action="{{ url("admin/login/doResetPassword") }}">
                <fieldset>
                    <label class="block clearfix">
                        <div class="input-group">
                              <input type="text" class="form-control" placeholder="手机号" name="phone" id="find_phone" required="required" />
                              <span class="input-group-btn">
                                <button class="btn btn-default  btn-sm btn-success" id="find_send_msg"  type="button">发送短信</button>
                              </span>
                        </div><!-- /input-group -->


                    </label>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="text" class="form-control" placeholder="验证码" required="required" id="find_authcode" name="authcode"/>
                              <i class="icon-code"></i>
                            </span>
                    </label>
                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password" class="form-control" placeholder="新密码" id="find_password" required="required" name="password"/>
                              <i class="icon-pause"></i>
                            </span>
                    </label>
                    <div class="clearfix">
                        <button id="find_reset_btn" type="submit" class="width-35 pull-right btn btn-sm btn-danger">
                            <i class="icon-lightbulb"></i>
                            重置密码
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
            <div class="alert alert-danger hide" id="reg_alert_danger"></div>
            <div class="alert alert-success hide" id="reg_alert_success"></div>
            <form method="post" id="register-form" action="{{ url('admin/login/doregister') }}">
                <fieldset>
                    <label class="block clearfix">
                        <div class="input-group">
                            <input type="text" class="form-control"  id="reg_phone_num" placeholder="手机号" name="phone" required="required" />
                              <span class="input-group-btn">
                                <button class="btn btn-default  btn-sm btn-success" id="reg_send_msg" type="button">发送短信</button>
                              </span>
                        </div><!-- /input-group -->
                    </label>


                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="text" class="form-control" placeholder="验证码" name="authcode" id="reg_authcode" required/>
                              <i class="icon-code"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password" class="form-control" placeholder="密码" name="password" id="reg_password" required/>
                              <i class="icon-lock"></i>
                            </span>
                    </label>

                    <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                              <input type="password" class="form-control" placeholder="请重复密码" id="reg_repassword" name="password_again"/>
                              <i class="icon-retweet"></i>
                            </span>
                    </label>

                    <label class="block">
                        <input type="checkbox" class="ace" id="reg_agree" required="required"/>
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

                        <button type="submit" class="width-65 pull-right btn btn-sm btn-success" id="register">
                            点击注册
                            <i class="icon-arrow-right icon-on-right"></i>
                        </button>
                        <input type="hidden" name="smsid" value="" id="reg_smsid" />
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
    
    function validatePhoneNum( num ){
       var re= /^[1][3578]\d{9}$/;
       if(!re.test(num))
       {
           
            return false;
       }
       
       return true;
    };
    
    $("#reg_send_msg").click(function(){
         var phone_num = $("#reg_phone_num").val();
         if( validatePhoneNum(phone_num)==false ){
            show_alert_box("reg_alert_danger","手机号码格式不正确");
            return false;
         }
         $.ajax({
            url:'{{ url("admin/login/doSendSMS") }}',
            type:'POST',
            data:{'phone':phone_num},
            dataType:'json',
            success:function(data){
                if( data.status!=200 ){
                    show_alert_box("reg_alert_danger",data.msg);
                }else{          
                    show_alert_box("reg_alert_success","短信发送成功，请查收");
                    //$("#reg_smsid").val(data.data.smsid);
                }
            }
        });
        return false;
    });
    
    function show_alert_box(id,msg){
       $("#"+id).html(msg).removeClass("hide");
       
       setTimeout(function(){
        $("#"+id).addClass('hide');
       },2000);
       
       return true;
    }
    
    $("#register-form").submit(function(){
       return doRegister();
    });
 
    
    function doRegister(){
        var url = $("#register-form").attr("action");
        var phone_num = $("#reg_phone_num").val();
         if( validatePhoneNum(phone_num)==false ){
            return false;
        }
        var authcode = $("#reg_authcode").val();
        if( authcode=="" ){
            show_alert_box("reg_alert_danger","验证码不能为空");
            return false;
        }
        var password = $("#reg_password").val();
        if( password=="" ){
            show_alert_box("reg_alert_danger","密码不能为空");
            return false;
        }
        
        var repassword = $("#reg_repassword").val();
        if( repassword!=password ){
            show_alert_box("reg_alert_danger","两次密码不一致");
            return false;
        }
        
        $.ajax({
            url:url,
            type:'POST',
            data:{'phone':phone_num,'authcode':authcode,'password':password},
            dataType:'json',
            success:function(data){
                if( data.status!=200 ){
                    show_alert_box("reg_alert_danger",data.msg);
                }else{          
                    show_alert_box("reg_alert_success","注册成功");
                }
            }
        });
        return false;
    };
    
    
    $("#find_send_msg").click(function(){
         var phone_num = $("#find_phone").val();
         if( validatePhoneNum(phone_num)==false ){
            show_alert_box("find_alert_danger","手机号码格式不正确");
            return false;
         }
         $.ajax({
            url:'{{ url("admin/login/doSendSMS") }}',
            type:'POST',
            data:{'phone':phone_num},
            dataType:'json',
            success:function(data){
                if( data.status!=200 ){
                    show_alert_box("find_alert_danger",data.msg);
                }else{          
                    show_alert_box("find_alert_success","短信发送成功，请查收");
                }
            }
        });
        return false;
    });
    
    $("#reset-form").submit(function(){
        return doFind();
    });
    
    function doFind(){
        var url = $("#reset-form").attr("action");
        var phone_num = $("#find_phone").val();
         if( validatePhoneNum(phone_num)==false ){
            return false;
        }
        var authcode = $("#find_authcode").val();
        if( authcode=="" ){
            show_alert_box("reg_alert_danger","验证码不能为空");
            return false;
        }
        var password = $("#find_password").val();
        if( password=="" ){
            show_alert_box("reg_alert_danger","密码不能为空");
            return false;
        }
        
        $.ajax({
            url:url,
            type:'POST',
            data:{'phone':phone_num,'authcode':authcode,'password':password},
            dataType:'json',
            success:function(data){
                if( data.status!=200 ){
                    show_alert_box("reg_alert_danger",data.msg);
                }else{          
                    show_alert_box("reg_alert_success","重置密码成功");
                }
            }
        });
        return false;
    };
    
    $("#login-form").submit(function(){
        return doLogin();
    });
    
    function doLogin(){
        var url = $("#login-form").attr("action");
        var phone_num = $("#login-phone").val();
         if( validatePhoneNum(phone_num)==false ){
            show_alert_box("login_alert_danger","手机号码格式不正确");
            return false;
        }
        var password = $("#login-password").val();
        if( password=="" ){
            show_alert_box("login_alert_danger","密码不能为空");
            return false;
        }
        var rem = $("#login-remeber").is(":checked");
        rem = rem?1:0;
        $.ajax({
            url:url,
            type:'POST',
            data:{'phone':phone_num,'password':password,'remeber':rem},
            dataType:'json',
            success:function(data){
                if( data.status==301 ){
                    show_alert_box("login_alert_success","登录成功");
                    window.location.href = data.url;
                }else{
                    show_alert_box("login_alert_danger",data.msg);
                }
            }
        });
        return false;
    }
</script>
</body>
</html>
