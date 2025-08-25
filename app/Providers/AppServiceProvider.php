<?php

namespace App\Providers;

use App\Models\Setting;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        // Bagikan data setting ke semua view
        if (Schema::hasTable('settings')) {
            $settings = Setting::pluck('value', 'key')->all();
            View::share('siteSettings', $settings);
        }
    }


    public function register(): void
    {
        //
    }
}