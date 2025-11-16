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

## Technologies

- **Elm 0.19.1** - Functional programming language for building web applications
- **Tailwind CSS 3.4** - Utility-first CSS framework
- **elm-watch** - Development server with hot module replacement

## Note

If you encounter network issues with the Elm package registry, you may need to check your internet connection or firewall settings. The project is configured with all necessary dependencies in `elm.json`.
