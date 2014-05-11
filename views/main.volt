<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta charset="utf-8" />
    <title>控制台 - 易行管理平台</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    {% block style %}
      <!-- basic styles -->
      <link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
      <link rel="stylesheet" href="/assets/css/font-awesome.min.css" />

      <!--[if IE 7]>
      <link rel="stylesheet" href="/assets/css/font-awesome-ie7.min.css" />
      <![endif]-->

      <!-- page specific plugin styles -->

      <!-- fonts -->
      <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

      <!-- ace styles -->
      <link rel="stylesheet" href="/assets/css/ace.min.css" />
      <link rel="stylesheet" href="/assets/css/ace-rtl.min.css" />
      <link rel="stylesheet" href="/assets/css/ace-skins.min.css" />

      <!--[if lte IE 8]>
      <link rel="stylesheet" href="/assets/css/ace-ie.min.css" />
      <![endif]-->

    {% endblock %}

    {% block js_top %}

      <!-- inline styles related to this page -->

      <!-- ace settings handler -->
      <script src="/assets/js/ace-extra.min.js"></script>

      <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

      <!--[if lt IE 9]>
      <script src="/assets/js/html5shiv.js"></script>
      <script src="/assets/js/respond.min.js"></script>
      <![endif]-->

    {% endblock %}

  </head>

  <body>

    {% include "layouts/navbar-header.volt" %}

    <div class="main-container" id="main-container">
      <script type="text/javascript">
       try{ace.settings.check('main-container' , 'fixed')}catch(e){}
      </script>

      <div class="main-container-inner">
	<a class="menu-toggler" id="menu-toggler" href="#">
	  <span class="menu-text"></span>
	</a>
        {% include "layouts/sidebar.volt" %}

        <div class="main-content">
	  <div class="breadcrumbs" id="breadcrumbs">
	    <script type="text/javascript">
	     try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
	    </script>

	    <ul class="breadcrumb">
	      <li>
		<i class="icon-home home-icon"></i>
		<a href="#">首页</a>
	      </li>

	      <li>
		<a href="#">控制台</a>
	      </li>
              
	      <li class="active">控制台</li>
	    </ul><!-- .breadcrumb -->

	    <div class="nav-search" id="nav-search">
	      <form class="form-search">
		<span class="input-icon">
		  <input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
		  <i class="icon-search nav-search-icon"></i>
		</span>
	      </form>
	    </div><!-- #nav-search -->
	  </div>

	  <div class="page-content">
            <div class="page-header">
	      <h1>
		控制台
		<small>
		  <i class="icon-double-angle-right"></i>
		  查看
		</small>
	      </h1>
	    </div><!-- /.page-header -->

	    <div class="row">
	      <div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
                {% block page_content %}

                {% endblock %}
		<!-- PAGE CONTENT ENDS -->
	      </div><!-- /.col -->
	    </div><!-- /.row -->
	  </div><!-- /.page-content -->
	</div><!-- /.main-content -->

        {% include "layouts/setting.volt" %}
      </div><!-- /.main-container-inner -->
      <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
	<i class="icon-double-angle-up icon-only bigger-110"></i>
      </a>
    </div><!-- /.main-container -->


    {% block js_bottom %}
      <!-- basic scripts -->

      <!--[if !IE]> -->

      <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

      <!-- <![endif]-->

      <!--[if IE]>
      <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
      <![endif]-->

      <!--[if !IE]> -->

      <script type="text/javascript">
       window.jQuery || document.write("<script src='/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
      </script>

      <!-- <![endif]-->

      <!--[if IE]>
      <script type="text/javascript">
      window.jQuery || document.write("<script src='/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
      </script>
      <![endif]-->

      <script type="text/javascript">
       if("ontouchend" in document) document.write("<script src='/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
      </script>
      <script src="/assets/js/bootstrap.min.js"></script>
      <script src="/assets/js/typeahead-bs2.min.js"></script>

      <!-- page specific plugin scripts -->

      <!-- ace scripts -->

      <script src="/assets/js/ace-elements.min.js"></script>
      <script src="/assets/js/ace.min.js"></script>

    {% endblock %}
  </body>


</html>
