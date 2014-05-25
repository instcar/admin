<?php 
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

class ControllerBase extends \Phalcon\Mvc\Controller
{
    protected $config = null;
    protected $user = null;
    protected $breadcrumb = array();

    protected function initialize()
    {
        $service = new InstcarService('/server/user/detail/-1');
        $ret = $service->call();
        if($ret['status'] == 403) {
            echo json_encode($ret);
            exit;
        }
        if($ret['status'] != 200) {
            $this->response->redirect('admin/login/index');
            $this->response->sendHeaders();
            return ;
        } else {
            $this->user = $ret['data'];
            $this->view->setVar('user', $this->user);
        }
        $this->config = $this->getDI()->get('config');
        $this->breadcrumb = array(
            'module'     => $this->dispatcher->getModuleName(),
            'controller' => $this->dispatcher->getControllerName(),
            'action'     => $this->dispatcher->getActionName(),
        );
        $this->view->setVar('breadcrumb', $this->breadcrumb);

        $annotations = $this->annotations->getMethod(
            $this->dispatcher->getActiveController(),
            $this->dispatcher->getActiveMethod()
        );
        if($annotations->has('breadcrumb')) {
            $annotation = $annotations->get('breadcrumb');
            $this->view->setVar('breadcrumb_annotation', $annotation);
        } else {
            $this->view->setVar('breadcrumb_annotation', null);
        }
    }

    protected function forward($uri)
    {
    	$uriParts = explode('/', $uri);
    	return $this->dispatcher->forward(
    		array(
                'module'     => $uriParts[0],
    			'controller' => $uriParts[1], 
    			'action'     => $uriParts[2]
    		));
    }

    protected function flashJson($status, $data = array(), $msg="")
{
        $this->response->setContentType('application/json');
        $this->response->sendHeaders();
        if(empty($data)) {
            echo json_encode(array(
                'status' => intval($status),
                'data'   => $data,
                'msg'    => $msg,
            ), JSON_FORCE_OBJECT );
        } else {
            echo json_encode(array(
                'status' => intval($status),
                'data'   => $data,
                'msg'    => $msg,
            ));
        }
        exit ;
    }
}
