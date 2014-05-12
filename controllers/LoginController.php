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
            $params['phone'] = $_POST['username'];
            $params['password'] = $_POST['password'];

            $service = new InstcarService('/server/user/login', $params);
            $ret = $service->call();
            if($ret['status'] == 200) {
                $this->response->redirect('admin/user/dashboard');
                return;
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
}