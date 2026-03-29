# NBFA Science College Website

Production deployment guide for hosting this Flutter web app on GitHub Pages with custom domain:

- Domain: `science.nbfaschool.edu.np`
- Hosting: GitHub Pages
- Auto deploy: GitHub Actions

---

## 1. Prerequisites

Install and verify:

```bash
flutter --version
git --version
```

You also need:

- A GitHub account
- A GitHub repository for this project
- Access to DNS settings for `nbfaschool.edu.np`

---

## 2. What Is Already Configured In This Project

These files are already set up:

- `.github/workflows/deploy-gh-pages.yml` (build + deploy pipeline)
- `web/CNAME` (custom domain)
- `web/.nojekyll` (prevents Jekyll processing)
- `lib/main.dart` uses `usePathUrlStrategy()` (clean URLs)

The workflow also copies `index.html` to `404.html` so Flutter routes work on refresh/direct URL hit.

---

## 3. Push Project To GitHub (Commands)

If this folder is not yet connected to a remote repository:

```bash
git init
git add .
git commit -m "Initial NBFA Science web deployment setup"
git branch -M main
git remote add origin https://github.com/<your-github-username>/<your-repo-name>.git
git push -u origin main
```

If remote already exists:

```bash
git add .
git commit -m "Update website and deployment config"
git push
```

---

## 4. GitHub Pages Settings

In your GitHub repository:

1. Open **Settings** -> **Pages**
2. Under **Build and deployment**, choose **Source: GitHub Actions**
3. Save settings

Now every push to `main` or `master` triggers deployment.

---

## 5. DNS Setup For Custom Domain

At your DNS provider for `nbfaschool.edu.np`, add:

- Type: `CNAME`
- Name/Host: `science`
- Value/Target: `<your-github-username>.github.io`

Example target:

`science  CNAME  yourusername.github.io`

DNS propagation can take a few minutes up to 24 hours.

---

## 6. Verify Deployment

After push:

1. Open GitHub -> **Actions** tab
2. Confirm workflow **Deploy Flutter Web to GitHub Pages** is green
3. Open:
   - GitHub URL: `https://<your-github-username>.github.io/<your-repo-name>/` (may redirect)
   - Custom domain: `https://science.nbfaschool.edu.np`

---

## 7. Commands For Daily Updates

Use these for each new website update:

```bash
flutter analyze
flutter build web --release
git add .
git commit -m "Update content and UI"
git push
```

GitHub Actions will deploy automatically.

---

## 8. Optional: GitHub CLI Commands

If you use GitHub CLI:

```bash
gh auth login
gh repo create <your-repo-name> --public --source=. --remote=origin --push
```

Then go to repository settings and set Pages source to GitHub Actions.

---

## 9. Troubleshooting

### Site works on home but route refresh gives 404

Already handled by this workflow using:

- `cp build/web/index.html build/web/404.html`

### Custom domain not opening

Check:

- `web/CNAME` contains exactly `science.nbfaschool.edu.np`
- DNS CNAME points to `<your-github-username>.github.io`
- No conflicting A/AAAA records for `science`

### Deployment not running

Check:

- You pushed to `main` or `master`
- GitHub Actions is enabled for repository
- Pages source is set to GitHub Actions# nbfa-science
