---
template: templates/redoc.html
---

<div id="redoc-container"></div>
<script src="https://cdn.redoc.ly/redoc/latest/bundles/redoc.standalone.js"></script>
<script>
	// Use explicit container mounting to avoid custom-element double mount/removeChild issues
	(function() {
		var specUrl = '../devops-v0.yaml';
		var container = document.getElementById('redoc-container');
		// Basic options; tweak as needed
		var options = {
			scrollYOffset: 60,
			hideDownloadButton: false,
			expandResponses: '200,201',
		};
		// Initialize ReDoc
		Redoc.init(specUrl, options, container);
	})();
</script>