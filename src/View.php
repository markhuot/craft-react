<?php

namespace markhuot\CraftReact;

use Craft;
use craft\web\View as BaseView;
use V8Js;

class View extends BaseView {

    /**
     * Renders a Twig template.
     *
     * @param string $template  The name of the template to load
     * @param array  $variables The variables that should be available to the template
     *
     * @return string the rendering result
     * @throws \Twig_Error_Loader if the template doesn’t exist
     * @throws Exception in case of failure
     * @throws \RuntimeException in case of failure
     */
    public function renderTemplate(string $template, array $variables = []): string
    {
        if (Craft::$app->request->getIsCpRequest()) {
            return parent::renderTemplate($template, $variables);
        }

        $v8 = new V8Js();
        $v8->setModuleLoader(function($module) {
            return file_get_contents($module);
        });
        $v8->executeString('print("Hello from Javascript!");');
        return "";
    }

}