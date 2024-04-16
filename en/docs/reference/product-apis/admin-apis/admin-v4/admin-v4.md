---
template: templates/redoc.html
---

<div>
    <redoc id="redoc"></redoc>
</div>
<script>
    var swaggerFile = "{{base_path}}/reference/product-apis/admin-apis/admin-v4/admin-v4.yaml";
    var redocTag = document.getElementById("redoc");
    redocTag.setAttribute("spec-url", swaggerFile + window.location.search);
</script>
<script src="https://cdn.redoc.ly/redoc/latest/bundles/redoc.standalone.js"> </script>
