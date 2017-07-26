<?php

namespace App\Service;

use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Processor\UidProcessor;

class LoggingServiceProvider extends ServiceProvider
{
    public function register($container)
    {
        $settings = $container->get('settings')['logging'];

        $logger = new Logger($settings['name']);
        $logger->pushProcessor(new UidProcessor());
        $logger->pushHandler(new StreamHandler($settings['path'], $settings['level']));

        $container['logger'] = $logger;
    }
}