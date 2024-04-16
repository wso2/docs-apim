---
template: templates/redoc.html
---

<div>
    <redoc id="redoc"></redoc>
</div>
<script>
    var swaggerFile = "{{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/service-catalog-v1.yaml";
    var redocTag = document.getElementById("redoc");
    redocTag.setAttribute("spec-url", swaggerFile + window.location.search);
</script>
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
