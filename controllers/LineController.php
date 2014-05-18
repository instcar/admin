<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

/**
 * Class UserController
 * @package Instcar\Admin\Controllers
 */

class LineController extends ControllerBase
{

    /**
     * @breadcrumb(first="线路", second="列表")
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