# Portfolio Website

A modern, responsive portfolio website built with Flutter Web showcasing skills, projects, and professional experience.

## 🚀 Live Demo
Visit the live website: [vignarajj.github.io](https://vignarajj.github.io)

## 📱 Features

- **Responsive Design**: Optimized for all screen sizes (mobile, tablet, desktop)
- **Interactive UI**: Smooth animations and transitions
- **Real-time Chat**: AI-powered chatbot for visitor engagement
- **Medium Integration**: Dynamic loading of latest blog posts
- **Contact Form**: Integrated contact system with validation
- **Visit Tracking**: Analytics for visitor count
- **Dark Theme**: Modern dark theme design
- **Progressive Web App**: Works offline and installable

## 🛠 Technology Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: GetX
- **Architecture**: Clean Architecture with GetX pattern
- **UI/UX**: Custom Material Design with dark theme
- **Animations**: Custom Flutter animations and Rive
- **Icons**: SVG icons and Font Awesome
- **Fonts**: Google Fonts (Noto Sans, Noto Serif, Source Code Pro)
- **Backend**: Custom API for contact and chat functionality
- **Deployment**: GitHub Pages

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   └── services/
│       └── injector.dart        # Dependency injection setup
├── app/
│   └── modules/
│       ├── home/                # Home page module
│       │   ├── bindings/
│       │   ├── controllers/
│       │   └── views/
│       ├── chat/                # AI chatbot module
│       │   ├── bindings/
│       │   ├── controllers/
│       │   ├── models/
│       │   ├── services/
│       │   └── views/
│       ├── skills/              # Skills showcase module
│       │   ├── bindings/
│       │   ├── controllers/
│       │   └── views/
│       ├── core_competency/     # Core competencies module
│       │   ├── bindings/
│       │   ├── controllers/
│       │   └── views/
│       ├── contact/             # Contact form module
│       │   ├── bindings/
│       │   ├── controllers/
│       │   └── views/
│       └── medium/              # Medium blog integration
│           ├── bindings/
│           ├── controllers/
│           └── views/
├── network/                     # API services and constants
├── repo/                        # Data repositories
├── routes/                      # App routing configuration
└── shared/                      # Shared resources
    ├── models/                  # Data models
    ├── theme/                   # App theme and colors
    └── widgets/                 # Reusable widgets
```

## 🏗 Architecture

This project follows **Clean Architecture** principles with **GetX** pattern:

- **Presentation Layer**: UI components and widgets
- **Business Logic Layer**: Controllers and use cases
- **Data Layer**: Repositories and API services
- **Core Layer**: Dependency injection and shared utilities

### Key Patterns Used:
- **Module-based Architecture**: Each feature is a self-contained module
- **Dependency Injection**: Using GetX and GetIt for service locator
- **Repository Pattern**: Data abstraction layer
- **Binding Classes**: Lazy loading of dependencies
- **Reactive Programming**: Observable state management with GetX

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK (>=3.8.1 <4.0.0)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vignarajj/vignarajj.github.io.git
   cd vignarajj.github.io
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome  # For web
   flutter run             # For mobile/desktop
   ```

### Build for Production

**Web (GitHub Pages)**
```bash
flutter build web --release
```

**Mobile**
```bash
flutter build apk --release     # Android
flutter build ios --release     # iOS
```

## 🔧 Configuration

### Environment Setup
Update the following files for your own portfolio:

1. **API Configuration** (`lib/network/api_constants.dart`)
   ```dart
   static const String baseUrl = "your-api-url";
   ```

2. **Personal Information** (`lib/app/modules/home/controllers/home_controller.dart`)
   - Update skills, competencies, and personal details
   - Replace social media links
   - Update resume/CV path

3. **Assets**
   - Replace `assets/images/profile_pic.jpeg` with your photo
   - Update skill icons in `assets/images/`
   - Replace resume PDF in `assets/images/`

### Custom Theming
Modify `lib/shared/theme/` to customize:
- Colors (`app_colors.dart`)
- Typography (`text_styles.dart`)
- Overall theme (`app_theme.dart`)

## 📦 Dependencies

### Core Dependencies
- `get: ^4.6.6` - State management and routing
- `get_storage: ^2.1.1` - Local storage
- `get_it: ^8.0.3` - Service locator

### UI/UX
- `google_fonts: ^2.3.1` - Typography
- `flutter_svg: ^1.1.1+1` - SVG support
- `font_awesome_flutter: ^10.7.0` - Icons
- `animated_text_kit: ^4.2.2` - Text animations
- `rive: ^0.13.20` - Advanced animations
- `lottie: ^3.0.0` - Lottie animations

### Functionality
- `http: ^0.13.3` - HTTP requests
- `dio: ^5.4.0` - Advanced HTTP client
- `url_launcher: ^6.2.5` - External links
- `flutter_linkify: ^6.0.0` - Automatic link detection

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Contact

- **Email**: your-email@example.com
- **LinkedIn**: [Your LinkedIn](https://linkedin.com/in/your-profile)
- **GitHub**: [Your GitHub](https://github.com/your-username)
- **Medium**: [Your Medium](https://medium.com/@your-username)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX team for the state management solution
- All open source contributors

---

**Made with ❤️ and Flutter**
