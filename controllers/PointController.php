<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

/**
 * Class PointController
 * @package Instcar\Admin\Controllers
 */

class PointController extends ControllerBase
{

	public function beforeExecuteRoute($dispatcher)
	{
		$option = array("edit","add","del");
		$oper = $this->request->getPost("oper", "string");
		//echo $oper;die;
		//拦截jqgrid的增删改操作
		if( in_array( $oper , $option ) ){
			unset($_POST['oper']);
			$this->dispatcher->forward(array(
					'controller' => $dispatcher->getControllerName(),
					'action' => "do".$oper
			));
			return false;
		}
	}
	
    /**
     * @breadcrumb(first="聚点", second="列表")
     */
    public function listAction()
    {
        
    }
    
    public function dolistAction()
    {
    	$params = array();
    	
    	$params['rows'] = max(10, $this->request->getQuery("rows", "int"));
    	$params['rows'] = $params['rows']?$params['rows']:10;
    	
    	$params['page']  = max(1, $this->request->getQuery("page", "int"));
    	$params['wd'] = $this->request->getQuery("wd", "string");
    	
    	$service = new InstcarService('/server/point/list', $params);
    	$ret = $service->call();
    	
    	$totalpages = ceil($ret['data']['total']/$params['rows']);
    	
    	$ret['data']['currpage'] = $params['page'];
    	$ret['data']['totalpages'] = $totalpages;
    	 
    	echo json_encode($ret);
    	exit;
    }

    public function doAddAction()
    {
    	$params = $_POST;
    
    	$service = new InstcarService('/server/point/add', $params);
    	 
    	$ret = $service->call();
    	 
    	if( $ret['status'] != 200 ) {
    		echo json_encode($ret);
    		exit;
    	}
    	echo json_encode($ret);
    	exit;
    }
    
    public function doEditAction()
    {
    	$params = $_POST;
    	$params['pointid'] = $params['id']; 

    	$service = new InstcarService('/server/point/edit', $params);
    	
    	$ret = $service->call();
    	
    	if( $ret['status'] != 200 ) {
    		echo json_encode($ret);
    		exit;
    	}
    	echo json_encode($ret);
    	exit;
    }
    
    public function doDelAction()
    {
    	$params = $_POST;
    	$params['pointid'] = $params['id'];
    
    	$service = new InstcarService('/server/point/del', $params);
    	    	 
    	$ret = $service->call();
    	 
    	if( $ret['status'] != 200 ) {
    		echo json_encode($ret);
    		exit;
    	}
    	echo json_encode($ret);
    	exit;
    }   
	
    //定义增删改空方法
    public function doSomethingAction(){
    	
    }
    
    
    public function searchAction(){
    	$params = array();
    	 
    	$params['wd'] = $this->request->getQuery("wd", "string");
    	
    	$service = new InstcarService('/server/point/list', $params);
    	$ret = $service->call();
    	
    	array_push($ret['data']['list'],array('name'=>"起点",'id'=>0));
    	array_push($ret['data']['list'],array('name'=>"结点",'id'=>0));
    	
    	echo json_encode($ret);
    	exit;
    }
}