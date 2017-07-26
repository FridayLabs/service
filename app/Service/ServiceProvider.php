<?php

namespace App\Service;

use App\Application;

class ServiceProvider
{
    /**
     * @var Application
     */
    protected $app;

    public function __construct($app)
    {
        $this->app = $app;
    }
}