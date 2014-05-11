<?php
namespace Instcar\Admin\Controllers;

class IndexController extends ControllerBase
{
    public function indexAction()
    {
        $this->response->redirect("admin/login/index");
        return ;
    }
}