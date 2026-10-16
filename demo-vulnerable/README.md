# demo-vulnerable

Everything in this folder is **intentionally insecure** and exists only to give
build/scan stages (Harness STO, SCS, SAST, SCA, secret and IaC scanners)
something to find.

- All credentials, keys and tokens are **fake** and not valid for any service.
- Nothing here is imported by the real app (`index.html`) or copied into the image.
- `k8s/insecure-deployment.yaml` is deliberately outside `k8s/` so deploy steps don't apply it.

| Scan type | Where |
|---|---|
| SAST | `app.py`, `static/legacy.js` |
| SCA (dependencies) | `requirements.txt`, `package.json`, `package-lock.json` |
| Secrets | `.env.production`, `id_rsa_demo`, `app.py`, `static/legacy.js`, `Dockerfile` |
| IaC / Dockerfile | `k8s/insecure-deployment.yaml`, `Dockerfile` |
| Container image | `Dockerfile` (old base image) |

Delete this folder and revert the `Dockerfile` change when finished.
