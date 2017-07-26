<?php

namespace App\Service;

use Slim\Views\PhpRenderer;

class RenderingServiceProvider extends ServiceProvider
{
    public function register($container)
    {
        $settings = $container->get('settings')['rendering'];
        $container['renderer'] = new PhpRenderer($settings['template_path']);
    }
}