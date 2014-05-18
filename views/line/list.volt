{# user/list.vot #}

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
                查询条件：{% if params["query"] == "" %} 空
                {% else %}
                phone or name like '{{ params["query"] }}%'
                {% endif %}
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
                        <th class="hidden-480">性别</th>
                        <th>
                            <i class="icon-time bigger-110 hidden-480"></i>
                            注册时间
                        </th>
                        <th class="hidden-480">状态</th>

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
                                <a href="#">{{ user["name"] }}</a>
                            </td>
                            <td>{{ user["phone"] }}</td>
                            <td class="hidden-480">
                                {% if user["sex"] == 0 %}
                                女
                                {% elseif user["sex"] == 1 %}
                                男
                                {% elseif user["sex"] == 2 %}
                                保密
                                {% else  %}
                                未知
                                {% endif %}
                            </td>
                            <td>{{ user["addtime"] }}</td>

                            <td class="hidden-480">
                                {% if user["status"] == 0 %}
                                <span class="label label-sm label-grey">普通</span>
                                {% elseif user["status"] == 1 %}
                                <span class="label label-sm label-success">实名</span>
                                {% else %}
                                <span class="label label-sm label-danger">拒绝</span>
                                {% endif %}
                            </td>

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
            }
        })
    </script>

{% endblock %}
