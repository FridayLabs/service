<?php

namespace App;

use Slim\App;
use App\Service\ServiceProvider;

class Application extends App
{
    protected $loadedProviders = [];

    public function registerService($provider)
    {
        if (!$provider instanceof ServiceProvider) {
            $provider = new $provider($this);
        }
        if (array_key_exists($providerName = get_class($provider), $this->loadedProviders)) {
            return;
        }
        $this->loadedProviders[$providerName] = true;
        if (method_exists($provider, 'register')) {
            $provider->register($this->getContainer());
        }
        if (method_exists($provider, 'boot')) {
            $provider->boot($this->getContainer());
        }
    }
}