# Vignaraj Portfolio (SvelteKit Migration)

A modern, animated, and modular personal portfolio built with SvelteKit. Migrated from Flutter Web for blazing-fast performance, maintainability, and a beautiful developer experience.

## 🚀 Features
- **Dark/Light Theme**: Toggle in the top app bar
- **Animated UI**: Smooth transitions and effects with Svelte and GSAP
- **Modular Structure**: Each feature is a self-contained route/module
- **API Integration**: Contact, Chat, and Medium modules use real backend APIs
- **Responsive Design**: Works on all devices
- **Easy Customization**: Add your own skills, projects, and content

## 📁 Project Structure
```
src/
  lib/
    api/           # API utilities for backend integration
    components/    # Reusable Svelte components
    models/        # TypeScript interfaces/types
    stores/        # Svelte stores (state management)
    assets/        # Images, fonts, etc.
  routes/
    +page.svelte         # Home page
    skills/              # Skills module
    core-competency/     # Core Competency module
    chat/                # Chat module
    medium/              # Medium blog module
    contact/             # Contact form module
```

## 🛠 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vignarajj/vignarajj.github.io.git
   cd vignarajj.github.io/sveltekit_portfolio
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Run the development server**
   ```bash
   npm run dev -- --open
   ```
   The app will open at [http://localhost:5173](http://localhost:5173) by default.

## 🌗 Theming
- Toggle dark/light mode using the button in the top app bar.
- The default theme is light.

## 🔗 API Integration
- Update API endpoints in `src/lib/api/contact.ts`, `chat.ts`, and `medium.ts` to point to your backend.
- All API utilities use `fetch` and handle errors gracefully.

## 🏗 Deployment

### Static Hosting (Vercel, Netlify, GitHub Pages, etc.)
1. **Build the app**
   ```bash
   npm run build
   ```
2. **Preview the production build**
   ```bash
   npm run preview
   ```
3. **Deploy the contents of the `build/` directory** to your preferred static host.

### Vercel (Recommended)
- Push your repo to GitHub and import it in [Vercel](https://vercel.com/).
- Vercel will auto-detect SvelteKit and deploy your site.

## 🧩 Customization
- Update your skills, core competencies, and content in the respective stores or via API.
- Replace images and assets in `src/lib/assets/`.
- Tweak styles and themes in the layout and component files.

## 🤝 Contributing
Pull requests and issues are welcome!

## 📄 License
MIT
