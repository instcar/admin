<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

class UserController extends ControllerBase
{
    
    public function profileAction()
    {
        
    }

    public function dashboardAction()
    {
        
    }

    public function listAction()
    {
        $params = array();

        $params['limit'] = max(10, $this->request->getQuery("limit", "int"));
        $params['page']  = max(1, $this->request->getQuery("page", "int"));
        
        $service = new InstcarService('/server/user/list', $params);
        $ret = $service->call();

        if($ret['status'] != 200) {
            echo json_encode($ret);
            exit;
        }
        $this->view->setVar('data', $ret['data']);
    }
}