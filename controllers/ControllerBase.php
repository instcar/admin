<?php 
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

class ControllerBase extends \Phalcon\Mvc\Controller
{
    protected $config = null;
    protected $user = null;
    
    protected function initialize()
    {
        $service = new InstcarService('/server/user/detail');
        $ret = $service->call();
        
        if($ret['status'] != 200) {
            $this->response->redirect('admin/login/index');
            return ;
        } else {
            $this->user = $ret['data'];
            $this->view->setVar('user', $this->user);
        }
        $this->config = $this->getDI()->get('config');
    }

    protected function forward($uri)
    {
    	$uriParts = explode('/', $uri);
    	return $this->dispatcher->forward(
    		array(
                'module'     => $uriParts[0],
    			'controller' => $uriParts[1], 
    			'action' => $uriParts[2]
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
