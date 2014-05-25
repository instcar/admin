<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

class LoginController extends ControllerBase
{
    protected function initialize()
    {

    }

    public function indexAction()
    {
        $service = new InstcarService('/server/user/islogin');
        $ret = $service->call();

        if($ret['data']['login_status']) {
            $this->response->redirect('admin/user/dashboard');
            return ;
        }
    }

    public function doLoginAction()
    {
        if($this->request->isPost()) {
            $params = array();
            $params['phone'] = $_POST['phone'];
            $params['password'] = $_POST['password'];

            $service = new InstcarService('/server/user/login', $params);
            $ret = $service->call();
            if($ret['status'] == 200) {
//                 $this->response->redirect('admin/user/dashboard');
//                 return;
                $ret['status'] = 301;
                $ret['url'] = '/admin/user/dashboard';
            }
            echo json_encode($ret);
            exit;
        }
    }

    public function doLogoutAction()
    {
        $service = new InstcarService('/server/user/logout');
        $ret= $service->call();
        if($ret['status'] == 200) {
            $this->response->redirect('admin/login/index');
            return;
        }
    }

    public function doRegisterAction()
    {
    	$params = array();
    	$params['phone'] = $_POST['phone'];
    	$params['authcode'] = $_POST['authcode'];
    	$params['password'] = $_POST['password'];
    	 
    	$service = new InstcarService('/server/user/register',$params);
    	$ret= $service->call();
    	if($ret['status'] == 200) {
    		// $this->response->redirect('admin/login/index');
    		// return;
            $ret['status'] = 301;
            $ret['url'] = '/admin/login/index';
    	} 
    	echo json_encode($ret);
    	exit;
    }

    public function doResetPasswordAction()
    {

    }
    
    public function doSendSMSAction(){
    	$params = array();
    	$params['phone'] = $_POST['phone'];
        if(!isset($_POST['for'])) {
            $this->flashJson(500, array(), "非法请求：必须指定for字段");
        }
        $for = strval($_POST['for']);
        switch(true) {
            case $for == 'visitor':
                $service = new InstcarService('/server/user/checkuserphone', $params);
                $ret = $service->call();
                if($ret['status'] != 200) {
                    echo json_encode($ret);
                    exit;
                }
                break;
            case $for == 'member':
                $service = new InstcarService('/server/user/getbyphone', $params);
                $ret = $service->call();
                if($ret['status'] == 404) {
                    echo json_encode($ret);
                    exit;
                }
                break;

        }
    	$service = new InstcarService('/server/user/getAuthCode', $params);
    	$ret= $service->call();
    	echo json_encode($ret);
    	exit;
    }
}