# Customizations done to the `material` theme

## Layout, text, and image changes

```
images/favicon.png
images/logo.svg
main.html
templates/no-nav.html
templates/swagger.html
templates/2-column.html
templates/single-column.html
partials/nav-item.html
partials/toc.html
partials/tabs.html
partials/language/en.html
partials/footer.html
partials/header.html
partials/tabs-item.html
partials/nav.html
```

## Search optimizations (note: the following are generated files)

```
base.html
assets/javascripts/application.c3ee3888.js
assets/javascripts/modernizr.268332fc.js
assets/stylesheets/application.1b62728e.css
assets/stylesheets/application-palette.a8b3c06d.css
```

### How to patch the mkdocs-material theme to apply search optimizations

1. Clone https://github.com/squidfunk/mkdocs-material (tag `4.5.1`)
2. Apply following diffs

   - Boost title weight in search score [related commit](https://github.com/tmkasun/mkdocs-material/commit/d46be032bea6c84c996f6308c743277a2ad1a060)

```diff
diff --git a/src/assets/javascripts/components/Material/Search/Result.jsx b/src/assets/javascripts/components/Material/Search/Result.jsx
index 97a2f63e..0f54ae56 100644
--- a/src/assets/javascripts/components/Material/Search/Result.jsx
+++ b/src/assets/javascripts/components/Material/Search/Result.jsx
@@ -293,15 +293,14 @@ export default class Result {

         /* Append trailing wildcard to all terms for prefix querying */
         .query(query => {
+          query.term(this.value_, { usePipeline: false,
+            fields: ["title"], boost: 200,
+            wildcard: lunr.Query.wildcard.TRAILING })
           this.value_.toLowerCase().split(" ")
             .filter(Boolean)
             .forEach(term => {
-              query.term(term, { wildcard: lunr.Query.wildcard.TRAILING })
-              query.term(term, {
-                fields: ["title"],
-                boost: 200,
-                usePipeline: false
-              })
+              query.term(term, { fields: ["text"],
+                boost: 1 })
             })
         })
```


    - Add a loader [related commit](https://github.com/tmkasun/mkdocs-material/commit/3e92e6cd0c72bbee571cacd6941c87d25e3dd6aa)

```diff
diff --git a/src/assets/javascripts/application.js b/src/assets/javascripts/application.js
index 1962eea7..b3203a57 100644
--- a/src/assets/javascripts/application.js
+++ b/src/assets/javascripts/application.js
@@ -281,10 +281,12 @@ function initialize(config) { // eslint-disable-line func-style
         new Material.Search.Lock("[data-md-toggle=search]")))

     /* Component: search results */
+    fetch(`${config.url.base}/search/search_index.json`)
     new Material.Event.Listener("[data-md-component=query]", [
       "focus", "keyup", "change"
     ], new Material.Search.Result("[data-md-component=result]", () => {
       return fetch(`${config.url.base}/search/search_index.json`, {
+        cache: "force-cache",
         credentials: "same-origin"
       }).then(response => response.json())
         .then(data => {
diff --git a/src/assets/javascripts/components/Material/Search/Result.jsx b/src/assets/javascripts/components/Material/Search/Result.jsx
index 4c876de5..889a8ff2 100644
--- a/src/assets/javascripts/components/Material/Search/Result.jsx
+++ b/src/assets/javascripts/components/Material/Search/Result.jsx
@@ -161,9 +161,20 @@ export default class Result {

     /* Initialize index, if this has not be done yet */
     if (ev.type === "focus" && !this.index_) {
+      document.querySelector(".md-search__icon").classList
+        .add("md-search-loader")
+      if (this.isInitializing) {
+        return
+      } else {
+        this.isInitializing = true
+      }
+      this.meta_.textContent = "Please wait while loading the indexes . . ."

       /* Initialize index */
       const init = data => {
+        document.querySelector(".md-search__icon").classList
+          .remove("md-search-loader")
+        this.meta_.textContent = this.message_.placeholder

         /* Preprocess and index sections and documents */
         this.docs_ = data.reduce((docs, doc) => {
diff --git a/webpack.config.js b/webpack.config.js
index aa273d2f..e0d7d785 100644
--- a/webpack.config.js
+++ b/webpack.config.js
@@ -255,20 +255,10 @@ module.exports = (_env, args) => { // eslint-disable-line complexity
     },

     /* Sourcemaps */
-    devtool: args.mode !== "production" ? "inline-source-map" : "",
+    devtool: "source-map",

     /* Optimizations */
     optimization: {
-      minimizer: [
-        new UglifyJsPlugin({
-          uglifyOptions: {
-            output: {
-              comments: /^!/
-            }
-          }
-        }),
-        new OptimizeCSSAssetsPlugin()
-      ],
       splitChunks: {
         cacheGroups: {
           commons: {
```

3. Run `npm run build`

4. Remove the following files from `docs-apim/en/` in your `https://github.com/wso2/docs-apim` clone.

```
theme/material/assets/javascripts/application.*.js
theme/material/assets/javascripts/modernizr.*.js
theme/material/assets/stylesheets/application-palette.*.css
theme/material/assets/stylesheets/application.*.css
theme/material/base.html
```

5. Copy the the new files back to your `docs-apim` clone from the `mkdocs-material` clone you built at step 3.

```
material/assets/javascripts/application.*.js
material/assets/javascripts/modernizr.*.js
material/assets/stylesheets/application*
material/base.html
```
# Customizations done to the top navigation tabs-item.html for navigation seperation

Top navigation seperation is achieved through matching the titles of pages which are on the right.
If titles needs to be changed in right floted nav links, tabs-item.html has to be changed as well.
