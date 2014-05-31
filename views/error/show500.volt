{% extends "main.volt" %}
{% block page_header %}
{% endblock %}
{% block page_content %}
    <div class="error-container">
        <div class="well">
            <h1 class="grey lighter smaller">
											<span class="blue bigger-125">
												<i class="icon-random"></i>
												500 错误！
											</span>
            </h1>

            <hr/>
            <h3 class="lighter smaller">
                <i class="icon-wrench icon-animated-wrench bigger-125"></i>
                {{ msg['msg'] }} 。
            </h3>

            <div class="space"></div>

            <div>
                <h4 class="lighter smaller">请重试或者：</h4>

                <ul class="list-unstyled spaced inline bigger-110 margin-15">
                    <li>
                        <i class="icon-hand-right blue"></i>
                        联系 <a href="mailto:guweigang@bullsoft.org">顾伟刚</a>
                    </li>

                    <li>
                        <i class="icon-hand-right blue"></i>
                        联系 冯源
                    </li>
                </ul>
            </div>

            <hr/>
            <div class="space"></div>

            <div class="center">
                <a href="javascript:history.back(-1)" class="btn btn-grey">
                    <i class="icon-arrow-left"></i>
                    Go Back
                </a>

                <a href="{{ url('admin/user/dashboard') }}" class="btn btn-primary">
                    <i class="icon-dashboard"></i>
                    Dashboard
                </a>
            </div>
        </div>
    </div>
{% endblock %}