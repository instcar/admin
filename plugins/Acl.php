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
        $controller = $dispatcher->getControllerName();
        $action = $dispatcher->getActionName();
        $dbUser = null;
        $userId = $this->session->get('identity');
        if(!$userId) {
        } else {
            $dbUser = \Instcar\Server\Models\User::findFirst(intval($userId));
            if(!empty($dbUser)) {
                $this->di->set('user', $dbUser);
            }
        }
        return true;
    }
}

/* Acl.php ends here */
