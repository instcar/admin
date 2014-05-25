<?php
namespace Instcar\Admin\Controllers;

class IndexController extends ControllerBase
{
    public function indexAction()
    {
        $this->response->redirect("admin/login/index");
        return ;
    }

    public function testAction()
    {
        $params['sidx'] = 'id';
        $params['sord'] = 'ASC';
        $params['filters'] = '{"groupOp":"AND","rules":[{"field":"id","op":"eq","data":"1"},{"field":"city","op":"in","data":"北京, 天津"}]}';

        $params['searchField']  = "";
        $params['searchString'] = "";
        $params['searchOper']   = "";

        $jqGrid = new \Instcar\Admin\Plugins\jqGridOP($params);
        echo $jqGrid->toSql();
        exit;
    }
}