{# user/note.volt #}
{% extends "main.volt" %}

{% block style %}
    {{ super() }}
    <link rel="stylesheet" href="/assets/css/jquery-ui-1.10.3.full.min.css"/>
    <link rel="stylesheet" href="/assets/css/datepicker.css"/>
    <link rel="stylesheet" href="/assets/css/ui.jqgrid.css"/>
{% endblock %}

{% block page_content %}

    <div class="row">
        <div class="col-xs-12">

            <div class="table-header">
                查询条件：
            </div>

            <div class="table-responsive">
                <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="center">
                            <label>
                                <input type="checkbox" class="ace"/>
                                <span class="lbl"></span>
                            </label>
                        </th>
                        <th>姓名</th>
                        <th>手机</th>
                        <th class="hidden-480">身份证号</th>
                        <th class="hidden-480">家庭地址</th>
                        <th>
                            <i class="icon-time bigger-110 hidden-480"></i>
                            上次更新时间
                        </th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    {% for user in data['list'] %}
                        <tr>
                            <td class="center">
                                <label>
                                    <input type="checkbox" class="ace"/>
                                    <span class="lbl"></span>
                                </label>
                            </td>

                            <td>
                                <a href="{{ url("admin/user/detail/") }}{{ user['user_id'] }}">{{ user["name"] }}</a>
                            </td>
                            <td>{{ user["phone"] }}</td>
                            <td class="hidden-480">
                                {% if user["id_number"] is not "" %}
                                    {{ user["id_number"] }}
                                {% else %}
                                    <button class="btn-info" data-toggle="modal" data-target="#idNumberModal">
                                        查看身份证图片
                                    </button>
                                {% endif %}
                                {% set info = json_decode(user["info"], true) %}
                                {% set id_cards = info["id_cards"] %}
                                <!-- Modal -->
                                <div class="modal fade" id="idNumberModal" tabindex="-1" role="dialog" aria-labelledby="idNumberModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title" id="idNumberModalLabel">查看用户身份证详情</h4>
                                            </div>
                                            <form method="post" action="{{ url('admin/user/realnameprocess') }}">
                                            <div class="modal-body">
                                                {% for id_card in id_cards %}
                                                    <a href="{{ id_card }}" target="_blank"><img src="{{ id_card }}" width="150px;"/></a>
                                                {% endfor %}
                                                <hr />
                                                <input type="hidden" name="user_id" value="{{ user['user_id'] }}"/>
                                                请输入身份证数字：
                                                <input type="text" name="id_number" class="input-xlarge" required="required"/>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                <button type="submit" class="btn btn-primary">保存</button>
                                            </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>


                            </td>
                            <td class="hidden-480">
                                {{ user["home_addr"] }}
                            </td>
                            <td>{{ user["modtime"] }}</td>


                            <td>
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                    <a class="blue" href="#">
                                        <i class="icon-zoom-in bigger-130"></i>
                                    </a>

                                    <a class="green" href="#">
                                        <i class="icon-pencil bigger-130"></i>
                                    </a>

                                    <a class="red" href="#">
                                        <i class="icon-trash bigger-130"></i>
                                    </a>
                                </div>

                                <div class="visible-xs visible-sm hidden-md hidden-lg">
                                    <div class="inline position-relative">
                                        <button class="btn btn-minier btn-yellow dropdown-toggle"
                                                data-toggle="dropdown">
                                            <i class="icon-caret-down icon-only bigger-120"></i>
                                        </button>

                                        <ul class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
                                            <li>
                                                <a href="#" class="tooltip-info" data-rel="tooltip" title="View">
			  <span class="blue">
			    <i class="icon-zoom-in bigger-120"></i>
			  </span>
                                                </a>
                                            </li>

                                            <li>
                                                <a href="#" class="tooltip-success" data-rel="tooltip" title="Edit">
			  <span class="green">
			    <i class="icon-edit bigger-120"></i>
			  </span>
                                                </a>
                                            </li>

                                            <li>
                                                <a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
			  <span class="red">
			    <i class="icon-trash bigger-120"></i>
			  </span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    {% endfor %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>

{% endblock %}
{% block js_bottom %}
    {{ super() }}

    <script src="/assets/js/jquery.dataTables.min.js"></script>
    <script src="/assets/js/jquery.dataTables.bootstrap.js"></script>
    <script src="/assets/js/bootbox.min.js"></script>
    <!-- inline scripts related to this page -->
    <script type="text/javascript">
        jQuery(function ($) {
            var oTable1 = $('#sample-table-2').dataTable({
                "aoColumns": [
                    { "bSortable": false },
                    null,
                    null,
                    null,
                    null,
                    null,
                    { "bSortable": false }
                ] });


            $('table th input:checkbox').on('click', function () {
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
                        .each(function () {
                            this.checked = that.checked;
                            $(this).closest('tr').toggleClass('selected');
                        });

            });

            $('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});

            function tooltip_placement(context, source) {
                var $source = $(source);
                var $parent = $source.closest('table')
                var off1 = $parent.offset();
                var w1 = $parent.width();

                var off2 = $source.offset();
                var w2 = $source.width();

                if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2)) return 'right';
                return 'left';
            };

            $("#bootbox-id-number").on(ace.click_event, function () {
                bootbox.prompt("身份证信息查看", function (result) {
                    console.log(this);
                    if (result === null) {
                        alert("不能留空");
                        return false;
                    } else {
                        console.log(result);
                    }
                });
            });
        })
    </script>

{% endblock %}