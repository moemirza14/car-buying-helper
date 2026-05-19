# Smart Car Buying Helper

A single-page web app that helps people figure out what car to buy, what it'll really cost, and how to negotiate.

Built as a pure static site — no backend, no API keys, no build step. Just open `index.html` in a browser.

## What's in it

- **Lifestyle Quiz** — answer 5 questions, get a body-style recommendation with example models in your budget range
- **Total Cost of Ownership Calculator** — loan payment + fuel + insurance + maintenance with live recalculation
- **Negotiation Prep Checklist** — research steps and dealer tactics to watch for
- **Used Car Inspection Guide** — documents, walkaround, under-the-hood, and test drive red flags

## Run it locally

Just double-click `index.html`. That's it.

For a slightly nicer local preview with a real server:

```bash
cd car-buying-helper
python3 -m http.server 8000
# then open http://localhost:8000
```

## Deploy to GitHub Pages

GitHub Pages serves static sites for free at `https://<your-username>.github.io/<repo-name>/`.

### One-time setup

1. **Create a GitHub account** if you don't have one: https://github.com/signup
2. **Install Git** if it isn't already: https://git-scm.com/downloads

### Push the project

From inside the `car-buying-helper` folder, run:

```bash
git init
git add .
git commit -m "Initial commit"
```

Then create a new repository on GitHub (call it something like `car-buying-helper`). After GitHub gives you the repo URL, run:

```bash
git branch -M main
git remote add origin https://github.com/<your-username>/car-buying-helper.git
git push -u origin main
```

### Enable Pages

1. Go to your repo on GitHub
2. Click **Settings** (top right of the repo)
3. In the left sidebar, click **Pages**
4. Under **Source**, choose **Deploy from a branch**
5. Pick the **main** branch and the **/ (root)** folder
6. Click **Save**

Wait 1–2 minutes, then visit `https://<your-username>.github.io/car-buying-helper/`. Your app is live.

## Making changes

Edit `index.html`, then:

```bash
git add .
git commit -m "Describe your change"
git push
```

GitHub Pages will pick up the change automatically within a minute.

## How it works

Everything lives in one file:
- The HTML structure has four `<section class="panel">` blocks for the four features
- The CSS is in a `<style>` tag at the top
- The JavaScript is in a `<script>` tag at the bottom
- The quiz uses a simple rule-based scoring system to pick a body style, then maps that style + budget tier to a small list of example models
- The TCO calculator uses the standard amortization formula for the loan portion

No frameworks, no libraries, no dependencies. Easy to read and modify.

## Ideas to extend

- Add more quiz questions (towing needs, garage size, climate)
- Expand the model database (currently has ~24 body-style/budget combos)
- Add a "compare two cars side by side" mode
- Save results to `localStorage` so they persist between visits
- Add charts to the cost calculator using a CDN like Chart.js
