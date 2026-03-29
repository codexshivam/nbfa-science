# NBFA Science College Website

Simple setup without GitHub Actions.

## 1. Push All Code To GitHub

Use these commands in this project folder:

```bash
git add .
git commit -m "Push full NBFA Science website code"
git push origin main
```

If you are setting the remote for the first time:

```bash
git remote add origin https://github.com/codexshivam/nbfa-science.git
git push -u origin main
```

## 2. Optional: Host Manually On GitHub Pages (No Actions)

Build static web files locally:

```bash
flutter build web --release --base-href /
cp build/web/index.html build/web/404.html
```

Then publish `build/web` to `gh-pages` branch:

```bash
git checkout --orphan gh-pages
git rm -rf .
cp -r build/web/* .
cp web/CNAME .
touch .nojekyll
git add .
git commit -m "Deploy static web build"
git push -f origin gh-pages
git checkout main
```

In GitHub repository settings:

1. Open **Settings -> Pages**
2. Source: **Deploy from a branch**
3. Branch: `gh-pages` and folder `/ (root)`

## 3. Custom Domain DNS

At your DNS provider, set:

- Type: `CNAME`
- Host: `science`
- Value: `codexshivam.github.io`

Final URL:

- `https://science.nbfaschool.edu.np`
