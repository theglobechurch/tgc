<?php

  use craft\helpers\App;

  return [
    'imagerUrl' => 'https://assets.globe.church/imgr/',
    'storages' => ['dospaces'],
    // Documentation:
    // https://github.com/aelvan/craft-imager-do-spaces-driver/blob/7462210548c3cd9564a858c5a321f39317c0cb38/README.md
    'storageConfig' => [
      'dospaces' => [
        'endpoint' => App::env('SPACES_ENDPOINT'),
        'accessKey' => App::env('SPACES_API_KEY'),
        'secretAccessKey' => App::env('SPACES_SECRET'),
        'region' => App::env('SPACES_REGION'),
        'bucket' => App::env('SPACES_BUCKET'),
        'folder' => App::env('IMAGER_SPACES_FOLDER'),
        'requestHeaders' => [],
      ],
    ],
  ];
