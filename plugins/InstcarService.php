<?php
namespace Instcar\Admin\Plugins;

class InstcarService
{
    private $request;
    private $response;
    private $client;
    
    public function __construct($api, $params = array())
    {
        $this->request = new \Buzz\Message\Request(\Buzz\Message\RequestInterface::METHOD_POST, '/'. ltrim($api, '/'), getDI()->get('config')->application->baseUrl
        );
        $this->request->setContent(http_build_query($params));
        
        $this->response = new \Buzz\Message\Response();
        
        $cookieJar = new \Buzz\Util\CookieJar();
        
        foreach ($_COOKIE as $_key => $_val) {
            $cookie = new \Buzz\Util\Cookie();
            $cookie->setName($_key);
            $cookie->setValue($_val);
            $cookie->setAttribute(\Buzz\Util\Cookie::ATTR_DOMAIN, parse_url(getDI()->get('config')->application->baseUrl, PHP_URL_HOST));
            $cookieJar->addCookie($cookie);
        }
        $this->client = new \Buzz\Client\FileGetContents($cookieJar);
    }

    public function call()
    {
        $this->client->send($this->request, $this->response);
        
        foreach ($this->client->getCookieJar()->getCookies() as $cookie) {
            if(!setcookie($cookie->getName(), $cookie->getValue(), time()+PHP_INT_MAX, $cookie->getAttribute(\Buzz\Util\Cookie::ATTR_PATH))) {
                getDI()->get('logger')->error("Error to set cookies", $cookie->getName(), $cookie->getValue());
            }
        }
        
        if($this->response->isOK()){
            return json_decode(trim($this->response->getContent()), true);
        } else {
            return false;
        }
    }
}