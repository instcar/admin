<?php
namespace Instcar\Admin\Controllers;
use Instcar\Admin\Plugins\InstcarService as InstcarService;

/**
 * Class LineDetailController
 * @package Instcar\Admin\Controllers
 */

class LinedetailController extends ControllerBase
{


	public function beforeExecuteRoute($dispatcher)
	{
		$option = array("edit","add","del");
		$oper = $this->request->getPost("oper", "string");
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
	 * @breadcrumb(first="线路", second="详情")
	 */
	public function listAction()
	{

		$lineid = $this->request->getQuery ( 'id','int' );

		$this->view->setVar('lineid', $lineid );
	}
	
	public function dolistAction()
	{
		$params = array();
		 
		$params['rows'] = max(10, $this->request->getQuery("rows", "int"));
		$params['rows'] = $params['rows']?$params['rows']:10;
		 
		$params['page']  = max(1, $this->request->getQuery("page", "int"));
		
		$params['lineid'] = $this->request->getQuery("lineid", "string");
		$params['all'] = 1;
		
		$service = new InstcarService('/server/line/listLineById', $params);
		$ret = $service->call();
		
		if( $ret['status'] != 200 ) {
			echo json_encode($ret);
			exit;
		}
		$tmp =$ret;
		unset($ret);
		
		$ret['status'] = $tmp['status'];
		$ret['msg'] = $tmp['msg'];
		$ret['data']['list'] = $tmp['data']['list'];
		$ret['data']['currpage'] = $params['page'];
		$ret['data']['totalpages'] = 1;
	
		echo json_encode($ret);
		exit;
	}
	
	public function doAddAction()
	{
		$params = $_POST;
	
		$service = new InstcarService('/server/line/addLinePoint', $params);
	
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
		$params['lineid'] = $params['line_id'];
		$params['pointid'] = $params['point_id'];
		$params['pre_pointid'] = $params['pre_point_id'];
		$params['post_pointid'] = $params['post_point_id'];
		
		$service = new InstcarService('/server/line/editLinePoint', $params);
		 
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
	
		$service = new InstcarService('/server/line/delLinePoint', $params);
		 
		$ret = $service->call();
	
		if( $ret['status'] != 200 ) {
			echo json_encode($ret);
			exit;
		}
		echo json_encode($ret);
		exit;
	}
	
	//定义增删改空方法
	public function doSomethingAction()
	{
		 
	}
	
	public function pointAction()
	{
	}
}
