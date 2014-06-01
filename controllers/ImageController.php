<?php
/**
 * Created by PhpStorm.
 * User: guweigang
 * Date: 14-6-1
 * Time: 10:56
 */

namespace Instcar\Admin\Controllers;


class ImageController extends \Phalcon\Mvc\Controller
{
    public function showAction()
    {
        $this->view->setVar('src', $_GET['src']);
    }
} 