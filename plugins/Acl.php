<?php
namespace Instcar\Admin\Plugins;

use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Mvc\Dispatcher;

class Acl extends Plugin
{
    protected $di;
    protected $eventManager;

    public function __construct($di, $evtManager)
    {
        $this->di = $di;
        $this->eventManager = $evtManager;
    }

    public function beforeDispatch(\Phalcon\Events\Event $event, \Phalcon\Mvc\Dispatcher $dispatcher)
    {
        return true;
    }
}

/* Acl.php ends here */
