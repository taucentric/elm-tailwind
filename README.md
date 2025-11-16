# elm-tailwind
Elm and Tailwind UI experiments

## Project Structure

```
elm-tailwind/
├── src/
│   ├── Main.elm          # Main Elm application
│   └── styles.css        # Tailwind CSS entry point
├── dist/                 # Build output (generated)
├── index.html            # HTML template
├── elm.json              # Elm package configuration
├── elm-watch.json        # Elm-watch configuration for hot reload
├── tailwind.config.js    # Tailwind CSS configuration
└── package.json          # Node.js dependencies and scripts
```

## Setup

1. Install dependencies:
```bash
npm install
```

## Available Scripts

### Build
Build both CSS and Elm:
```bash
npm run build
```

Build CSS only:
```bash
npm run build:css
```

Build Elm only:
```bash
npm run build:elm
```

### Development
Run development server with hot reload:
```bash
npm run dev
```

This will run Tailwind CSS in watch mode and elm-watch for hot module replacement.

### Clean
Remove build artifacts:
```bash
npm run clean
```

## Opening the Application

After building, open `index.html` in your browser to see the application.

## Deployment

This project is configured for easy deployment to free hosting services.

### GitHub Pages

The project includes a GitHub Actions workflow that automatically deploys to GitHub Pages on every push to the `main` branch.

**Setup:**
1. Go to your repository settings on GitHub
2. Navigate to **Pages** under "Code and automation"
3. Under **Source**, select "GitHub Actions"
4. Push to the `main` branch to trigger deployment
5. Your site will be available at `https://<username>.github.io/<repository>/`

The workflow file is located at `.github/workflows/deploy.yml`.

### Netlify

**Option 1: Automatic deployment from Git**
1. Sign up at [netlify.com](https://netlify.com)
2. Click "Add new site" → "Import an existing project"
3. Connect your GitHub repository
4. Netlify will automatically detect the build settings from `netlify.toml`
5. Click "Deploy site"

**Option 2: Manual deployment**
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Build the project
npm run build

# Deploy
netlify deploy --prod --dir=dist
```

### Vercel, Cloudflare Pages, or other services

The build output is in the `dist/` directory. Configure your hosting service to:
- **Build command:** `npm run build`
- **Publish directory:** `dist`
- **Node version:** 20

## Technologies

- **Elm 0.19.1** - Functional programming language for building web applications
- **Tailwind CSS 3.4** - Utility-first CSS framework
- **elm-watch** - Development server with hot module replacement

## Production Build

The production build includes:
- **Optimized Elm code** - Compiled with `--optimize` flag for smaller bundle size
- **Minified CSS** - Tailwind CSS with unused styles purged and minified
- **Processed HTML** - Paths automatically adjusted for the dist directory

## Note

If you encounter network issues with the Elm package registry, you may need to check your internet connection or firewall settings. The project is configured with all necessary dependencies in `elm.json`.
