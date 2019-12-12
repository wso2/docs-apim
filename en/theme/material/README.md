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

### How to generate files related to search optimizations

1. Clone https://github.com/squidfunk/mkdocs-material (tag `4.5.1`)
2. Make this change.

```
diff --git a/src/assets/javascripts/components/Material/Search/Result.jsx b/src/assets/javascripts/components/Material/Search/Result.jsx
index 4c876de..0b4b250 100644
--- a/src/assets/javascripts/components/Material/Search/Result.jsx
+++ b/src/assets/javascripts/components/Material/Search/Result.jsx
@@ -229,7 +229,7 @@ export default class Result {
           }

           /* Index fields */
-          this.field("title", { boost: 10 })
+          this.field("title", { boost: 100 })
           this.field("text")
           this.ref("location")

@@ -286,7 +286,12 @@ export default class Result {
             .filter(Boolean)
             .forEach(term => {
               query.term(term, { wildcard: lunr.Query.wildcard.TRAILING })
-            })
+              query.term(term, {
+                fields: ["title"],
+                boost: 200,
+                usePipeline: false
+              })
+           })
         })
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




