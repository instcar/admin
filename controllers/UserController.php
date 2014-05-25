<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

/**
 * Class UserController
 * @package Instcar\Admin\Controllers
 */

class UserController extends ControllerBase
{
    /**
     * @breadcrumb(first="用户", second="个人资料")
     */
    public function profileAction()
    {
        
    }

    /**
     * @breadcrumb(first="用户", second="控制台")
     */
    public function dashboardAction()
    {
        
    }

    /**
     * @breadcrumb(first="用户", second="笔记")
     */
    public function noteAction()
    {


    }

    /**
     * @breadcrumb(first="用户", second="列表")
     */
    public function listAction()
    {
        $params = array();

        $params['limit'] = max(10, $this->request->getQuery("limit", "int"));
        $params['page']  = max(1, $this->request->getQuery("page", "int"));
        $params['query'] = $this->request->getQuery("query", "string");

        $service = new InstcarService('/server/user/list', $params);
        $ret = $service->call();

        if($ret['status'] != 200) {
            echo json_encode($ret);
            exit;
        }
        $this->view->setVar('data', $ret['data']);
        $this->view->setVar('params', $params);
    }
}