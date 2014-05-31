<?php
namespace Instcar\Admin\Controllers;

class ErrorController extends ControllerBase
{
    public function show404Action()
    {
      $this->flashJson(404, array(), "404, Not Found!");
    }

    public function show500Action($jsonMsg)
    {
        $msg = json_decode($jsonMsg, true);
        $this->view->setVar("msg", $msg);
    }
}

