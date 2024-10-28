<?php

$wgPluggableAuth_EnableAutoLogin=true;

// TODO: Remove on release
$wgPluggableAuth_EnableLocalLogin=true;

$wgOAuthCustomAuthProviders = [
    'ft' => FTAuthProvider::class // OAuth provider "google" uses class "GoogleAuth".
];
//
// $wgPluggableAuth_Config['ft'] = [
//     'plugin' => 'WSOAuth',
//     'data' => [
//         'type' => 'ft',
//         'uri' => 'https://api.intra.42/oauth/authorize',
//         'clientId' => 'fd8a345cc292936ad61c44a4ce5a388cadaeb0944a2cfcefd4fd0d7f50b90bae',
//         'clientSecret' => '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'
//     ],
//     // TODO: change
//     'buttonLabelMessage' => '42'
// ];

$wgPluggableAuth_Config['mywikiauth'] = [
    'plugin' => 'WSOAuth',
    'data' => [
        'type' => 'mediawiki',
        'uri' => 'https://wikipedia.org/w/index.php?title=Special:OAuth',
        'clientId' => 'fd8a345cc292936ad61c44a4ce5a388cadaeb0944a2cfcefd4fd0d7f50b90bae',
        'clientSecret' => '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'
    ]
];
