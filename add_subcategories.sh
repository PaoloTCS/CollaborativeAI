#!/bin/bash
# add_subcategories.sh
# Creates a simple static site with a home page + Medical/Legal/Investment sub-pages.

set -e
cd "$(dirname "$0")"

# Paths
PUB="public"
IMG="$PUB/images"
CSS="$PUB/styles.css"
JS="$PUB/app.js"
LOGO_SRC="CollaborativeAI_Logo_gpt_1.png"
LOGO="$IMG/CollaborativeAI_Logo_gpt_1.png"

mkdir -p "$IMG"

# Copy logo if present
if [ -f "$LOGO_SRC" ]; then
  cp "$LOGO_SRC" "$LOGO"
  echo "✅ Copied logo to $LOGO"
else
  echo "⚠️ $LOGO_SRC not found in project root. Place your logo there and re-run if needed."
fi

# Shared CSS
cat > "$CSS" <<'CSS'
:root{
  --ink:#213547; --muted:#667; --bg:#f9fafc;
  --brand1:#667eea; --brand2:#764ba2;
}
*{box-sizing:border-box}
body{margin:0;font-family:system-ui,-apple-system,Segoe UI,Roboto,Inter,sans-serif;color:var(--ink);background:var(--bg)}
.container{max-width:1100px;margin:0 auto;padding:2rem 1rem}
header{display:flex;align-items:center;gap:1rem;justify-content:space-between;padding:1rem 0}
.brand{display:flex;align-items:center;gap:.75rem;text-decoration:none;color:inherit}
.brand img{height:48px;width:auto}
.brand h1{margin:0;font-size:1.25rem;background:linear-gradient(90deg,var(--brand1),var(--brand2));-webkit-background-clip:text;-webkit-text-fill-color:transparent}
nav a{margin-left:1rem;text-decoration:none;color:var(--ink);font-weight:600}
nav a:hover{color:var(--brand1)}
nav a.active{color:var(--brand2)}
.hero{padding:3rem 1rem;text-align:center;background:#fff;border-radius:12px;box-shadow:0 8px 30px rgba(0,0,0,.06)}
.hero h2{margin:.5rem 0 1rem;font-size:2.2rem}
.hero p{margin:0 auto 1.25rem;max-width:720px;font-size:1.1rem;line-height:1.55}
.btn{display:inline-block;padding:.75rem 1.25rem;border-radius:8px;font-weight:700;text-decoration:none}
.btn.primary{background:var(--brand1);color:#fff}
.btn.primary:hover{background:#5468d6}
.btn.ghost{border:2px solid var(--brand1);color:var(--brand1)}
.btn.ghost:hover{background:#eef0ff}
.section{margin-top:2rem}
.card{background:#fff;border-radius:12px;padding:1.25rem;box-shadow:0 4px 20px rgba(0,0,0,.05)}
footer{margin:3rem 0 1rem;text-align:center;color:#666;font-size:.95rem}
CSS

# Tiny JS to mark active nav link
cat > "$JS" <<'JS'
(function(){
  const path = location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('nav a').forEach(a=>{
    const href = a.getAttribute('href') || '';
    if ((path === '' && href === 'index.html') || href === path) a.classList.add('active');
  });
})();
JS

# Template function
make_page () {
  FILE="$1"
  TITLE="$2"
  H2="$3"
  INTRO="$4"
  BTN1_TEXT="$5"
  BTN1_HREF="$6"
  BTN2_TEXT="$7"
  BTN2_HREF="$8"

  cat > "$PUB/$FILE" <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>$TITLE — Collaborative AI</title>
  <link rel="icon" type="image/png" href="images/CollaborativeAI_Logo_gpt_1.png" />
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <div class="container">
    <header>
      <a class="brand" href="index.html">
        <img src="images/CollaborativeAI_Logo_gpt_1.png" alt="Logo" />
        <h1>Collaborative AI</h1>
      </a>
      <nav>
        <a href="index.html">Home</a>
        <a href="medical.html">Medical</a>
        <a href="legal.html">Legal</a>
        <a href="investment.html">Investment</a>
      </nav>
    </header>

    <main>
      <section class="hero">
        <h2>$H2</h2>
        <p>$INTRO</p>
        <div style="margin-top:1rem;">
          <a class="btn primary" href="$BTN1_HREF">$BTN1_TEXT</a>
          <a class="btn ghost" href="$BTN2_HREF">$BTN2_TEXT</a>
        </div>
      </section>

      <section class="section">
        <div class="card">
          <h3>How it works</h3>
          <p>
            We yoke multiple AI engines, feed outputs across engines, and recurse until
            convergence. Each domain uses a directed graph of nodes (engines) and named edges
            (transforms/validators). The **hub** decides when answers have converged.
          </p>
        </div>
      </section>
    </main>

    <footer>© 2025 Collaborative AI — Recursive Self-Improvement Platform</footer>
  </div>
  <script src="app.js"></script>
</body>
</html>
HTML
}

# Home page
make_page "index.html" \
  "Home" \
  "Recursive Self-Improvement Across AI Systems" \
  "CollaborativeAI.ai yokes multiple engines and recursively refines their outputs until convergence. Start with our Medical experiment, then expand into Legal and Investment." \
  "Try Medical Demo" "medical.html" \
  "Learn About the Approach" "legal.html"

# Medical
make_page "medical.html" \
  "Medical" \
  "Medical Recursive Help" \
  "Cross-model diagnosis support: symptoms → different engines → cross-feeding → convergence with transparent evidence and caveats." \
  "Run Medical Flow" "#" \
  "See Graph Layout" "#"

# Legal
make_page "legal.html" \
  "Legal" \
  "Legal Reasoning with Convergence" \
  "Parallel legal engines synthesize case law, statutes, and precedents. Edges name transforms (retrieval, normalization, citation check) and recurse to refine." \
  "Explore Legal Flow" "#" \
  "View Example" "#"

# Investment
make_page "investment.html" \
  "Investment" \
  "Investment Signals & Risk" \
  "Diverse models (macro, sentiment, factor) feed each other; edges express transforms (de-bias, hedging, stop-loss checks) until a convergent signal emerges." \
  "Open Investment Flow" "#" \
  "Methodology" "#"

echo "✅ Static site created in $PUB/"
echo "   - index.html, medical.html, legal.html, investment.html"
echo "   - styles.css, app.js, images/"
