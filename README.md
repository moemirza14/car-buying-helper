# Supercar Buying Helper

A single-page web app for top-tier supercar and hypercar buyers — picker quiz, ownership-cost model (depreciation-driven), buying strategy (allocations, ADM, classics), and marque-specific PPI checklist.

Built as a pure static site — no backend, no API keys, no build step.

Live at: https://moemirza14.github.io/car-buying-helper/

---

## What's in it

- **Picker Quiz** — 6 questions across buyer type, budget tier, use, brand, powertrain, and market (new/used/classic). Scores against a 28-car catalog from $500k Porsches through Bugatti Tourbillon.
- **Ownership Cost** — depreciation-driven TCO since value change dwarfs everything else at this tier. Supports appreciation for classics.
- **Buying Strategy** — playbooks for chasing an allocation, buying used, and acquiring classics. Includes contract-stage anti-fraud tips.
- **PPI Checklist** — marque-specific failure modes (Ferrari V8 manifolds, V12 clutch wear, Lambo carbon ceramics, McLaren coolant, Porsche 918 HV battery, universal paint/OBD checks).

---

## Run it locally — 3 ways

### 1. Just open the file (zero setup)

Double-click `index.html`. Done.

### 2. With a simple local server

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

### 3. With Docker (production-equivalent)

```bash
docker build -t supercar-helper:dev .
docker run --rm -p 8080:8080 supercar-helper:dev
# open http://localhost:8080
```

That third option runs the *exact* image you'd ship to Kubernetes, locally. Identical behavior.

---

## Deploy options

### Option A — GitHub Pages (what's currently in use)

Already configured. Any `git push` to `main` auto-deploys to https://moemirza14.github.io/car-buying-helper/ in about a minute.

### Option B — Container registry + Kubernetes

For when you want full control over hosting, want to compose with other services, or are practicing real-world deployment workflows.

**Build and push the image:**

```bash
# Build
docker build -t ghcr.io/moemirza14/supercar-helper:v1 .

# Log in (GitHub Container Registry uses your gh token)
echo $GH_TOKEN | docker login ghcr.io -u moemirza14 --password-stdin
# Or for Docker Hub: docker login

# Push
docker push ghcr.io/moemirza14/supercar-helper:v1
```

**Apply the Kubernetes manifest:**

```bash
# Point kubectl at your cluster first (kind, minikube, EKS, GKE, etc)
kubectl apply -f k8s/manifest.yaml

# Watch it come up
kubectl -n supercar-helper get pods -w

# Port-forward to test without an Ingress
kubectl -n supercar-helper port-forward svc/supercar-helper 8080:80
# open http://localhost:8080
```

The manifest declares: a Namespace, a Deployment (2 replicas, health-probed, resource-limited, hardened), a ClusterIP Service, and an optional Ingress. Read `k8s/manifest.yaml` — it's commented top to bottom.

---

## File layout

```
car-buying-helper/
├── index.html         The entire app (HTML + CSS + JS in one file)
├── Dockerfile         Builds an nginx-based image serving the site
├── nginx.conf         nginx config with /healthz endpoint + security headers
├── .dockerignore      Excludes git, k8s, README from the image
├── k8s/
│   └── manifest.yaml  Namespace + Deployment + Service + Ingress
└── README.md          This file
```

---

## Why a Dockerfile and Kubernetes manifest for a static site?

**You don't strictly need them.** GitHub Pages already serves this site for free with a CDN and TLS.

The reasons to learn this anyway:

1. **Portability.** A container runs identically on your laptop, in CI, on any cloud. No "works on my machine."
2. **Composability.** When you eventually add a backend, a database, or auth, you'll already have the deployment substrate in place.
3. **Industry standard.** Every meaningful deployment workflow assumes containers. Learning to wrap even a static app teaches the pattern.
4. **Kubernetes specifically gives you:** self-healing, rolling updates, horizontal scaling, declarative state, and the same YAML works on any cluster.

If your goal is just "host this site for free and forever" → stick with GitHub Pages.
If your goal is "learn how production deployments actually work" → use the Docker + K8s path.

---

## Making changes

Edit `index.html`, then:

```bash
git add .
git commit -m "describe your change"
git push
```

GitHub Pages re-deploys in about a minute. If you're also publishing a Docker image, bump the tag (`v1` → `v2`), rebuild, push, and update the manifest.

---

## Ideas to extend

- Add charts to the cost calculator (Chart.js from CDN)
- Side-by-side comparison of two cars across the same TCO inputs
- Persist quiz answers to `localStorage`
- More marques in the PPI checklist (Bentley, Rolls, Aston Martin, Pagani)
- A backend API to track market prices over time (now you actually *would* need the container)
