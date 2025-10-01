#!/bin/bash
# setup_landing.sh
# Script to create a simple landing page for Collaborative AI

# Ensure we’re in the project root
cd "$(dirname "$0")"

# Create folders
mkdir -p public/images

# Copy logo into images folder (assuming it's in current dir)
if [ -f CollaborativeAI_Logo_gpt_1.png ]; then
  cp CollaborativeAI_Logo_gpt_1.png public/images/
  echo "✅ Copied CollaborativeAI_Logo_gpt_1.png to public/images/"
else
  echo "⚠️ Warning: CollaborativeAI_Logo_gpt_1.png not found in project root"
fi

# Write the index.html file
cat > public/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Collaborative AI</title>
  <link rel="icon" type="image/png" href="images/CollaborativeAI_Logo_gpt_1.png">
  <style>
    body {
      margin: 0;
      font-family: system-ui, -apple-system, sans-serif;
      color: #213547;
      background: #f9fafc;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      min-height: 100vh;
    }
    header {
      text-align: center;
      padding: 2rem 1rem;
    }
    header img {
      max-width: 240px;
      height: auto;
    }
    h1 {
      font-size: 2.5rem;
      margin: 1rem 0 0.5rem;
      background: linear-gradient(90deg, #667eea, #764ba2);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    p {
      max-width: 700px;
      margin: 0 auto 2rem;
      font-size: 1.1rem;
      line-height: 1.5;
    }
    main {
      text-align: center;
      padding: 2rem 1rem;
    }
    .btn {
      display: inline-block;
      padding: 0.75rem 1.5rem;
      margin: 0.5rem;
      border-radius: 6px;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }
    .btn.primary {
      background: #667eea;
      color: #fff;
    }
    .btn.primary:hover {
      background: #5468d6;
    }
    .btn.secondary {
      border: 2px solid #667eea;
      color: #667eea;
    }
    .btn.secondary:hover {
      background: #eef0ff;
    }
    footer {
      margin-top: auto;
      padding: 1rem;
      text-align: center;
      font-size: 0.9rem;
      color: #666;
    }
  </style>
</head>
<body>
  <header>
    <img src="images/CollaborativeAI_Logo_gpt_1.png" alt="Collaborative AI Logo">
    <h1>Welcome to Collaborative AI</h1>
    <p>
      CollaborativeAI.ai is a recursive self-improvement platform: multiple AI engines 
      are yoked together, feeding their outputs back into one another until convergence. 
      Our first experiment: <strong>Medical recursive help</strong>.
    </p>
  </header>
  <main>
    <a href="#concept" class="btn primary">Learn More</a>
    <a href="#demo" class="btn secondary">Try the Demo</a>
  </main>
  <footer>
    © 2025 Collaborative AI — Recursive Self-Improvement Platform
  </footer>
</body>
</html>
HTML

echo "✅ Landing page created at public/index.html"