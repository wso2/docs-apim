---
template: templates/redoc.html
---

<div>
    <redoc id="redoc"></redoc>
</div>
<script>
    var swaggerFile = "{{base_path}}/reference/product-apis/devops-apis/devops-v0/devops-v0.yaml";
    var redocTag = document.getElementById("redoc");
    redocTag.setAttribute("spec-url", swaggerFile + window.location.search);
</script>
<script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
