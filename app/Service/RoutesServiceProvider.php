<?php

namespace App\Service;

class RoutesServiceProvider extends ServiceProvider
{
    public function boot($container)
    {
        $this->loadWebRoutes();
    }

    protected function loadWebroutes()
    {
        $app = $this->app;
        $loader = function ($path) use ($app) {
            if (file_exists($path)) {
                require_once $path;
            }
        };
        $loader(working_dir('routes/web.php'));
    }
}