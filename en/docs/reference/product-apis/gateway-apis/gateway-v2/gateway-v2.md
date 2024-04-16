---
template: templates/redoc.html
---

<div>
    <redoc id="redoc"></redoc>
</div>
<script>
    var swaggerFile = "{{base_path}}/reference/product-apis/gateway-apis/gateway-v2/gateway-v2.yaml";
    var redocTag = document.getElementById("redoc");
    redocTag.setAttribute("spec-url", swaggerFile + window.location.search);
</script>
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
