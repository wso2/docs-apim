





<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
  <link rel="dns-prefetch" href="https://github.githubassets.com">
  <link rel="dns-prefetch" href="https://avatars0.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars1.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars2.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars3.githubusercontent.com">
  <link rel="dns-prefetch" href="https://github-cloud.s3.amazonaws.com">
  <link rel="dns-prefetch" href="https://user-images.githubusercontent.com/">



  <link crossorigin="anonymous" media="all" integrity="sha512-XkdvnY4XAps/ohU58xyeZCv2463I3ZTnOhwzle5VPdwFw9Eh/ZfNvhlTgf4H9K7RPiRXW3oGu7CuNk9QiENAFQ==" rel="stylesheet" href="https://github.githubassets.com/assets/frameworks-b003e0a30d85cc60f5920a4b6ff04123.css" />
  
    <link crossorigin="anonymous" media="all" integrity="sha512-+EeonPFJPOixSBlN5rTxrzh6vdTLNhknT6HivFp5j4d25wXRkAV0J5LtGSOnUvDdYd5M4r+WcOfulwVw0yLa+Q==" rel="stylesheet" href="https://github.githubassets.com/assets/github-69306aac5d15cf59cad51421acb1bc7d.css" />
    
    
    
    

  <meta name="viewport" content="width=device-width">
  
  <title>docs-ei/config-catalog.md at 7.0.0 · wso2/docs-ei</title>
    <meta name="description" content="Contribute to wso2/docs-ei development by creating an account on GitHub.">
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
  <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
  <meta property="fb:app_id" content="1401488693436528">

    <meta name="twitter:image:src" content="https://avatars2.githubusercontent.com/u/533043?s=400&amp;v=4" /><meta name="twitter:site" content="@github" /><meta name="twitter:card" content="summary" /><meta name="twitter:title" content="wso2/docs-ei" /><meta name="twitter:description" content="Contribute to wso2/docs-ei development by creating an account on GitHub." />
    <meta property="og:image" content="https://avatars2.githubusercontent.com/u/533043?s=400&amp;v=4" /><meta property="og:site_name" content="GitHub" /><meta property="og:type" content="object" /><meta property="og:title" content="wso2/docs-ei" /><meta property="og:url" content="https://github.com/wso2/docs-ei" /><meta property="og:description" content="Contribute to wso2/docs-ei development by creating an account on GitHub." />

  <link rel="assets" href="https://github.githubassets.com/">
  <link rel="web-socket" href="wss://live.github.com/_sockets/VjI6NDI2MDQ5MjU2OjUxOWZmN2E1NjVhOWRlYmI2MDNiMzlhN2M0MjQxZWJkZmYxYTQzZDYwMzc0ZTZlODg5YmU5YWE5ZTZlYTQzMWM=--8c4bdb199a7d3ebfe387235dd43e5c910569fb0f">
  <meta name="pjax-timeout" content="1000">
  <link rel="sudo-modal" href="/sessions/sudo_modal">
  <meta name="request-id" content="77B2:33F2:63EF05:9F9D05:5D8771B8" data-pjax-transient>


  

  <meta name="selected-link" value="repo_source" data-pjax-transient>

      <meta name="google-site-verification" content="KT5gs8h0wvaagLKAVWq8bbeNwnZZK1r1XQysX3xurLU">
    <meta name="google-site-verification" content="ZzhVyEFwb7w3e0-uOTltm8Jsck2F5StVihD0exw2fsA">
    <meta name="google-site-verification" content="GXs5KoUUkNCoaAZn7wPN-t01Pywp9M3sEjnt_3_ZWPc">

  <meta name="octolytics-host" content="collector.githubapp.com" /><meta name="octolytics-app-id" content="github" /><meta name="octolytics-event-url" content="https://collector.githubapp.com/github-external/browser_event" /><meta name="octolytics-dimension-request_id" content="77B2:33F2:63EF05:9F9D05:5D8771B8" /><meta name="octolytics-dimension-region_edge" content="iad" /><meta name="octolytics-dimension-region_render" content="iad" /><meta name="octolytics-dimension-ga_id" content="" class="js-octo-ga-id" /><meta name="octolytics-dimension-visitor_id" content="3304829717783374505" /><meta name="octolytics-actor-id" content="23217207" /><meta name="octolytics-actor-login" content="ruthryi" /><meta name="octolytics-actor-hash" content="1f97b947f2b02af1536ec6c65ce20638f94eccfc41d61c1e2fa712ce035a2c46" />
<meta name="analytics-location" content="/&lt;user-name&gt;/&lt;repo-name&gt;/blob/show" data-pjax-transient="true" />



    <meta name="google-analytics" content="UA-3769691-2">

  <meta class="js-ga-set" name="userId" content="79a79ce7dfdf5a74937f73a1e2605a57">

<meta class="js-ga-set" name="dimension1" content="Logged In">



  

      <meta name="hostname" content="github.com">
    <meta name="user-login" content="ruthryi">

      <meta name="expected-hostname" content="github.com">
    <meta name="js-proxy-site-detection-payload" content="Y2NlYzJlMTJlZGQ0MTA2Njk5Nzg1YjBiYzk3YTBkNmEzZGY4MmM2ZThkMjc4YTA2ZTQ2NWY5MmExMDYyN2QzMnx7InJlbW90ZV9hZGRyZXNzIjoiMTc1LjE1Ny4yNTEuMTQzIiwicmVxdWVzdF9pZCI6Ijc3QjI6MzNGMjo2M0VGMDU6OUY5RDA1OjVEODc3MUI4IiwidGltZXN0YW1wIjoxNTY5MTU3NTk3LCJob3N0IjoiZ2l0aHViLmNvbSJ9">

    <meta name="enabled-features" content="ACTIONS_V2_ON_MARKETPLACE,MARKETPLACE_FEATURED_BLOG_POSTS,MARKETPLACE_INVOICED_BILLING,MARKETPLACE_SOCIAL_PROOF_CUSTOMERS,MARKETPLACE_TRENDING_SOCIAL_PROOF,MARKETPLACE_RECOMMENDATIONS,MARKETPLACE_PENDING_INSTALLATIONS,NOTIFY_ON_BLOCK,RELATED_ISSUES,GHE_CLOUD_TRIAL">

  <meta name="html-safe-nonce" content="727481a1d145326669b438e4ed25df0fbe219c0a">

  <meta http-equiv="x-pjax-version" content="3b02fa1e5aa38bd2ff8205d7c128dcc7">
  

      <link href="https://github.com/wso2/docs-ei/commits/7.0.0.atom" rel="alternate" title="Recent Commits to docs-ei:7.0.0" type="application/atom+xml">

  <meta name="go-import" content="github.com/wso2/docs-ei git https://github.com/wso2/docs-ei.git">

  <meta name="octolytics-dimension-user_id" content="533043" /><meta name="octolytics-dimension-user_login" content="wso2" /><meta name="octolytics-dimension-repository_id" content="171851899" /><meta name="octolytics-dimension-repository_nwo" content="wso2/docs-ei" /><meta name="octolytics-dimension-repository_public" content="true" /><meta name="octolytics-dimension-repository_is_fork" content="false" /><meta name="octolytics-dimension-repository_network_root_id" content="171851899" /><meta name="octolytics-dimension-repository_network_root_nwo" content="wso2/docs-ei" /><meta name="octolytics-dimension-repository_explore_github_marketplace_ci_cta_shown" content="false" />


    <link rel="canonical" href="https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md" data-pjax-transient>


  <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">

  <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">

  <link rel="mask-icon" href="https://github.githubassets.com/pinned-octocat.svg" color="#000000">
  <link rel="icon" type="image/x-icon" class="js-site-favicon" href="https://github.githubassets.com/favicon.ico">

<meta name="theme-color" content="#1e2327">



  <meta name="webauthn-auth-enabled" content="true">

  <meta name="webauthn-registration-enabled" content="true">

  <link rel="manifest" href="/manifest.json" crossOrigin="use-credentials">

  </head>

  <body class="logged-in env-production emoji-size-boost page-responsive page-blob">
    

  <div class="position-relative js-header-wrapper ">
    <a href="#start-of-content" tabindex="1" class="p-3 bg-blue text-white show-on-focus js-skip-to-content">Skip to content</a>
    <div id="js-pjax-loader-bar" class="pjax-loader-bar"><div class="progress"></div></div>

    
    
    


          <header class="Header js-details-container Details flex-wrap flex-lg-nowrap p-responsive" role="banner">

    <div class="Header-item d-none d-lg-flex">
      <a class="Header-link" href="https://github.com/" data-hotkey="g d" aria-label="Homepage" data-ga-click="Header, go to dashboard, icon:logo">
  <svg class="octicon octicon-mark-github v-align-middle" height="32" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>

    </div>

    <div class="Header-item d-lg-none">
      <button class="Header-link btn-link js-details-target" type="button" aria-label="Toggle navigation" aria-expanded="false">
        <svg height="24" class="octicon octicon-three-bars" viewBox="0 0 12 16" version="1.1" width="18" aria-hidden="true"><path fill-rule="evenodd" d="M11.41 9H.59C0 9 0 8.59 0 8c0-.59 0-1 .59-1H11.4c.59 0 .59.41.59 1 0 .59 0 1-.59 1h.01zm0-4H.59C0 5 0 4.59 0 4c0-.59 0-1 .59-1H11.4c.59 0 .59.41.59 1 0 .59 0 1-.59 1h.01zM.59 11H11.4c.59 0 .59.41.59 1 0 .59 0 1-.59 1H.59C0 13 0 12.59 0 12c0-.59 0-1 .59-1z"/></svg>
      </button>
    </div>

    <div class="Header-item Header-item--full flex-column flex-lg-row width-full flex-order-2 flex-lg-order-none mr-0 mr-lg-3 mt-3 mt-lg-0 Details-content--hidden">
        <div class="header-search flex-self-stretch flex-lg-self-auto mr-0 mr-lg-3 mb-3 mb-lg-0 scoped-search site-scoped-search js-site-search position-relative js-jump-to"
  role="combobox"
  aria-owns="jump-to-results"
  aria-label="Search or jump to"
  aria-haspopup="listbox"
  aria-expanded="false"
>
  <div class="position-relative">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="js-site-search-form" role="search" aria-label="Site" data-scope-type="Repository" data-scope-id="171851899" data-scoped-search-url="/wso2/docs-ei/search" data-unscoped-search-url="/search" action="/wso2/docs-ei/search" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
      <label class="form-control input-sm header-search-wrapper p-0 header-search-wrapper-jump-to position-relative d-flex flex-justify-between flex-items-center js-chromeless-input-container">
        <input type="text"
          class="form-control input-sm header-search-input jump-to-field js-jump-to-field js-site-search-focus js-site-search-field is-clearable"
          data-hotkey="s,/"
          name="q"
          value=""
          placeholder="Search or jump to…"
          data-unscoped-placeholder="Search or jump to…"
          data-scoped-placeholder="Search or jump to…"
          autocapitalize="off"
          aria-autocomplete="list"
          aria-controls="jump-to-results"
          aria-label="Search or jump to…"
          data-jump-to-suggestions-path="/_graphql/GetSuggestedNavigationDestinations#csrf-token=z/wC9lNS8RJ/aLSNpp/iIJciWZBvLZfGk81dCaz2/ujg2uk3U6QILCnd7sEpK/KyYAR9awFBuJlKnCjsUFSC6Q=="
          spellcheck="false"
          autocomplete="off"
          >
          <input type="hidden" class="js-site-search-type-field" name="type" >
            <img src="https://github.githubassets.com/images/search-key-slash.svg" alt="" class="mr-2 header-search-key-slash">

            <div class="Box position-absolute overflow-hidden d-none jump-to-suggestions js-jump-to-suggestions-container">
              
<ul class="d-none js-jump-to-suggestions-template-container">
  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-suggestion" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 12 16" version="1.1" role="img"><path fill-rule="evenodd" d="M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 15 16" version="1.1" role="img"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M15.7 13.3l-3.81-3.83A5.93 5.93 0 0 0 13 6c0-3.31-2.69-6-6-6S1 2.69 1 6s2.69 6 6 6c1.3 0 2.48-.41 3.47-1.11l3.83 3.81c.19.2.45.3.7.3.25 0 .52-.09.7-.3a.996.996 0 0 0 0-1.41v.01zM7 10.7c-2.59 0-4.7-2.11-4.7-4.7 0-2.59 2.11-4.7 4.7-4.7 2.59 0 4.7 2.11 4.7 4.7 0 2.59-2.11 4.7-4.7 4.7z"/></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>

</ul>

<ul class="d-none js-jump-to-no-results-template-container">
  <li class="d-flex flex-justify-center flex-items-center f5 d-none js-jump-to-suggestion p-2">
    <span class="text-gray">No suggested jump to results</span>
  </li>
</ul>

<ul id="jump-to-results" role="listbox" class="p-0 m-0 js-navigation-container jump-to-suggestions-results-container js-jump-to-suggestions-results-container">
  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-scoped-search d-none" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 12 16" version="1.1" role="img"><path fill-rule="evenodd" d="M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 15 16" version="1.1" role="img"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M15.7 13.3l-3.81-3.83A5.93 5.93 0 0 0 13 6c0-3.31-2.69-6-6-6S1 2.69 1 6s2.69 6 6 6c1.3 0 2.48-.41 3.47-1.11l3.83 3.81c.19.2.45.3.7.3.25 0 .52-.09.7-.3a.996.996 0 0 0 0-1.41v.01zM7 10.7c-2.59 0-4.7-2.11-4.7-4.7 0-2.59 2.11-4.7 4.7-4.7 2.59 0 4.7 2.11 4.7 4.7 0 2.59-2.11 4.7-4.7 4.7z"/></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>

  

<li class="d-flex flex-justify-start flex-items-center p-0 f5 navigation-item js-navigation-item js-jump-to-global-search d-none" role="option">
  <a tabindex="-1" class="no-underline d-flex flex-auto flex-items-center jump-to-suggestions-path js-jump-to-suggestion-path js-navigation-open p-2" href="">
    <div class="jump-to-octicon js-jump-to-octicon flex-shrink-0 mr-2 text-center d-none">
      <svg height="16" width="16" class="octicon octicon-repo flex-shrink-0 js-jump-to-octicon-repo d-none" title="Repository" aria-label="Repository" viewBox="0 0 12 16" version="1.1" role="img"><path fill-rule="evenodd" d="M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-project flex-shrink-0 js-jump-to-octicon-project d-none" title="Project" aria-label="Project" viewBox="0 0 15 16" version="1.1" role="img"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      <svg height="16" width="16" class="octicon octicon-search flex-shrink-0 js-jump-to-octicon-search d-none" title="Search" aria-label="Search" viewBox="0 0 16 16" version="1.1" role="img"><path fill-rule="evenodd" d="M15.7 13.3l-3.81-3.83A5.93 5.93 0 0 0 13 6c0-3.31-2.69-6-6-6S1 2.69 1 6s2.69 6 6 6c1.3 0 2.48-.41 3.47-1.11l3.83 3.81c.19.2.45.3.7.3.25 0 .52-.09.7-.3a.996.996 0 0 0 0-1.41v.01zM7 10.7c-2.59 0-4.7-2.11-4.7-4.7 0-2.59 2.11-4.7 4.7-4.7 2.59 0 4.7 2.11 4.7 4.7 0 2.59-2.11 4.7-4.7 4.7z"/></svg>
    </div>

    <img class="avatar mr-2 flex-shrink-0 js-jump-to-suggestion-avatar d-none" alt="" aria-label="Team" src="" width="28" height="28">

    <div class="jump-to-suggestion-name js-jump-to-suggestion-name flex-auto overflow-hidden text-left no-wrap css-truncate css-truncate-target">
    </div>

    <div class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none js-jump-to-badge-search">
      <span class="js-jump-to-badge-search-text-default d-none" aria-label="in this repository">
        In this repository
      </span>
      <span class="js-jump-to-badge-search-text-global d-none" aria-label="in all of GitHub">
        All GitHub
      </span>
      <span aria-hidden="true" class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>

    <div aria-hidden="true" class="border rounded-1 flex-shrink-0 bg-gray px-1 text-gray-light ml-1 f6 d-none d-on-nav-focus js-jump-to-badge-jump">
      Jump to
      <span class="d-inline-block ml-1 v-align-middle">↵</span>
    </div>
  </a>
</li>


    <li class="d-flex flex-justify-center flex-items-center p-0 f5 js-jump-to-suggestion">
      <img src="https://github.githubassets.com/images/spinners/octocat-spinner-128.gif" alt="Octocat Spinner Icon" class="m-2" width="28">
    </li>
</ul>

            </div>
      </label>
</form>  </div>
</div>


      <nav class="d-flex flex-column flex-lg-row flex-self-stretch flex-lg-self-auto" aria-label="Global">
    <a class="Header-link d-block d-lg-none py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15" data-ga-click="Header, click, Nav menu - item:dashboard:user" aria-label="Dashboard" href="/dashboard">
      Dashboard
</a>
  <a class="js-selected-navigation-item Header-link  mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15" data-hotkey="g p" data-ga-click="Header, click, Nav menu - item:pulls context:user" aria-label="Pull requests you created" data-selected-links="/pulls /pulls/assigned /pulls/mentioned /pulls" href="/pulls">
    Pull requests
</a>
  <a class="js-selected-navigation-item Header-link  mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15" data-hotkey="g i" data-ga-click="Header, click, Nav menu - item:issues context:user" aria-label="Issues you created" data-selected-links="/issues /issues/assigned /issues/mentioned /issues" href="/issues">
    Issues
</a>
    <div class="mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15">
      <a class="js-selected-navigation-item Header-link" data-ga-click="Header, click, Nav menu - item:marketplace context:user" data-octo-click="marketplace_click" data-octo-dimensions="location:nav_bar" data-selected-links=" /marketplace" href="/marketplace">
        Marketplace
</a>      

    </div>

  <a class="js-selected-navigation-item Header-link  mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15" data-ga-click="Header, click, Nav menu - item:explore" data-selected-links="/explore /trending /trending/developers /integrations /integrations/feature/code /integrations/feature/collaborate /integrations/feature/ship showcases showcases_search showcases_landing /explore" href="/explore">
    Explore
</a>


    <a class="Header-link d-block d-lg-none mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15" href="https://github.com/ruthryi">
      <img class="avatar" height="20" width="20" alt="@ruthryi" src="https://avatars2.githubusercontent.com/u/23217207?s=60&amp;v=4" />
      ruthryi
</a>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form action="/logout" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="pjLtru0bn5a5gYbuJBveawynX8k8uRJBZV4HSyLEMHRNEjl02a25v7V8JXhEKh0X6ocz5RhaWD6qvZjOt+n6Lg==" />
      <button type="submit" class="Header-link mr-0 mr-lg-3 py-2 py-lg-0 border-top border-lg-top-0 border-white-fade-15 d-lg-none btn-link d-block width-full text-left" data-ga-click="Header, sign out, icon:logout" style="padding-left: 2px;">
        <svg class="octicon octicon-sign-out v-align-middle" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 9V7H8V5h4V3l4 3-4 3zm-2 3H6V3L2 1h8v3h1V1c0-.55-.45-1-1-1H1C.45 0 0 .45 0 1v11.38c0 .39.22.73.55.91L6 16.01V13h4c.55 0 1-.45 1-1V8h-1v4z"/></svg>
        Sign out
      </button>
</form></nav>

    </div>

    <div class="Header-item Header-item--full flex-justify-center d-lg-none position-relative">
      <div class="css-truncate css-truncate-target width-fit position-absolute left-0 right-0 text-center">
              <svg class="octicon octicon-repo" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z"/></svg>
    <a class="Header-link" href="/wso2">wso2</a>
    /
    <a class="Header-link" href="/wso2/docs-ei">docs-ei</a>

</div>
    </div>


    <div class="Header-item mr-0 mr-lg-3 flex-order-1 flex-lg-order-none">
      

    <a aria-label="You have no unread notifications" class="Header-link notification-indicator position-relative tooltipped tooltipped-s js-socket-channel js-notification-indicator" data-hotkey="g n" data-ga-click="Header, go to notifications, icon:read" data-channel="notification-changed:23217207" href="/notifications">
        <span class="mail-status "></span>
        <svg class="octicon octicon-bell" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 12v1H0v-1l.73-.58c.77-.77.81-2.55 1.19-4.42C2.69 3.23 6 2 6 2c0-.55.45-1 1-1s1 .45 1 1c0 0 3.39 1.23 4.16 5 .38 1.88.42 3.66 1.19 4.42l.66.58H14zm-7 4c1.11 0 2-.89 2-2H5c0 1.11.89 2 2 2z"/></svg>
</a>
    </div>


    <div class="Header-item position-relative d-none d-lg-flex">
      <details class="details-overlay details-reset">
  <summary class="Header-link"
      aria-label="Create new…"
      data-ga-click="Header, create new, icon:add">
    <svg class="octicon octicon-plus" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 9H7v5H5V9H0V7h5V2h2v5h5v2z"/></svg> <span class="dropdown-caret"></span>
  </summary>
  <details-menu class="dropdown-menu dropdown-menu-sw">
    
<a role="menuitem" class="dropdown-item" href="/new" data-ga-click="Header, create new repository">
  New repository
</a>

  <a role="menuitem" class="dropdown-item" href="/new/import" data-ga-click="Header, import a repository">
    Import repository
  </a>

<a role="menuitem" class="dropdown-item" href="https://gist.github.com/" data-ga-click="Header, create new gist">
  New gist
</a>

  <a role="menuitem" class="dropdown-item" href="/organizations/new" data-ga-click="Header, create new organization">
    New organization
  </a>


  <div role="none" class="dropdown-divider"></div>
  <div class="dropdown-header">
    <span title="wso2/docs-ei">This repository</span>
  </div>
    <a role="menuitem" class="dropdown-item" href="/wso2/docs-ei/issues/new" data-ga-click="Header, create new issue" data-skip-pjax>
      New issue
    </a>


  </details-menu>
</details>

    </div>

    <div class="Header-item position-relative mr-0 d-none d-lg-flex">
      
<details class="details-overlay details-reset">
  <summary class="Header-link"
    aria-label="View profile and more"
    data-ga-click="Header, show menu, icon:avatar">
    <img alt="@ruthryi" class="avatar" src="https://avatars1.githubusercontent.com/u/23217207?s=40&amp;v=4" height="20" width="20">
    <span class="dropdown-caret"></span>
  </summary>
  <details-menu class="dropdown-menu dropdown-menu-sw mt-2" style="width: 180px">
    <div class="header-nav-current-user css-truncate"><a role="menuitem" class="no-underline user-profile-link px-3 pt-2 pb-2 mb-n2 mt-n1 d-block" href="/ruthryi" data-ga-click="Header, go to profile, text:Signed in as">Signed in as <strong class="css-truncate-target">ruthryi</strong></a></div>
    <div role="none" class="dropdown-divider"></div>

      <div class="pl-3 pr-3 f6 user-status-container js-user-status-context pb-1" data-url="/users/status?compact=1&amp;link_mentions=0&amp;truncate=1">
        
<div class="js-user-status-container
    user-status-compact rounded-1 px-2 py-1 mt-2
    border
  " data-team-hovercards-enabled>
  <details class="js-user-status-details details-reset details-overlay details-overlay-dark">
    <summary class="btn-link btn-block link-gray no-underline js-toggle-user-status-edit toggle-user-status-edit "
      role="menuitem" data-hydro-click="{&quot;event_type&quot;:&quot;user_profile.click&quot;,&quot;payload&quot;:{&quot;profile_user_id&quot;:533043,&quot;target&quot;:&quot;EDIT_USER_STATUS&quot;,&quot;user_id&quot;:23217207,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;}}" data-hydro-click-hmac="a6d3ab658fe8498762caf333cb0e8716a468ae8e1fe885ab04d5ab03ced7a5cf">
      <div class="d-flex">
        <div class="f6 lh-condensed user-status-header
          d-inline-block v-align-middle
            user-status-emoji-only-header circle
            pr-2
"
            style="max-width: 29px"
          >
          <div class="user-status-emoji-container flex-shrink-0 mr-1 mt-1 lh-condensed-ultra v-align-bottom" style="">
            <svg class="octicon octicon-smiley" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8s3.58 8 8 8 8-3.58 8-8-3.58-8-8-8zm4.81 12.81a6.72 6.72 0 0 1-2.17 1.45c-.83.36-1.72.53-2.64.53-.92 0-1.81-.17-2.64-.53-.81-.34-1.55-.83-2.17-1.45a6.773 6.773 0 0 1-1.45-2.17A6.59 6.59 0 0 1 1.21 8c0-.92.17-1.81.53-2.64.34-.81.83-1.55 1.45-2.17.62-.62 1.36-1.11 2.17-1.45A6.59 6.59 0 0 1 8 1.21c.92 0 1.81.17 2.64.53.81.34 1.55.83 2.17 1.45.62.62 1.11 1.36 1.45 2.17.36.83.53 1.72.53 2.64 0 .92-.17 1.81-.53 2.64-.34.81-.83 1.55-1.45 2.17zM4 6.8v-.59c0-.66.53-1.19 1.2-1.19h.59c.66 0 1.19.53 1.19 1.19v.59c0 .67-.53 1.2-1.19 1.2H5.2C4.53 8 4 7.47 4 6.8zm5 0v-.59c0-.66.53-1.19 1.2-1.19h.59c.66 0 1.19.53 1.19 1.19v.59c0 .67-.53 1.2-1.19 1.2h-.59C9.53 8 9 7.47 9 6.8zm4 3.2c-.72 1.88-2.91 3-5 3s-4.28-1.13-5-3c-.14-.39.23-1 .66-1h8.59c.41 0 .89.61.75 1z"/></svg>
          </div>
        </div>
        <div class="
          d-inline-block v-align-middle
          
          
           css-truncate css-truncate-target 
           user-status-message-wrapper f6"
           style="line-height: 20px;" >
          <div class="d-inline-block text-gray-dark v-align-text-top text-left">
              <span class="text-gray ml-2">Set status</span>
          </div>
        </div>
      </div>
    </summary>
    <details-dialog class="details-dialog rounded-1 anim-fade-in fast Box Box--overlay" role="dialog" tabindex="-1">
      <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="position-relative flex-auto js-user-status-form" action="/users/status?compact=1&amp;link_mentions=0&amp;truncate=1" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="_method" value="put" /><input type="hidden" name="authenticity_token" value="R/pkVDsYxeWd3u0jIQEBLb/9r2okg6euJsPTwzzyzzLHnD1pI0U6QtEgKrsFY+zB7eQnRf2hDsvgHZIzXnoutw==" />
        <div class="Box-header bg-gray border-bottom p-3">
          <button class="Box-btn-octicon js-toggle-user-status-edit btn-octicon float-right" type="reset" aria-label="Close dialog" data-close-dialog>
            <svg class="octicon octicon-x" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48L7.48 8z"/></svg>
          </button>
          <h3 class="Box-title f5 text-bold text-gray-dark">Edit status</h3>
        </div>
        <input type="hidden" name="emoji" class="js-user-status-emoji-field" value="">
        <input type="hidden" name="organization_id" class="js-user-status-org-id-field" value="">
        <div class="px-3 py-2 text-gray-dark">
          <div class="js-characters-remaining-container position-relative mt-2">
            <div class="input-group d-table form-group my-0 js-user-status-form-group">
              <span class="input-group-button d-table-cell v-align-middle" style="width: 1%">
                <button type="button" aria-label="Choose an emoji" class="btn-outline btn js-toggle-user-status-emoji-picker btn-open-emoji-picker p-0">
                  <span class="js-user-status-original-emoji" hidden></span>
                  <span class="js-user-status-custom-emoji"></span>
                  <span class="js-user-status-no-emoji-icon" >
                    <svg class="octicon octicon-smiley" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8s3.58 8 8 8 8-3.58 8-8-3.58-8-8-8zm4.81 12.81a6.72 6.72 0 0 1-2.17 1.45c-.83.36-1.72.53-2.64.53-.92 0-1.81-.17-2.64-.53-.81-.34-1.55-.83-2.17-1.45a6.773 6.773 0 0 1-1.45-2.17A6.59 6.59 0 0 1 1.21 8c0-.92.17-1.81.53-2.64.34-.81.83-1.55 1.45-2.17.62-.62 1.36-1.11 2.17-1.45A6.59 6.59 0 0 1 8 1.21c.92 0 1.81.17 2.64.53.81.34 1.55.83 2.17 1.45.62.62 1.11 1.36 1.45 2.17.36.83.53 1.72.53 2.64 0 .92-.17 1.81-.53 2.64-.34.81-.83 1.55-1.45 2.17zM4 6.8v-.59c0-.66.53-1.19 1.2-1.19h.59c.66 0 1.19.53 1.19 1.19v.59c0 .67-.53 1.2-1.19 1.2H5.2C4.53 8 4 7.47 4 6.8zm5 0v-.59c0-.66.53-1.19 1.2-1.19h.59c.66 0 1.19.53 1.19 1.19v.59c0 .67-.53 1.2-1.19 1.2h-.59C9.53 8 9 7.47 9 6.8zm4 3.2c-.72 1.88-2.91 3-5 3s-4.28-1.13-5-3c-.14-.39.23-1 .66-1h8.59c.41 0 .89.61.75 1z"/></svg>
                  </span>
                </button>
              </span>
              <text-expander keys=": @" data-mention-url="/autocomplete/user-suggestions" data-emoji-url="/autocomplete/emoji">
                <input
                  type="text"
                  autocomplete="off"
                  data-no-org-url="/autocomplete/user-suggestions"
                  data-org-url="/suggestions?mention_suggester=1"
                  data-maxlength="80"
                  class="d-table-cell width-full form-control js-user-status-message-field js-characters-remaining-field"
                  placeholder="What's happening?"
                  name="message"
                  value=""
                  aria-label="What is your current status?">
              </text-expander>
              <div class="error">Could not update your status, please try again.</div>
            </div>
            <div style="margin-left: 53px" class="my-1 text-small label-characters-remaining js-characters-remaining" data-suffix="remaining" hidden>
              80 remaining
            </div>
          </div>
          <include-fragment class="js-user-status-emoji-picker" data-url="/users/status/emoji"></include-fragment>
          <div class="overflow-auto ml-n3 mr-n3 px-3 border-bottom" style="max-height: 33vh">
            <div class="user-status-suggestions js-user-status-suggestions collapsed overflow-hidden">
              <h4 class="f6 text-normal my-3">Suggestions:</h4>
              <div class="mx-3 mt-2 clearfix">
                  <div class="float-left col-6">
                      <button type="button" value=":palm_tree:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="palm_tree" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f334.png">🌴</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          On vacation
                        </div>
                      </button>
                      <button type="button" value=":face_with_thermometer:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="face_with_thermometer" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f912.png">🤒</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Out sick
                        </div>
                      </button>
                  </div>
                  <div class="float-left col-6">
                      <button type="button" value=":house:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="house" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f3e0.png">🏠</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Working from home
                        </div>
                      </button>
                      <button type="button" value=":dart:" class="d-flex flex-items-baseline flex-items-stretch lh-condensed f6 btn-link link-gray no-underline js-predefined-user-status mb-1">
                        <div class="emoji-status-width mr-2 v-align-middle js-predefined-user-status-emoji">
                          <g-emoji alias="dart" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f3af.png">🎯</g-emoji>
                        </div>
                        <div class="d-flex flex-items-center no-underline js-predefined-user-status-message ws-normal text-left" style="border-left: 1px solid transparent">
                          Focusing
                        </div>
                      </button>
                  </div>
              </div>
            </div>
            <div class="user-status-limited-availability-container">
              <div class="form-checkbox my-0">
                <input type="checkbox" name="limited_availability" value="1" class="js-user-status-limited-availability-checkbox" data-default-message="I may be slow to respond." aria-describedby="limited-availability-help-text-truncate-true-compact-true" id="limited-availability-truncate-true-compact-true">
                <label class="d-block f5 text-gray-dark mb-1" for="limited-availability-truncate-true-compact-true">
                  Busy
                </label>
                <p class="note" id="limited-availability-help-text-truncate-true-compact-true">
                  When others mention you, assign you, or request your review,
                  GitHub will let them know that you have limited availability.
                </p>
              </div>
            </div>
          </div>
            

<div class="d-inline-block f5 mr-2 pt-3 pb-2" >
  <div class="d-inline-block mr-1">
    Clear status
  </div>

  <details class="js-user-status-expire-drop-down f6 dropdown details-reset details-overlay d-inline-block mr-2">
    <summary class="f5 btn-link link-gray-dark border px-2 py-1 rounded-1" aria-haspopup="true">
      <div class="js-user-status-expiration-interval-selected d-inline-block v-align-baseline">
        Never
      </div>
      <div class="dropdown-caret"></div>
    </summary>

    <ul class="dropdown-menu dropdown-menu-se pl-0 overflow-auto" style="width: 220px; max-height: 15.5em">
      <li>
        <button type="button" class="btn-link dropdown-item js-user-status-expire-button ws-normal" title="Never">
          <span class="d-inline-block text-bold mb-1">Never</span>
          <div class="f6 lh-condensed">Keep this status until you clear your status or edit your status.</div>
        </button>
      </li>
      <li class="dropdown-divider" role="none"></li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 30 minutes" value="2019-09-22T19:06:37+05:30">
            in 30 minutes
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 1 hour" value="2019-09-22T19:36:37+05:30">
            in 1 hour
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="in 4 hours" value="2019-09-22T22:36:37+05:30">
            in 4 hours
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="today" value="2019-09-22T23:59:59+05:30">
            today
          </button>
        </li>
        <li>
          <button type="button" class="btn-link dropdown-item ws-normal js-user-status-expire-button" title="this week" value="2019-09-22T23:59:59+05:30">
            this week
          </button>
        </li>
    </ul>
  </details>
  <input class="js-user-status-expiration-date-input" type="hidden" name="expires_at" value="">
</div>

          <include-fragment class="js-user-status-org-picker" data-url="/users/status/organizations"></include-fragment>
        </div>
        <div class="d-flex flex-items-center flex-justify-between p-3 border-top">
          <button type="submit" disabled class="width-full btn btn-primary mr-2 js-user-status-submit">
            Set status
          </button>
          <button type="button" disabled class="width-full js-clear-user-status-button btn ml-2 ">
            Clear status
          </button>
        </div>
</form>    </details-dialog>
  </details>
</div>

      </div>
      <div role="none" class="dropdown-divider"></div>


    <a role="menuitem" class="dropdown-item" href="/ruthryi" data-ga-click="Header, go to profile, text:your profile">Your profile</a>


    <a role="menuitem" class="dropdown-item" href="/ruthryi?tab=repositories" data-ga-click="Header, go to repositories, text:your repositories">Your repositories</a>

    <a role="menuitem" class="dropdown-item" href="/ruthryi?tab=projects" data-ga-click="Header, go to projects, text:your projects">Your projects</a>

    <a role="menuitem" class="dropdown-item" href="/ruthryi?tab=stars" data-ga-click="Header, go to starred repos, text:your stars">Your stars</a>
      <a role="menuitem" class="dropdown-item" href="https://gist.github.com/mine" data-ga-click="Header, your gists, text:your gists">Your gists</a>


    <div role="none" class="dropdown-divider"></div>
    <a role="menuitem" class="dropdown-item" href="https://help.github.com" data-ga-click="Header, go to help, text:help">Help</a>
    <a role="menuitem" class="dropdown-item" href="/settings/profile" data-ga-click="Header, go to settings, icon:settings">Settings</a>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="logout-form" action="/logout" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="LF2Mrhrwe3vDf5y+z/RjUqwNZ7YY80VZxoxRAhy3koLHfVh0LkZdUs+CPyivxaAuSi0LmjwQDyYJb86HiZpY2A==" />
      
      <button type="submit" class="dropdown-item dropdown-signout" data-ga-click="Header, sign out, icon:logout" role="menuitem">
        Sign out
      </button>
</form>  </details-menu>
</details>

    </div>

  </header>

      

  </div>

  <div id="start-of-content" class="show-on-focus"></div>


    <div id="js-flash-container">

</div>



  <div class="application-main " data-commit-hovercards-enabled>
        <div itemscope itemtype="http://schema.org/SoftwareSourceCode" class="">
    <main  >
      


  

      <div class="border-bottom shelf intro-shelf js-notice mb-0 pb-4">
  <div class="width-full container">
    <div class="width-full mx-auto shelf-content">
      <h2 class="shelf-title">Learn Git and GitHub without any code!</h2>
      <p class="shelf-lead">
          Using the Hello World guide, you’ll start a branch, write comments, and open a pull request.
      </p>
      <a class="btn btn-primary shelf-cta" target="_blank" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;READ_GUIDE&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="768e7034eec899254e9a92d93be08cac9f99f2fab14006a6d286ac8fb65a26d8" href="https://guides.github.com/activities/hello-world/">Read the guide</a>
    </div>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="shelf-dismiss js-notice-dismiss" action="/dashboard/dismiss_bootcamp" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="_method" value="delete" /><input type="hidden" name="authenticity_token" value="R61Nwbfm44UnLvpAqml/5LDzhpycDsiTQ2s+Jj0M9KGmudft3Hw1NrK694P+7hQzY1LD2dFRMdCw7bdcDelhNg==" />
      <button name="button" type="submit" class="mr-1 close-button tooltipped tooltipped-w" aria-label="Hide this notice forever" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;DISMISS_BANNER&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="f7a6b841e46da5bec807881b0f880f5a434ddc8387adf4ec26fade43b7244b80">
        <svg aria-label="Hide this notice forever" class="octicon octicon-x v-align-text-top" viewBox="0 0 12 16" version="1.1" width="12" height="16" role="img"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48L7.48 8z"/></svg>
</button></form>  </div>
</div>



  








  <div class="pagehead repohead instapaper_ignore readability-menu experiment-repo-nav pt-0 pt-lg-4 ">
    <div class="repohead-details-container clearfix container-lg p-responsive d-none d-lg-block">

      <ul class="pagehead-actions">



    <li hidden>
      <include-fragment src="/wso2/docs-ei/used_by_count">
</include-fragment>
    </li>

  <li>
    
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form data-remote="true" class="clearfix js-social-form js-social-container" action="/notifications/subscribe" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="NlXGO6P/tz26qE5ihigi8ZveJQOCOf855kZ2DoTwV/IsTpszKlXdtjzxrbr343P7mSQw4TMTEdxRGJv4uY5RJg==" />      <input type="hidden" name="repository_id" value="171851899">

      <details class="details-reset details-overlay select-menu float-left">
        <summary class="select-menu-button float-left btn btn-sm btn-with-count" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;WATCH_BUTTON&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="0621be43fcf573d01825449504923e647e0f899a7b866601fed3cfce112d7aee" data-ga-click="Repository, click Watch settings, action:blob#show">          <span data-menu-button>
              <svg class="octicon octicon-eye v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
              Watch
          </span>
</summary>        <details-menu
          class="select-menu-modal position-absolute mt-5"
          style="z-index: 99;">
          <div class="select-menu-header">
            <span class="select-menu-title">Notifications</span>
          </div>
          <div class="select-menu-list">
            <button type="submit" name="do" value="included" class="select-menu-item width-full" aria-checked="true" role="menuitemradio">
              <svg class="octicon octicon-check select-menu-item-icon" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5L12 5z"/></svg>
              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Not watching</span>
                <span class="description">Be notified only when participating or @mentioned.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg class="octicon octicon-eye v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                  Watch
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="release_only" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg class="octicon octicon-check select-menu-item-icon" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5L12 5z"/></svg>
              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Releases only</span>
                <span class="description">Be notified of new releases, and when participating or @mentioned.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg class="octicon octicon-eye v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                  Unwatch releases
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="subscribed" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg class="octicon octicon-check select-menu-item-icon" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5L12 5z"/></svg>
              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Watching</span>
                <span class="description">Be notified of all conversations.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg class="octicon octicon-eye v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                  Unwatch
                </span>
              </div>
            </button>

            <button type="submit" name="do" value="ignore" class="select-menu-item width-full" aria-checked="false" role="menuitemradio">
              <svg class="octicon octicon-check select-menu-item-icon" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5L12 5z"/></svg>
              <div class="select-menu-item-text">
                <span class="select-menu-item-heading">Ignoring</span>
                <span class="description">Never be notified.</span>
                <span class="hidden-select-button-text" data-menu-button-contents>
                  <svg class="octicon octicon-mute v-align-text-bottom" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 2.81v10.38c0 .67-.81 1-1.28.53L3 10H1c-.55 0-1-.45-1-1V7c0-.55.45-1 1-1h2l3.72-3.72C7.19 1.81 8 2.14 8 2.81zm7.53 3.22l-1.06-1.06-1.97 1.97-1.97-1.97-1.06 1.06L11.44 8 9.47 9.97l1.06 1.06 1.97-1.97 1.97 1.97 1.06-1.06L13.56 8l1.97-1.97z"/></svg>
                  Stop ignoring
                </span>
              </div>
            </button>
          </div>
        </details-menu>
      </details>
        <a class="social-count js-social-count"
          href="/wso2/docs-ei/watchers"
          aria-label="78 users are watching this repository">
          78
        </a>
</form>
  </li>

  <li>
      <div class="js-toggler-container js-social-container starring-container ">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="starred js-social-form" action="/wso2/docs-ei/unstar" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="gWqW/ROxtjOPp86VD50fWNdgSpJqVyESaWT+QbDWlCqiDrcoCc71xS99+Uf2ivq1oSDua60rc1StFBCoMAp7zg==" />
      <input type="hidden" name="context" value="repository"></input>
      <button type="submit" class="btn btn-sm btn-with-count js-toggler-target" aria-label="Unstar this repository" title="Unstar wso2/docs-ei" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;UNSTAR_BUTTON&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="cc091833b5a555fc0bac83891a5a9382428d309f1dbf33c1e410e06e5e94e46c" data-ga-click="Repository, click unstar button, action:blob#show; text:Unstar">        <svg class="octicon octicon-star v-align-text-bottom" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74L14 6z"/></svg>
        Unstar
</button>        <a class="social-count js-social-count" href="/wso2/docs-ei/stargazers"
           aria-label="18 users starred this repository">
           18
        </a>
</form>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="unstarred js-social-form" action="/wso2/docs-ei/star" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="arnPUdZkwQ6PPf+Mz4QAlU7cHq6/ovbceWd3fbNUESf4glbO1JFNjKVPL3Oux6kmtZo0tB9Cwafm7RAuzTCKIA==" />
      <input type="hidden" name="context" value="repository"></input>
      <button type="submit" class="btn btn-sm btn-with-count js-toggler-target" aria-label="Unstar this repository" title="Star wso2/docs-ei" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;STAR_BUTTON&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="ff62564cb8ea5f5948f1ad341353e9317dc51749f0bfaaf02df6e6669b6efea2" data-ga-click="Repository, click star button, action:blob#show; text:Star">        <svg class="octicon octicon-star v-align-text-bottom" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74L14 6z"/></svg>
        Star
</button>        <a class="social-count js-social-count" href="/wso2/docs-ei/stargazers"
           aria-label="18 users starred this repository">
          18
        </a>
</form>  </div>

  </li>

  <li>
          <details class="details-reset details-overlay details-overlay-dark d-inline-block float-left">
            <summary class="btn btn-sm btn-with-count" data-hydro-click="{&quot;event_type&quot;:&quot;repository.click&quot;,&quot;payload&quot;:{&quot;target&quot;:&quot;FORK_BUTTON&quot;,&quot;repository_id&quot;:171851899,&quot;client_id&quot;:&quot;769465630.1537338025&quot;,&quot;originating_request_id&quot;:&quot;77B2:33F2:63EF05:9F9D05:5D8771B8&quot;,&quot;originating_url&quot;:&quot;https://github.com/wso2/docs-ei/blob/7.0.0/en/micro-integrator/docs/references/config-catalog.md&quot;,&quot;referrer&quot;:&quot;https://github.com/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references&quot;,&quot;user_id&quot;:23217207}}" data-hydro-click-hmac="27505fe8f6c7c04cf0938ac5bc967f560c949f3f6df9063c0cca249cc03ae4c9" data-ga-click="Repository, show fork modal, action:blob#show; text:Fork" title="Fork your own copy of wso2/docs-ei to your account">              <svg class="octicon octicon-repo-forked v-align-text-bottom" viewBox="0 0 10 16" version="1.1" width="10" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8 1a1.993 1.993 0 0 0-1 3.72V6L5 8 3 6V4.72A1.993 1.993 0 0 0 2 1a1.993 1.993 0 0 0-1 3.72V6.5l3 3v1.78A1.993 1.993 0 0 0 5 15a1.993 1.993 0 0 0 1-3.72V9.5l3-3V4.72A1.993 1.993 0 0 0 8 1zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3 10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3-10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
              Fork
</summary>            <details-dialog
              class="anim-fade-in fast Box Box--overlay d-flex flex-column"
              src="/wso2/docs-ei/fork?fragment=1"
              preload>
              <div class="Box-header">
                <button class="Box-btn-octicon btn-octicon float-right" type="button" aria-label="Close dialog" data-close-dialog>
                  <svg class="octicon octicon-x" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48L7.48 8z"/></svg>
                </button>
                <h3 class="Box-title">Fork docs-ei</h3>
              </div>
              <div class="overflow-auto text-center">
                <include-fragment>
                  <div class="octocat-spinner my-3" aria-label="Loading..."></div>
                  <p class="f5 text-gray">If this dialog fails to load, you can visit <a href="/wso2/docs-ei/fork">the fork page</a> directly.</p>
                </include-fragment>
              </div>
            </details-dialog>
          </details>

    <a href="/wso2/docs-ei/network/members" class="social-count"
       aria-label="20 users forked this repository">
      20
    </a>
  </li>
</ul>

      <h1 class="public ">
    <svg class="octicon octicon-repo" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9H3V8h1v1zm0-3H3v1h1V6zm0-2H3v1h1V4zm0-2H3v1h1V2zm8-1v12c0 .55-.45 1-1 1H6v2l-1.5-1.5L3 16v-2H1c-.55 0-1-.45-1-1V1c0-.55.45-1 1-1h10c.55 0 1 .45 1 1zm-1 10H1v2h2v-1h3v1h5v-2zm0-10H2v9h9V1z"/></svg>
  <span class="author" itemprop="author"><a class="url fn" rel="author" data-hovercard-type="organization" data-hovercard-url="/orgs/wso2/hovercard" href="/wso2">wso2</a></span><!--
--><span class="path-divider">/</span><!--
--><strong itemprop="name"><a data-pjax="#js-repo-pjax-container" href="/wso2/docs-ei">docs-ei</a></strong>
  

</h1>

    </div>
    
<nav class="hx_reponav reponav js-repo-nav js-sidenav-container-pjax container-lg p-responsive d-none d-lg-block"
     itemscope
     itemtype="http://schema.org/BreadcrumbList"
    aria-label="Repository"
     data-pjax="#js-repo-pjax-container">

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a class="js-selected-navigation-item selected reponav-item" itemprop="url" data-hotkey="g c" aria-current="page" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches repo_packages /wso2/docs-ei/tree/7.0.0" href="/wso2/docs-ei/tree/7.0.0">
      <svg class="octicon octicon-code" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4.5 5L6 11.5 2.5 8 6 4.5 4.5 3z"/></svg>
      <span itemprop="name">Code</span>
      <meta itemprop="position" content="1">
</a>  </span>

    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
      <a itemprop="url" data-hotkey="g i" class="js-selected-navigation-item reponav-item" data-selected-links="repo_issues repo_labels repo_milestones /wso2/docs-ei/issues" href="/wso2/docs-ei/issues">
        <svg class="octicon octicon-issue-opened" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"/></svg>
        <span itemprop="name">Issues</span>
        <span class="Counter">198</span>
        <meta itemprop="position" content="2">
</a>    </span>

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a data-hotkey="g p" itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="repo_pulls checks /wso2/docs-ei/pulls" href="/wso2/docs-ei/pulls">
      <svg class="octicon octicon-git-pull-request" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M11 11.28V5c-.03-.78-.34-1.47-.94-2.06C9.46 2.35 8.78 2.03 8 2H7V0L4 3l3 3V4h1c.27.02.48.11.69.31.21.2.3.42.31.69v6.28A1.993 1.993 0 0 0 10 15a1.993 1.993 0 0 0 1-3.72zm-1 2.92c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zM4 3c0-1.11-.89-2-2-2a1.993 1.993 0 0 0-1 3.72v6.56A1.993 1.993 0 0 0 2 15a1.993 1.993 0 0 0 1-3.72V4.72c.59-.34 1-.98 1-1.72zm-.8 10c0 .66-.55 1.2-1.2 1.2-.65 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
      <span itemprop="name">Pull requests</span>
      <span class="Counter">0</span>
      <meta itemprop="position" content="3">
</a>  </span>


    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement" class="position-relative float-left">
      <a data-hotkey="g w" data-skip-pjax="true" class="js-selected-navigation-item reponav-item" data-selected-links="repo_actions /wso2/docs-ei/actions" href="/wso2/docs-ei/actions">
        <svg class="octicon octicon-play" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M14 8A7 7 0 1 1 0 8a7 7 0 0 1 14 0zm-8.223 3.482l4.599-3.066a.5.5 0 0 0 0-.832L5.777 4.518A.5.5 0 0 0 5 4.934v6.132a.5.5 0 0 0 .777.416z"/></svg>
        Actions
</a>
    </span>

    <a data-hotkey="g b" class="js-selected-navigation-item reponav-item" data-selected-links="repo_projects new_repo_project repo_project /wso2/docs-ei/projects" href="/wso2/docs-ei/projects">
      <svg class="octicon octicon-project" viewBox="0 0 15 16" version="1.1" width="15" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      Projects
      <span class="Counter" >0</span>
</a>


    <a data-skip-pjax="true" class="js-selected-navigation-item reponav-item" data-selected-links="security alerts policy code_scanning /wso2/docs-ei/security/advisories" href="/wso2/docs-ei/security/advisories">
      <svg class="octicon octicon-shield" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M0 2l7-2 7 2v6.02C14 12.69 8.69 16 7 16c-1.69 0-7-3.31-7-7.98V2zm1 .75L7 1l6 1.75v5.268C13 12.104 8.449 15 7 15c-1.449 0-6-2.896-6-6.982V2.75zm1 .75L7 2v12c-1.207 0-5-2.482-5-5.985V3.5z"/></svg>
      Security
</a>
    <a class="js-selected-navigation-item reponav-item" data-selected-links="repo_graphs repo_contributors dependency_graph pulse people /wso2/docs-ei/pulse" href="/wso2/docs-ei/pulse">
      <svg class="octicon octicon-graph" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M16 14v1H0V0h1v14h15zM5 13H3V8h2v5zm4 0H7V3h2v10zm4 0h-2V6h2v7z"/></svg>
      Insights
</a>

</nav>

  <div class="reponav-wrapper reponav-small d-lg-none">
  <nav class="reponav js-reponav text-center no-wrap"
       itemscope
       itemtype="http://schema.org/BreadcrumbList">

    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
      <a class="js-selected-navigation-item selected reponav-item" itemprop="url" aria-current="page" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches repo_packages /wso2/docs-ei/tree/7.0.0" href="/wso2/docs-ei/tree/7.0.0">
        <span itemprop="name">Code</span>
        <meta itemprop="position" content="1">
</a>    </span>

      <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
        <a itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="repo_issues repo_labels repo_milestones /wso2/docs-ei/issues" href="/wso2/docs-ei/issues">
          <span itemprop="name">Issues</span>
          <span class="Counter">198</span>
          <meta itemprop="position" content="2">
</a>      </span>

    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
      <a itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="repo_pulls checks /wso2/docs-ei/pulls" href="/wso2/docs-ei/pulls">
        <span itemprop="name">Pull requests</span>
        <span class="Counter">0</span>
        <meta itemprop="position" content="3">
</a>    </span>

      <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
        <a itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="repo_projects new_repo_project repo_project /wso2/docs-ei/projects" href="/wso2/docs-ei/projects">
          <span itemprop="name">Projects</span>
          <span class="Counter">0</span>
          <meta itemprop="position" content="4">
</a>      </span>


      <a itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="security alerts policy code_scanning /wso2/docs-ei/security/advisories" href="/wso2/docs-ei/security/advisories">
        <span itemprop="name">Security</span>
        <meta itemprop="position" content="6">
</a>
      <a class="js-selected-navigation-item reponav-item" data-selected-links="pulse /wso2/docs-ei/pulse" href="/wso2/docs-ei/pulse">
        Pulse
</a>
      <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
        <a itemprop="url" class="js-selected-navigation-item reponav-item" data-selected-links="community /wso2/docs-ei/community" href="/wso2/docs-ei/community">
          Community
</a>      </span>

  </nav>
</div>


  </div>
<div class="container-lg clearfix new-discussion-timeline experiment-repo-nav  p-responsive">
  <div class="repository-content ">

    
    


  


    <a class="d-none js-permalink-shortcut" data-hotkey="y" href="/wso2/docs-ei/blob/6c2890da7b4bcde50bd4d1ba48d23e12b6658a85/en/micro-integrator/docs/references/config-catalog.md">Permalink</a>

    <!-- blob contrib key: blob_contributors:v21:bce2b8c76da74f7b0e89661474aa090c -->
      

    <div class="d-flex flex-items-start flex-shrink-0 pb-3 flex-column flex-md-row">
      <span class="d-flex flex-justify-between width-full width-md-auto">
        
<details class="details-reset details-overlay select-menu branch-select-menu  hx_rsm" id="branch-select-menu">
  <summary class="btn btn-sm select-menu-button css-truncate"
           data-hotkey="w"
           title="Switch branches or tags">
    <i>Branch:</i>
    <span class="css-truncate-target" data-menu-button>7.0.0</span>
  </summary>

  <details-menu class="select-menu-modal hx_rsm-modal position-absolute" style="z-index: 99;" src="/wso2/docs-ei/ref-list/7.0.0/en/micro-integrator/docs/references/config-catalog.md?source_action=show&amp;source_controller=blob" preload>
    <include-fragment class="select-menu-loading-overlay anim-pulse">
      <svg height="32" class="octicon octicon-octoface" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M14.7 5.34c.13-.32.55-1.59-.13-3.31 0 0-1.05-.33-3.44 1.3-1-.28-2.07-.32-3.13-.32s-2.13.04-3.13.32c-2.39-1.64-3.44-1.3-3.44-1.3-.68 1.72-.26 2.99-.13 3.31C.49 6.21 0 7.33 0 8.69 0 13.84 3.33 15 7.98 15S16 13.84 16 8.69c0-1.36-.49-2.48-1.3-3.35zM8 14.02c-3.3 0-5.98-.15-5.98-3.35 0-.76.38-1.48 1.02-2.07 1.07-.98 2.9-.46 4.96-.46 2.07 0 3.88-.52 4.96.46.65.59 1.02 1.3 1.02 2.07 0 3.19-2.68 3.35-5.98 3.35zM5.49 9.01c-.66 0-1.2.8-1.2 1.78s.54 1.79 1.2 1.79c.66 0 1.2-.8 1.2-1.79s-.54-1.78-1.2-1.78zm5.02 0c-.66 0-1.2.79-1.2 1.78s.54 1.79 1.2 1.79c.66 0 1.2-.8 1.2-1.79s-.53-1.78-1.2-1.78z"/></svg>
    </include-fragment>
  </details-menu>
</details>

        <div class="BtnGroup flex-shrink-0 d-md-none">
          <a href="/wso2/docs-ei/find/7.0.0"
                class="js-pjax-capture-input btn btn-sm BtnGroup-item"
                data-pjax
                data-hotkey="t">
            Find file
          </a>
          <clipboard-copy value="en/micro-integrator/docs/references/config-catalog.md" class="btn btn-sm BtnGroup-item">
            Copy path
          </clipboard-copy>
        </div>
      </span>
      <h2 id="blob-path" class="breadcrumb flex-auto min-width-0 text-normal flex-md-self-center ml-md-2 mr-md-3 my-2 my-md-0">
        <span class="js-repo-root text-bold"><span class="js-path-segment"><a data-pjax="true" href="/wso2/docs-ei/tree/7.0.0"><span>docs-ei</span></a></span></span><span class="separator">/</span><span class="js-path-segment"><a data-pjax="true" href="/wso2/docs-ei/tree/7.0.0/en"><span>en</span></a></span><span class="separator">/</span><span class="js-path-segment"><a data-pjax="true" href="/wso2/docs-ei/tree/7.0.0/en/micro-integrator"><span>micro-integrator</span></a></span><span class="separator">/</span><span class="js-path-segment"><a data-pjax="true" href="/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs"><span>docs</span></a></span><span class="separator">/</span><span class="js-path-segment"><a data-pjax="true" href="/wso2/docs-ei/tree/7.0.0/en/micro-integrator/docs/references"><span>references</span></a></span><span class="separator">/</span><strong class="final-path">config-catalog.md</strong>
      </h2>

      <div class="BtnGroup flex-shrink-0 d-none d-md-inline-block">
        <a href="/wso2/docs-ei/find/7.0.0"
              class="js-pjax-capture-input btn btn-sm BtnGroup-item"
              data-pjax
              data-hotkey="t">
          Find file
        </a>
        <clipboard-copy value="en/micro-integrator/docs/references/config-catalog.md" class="btn btn-sm BtnGroup-item">
          Copy path
        </clipboard-copy>
      </div>
    </div>



    <include-fragment src="/wso2/docs-ei/contributors/7.0.0/en/micro-integrator/docs/references/config-catalog.md" class="Box Box--condensed commit-loader">
      <div class="Box-body bg-blue-light f6">
        Fetching contributors&hellip;
      </div>

      <div class="Box-body d-flex flex-items-center" >
          <img alt="" class="loader-loading mr-2" src="https://github.githubassets.com/images/spinners/octocat-spinner-32-EAF2F5.gif" width="16" height="16" />
        <span class="text-red h6 loader-error">Cannot retrieve contributors at this time</span>
      </div>
</include-fragment>




    <div class="Box mt-3 position-relative">
      
<div class="Box-header py-2 d-flex flex-column flex-shrink-0 flex-md-row flex-md-items-center">

  <div class="text-mono f6 flex-auto pr-3 flex-order-2 flex-md-order-1 mt-2 mt-md-0">
      9053 lines (8763 sloc)
      <span class="file-info-divider"></span>
    532 KB
  </div>

  <div class="d-flex py-1 py-md-0 flex-auto flex-order-1 flex-md-order-2 flex-sm-grow-0 flex-justify-between">

    <div class="BtnGroup">
      <a id="raw-url" class="btn btn-sm BtnGroup-item" href="/wso2/docs-ei/raw/7.0.0/en/micro-integrator/docs/references/config-catalog.md">Raw</a>
        <a class="btn btn-sm js-update-url-with-hash BtnGroup-item" data-hotkey="b" href="/wso2/docs-ei/blame/7.0.0/en/micro-integrator/docs/references/config-catalog.md">Blame</a>
      <a rel="nofollow" class="btn btn-sm BtnGroup-item" href="/wso2/docs-ei/commits/7.0.0/en/micro-integrator/docs/references/config-catalog.md">History</a>
    </div>


    <div>
            <a class="btn-octicon tooltipped tooltipped-nw"
               href="github-mac://openRepo/https://github.com/wso2/docs-ei?branch=7.0.0&amp;filepath=en%2Fmicro-integrator%2Fdocs%2Freferences%2Fconfig-catalog.md"
               aria-label="Open this file in GitHub Desktop"
               data-ga-click="Repository, open with desktop, type:mac">
                <svg class="octicon octicon-device-desktop" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M15 2H1c-.55 0-1 .45-1 1v9c0 .55.45 1 1 1h5.34c-.25.61-.86 1.39-2.34 2h8c-1.48-.61-2.09-1.39-2.34-2H15c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm0 9H1V3h14v8z"/></svg>
            </a>

            <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="inline-form js-update-url-with-hash" action="/wso2/docs-ei/edit/7.0.0/en/micro-integrator/docs/references/config-catalog.md" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="Zu9Wqm7VBYNDdBEM8gCuwCZnnIhiHvvKf//ItRUvijuaClzqzI6kt6d/zZ+UKBH4XY/DZBx4txAr/ZpWaheqjQ==" />
              <button class="btn-octicon tooltipped tooltipped-nw" type="submit"
                aria-label="Edit this file" data-hotkey="e" data-disable-with>
                <svg class="octicon octicon-pencil" viewBox="0 0 14 16" version="1.1" width="14" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M0 12v3h3l8-8-3-3-8 8zm3 2H1v-2h1v1h1v1zm10.3-9.3L12 6 9 3l1.3-1.3a.996.996 0 0 1 1.41 0l1.59 1.59c.39.39.39 1.02 0 1.41z"/></svg>
              </button>
</form>
          <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="inline-form" action="/wso2/docs-ei/delete/7.0.0/en/micro-integrator/docs/references/config-catalog.md" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="1DUHniP41gGZPjTKG6p9w7oS95tMMaLqabXf26G0D0cwPz9GSU859dnEzdm+FwKNjypl9sbrzJ/dwrP72ubgZA==" />
            <button class="btn-octicon btn-octicon-danger tooltipped tooltipped-nw" type="submit"
              aria-label="Delete this file" data-disable-with>
              <svg class="octicon octicon-trashcan" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M11 2H9c0-.55-.45-1-1-1H5c-.55 0-1 .45-1 1H2c-.55 0-1 .45-1 1v1c0 .55.45 1 1 1v9c0 .55.45 1 1 1h7c.55 0 1-.45 1-1V5c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm-1 12H3V5h1v8h1V5h1v8h1V5h1v8h1V5h1v9zm1-10H2V3h9v1z"/></svg>
            </button>
</form>    </div>
  </div>
</div>




      
  <div id="readme" class="Box-body readme blob instapaper_body js-code-block-container">
    <article class="markdown-body entry-content p-3 p-md-6" itemprop="text"><h1><a id="user-content-product-configurations" class="anchor" aria-hidden="true" href="#product-configurations"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Product Configurations</h1>
<p>This document describes all the configuration parameters that are used in WSO2 Micro Integrator.</p>
<h2><a id="user-content-instructions-for-use" class="anchor" aria-hidden="true" href="#instructions-for-use"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Instructions for use</h2>
<blockquote>
<p>Select the configuration sections, parameters, and values that are required for your use and add them to the .toml file. See the example .toml file given below.</p>
</blockquote>
<div class="highlight highlight-source-toml"><pre><span class="pl-c"><span class="pl-c">#</span> This is an example .toml file.</span>

[<span class="pl-en">server</span>]
<span class="pl-smi">hostname</span>=<span class="pl-s"><span class="pl-pds">"</span>localhost<span class="pl-pds">"</span></span>
<span class="pl-smi">enable_mtom</span>=<span class="pl-c1">false</span>
<span class="pl-smi">userAgent</span> = <span class="pl-s"><span class="pl-pds">"</span>WSO2 ${product.key} ${product.version}<span class="pl-pds">"</span></span>

[<span class="pl-en">keystore</span>.<span class="pl-en">tls</span>]
<span class="pl-smi">file_name</span>=<span class="pl-s"><span class="pl-pds">"</span>wso2carbon.jks<span class="pl-pds">"</span></span>
<span class="pl-smi">type</span>=<span class="pl-s"><span class="pl-pds">"</span>JKS<span class="pl-pds">"</span></span>
<span class="pl-smi">password</span>=<span class="pl-s"><span class="pl-pds">"</span>wso2carbon<span class="pl-pds">"</span></span>
<span class="pl-smi">alias</span>=<span class="pl-s"><span class="pl-pds">"</span>wso2carbon<span class="pl-pds">"</span></span>
<span class="pl-smi">key_password</span>=<span class="pl-s"><span class="pl-pds">"</span>wso2carbon<span class="pl-pds">"</span></span>
</pre></div>
<h2><a id="user-content-deployment" class="anchor" aria-hidden="true" href="#deployment"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Deployment</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="2" type="checkbox" id="_tab_2"&gt;
            &lt;label class="tab-selector" for="_tab_2"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[server]
hostname="localhost"
node_ip = "10.100.1.80"
base_path = "127.0.0.1"
enable_mtom=false
enable_swa=false
userAgent = "WSO2 ${product.key} ${product.version}"
serverDetails = "WSO2 ${product.key} ${product.version}"
offset  = 0
proxy_context_path = ""
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[server]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            This toml header groups the parameters that are used for identifying a server node. You need to update these values when you &lt;a href="../../setup/deployment/deploying_wso2_ei"&gt;set up a deployment&lt;/a&gt;.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&amp;quot;localhost&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;localhost&amp;quot;
</code></pre>
<p>,"127.0.0.1","&lt;any-ip-address&gt;"
</p></div>
</div>
<div>
<p>The hostname of the Micro Integrator instance.</p>
</div>
</div>
<div>
<div>
<span> <code>node_ip</code> </span>
</div>
<div>
<div>
<p>
<span> string </span>
<span>Required</span>
</p>
<div>
<span>Default: <code>"127.0.0.1"</code></span>
</div><p></p>
<pre><code>                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The IP address of the server node.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;enable_mtom&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Use this paramater to enable MTOM (Message Transmission Optimization Mechanism) for the product server.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;enable_swa&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Use this paramater to enable SwA (SOAP with Attachments) for the product server. When SwA is enabled, the Micro Integrator will process the files attached to SOAP messages.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;offset&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Port offset allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). &lt;/br&gt;&lt;/br&gt;Port offset defines the number by which all ports defined in the runtime such as the HTTP/S ports will be offset. For example, if the default HTTP port is 9443 and the portOffset is 1, the effective HTTP port will be 9444. Therefore, for each additional WSO2 product instance, set the port offset to a unique value (the default is 0) so that they can all run on the same server without any port conflicts.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-clustering" class="anchor" aria-hidden="true" href="#clustering"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Clustering</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="3" type="checkbox" id="_tab_3"&gt;
            &lt;label class="tab-selector" for="_tab_3"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[clustering]
members = ["10.100.5.86:4000","10.100.5.86:4001"]
local_member_port = 4000
local_member_host = "10.100.5.86"
membership_scheme =  'wka'
domain = "wso2.carbon.domain"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[clustering]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            This toml header groups the parameters that connect the server to a &lt;a href="../../setup/deployment/deploying_wso2_ei"&gt;clustered deployment&lt;/a&gt;.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;members&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;[&amp;quot;10.100.5.86:4000&amp;quot;,&amp;quot;10.100.5.86:4001&amp;quot;]&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Specify the well-known members in the cluster in both nodes of a two-node cluster. For example, when you configure one Micro Integrator node, you need to specify the other nodes in the cluster as well-known member. The port value for the WKA node must be the same value as its &lt;b&gt;local_member_port&lt;/b&gt; (in this case it is 4000).&lt;details class="warning classes" open="open"&gt;&lt;summary&gt;Note&lt;/summary&gt;&lt;p&gt;You can also use IP address ranges for the hostname (e.g., 192.168.1.2-10). However, you can define a range only for the last portion of the IP address. Smaller the range, faster the time it takes to discover members since each node has to scan a lesser number of potential members. The best practice is to add all the members (including itself) in all the nodes to avoid any conflicts in configurations.&lt;/p&gt;&lt;/details&gt;&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;local_member_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;4000&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The port that is assigned to the server node in the deployment. This port number is not affected by the port offset value specified under the "[server]" section. If this port number is already assigned to another server, the clustering framework automatically increments this port number. However, if there are two servers running on the same machine, ensure that a unique port is set for each server. For example, you can have port 4000 for node 1 and port 4001 for node 2.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;local_member_host&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10.100.5.86&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The hostname of the server node. When you have multiple nodes in the deployment, this hostname will be used to identify the node during inter-node communications.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;membership_scheme&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wka&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Add this parameter to change the default membership scheme. By default, the well-known address registration method (WKA) is used, which ensures that each node sends cluster initiation messages to the WKA members.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;domain&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2.carbon.domain&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Add this parameter to change the default cluster (domain name) to which the server node joins.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-primary-keystore" class="anchor" aria-hidden="true" href="#primary-keystore"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Primary keystore</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="4" type="checkbox" id="_tab_4"&gt;
            &lt;label class="tab-selector" for="_tab_4"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[keystore.tls]
file_name="wso2carbon.jks"
type="JKS"
password="wso2carbon"
alias="wso2carbon"
key_password="wso2carbon"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[keystore_tls]&lt;/code&gt;
                        
                        &lt;p&gt;
                            This config heading in the ei.toml file groups the parameters that connect the server to the primary keystore. This keystore is used for SSL handshaking (when the server communicates with another server) and for encrypting plain text information in configuration files. By default, this keystore is also used for encrypted data in internal datastores, unless you have configured a separate keystore for internal data encryption. Read more about &lt;a href="../../setup/security/configuring_keystores/#changing-the-default-primary-keystore"&gt;configuring the primary keystore&lt;/a&gt;.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon.jks&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The name of the keystore file that is used for SSL communication and for encrypting/decrypting data in configuration files.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;JKS&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;JKS&amp;quot;,&amp;quot;PKCS12&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The type of the keystore file.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The password of the keystore file that is used for SSL communication and for encrypting/decrypting data in configuration files. The keystore password is used when accessing the keys in the keystore.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;alias&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore's public key.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-internal-keystore" class="anchor" aria-hidden="true" href="#internal-keystore"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Internal keystore</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="5" type="checkbox" id="_tab_5"&gt;
            &lt;label class="tab-selector" for="_tab_5"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[keystore.internal]
file_name="wso2carbon.jks"
type="JKS"
password="wso2carbon"
alias="wso2carbon"
key_password="wso2carbon"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[keystore_internal]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that connect the server to the keystore used for encrypting/decrypting data in internal data stores. You may sometimes choose to configure a separate keystore for this purpose because the primary keystore that is used by the "[keystore.tls]" configuration needs to renew certificates frequently. However, for encrypting information in internal data stores, the keystore certificates should not be changed frequently because the data that is already encrypted will become unusable every time the certificate changes. Read more about &lt;a href="../../setup/security/configuring_keystores/#separating-the-internal-keystore"&gt;configuring the internal keystore&lt;/a&gt;.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon.jks&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The name of the keystore file that is used for data encryption/decryption in internal data stores.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;JKS&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;JKS&amp;quot;,&amp;quot;PKCS12&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The type of the keystore file.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The password of the keystore file that is used for data encryption/decryption in internal data stores. The keystore password is used when accessing the keys in the keystore.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;alias&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore's public key.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-trust-store" class="anchor" aria-hidden="true" href="#trust-store"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Trust store</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="6" type="checkbox" id="_tab_6"&gt;
            &lt;label class="tab-selector" for="_tab_6"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[truststore]
file_name="wso2truststore.jks"
type="JKS"
password="wso2carbon"
alias="symmetric.key.value"
algorithm=""
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[truststore]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that connect the server to the keystore file (trust store) that is used to store the digital certificates that the server trusts for SSL communication. All keystore files used by this product should be stored in the MI_HOME/repository/resources/security/ directory. The product is configured to use the default trust store (wso2truststore.jks), which contains the self-signed digital certificate of the default keystore. Read more about &lt;a href="../../setup/security/configuring_keystores/#optional-changing-the-default-truststore"&gt;configuring the truststore&lt;/a&gt;.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2truststore.jks&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The name of the keystore file that is used for storing the trusted digital certificates.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;JKS&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;JKS&amp;quot;,&amp;quot;PKCS12&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The type of the keystore file that is used as the trust store.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;wso2carbon&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The password of the keystore file that is used as the trust store.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;alias&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;symmetric.key.value&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The alias is the password of the digital certificate (which holds the public key) that is included in the trustore.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;algorithm&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-owasp-csrf-guard" class="anchor" aria-hidden="true" href="#owasp-csrf-guard"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>OWASP CSRF Guard</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="7" type="checkbox" id="_tab_7"&gt;
            &lt;label class="tab-selector" for="_tab_7"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[owasp.csrfguard.unprotected.service]]
 name = "oauthiwa"
 service = "%servletContext%/commonauth/iwa/*"

[owasp.csrfguard]
create_token_per_page=false
token_length=32
random_number_generator_algo="SHA1PRNG"

[owasp.csrfguard.js_servlet]
x_request_with_header = "WSO2 CSRF Protection"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[owasp.csrfguard]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The .......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;create_token_per_page&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;token_length&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;32&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;random_number_generator_algo&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;SHA1PRNG&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-owasp-csrf-unprotected-service" class="anchor" aria-hidden="true" href="#owasp-csrf-unprotected-service"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>OWASP CSRF Unprotected Service</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="8" type="checkbox" id="_tab_8"&gt;
            &lt;label class="tab-selector" for="_tab_8"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[owasp.csrfguard.unprotected.service]]
 name = "oauthiwa"
 service = "%servletContext%/commonauth/iwa/*"

[owasp.csrfguard]
create_token_per_page=false
token_length=32
random_number_generator_algo="SHA1PRNG"

[owasp.csrfguard.js_servlet]
x_request_with_header = "WSO2 CSRF Protection"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[owasp.csrfguard.unprotected.service]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The .......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;oauthiwa&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;service&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;%servletContext%/commonauth/iwa/*&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-owasp-csrf-js-servlet" class="anchor" aria-hidden="true" href="#owasp-csrf-js-servlet"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>OWASP CSRF JS Servlet</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="9" type="checkbox" id="_tab_9"&gt;
            &lt;label class="tab-selector" for="_tab_9"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[owasp.csrfguard.unprotected.service]]
 name = "oauthiwa"
 service = "%servletContext%/commonauth/iwa/*"

[owasp.csrfguard]
create_token_per_page=false
token_length=32
random_number_generator_algo="SHA1PRNG"

[owasp.csrfguard.js_servlet]
x_request_with_header = "WSO2 CSRF Protection"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[owasp.csrfguard.js_servlet]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The .......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;x_request_with_header&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;WSO2 CSRF Protection&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-server-request-processor" class="anchor" aria-hidden="true" href="#server-request-processor"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Server request processor</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="10" type="checkbox" id="_tab_10"&gt;
            &lt;label class="tab-selector" for="_tab_10"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[server.get_request_processor]]
item = "swagger.json"
class = "org.wso2.appcloud.api.swagger.processors.json.SwaggerJsonProcessor"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[server.get_request_processor]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The...
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;item&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;swagger.json&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.wso2.appcloud.api.swagger.processors.json.SwaggerJsonProcessor&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-http-transport" class="anchor" aria-hidden="true" href="#http-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>HTTP transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="11" type="checkbox" id="_tab_11"&gt;
            &lt;label class="tab-selector" for="_tab_11"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.http]
socket_timeout = "3m"
core_worker_pool_size = 400
max_worker_pool_size = 400
worker_pool_queue_length = -1
io_buffer_size = 16384
max_http_connection_per_host_port = 32767
preserve_http_user_agent = false
preserve_http_server_name = true
preserve_http_headers = ["Content-Type"]
disable_connection_keepalive = false
enable_message_size_validation = false
max_message_size_bytes = 81920
max_open_connections = -1
force_xml_validation = false
force_json_validation = false
listener.port = 8280    #inferred  default: 8280
listener.wsdl_epr_prefix ="$ref{server.hostname}"
listener.bind_address = "$ref{server.hostname}"
listener.secured_port = 8243
listener.secured_wsdl_epr_prefix = "$ref{server.hostname}"
listener.secured_bind_address = "$ref{server.hostname}"
listener.secured_protocols = "TLSv1,TLSv1.1,TLSv1.2"
listener.verify_client = "require"
listener.ssl_profile.file_path = "conf/sslprofiles/listenerprofiles.xml"
listener.ssl_profile.read_interval = "1h"
listener.preferred_ciphers = "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256"
listener.keystore.file_name ="$ref{keystore.tls.file_name}"
listener.keystore.type = "$ref{keystore.tls.type}"
listener.keystore.password = "$ref{keystore.tls.password}"
listener.keystore.key_password = "$ref{keystore.tls.key_password}"
listener.truststore.file_name = "$ref{truststore.file_name}"
listener.truststore.type = "$ref{truststore.type}"
listener.truststore.password = "$ref{truststore.password}"
sender.warn_on_http_500 = "*"
sender.proxy_host = "$ref{server.hostname}"
sender.proxy_port = 3128
sender.non_proxy_hosts = ["$ref{server.hostname}"]
sender.hostname_verifier = "AllowAll"
sender.keystore.file_name ="$ref{keystore.tls.file_name}"
sender.keystore.type = "$ref{keystore.tls.type}"
sender.keystore.password = "$ref{keystore.tls.password}"
sender.keystore.key_password = "$ref{keystore.tls.key_password}"
sender.truststore.file_name = "$ref{truststore.file_name}"
sender.truststore.type = "$ref{truststore.type}"
sender.truststore.password = "$ref{truststore.password}"
sender.ssl_profile.file_path = "conf/sslprofiles/senderprofiles.xml"
sender.ssl_profile.read_interval = "30s"
# common for http/https
blocking_sender.enable_client_caching = true
blocking_sender.transfer_encoding = "chunked"
blocking_sender.default_connections_per_host = 200
blocking_sender.omit_soap12_action = true
blocking_sender.so_timeout = "1m"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.http]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters for configuring the HTTP/S transports in the product.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;socket_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;3m&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;core_worker_pool_size&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;400&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;max_worker_pool_size&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;400&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;worker_pool_queue_length&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;-1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;io_buffer_size&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;16384&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;max_http_connection_per_host_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;32767&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;preserve_http_user_agent&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;preserve_http_server_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;preserve_http_headers&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;Content-Type&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;disable_connection_keepalive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;enable_message_size_validation&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;max_message_size_bytes&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;81920&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;max_open_connections&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;-1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;force_xml_validation&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;force_json_validation&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;8280&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The port on which this transport receiver should listen for incoming messages.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.wsdl_epr_prefix&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;A URL prefix which will be added to all service EPRs and EPRs in WSDLs etc.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.bind_address&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.secured_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;8243&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The secured port on which this transport receiver should listen for incoming messages.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.secured_wsdl_epr_prefix&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;A URL prefix which will be added to all service EPRs and EPRs in WSDLs etc.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.secured_bind_address&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.secured_protocols&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;TLSv1,TLSv1.1,TLSv1.2&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.verify_client&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;require&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.ssl_profile.file_path&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;conf/sslprofiles/listenerprofiles.xml&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.ssl_profile.read_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1h&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.preferred_ciphers&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.key_password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.truststore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.truststore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.truststore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.warn_on_http_500&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.proxy_host&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;${deployement.node_ip}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.proxy_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;3128&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The port through which the target proxy accepts HTTP traffic.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.non_proxy_hosts&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;[&amp;quot;$ref{server.hostname}&amp;quot;]&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The list of hosts to which the HTTP traffic should be sent directly without going through the proxy. When trying to add multiple hostnames along with an asterisk in order to define a set of sub-domains for non-proxy hosts, you need to add a period before the asterisk when configuring proxy server.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.hostname_verifier&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;AllowAll&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The list of hosts to which the HTTP traffic should be sent directly without going through the proxy. When trying to add multiple hostnames along with an asterisk in order to define a set of sub-domains for non-proxy hosts, you need to add a period before the asterisk when configuring proxy server.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.keystore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.keystore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.keystore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.keystore.key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.key_password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.truststore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.truststore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.truststore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;blocking_sender.enable_client_caching&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;This parameter is used to specify whether the HTTP client should save cache entries and the cached responses in the JVM memory or not.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;blocking_sender.transfer_encoding&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;chunked&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;chunked&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;This parameter enables you to specify whether the data sent should be chunked. It can be used instead of the Content-Length header if you want to upload data without having to know the amount of data to be uploaded in advance.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;blocking_sender.default_connections_per_host&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The maximum number of connections that will be created per host server by the client. If the backend server is slow, the connections in use at a given time will take a long time to be released and added back to the connection pool. As a result, connections may not be available for some requests. In such situations, it is recommended to increase the value for this parameter.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;blocking_sender.omit_soap12_action&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If following is set to 'true', optional action part of the Content-Type will not be added to the SOAP 1.2 messages.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;blocking_sender.so_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If following is set to 'true', optional action part of the Content-Type will not be added to the SOAP 1.2 messages.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-http-proxy-profile" class="anchor" aria-hidden="true" href="#http-proxy-profile"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>HTTP proxy profile</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="12" type="checkbox" id="_tab_12"&gt;
            &lt;label class="tab-selector" for="_tab_12"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.http.proxy_profile]]
target_hosts = [""]
proxy_host = ""
proxy_port = ""
proxy_username = ""
proxy_password = ""
bypass_hosts = [""]
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.http.proxy_profile]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;target_hosts&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&amp;quot;true&amp;quot; or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;127.0.0.1&amp;quot;,&amp;quot;localhost&amp;quot;,&amp;quot;&amp;lt;any-ip-address&amp;gt;&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The hostname of the WSO2 EI server instance.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;proxy_hosts&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;......&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;proxy_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;......&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;proxy_username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;......&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;proxy_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;......&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;bypass_hosts&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;......&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-local-transport" class="anchor" aria-hidden="true" href="#local-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Local transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="13" type="checkbox" id="_tab_13"&gt;
            &lt;label class="tab-selector" for="_tab_13"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.local]
listener.enabled=false
sender.enabled=false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.local]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            This parameter is used to enable the listeners and senders when the ESB server communicates through the local transport.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the local transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the local transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-vfs-transport" class="anchor" aria-hidden="true" href="#vfs-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>VFS transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="14" type="checkbox" id="_tab_14"&gt;
            &lt;label class="tab-selector" for="_tab_14"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.vfs]
listener.enable = true
listener.keystore.file_name = "$ref{keystore.tls.file_name}"
listener.keystore.type = "$ref{keystore.tls.type}"
listener.keystore.password = "$ref{keystore.tls.password}"
listener.keystore.key_password = "$ref{keystore.tls.key_password}"
listener.keystore.alias = "$ref{keystore.tls.alias}"
sender.enable = true
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.vfs]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB server to communicate through the VFS transport. Read more about file transfering in the ESB.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the VFS transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.key_password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.keystore.alias&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.alias}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-mail-transport-listener" class="anchor" aria-hidden="true" href="#mail-transport-listener"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>MAIL transport listener</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="15" type="checkbox" id="_tab_15"&gt;
            &lt;label class="tab-selector" for="_tab_15"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.mail.listener]
enable = true
name = "mailto"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.mail.listener]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB server to communicate through the MAIL transport. Read more about using the MAIL transport.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the MAIL transport listener in the ESB.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;mailto&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the MAIL transport listener in the ESB.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-mail-transport-sender" class="anchor" aria-hidden="true" href="#mail-transport-sender"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>MAIL transport sender</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="16" type="checkbox" id="_tab_16"&gt;
            &lt;label class="tab-selector" for="_tab_16"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.mail.sender]]
name = "mailto"
parameter.hostname = "smtp.gmail.com"
parameter.port = "587"
parameter.enable_tls = true
parameter.auth = true
parameter.username = "demo_user"
parameter.password = "mailpassword"
parameter.from = "demo_user@wso2.com"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.mail.sender]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB server to communicate through the MAIL transport. Read more about using the MAIL transport.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;mailto&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the MAIL transport sender in the ESB.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;smtp.gmail.com&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;587&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.enable_tls&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.auth&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;demo_user&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;mailpassword&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.from&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;demo_user@wso2.com&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-jms-transport-listener" class="anchor" aria-hidden="true" href="#jms-transport-listener"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>JMS transport listener</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="17" type="checkbox" id="_tab_17"&gt;
            &lt;label class="tab-selector" for="_tab_17"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.jms.listener]]

name = "myTopicListener"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.broker_name = "artemis"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "consumer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue"
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1s"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10s"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "1h"
parameter.reconnect_interval = "1h"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100ms"
parameter.consume_error_progression = "2.0"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.jms.listener]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB server to communicate through the JMS transport. Read more about using the JMS transport.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;myTopicListener&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.initial_naming_factory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.broker_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;artemis&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.provider_url&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;tcp://localhost:61616&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.connection_factory_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;TopicConnectionFactory&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.cache_level&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;consumer&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.naming_security_principal&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.naming_security_credential&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.transactionality&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.transaction_jndi_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.cache_user_transaction&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.session_transaction&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.session_acknowledgement&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;AUTO_ACKNOWLEDGE&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.jms_spec_version&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1.1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.destination&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.destination_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;queue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.default_reply_destination&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.default_destination_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;queue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.message_selector&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.subscription_durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.durable_subscriber_client_id&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.durable_subscriber_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.pub_sub_local&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.receive_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.concurrent_consumer&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_concurrent_consumer&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.idle_task_limit&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_message_per_task&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;-1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.initial_reconnection_duration&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reconnect_progress_factor&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;2&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_reconnect_duration&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1h&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reconnect_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1h&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_jsm_connection&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_consumer_error_retrieve_before_delay&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;20&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.consume_error_delay&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;100ms&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.consume_error_progression&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;2.0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-jms-transport-sender" class="anchor" aria-hidden="true" href="#jms-transport-sender"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>JMS transport sender</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="18" type="checkbox" id="_tab_18"&gt;
            &lt;label class="tab-selector" for="_tab_18"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.jms.sender]]

enable = true
name = "myTopicSender"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.broker_name = "artemis"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "producer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue" # queue/topic
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1s"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10s"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "1h"
parameter.reconnect_interval = "1h"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100ms"
parameter.consume_error_progression = "2.0"

parameter.vender_class_loader = false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.jms.sender]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB server to communicate through the JMS transport. Read more about using the JMS transport.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;myTopicSender&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.initial_naming_factory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.broker_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;artemis&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.provider_url&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;TopicConnectionFactory&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.connection_factory_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;topic&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.cache_level&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;producer&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.naming_security_principal&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.naming_security_credential&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.transactionality&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.transaction_jndi_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.cache_user_transaction&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.session_transaction&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.session_acknowledgement&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;AUTO_ACKNOWLEDGE&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.jms_spec_version&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1.1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.destination&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.destination_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;queue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.default_reply_destination&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.default_destination_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;queue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.message_selector&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.subscription_durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.durable_subscriber_client_id&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.durable_subscriber_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.pub_sub_local&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.receive_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.concurrent_consumer&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_concurrent_consumer&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.idle_task_limit&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_message_per_task&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;-1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.initial_reconnection_duration&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reconnect_progress_factor&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;2&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_reconnect_duration&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1h&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reconnect_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1h&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_jsm_connection&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.max_consumer_error_retrieve_before_delay&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;20&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.consume_error_delay&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;100ms&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.consume_error_progression&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;2.0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.vender_class_loader&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-jndi-connection-factories" class="anchor" aria-hidden="true" href="#jndi-connection-factories"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>JNDI connection factories</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="19" type="checkbox" id="_tab_19"&gt;
            &lt;label class="tab-selector" for="_tab_19"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.jndi.connection_factories]
QueueConnectionFactory = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"
TopicConnectionFactory = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.jndi.connection_factories]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;QueueConnectionFactory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;amqp://admin:admin@clientID/carbon?brokerlist=&amp;#39;tcp://localhost:5675&amp;#39;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;TopicConnectionFactory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;amqp://admin:admin@clientID/carbon?brokerlist=&amp;#39;tcp://localhost:5675&amp;#39;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-jndi-queues" class="anchor" aria-hidden="true" href="#jndi-queues"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>JNDI queues</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="20" type="checkbox" id="_tab_20"&gt;
            &lt;label class="tab-selector" for="_tab_20"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.jndi.queue]
JMSMS = "JMSMS"
StockQuotesQueue = "StockQuotesQueue"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.jndi.queue]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            ......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;JMSMS&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;JMSMS&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;StockQuotesQueue&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;StockQuotesQueue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-jndi-topics" class="anchor" aria-hidden="true" href="#jndi-topics"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>JNDI topics</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="21" type="checkbox" id="_tab_21"&gt;
            &lt;label class="tab-selector" for="_tab_21"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.jndi.topic]
MyTopic = "example.MyTopic"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.jndi.topic]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            This.......
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt; MyTopic&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;example.MyTopic&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-rabbitmq-listener" class="anchor" aria-hidden="true" href="#rabbitmq-listener"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>RabbitMQ listener</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="22" type="checkbox" id="_tab_22"&gt;
            &lt;label class="tab-selector" for="_tab_22"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.rabbitmq.listener]]

name = "rabbitMQListener"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.connection_factory = ""
parameter.exchange_name = "amq.direct"
parameter.queue_name = "MyQueue"
parameter.queue_auto_ack = false
parameter.consumer_tag = ""
parameter.channel_consumer_qos = ""
parameter.durable = ""
parameter.queue_exclusive = ""
parameter.queue_auto_delete = ""
parameter.queue_routing_key = ""
parameter.queue_auto_declare = ""
parameter.exchange_auto_declare = ""
parameter.exchange_type = ""
parameter.exchange_durable = ""
parameter.exchange_auto_delete = ""
parameter.message_content_type = ""

parameter.retry_interval = "10s"
parameter.retry_count = 5

parameter.ssl_enable = true
parameter.ssl_version = "SSL"
parameter.keystore_file_name ="$ref{keystore.tls.file_name}"
parameter.keystore_type = "$ref{keystore.tls.type}"
parameter.keystore_password = "$ref{keystore.tls.password}"
parameter.truststore_file_name ="$ref{truststore.file_name}"
parameter.truststore_type = "$ref{truststore.type}"
parameter.truststore_password = "$ref{truststore.password}"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.rabbitmq.listener]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The.....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;localhost&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The IP address of the server node.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;5672&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;guest&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;guest&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.connection_factory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;amq.direct&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;MyQueue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_auto_ack&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.consumer_tag&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.channel_consumer_qos&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_exclusive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_auto_delete&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_routing_key&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_auto_declare&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_auto_declare&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_auto_delete&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.default_destination_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.retry_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.retry_count&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;5&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.ssl_enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.ssl_version&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;SSL&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.keystore_file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.keystore_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.keystore_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.truststore_file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.truststore_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.truststore_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-rabbitmq-sender" class="anchor" aria-hidden="true" href="#rabbitmq-sender"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>RabbitMQ sender</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="23" type="checkbox" id="_tab_23"&gt;
            &lt;label class="tab-selector" for="_tab_23"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[transport.rabbitmq.sender]]

name = "rabbitMQSender"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.exchange_name = "amq.direct"
parameter.routing_key = "MyQueue"
parameter.reply_to_name = ""
parameter.queue_delivery_mode = 1 # 1/2
parameter.exchange_type = ""
parameter.queue_name = "MyQueue"
parameter.queue_durable = false
parameter.queue_exclusive = false
parameter.queue_auto_delete = false
parameter.exchange_durable = ""
parameter.queue_auto_declare = ""
parameter.exchange_auto_declare = ""
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[transport.rabbitmq.sender]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;rabbitMQSender&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;localhost&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The IP address of the server node.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;5672&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;guest&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;guest&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;amq.direct&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.routing_key&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;MyQueue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;MyQueue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reply_to_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_delivery_mode&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;MyQueue&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.reply_to_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_delivery_mode&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_exclusive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_auto_delete&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_durable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.queue_auto_declare&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.exchange_auto_declare&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;.....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-fix-transport" class="anchor" aria-hidden="true" href="#fix-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>FIX transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="24" type="checkbox" id="_tab_24"&gt;
            &lt;label class="tab-selector" for="_tab_24"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.ws]

[transport.fix]
listener.enabled=false
sender.enabled=false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.fix]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml to group the parameters that configure the ESB server to communicate through the FIX transport. Read more about how the ESB uses FIX communication.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the FIX transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the FIX transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-mqtt-transport" class="anchor" aria-hidden="true" href="#mqtt-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>MQTT transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="25" type="checkbox" id="_tab_25"&gt;
            &lt;label class="tab-selector" for="_tab_25"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.mqtt]

listener.enable = false
listener.parameter.hostname = "$ref{server.hostname}"
listener.parameter.connection_factory = "mqttConFactory"
listener.parameter.server_port = 1883
listener.parameter.client_id = "client-id-1234"
listener.parameter.topic_name = "esb.test"

# not reqired parameter list
listener.parameter.subscription_qos = 0
listener.parameter.session_clean = false
listener.parameter.enable_ssl = false
listener.parameter.subscription_username = ""
listener.parameter.subscription_password = ""
listener.parameter.temporary_store_directory = ""
listener.parameter.blocking_sender = false
listener.parameter.connect_type = "text/plain"
listener.parameter.message_retained = false

sender.enable = false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[server]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The.....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the MQTT transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.connection_factory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;mqttConFactory&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.server_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1883&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.client_id&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;client-id-1234&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.topic_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;esb.test&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.subscription_qos&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.session_clean&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.enable_ssl&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.subscription_username&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.subscription_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.temporary_store_directory&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.blocking_sender&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.connect_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;text/plain&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.parameter.message_retained&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-hl7-transport" class="anchor" aria-hidden="true" href="#hl7-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>HL7 transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="26" type="checkbox" id="_tab_26"&gt;
            &lt;label class="tab-selector" for="_tab_26"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.hl7]

listener.enable = false
listener.port = 9292

sender.enable = false
sender.non_blocking = true
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.hl7]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to group the parameters that configure the ESB server communicate through the HL7 transport. Read more about HL7 communication in the ESB.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the HL7 transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;9292&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The port of the HL7 transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the HL7 transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.non_blocking&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-hl7-inbound-endpoint-tuning" class="anchor" aria-hidden="true" href="#hl7-inbound-endpoint-tuning"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>HL7 Inbound Endpoint Tuning</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="27" type="checkbox" id="_tab_27"&gt;
            &lt;label class="tab-selector" for="_tab_27"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[....]
hl7_id_generator = "file"
worker_threads_core = 100
io_thread_count = 2
so_timeout =  0
connect_timeout = 0
so_keep_alive = "true"
so_rcvbuf = 0
so_sndbuf = 0
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[..]]&lt;/code&gt;
                        
                        &lt;p&gt;
                            This config heading groups the parameters for tuning an HL7 inbound endpoint.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;hl7_id_generator &lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;file&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;file&amp;quot;, or &amp;quot;UUID&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;By default the HAPI HL7 parsing library uses a file based ID generator to generate unique control IDs. To use a UUID based ID generator you can change this to ‘uuid’.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;worker_threads_core&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;100&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines the HL7 inbound worker thread pool size.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;io_thread_count&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;2&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines the number of IO threads the IO Reactor uses. It is recommended to set this to the number of cores on the machine.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;so_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines TCP socket timeout.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;connect_timeout&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines the TCP connect timeout.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;so_keep_alive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines TCP socket keep alive.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;so_rcvbuf&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0 (Uses OS default. Maximum value depends on OS settings)&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines the TCP socket receive buffer size.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;so_sndbuf&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;0 (Uses OS default. Maximum value depends on OS settings)&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;0..9&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Defines the TCP socket send buffer size.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-sap-transport" class="anchor" aria-hidden="true" href="#sap-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>SAP transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="28" type="checkbox" id="_tab_28"&gt;
            &lt;label class="tab-selector" for="_tab_28"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.sap]
listener.enabled=false
sender.enabled=false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.sap]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters that configure the ESB to communicate with a SAP system. Read more about SAP integration of the ESB.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling SAP transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.idoc.class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.wso2.carbon.transports.sap.SAPTransportListener&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.bapi.class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.wso2.carbon.transports.sap.SAPTransportListener&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the SAP transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.idoc.class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.wso2.carbon.transports.sap.SAPTransportSender&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The ......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.bapi.class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;org.wso2.carbon.transports.sap.SAPTransportSender&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The ......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-msmq-transport" class="anchor" aria-hidden="true" href="#msmq-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>MSMQ transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="29" type="checkbox" id="_tab_29"&gt;
            &lt;label class="tab-selector" for="_tab_29"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.msmq]

listener.enable = false
listener.hostname = "$ref{server.hostname}"
sender.enable = false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.msmq]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The.....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling MSMQ transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The......&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-tcp-transport" class="anchor" aria-hidden="true" href="#tcp-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>TCP transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="30" type="checkbox" id="_tab_30"&gt;
            &lt;label class="tab-selector" for="_tab_30"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.tcp]
listener.enable = false
listener.port = 8000
listener.hostname = "$ref{server.hostname}"
listener.content_type = ["application/xml"]
listener.response_client = true
sender.enable = true
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.tcp]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The..
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the TCP transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;8000&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.content_type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;[&amp;quot;application/xml&amp;quot;]&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.response_client&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the TCP transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-websocket-transport" class="anchor" aria-hidden="true" href="#websocket-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Websocket transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="31" type="checkbox" id="_tab_31"&gt;
            &lt;label class="tab-selector" for="_tab_31"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.ws]

sender.enable = false
sender.parameter.outflow_dispatch_sequence = "outflowDispatchSeq"
sender.parameter.outflow_dispatch_fault_sequence = "outflowFaultSeq"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.ws]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The....
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the websocket transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.parameter.outflow_dispatch_sequence&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;outflowDispatchSeq&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.parameter.outflow_dispatch_fault_sequence&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;outflowFaultSeq&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-secure-websocket-transport" class="anchor" aria-hidden="true" href="#secure-websocket-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Secure Websocket transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="32" type="checkbox" id="_tab_32"&gt;
            &lt;label class="tab-selector" for="_tab_32"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.wss]

sender.enable = false
sender.parameter.outflow_dispatch_sequence = "outflowDispatchSeq"
sender.parameter.outflow_dispatch_fault_sequence = "outflowFaultSeq"
sender.truststore_location = "$ref{truststore.file_name}"
sender.truststore_password = "$ref{truststore.password}"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.wss]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The...
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the websocket secured transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.parameter.outflow_dispatch_sequence&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;outflowDispatchSeq&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.parameter.outflow_dispatch_fault_sequence&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;outflowFaultSeq&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.truststore_location&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.truststore_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-udp-transport" class="anchor" aria-hidden="true" href="#udp-transport"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>UDP transport</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="33" type="checkbox" id="_tab_33"&gt;
            &lt;label class="tab-selector" for="_tab_33"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[transport.udp]

listener.enable = false
sender.enable =false
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[transport.udp]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            The...
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;listener.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the UDP transport listener.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;sender.enabled&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The parameter for enabling the UDP transport sender.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-custom-transport-listener" class="anchor" aria-hidden="true" href="#custom-transport-listener"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Custom transport listener</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="34" type="checkbox" id="_tab_34"&gt;
            &lt;label class="tab-selector" for="_tab_34"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[custom_transport.listener]]
class=""
protocol = "ISO8583"
parameter.port = 8081
parameter.hostname = "$ref{server.node_ip}"
parameter.non-blocking = true
parameter.bind-address = "$ref{server.hostname}"
parameter.WSDLEPRPrefix = "$ref{server.hostname}"  # inferred

keystore.file_name = "$ref{keystore.tls.file_name}"
keystore.type = "$ref{keystore.tls.type}"
keystore.password = "$ref{keystore.tls.password}"
keystore.key_password = "$ref{keystore.tls.key_password}"
truststore.file_name = "$ref{truststore.file_name}"
truststore.type = "$ref{truststore.type}"
truststore.password = "$ref{truststore.password}"

ssl_profile.file_path= "conf/sslprofiles/listenerprofiles.xml"
ssl_profile.read_interval = "30s"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[custom_transport.listener]]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            This config heading is used to group the parameters for a custom transport implementation that you want to use in your product.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;protocol&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;ISO8583&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;8081&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.node_ip}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.non-blocking&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;, or &amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.bind-address&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.WSDLEPRPrefix&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.hostname}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.key_password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;ssl_profile.file_path&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;conf/sslprofiles/listenerprofiles.xml&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;ssl_profile.read_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;30s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-custom-transport-sender" class="anchor" aria-hidden="true" href="#custom-transport-sender"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Custom transport sender</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="35" type="checkbox" id="_tab_35"&gt;
            &lt;label class="tab-selector" for="_tab_35"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[[custom_transport.sender]]
class=""
protocol = "ISO8583"
parameter.hostname = ""
parameter.port = ""
parameter.non_proxy_host = ""
parameter.non_blocking = true

keystore.file_name = "$ref{keystore.tls.file_name}"
keystore.type = "$ref{keystore.tls.type}"
keystore.password = "$ref{keystore.tls.password}"
keystore.key_password = "$ref{keystore.tls.key_password}"
truststore.file_name = "$ref{truststore.file_name}"
truststore.type = "$ref{truststore.type}"
truststore.password = "$ref{truststore.password}"

ssl_profile.file_path = "conf/sslprofiles/senderprofiles.xml"
ssl_profile.read_interval = "30s"
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[[custom_transport.sender]]]&lt;/code&gt;
                        
                        &lt;p&gt;
                            This config heading is used to group the parameters for a custom transport implementation that you want to use in your product.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;class&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;protocol&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;ISO8583&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;8081&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.hostname&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{server.node_ip}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.non-blocking&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;parameter.non_proxy_host&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;keystore.key_password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{keystore.tls.key_password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.file_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.file_name}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.type&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.type}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;truststore.password&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;$ref{truststore.password}&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;ssl_profile.file_path&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;conf/sslprofiles/senderprofiles.xml&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;ssl_profile.read_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;30s&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The....&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
<h2><a id="user-content-mediation-process" class="anchor" aria-hidden="true" href="#mediation-process"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Mediation process</h2>
<div>
    
        <div>
            <div>
<pre><code>        &lt;input name="36" type="checkbox" id="_tab_36"&gt;
            &lt;label class="tab-selector" for="_tab_36"&gt;&lt;i class="icon fa fa-code"&gt;&lt;/i&gt;&lt;/label&gt;
            &lt;div class="superfences-content"&gt;
                &lt;div class="mb-config-example"&gt;
</code></pre>
<pre><code>[mediation]
synapse.core_threads = 20
synapse.max_threads = 100
synapse.threads_queue_length = 10

synapse.global_timeout_interval = "120000ms"

synapse.enable_xpath_dom_failover=true
synapse.temp_data_chunk_size=3072

synapse.command_debugger_port=9005
synapse.event_debugger_port=9006

synapse.script_mediator_pool_size=15
synapse.enable_xml_nil=false
synapse.disable_auto_primitive_regex = "^-?(0|[1-9][0-9]*)(\\.[0-9]+)?([eE][+-]?[0-9]+)?$"
synapse.disable_custom_replace_regex = "@@@"
synapse.enable_namespace_declaration = false
synapse.build_valid_nc_name = false
synapse.enable_auto_primitive = false
synapse.json_out_auto_array = false
synapse.preserve_namespace_on_xml_to_json=false
flow.statistics.enable=false
flow.statistics.capture_all=false
statistics.enable_clean=true
statistics.clean_interval = "1000ms"
flow.statistics.tracer.collect_payloads=false
flow.statistics.tracer.collect_properties=false
inbound.core_threads = 20
inbound.max_threads = 100
</code></pre>
<pre><code>                &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="doc-wrapper"&gt;
                &lt;div class="mb-config"&gt;
                    &lt;div class="config-wrap"&gt;
                        &lt;code&gt;[[mediation]]&lt;/code&gt;
                        &lt;span class="badge-required"&gt;Required&lt;/span&gt;
                        &lt;p&gt;
                            Add this config heading to the ei.toml file to group the parameters for tuning the mediation process (Synapse engine) of the ESB. These parameters are mainly used when mediators such as Iterate and Clone (which leverage on internal thread pools) are used.
                        &lt;/p&gt;
                    &lt;/div&gt;
                    &lt;div class="params-wrap"&gt;
                        &lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.core_threads&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;20&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The initial number of synapse threads in the pool. This parameter is applicable only if the Iterate or the Clone mediator is used to handle a higher load. These mediators use a thread pool to create new threads when processing messages and sending messages in parallal. You can configure the size of the thread pool by this parameter. The number of threads specified via this parameter should be increased as required to balance an increased load. Increasing the value specified for this parameter results in higher performance of the Iterate and Clone mediators.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.max_threads&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;100&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The maximum number of synapse threads in the pool. This parameter is applicable only if the Iterate or the Clone mediator is used to handle a higher load. The number of threads specified for this parameter should be increased as required to balance an increased load.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.threads_queue_length&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;10&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The length of the queue that is used to hold the runnable tasks to be executed by the pool. This parameter is applicable only if the Iterate or the Clone mediator is used to handle a higher load.&lt;/br&gt; You can specify a finite value as the queue length by giving any positive number. If this parameter is set to (-1) it means that the task queue length is infinite. If the queue length is finite there can be situations where requests are rejected when the task queue is full, and all the cores are occupied. If the queue length is infinite, and if some thread locking happens, the server can go out of memory. Therefore, you need to decide on an optimal value based on the actual load.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.threads.keepalive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;....&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The keep-alive time for idle threads in milliseconds. Once this time has elapsed for an idle thread, it will be destroyed. This parameter is applicable only if the Iterate or the Clone mediator is used to handle a high load.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.global_timeout_interval_millis&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;120000&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The maximum number of milliseconds within which a response for the request should be received. A response which arrives after the specified number of seconds cannot be correlated with the request. Hence, a warning all be logged and the request will be dropped. This parameter is also referred to as the time-out handler.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.enable_xpath_dom_failover&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If this parameter is set to true , it will be possible for ESB to switch to xpath 2.0. The default value for this parameter is false since xpath 2.0 evaluations can cause performance degradation. WSO2 EI uses the Saxon Home Edition in implementing XPATH 2.0 functionalities, and thus supports all the functions that are shipped with it. For more information on the supported functions, see Saxon Documentation.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.temp_data_chunk_size&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;3072&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The message size that can be processed by the ESB server.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.command_debugger_port&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;9005&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.script_mediator_pool_size&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;15&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;When using externally referenced scripts, this parameter is used to specify the size of the script engine pool to be used per script mediator. The script engines from this pool are used for externally referenced script execution where updates to external scripts on an engine currently in use may otherwise not be thread safe. It is recommended to keep this value at a reasonable size since there will be a pool per externally referenced script.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.enable_xml_nil&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.disable_auto_primitive_regex&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;^-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?$&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.disable_custom_replace_regex&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;@@@&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.. &lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.enable_namespace_declaration&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The.. &lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.build_valid_nc_name&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.enable_auto_primitive&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.json_out_auto_array&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;synapse.preserve_namespace_on_xml_to_json&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Preserves the namespace declarations in the JSON output in XML to JSON transformations.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;flow.statistics.enable&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Set this property to true and enable statistics for the required ESB artifact, to record information such as the following. &lt;ul&gt;&lt;li&gt;The time spent on each mediator.&lt;/li&gt;&lt;li&gt;The time spent to process each message.&lt;/li&gt;&lt;li&gt;The fault count of a single message flow.&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;flow.statistics.capture_all&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Set this property to true and set the mediation.flow.statistics.enable property also to true, to enable mediation statistics for all the artifacts in the ESB profile by default. If you set this property to false, you need to set the mediation.flow.statistics.enable property to true and manually enable statistics for the required ESB artifact.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;statistics.enable_clean&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;true&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;If this parameter is set to true, all the existing statistics would be cleared before processing a request. This is recommended if you want to increase the processing speed.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;statistics.clean_interval&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; string &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;1000ms&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;..&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The..&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;flow.statistics.tracer.collect_payload&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Set this property to true and enable tracing for the required ESB artifact, to record the message payload before and after the mediation performed by individual mediators.&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;flow.statistics.tracer.collect_properties&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; boolean &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;false&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;&amp;quot;true&amp;quot;,&amp;quot;false&amp;quot;&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;Set this property to true and enable tracing for the required ESB artifact, to record the following information. &lt;ul&gt;&lt;li&gt;Message context properties.&lt;/li&gt;&lt;li&gt;Message transport-scope properties.&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;inbound.core_threads&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;20&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;&lt;div class="param"&gt;
                            &lt;div class="param-name"&gt;
                              &lt;span class="param-name-wrap"&gt; &lt;code&gt;inbound.max_threads&lt;/code&gt; &lt;/span&gt;
                            &lt;/div&gt;
                            &lt;div class="param-info"&gt;
                                &lt;div&gt;
                                    &lt;p&gt;
                                        &lt;span class="param-type string"&gt; integer &lt;/span&gt;
                                        
                                    &lt;/p&gt;
                                    &lt;div class="param-default"&gt;
                                        &lt;span class="param-default-value"&gt;Default: &lt;code&gt;100&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                    &lt;div class="param-possible"&gt;
                                        &lt;span class="param-possible-values"&gt;Possible Values: &lt;code&gt;...&lt;/code&gt;&lt;/span&gt;
                                    &lt;/div&gt;
                                &lt;/div&gt;
                                &lt;div class="param-description"&gt;
                                    &lt;p&gt;The...&lt;/p&gt;
                                &lt;/div&gt;
                            &lt;/div&gt;
                        &lt;/div&gt;
                    &lt;/div&gt;
                &lt;/div&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/section&gt;
</code></pre>
</div>
</div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></div></article>
  </div>

    </div>

  

  <details class="details-reset details-overlay details-overlay-dark">
    <summary data-hotkey="l" aria-label="Jump to line"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast linejump" aria-label="Jump to line">
      <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="js-jump-to-line-form Box-body d-flex" action="" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
        <input class="form-control flex-auto mr-3 linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
        <button type="submit" class="btn" data-close-dialog>Go</button>
</form>    </details-dialog>
  </details>



  </div>
</div>

    </main>
  </div>
  

  </div>

        
<div class="footer container-lg width-full p-responsive" role="contentinfo">
  <div class="position-relative d-flex flex-row-reverse flex-lg-row flex-wrap flex-lg-nowrap flex-justify-center flex-lg-justify-between pt-6 pb-2 mt-6 f6 text-gray border-top border-gray-light ">
    <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
      <li class="mr-3 mr-lg-0">&copy; 2019 <span title="0.62819s from unicorn-8675b6897d-bmnb4">GitHub</span>, Inc.</li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to terms, text:terms" href="https://github.com/site/terms">Terms</a></li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to privacy, text:privacy" href="https://github.com/site/privacy">Privacy</a></li>
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to security, text:security" href="https://github.com/security">Security</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://githubstatus.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
        <li><a data-ga-click="Footer, go to help, text:help" href="https://help.github.com">Help</a></li>
    </ul>

    <a aria-label="Homepage" title="GitHub" class="footer-octicon d-none d-lg-block mx-lg-4" href="https://github.com">
      <svg height="24" class="octicon octicon-mark-github" viewBox="0 0 16 16" version="1.1" width="24" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>
   <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
        <li class="mr-3 mr-lg-0"><a data-ga-click="Footer, go to contact, text:contact" href="https://github.com/contact">Contact GitHub</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.com/pricing" data-ga-click="Footer, go to Pricing, text:Pricing">Pricing</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a data-ga-click="Footer, go to about, text:about" href="https://github.com/about">About</a></li>

    </ul>
  </div>
  <div class="d-flex flex-justify-center pb-6">
    <span class="f6 text-gray-light"></span>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error">
    <svg class="octicon octicon-alert" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.893 1.5c-.183-.31-.52-.5-.887-.5s-.703.19-.886.5L.138 13.499a.98.98 0 0 0 0 1.001c.193.31.53.501.886.501h13.964c.367 0 .704-.19.877-.5a1.03 1.03 0 0 0 .01-1.002L8.893 1.5zm.133 11.497H6.987v-2.003h2.039v2.003zm0-3.004H6.987V5.987h2.039v4.006z"/></svg>
    <button type="button" class="flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg class="octicon octicon-x" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48L7.48 8z"/></svg>
    </button>
    You can’t perform that action at this time.
  </div>


    
    <script crossorigin="anonymous" integrity="sha512-6ds1nmSieMZVJUz/Lg1/PhdizfysNwmo+T94e9p4BT3M6jtP8m1Hi/Slym0TJQpUW/rjhG8FWutX5JkiKF69CQ==" type="application/javascript" src="https://github.githubassets.com/assets/frameworks-8b4af415.js"></script>
    
    <script crossorigin="anonymous" async="async" integrity="sha512-i7Fnzhn9vNYtInnoi+GE4HOgQt1Wj/GUXZg4zDMJuUYp2wkswEwg9mpT2EA6caO5OU+yLyNxBxX3ZRp68snVLA==" type="application/javascript" src="https://github.githubassets.com/assets/github-bootstrap-b012f3cd.js"></script>
    
    
    
  <div class="js-stale-session-flash stale-session-flash flash flash-warn flash-banner" hidden
    >
    <svg class="octicon octicon-alert" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M8.893 1.5c-.183-.31-.52-.5-.887-.5s-.703.19-.886.5L.138 13.499a.98.98 0 0 0 0 1.001c.193.31.53.501.886.501h13.964c.367 0 .704-.19.877-.5a1.03 1.03 0 0 0 .01-1.002L8.893 1.5zm.133 11.497H6.987v-2.003h2.039v2.003zm0-3.004H6.987V5.987h2.039v4.006z"/></svg>
    <span class="signed-in-tab-flash">You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="signed-out-tab-flash">You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
  <template id="site-details-dialog">
  <details class="details-reset details-overlay details-overlay-dark lh-default text-gray-dark hx_rsm" open>
    <summary role="button" aria-label="Close dialog"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast hx_rsm-dialog hx_rsm-modal">
      <button class="Box-btn-octicon m-0 btn-octicon position-absolute right-0 top-0" type="button" aria-label="Close dialog" data-close-dialog>
        <svg class="octicon octicon-x" viewBox="0 0 12 16" version="1.1" width="12" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48L7.48 8z"/></svg>
      </button>
      <div class="octocat-spinner my-6 js-details-dialog-spinner"></div>
    </details-dialog>
  </details>
</template>

  <div class="Popover js-hovercard-content position-absolute" style="display: none; outline: none;" tabindex="0">
  <div class="Popover-message Popover-message--bottom-left Popover-message--large Box box-shadow-large" style="width:360px;">
  </div>
</div>

  <div aria-live="polite" class="js-global-screen-reader-notice sr-only"></div>

  </body>
</html>

