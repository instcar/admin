{# user/note.volt #}
{% extends "main.volt" %}

{% block style %}
    {{ super() }}
    <style type="text/css">
        .directionTitle{
            text-align: center;
            font-weight: bold;
            font-size: 20px;
            padding-bottom:3px;
            border-bottom: 1px dashed #ccc;
        }
        .sectionItem {
            height: 20px;
            padding: 4px;
        }

        .sectionItem span {
            *zoom: 1;
            display: inline-block;
        }

        .itemTitle {
            _float: left;
        }

        .selectIcon, .deleteIcon, .moveUp, .moveDown {
            float: right;
            color: red;
            font-size: 0px;
            line-height: 20px;
            height: 20px;
            text-align: center;
            cursor: pointer;
        }

        .selectIcon, .moveUp, .moveDown {
            width: 14px;
            font-size: 10px;
        }

        .selectIcon:hover, .moveUp:hover, .moveDown:hover {
            text-decoration: underline;
        }

        .deleteIcon {
            width: 20px;
            margin-left: 3px;
            background: url(/ueditor/themes/default/images/icons-all.gif) 0 -89px;
        }

        .fixTop {
            position: fixed;
            top: -1px;
        }
    </style>
{% endblock %}

{% block js_top %}
{{ super() }}
    <script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
{% endblock %}

{% block page_content %}

    <div class="clearfix row">
        <div class="col-sm-9">
            <script id="editor" type="text/plain" style="height:400px;"></script>
            <div class="clearfix" style="margin-bottom: 5px;">

                <div class="pull-right">
                    <button class="btn">
                        <i class="icon-pencil align-top bigger-125"></i>
                        保 存
                    </button>
                </div>

            </div>
        </div>

        <div class="col-sm-3">


            <div id="directionWrapper" class="widget-box">
                <div class="directionTitle widget-header widget-header-flat">目&nbsp;录</div>
                <div class="widget-body"
                <div id="directionContainer" class="widget-main">

                </div>
            </div>
        </div>


    </div>

{% endblock %}

{% block js_bottom %}
    {{ super() }}
    <script type="text/javascript">
        //实例化编辑器
        var ue = UE.getEditor('editor');

        ue.ready(function(){
            ue.addListener('updateSections', resetHandler);
        });

        var resetHandler = function(){
            var dirmap = {}, dir = ue.execCommand('getsections');

            // 更新目录树
            $('#directionContainer').html(traversal(dir) || null);
            // 删除章节按钮
            $('.deleteIcon').click(function(e){
                var $target = $(this),
                        address = $target.parent().attr('data-address');
                ue.execCommand('deletesection', dirmap[address]);
            });
            // 选中章节按钮
            $('.selectIcon').click(function(e){
                var $target = $(this),
                        address = $target.parent().attr('data-address');
                ue.execCommand('selectsection', dirmap[address], true);
            });
            // 章节上移
            $('.moveUp,.moveDown').click(function(e){
                var $target = $(this),
                        address = $target.parent().attr('data-address'),
                        moveUp = $target.hasClass('moveUp') ? true:false;
                if($target.hasClass('moveUp')) {
                    ue.execCommand('movesection', dirmap[address], dirmap[address].previousSection);
                } else {
                    ue.execCommand('movesection', dirmap[address], dirmap[address].nextSection, true);
                }
            });
            // 页面网上滚动时，让目录固定在顶部
            $(window).scroll(function(e) {
                if($('.left').offset().top < (document.body.scrollTop||document.documentElement.scrollTop)) {
                    $('#directionWrapper').addClass('fixTop');
                } else {
                    $('#directionWrapper').removeClass('fixTop');
                }
            });

            function traversal(section) {
                var $list, $item, $itemContent, child, childList;
                if(section.children.length) {
                    $list = $('<ul>');
                    for(var i = 0; i< section.children.length; i++) {
                        child = section.children[i];
                        //设置目录节点内容标签
                        var title = getSubStr(child['title'], 18);
                        $itemContent = $('<div class="sectionItem"></div>').html($('<span class="itemTitle">' + title + '</span>'));
                        $itemContent.attr('data-address', child['startAddress'].join(','));
                        $itemContent.append($('<span class="deleteIcon">删</span>' +
                                '<span class="selectIcon">选</span>' +
                                '<span class="moveUp">↑</span>' +
                                '<span class="moveDown">↓</span>'));
                        dirmap[child['startAddress'].join(',')] = child;
                        //设置目录节点容器标签
                        $item = $('<li>');
                        $item.append($itemContent);
                        //继续遍历子节点
                        if($item.children.length) {
                            childList = traversal(child);
                            childList && $item.append(childList);
                        }
                        $list.append($item);
                    }
                }
                return $list;
            }
        }

        function getSubStr(s,l){
            var i=0,len=0;
            for(i;i<s.length;i++){
                if(s.charAt(i).match(/[^\x00-\xff]/g)!=null){
                    len+=2;
                }else{
                    len++;
                }
                if(len>l){ break; }
            }return s.substr(0,i);
        };

    </script>
{% endblock %}