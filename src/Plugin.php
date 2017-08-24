<?php

namespace markhuot\CraftReact;

use Craft;

use craft\base\Plugin as BasePlugin;
use craft\console\Application as ConsoleApplication;
use craft\web\UrlManager;
use craft\events\RegisterUrlRulesEvent;

use yii\base\Event;

use markhuot\CraftQL\Models\Token;

class Plugin extends BasePlugin
{
    public $schemaVersion = '1.0.0';
    public $controllerNamespace = 'markhuot\\CraftReact\\Controllers';
    public $hasCpSettings = false;
    public $hasCpSection = false;

    /**
     * Init for the entire plugin
     *
     * @return void
     */
    function init() {
        Craft::$app->set('view', new \markhuot\CraftReact\View);
    }
}
