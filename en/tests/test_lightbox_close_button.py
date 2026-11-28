import pathlib
import unittest


ROOT = pathlib.Path(__file__).resolve().parents[1]
THEME_JS = ROOT / "docs" / "assets" / "js" / "theme.js"
THEME_CSS = ROOT / "theme" / "material" / "assets" / "css" / "theme.css"


class LightboxCloseButtonTests(unittest.TestCase):
    def test_theme_enhances_glightbox_close_button(self):
        js = THEME_JS.read_text(encoding="utf-8")
        self.assertIn("glightbox-close-label", js)
        self.assertIn("Close image", js)

    def test_theme_styles_glightbox_close_button(self):
        css = THEME_CSS.read_text(encoding="utf-8")
        self.assertIn(".glightbox-container .gclose", css)
        self.assertIn("border-radius: 999px", css)


if __name__ == "__main__":
    unittest.main()
