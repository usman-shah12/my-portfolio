# Syed Usman Shah — Flutter Portfolio

A fully responsive, cross-platform Flutter portfolio application.

## 🚀 Platforms
- Flutter Web
- Android
- iOS
- Windows
- macOS
- Linux

## 🎨 Design
- Dark theme: `#0D0D0D` background
- Red accent: `#FF0000`
- Google Fonts (Poppins)
- Card-based layout
- Animated transitions

## 📁 Project Structure
```
lib/
├── main.dart                    # App entry point
├── portfolio_page.dart          # Main scaffold + navigation
├── core/
│   ├── app_theme.dart           # ThemeData, colors, typography
│   ├── constants.dart           # App-wide constants
│   └── responsive.dart          # Breakpoints & responsive helpers
├── models/
│   ├── project_model.dart       # Project data model
│   └── skill_model.dart         # Skill data model
├── data/
│   └── demo_data.dart           # Demo projects and skills
└── widgets/
    ├── shared/
    │   ├── navbar.dart           # Desktop top navigation bar
    │   ├── app_drawer.dart       # Mobile drawer navigation
    │   ├── section_title.dart    # Reusable section header
    │   └── project_card.dart     # Reusable project card
    └── sections/
        ├── hero_section.dart     # Hero / landing section
        ├── about_section.dart    # About me section
        ├── skills_section.dart   # Skills grid section
        ├── projects_section.dart # Projects grid section
        └── contact_section.dart  # Contact section + footer
```

## ⚡ Responsive Breakpoints
| Screen       | Width     | Nav      | Grid Columns |
|-------------|-----------|----------|-------------|
| Mobile      | < 768px   | Drawer   | 1           |
| Tablet      | 768–1100px | Top Nav | 2           |
| Desktop     | > 1100px  | Top Nav  | 3           |

## 🛠️ Setup

```bash
# Install dependencies
flutter pub get

# Run on web
flutter run -d chrome

# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run on Windows
flutter run -d windows

# Run on macOS
flutter run -d macos

# Run on Linux
flutter run -d linux

# Build for web
flutter build web --release
```

## 📦 Dependencies
- `google_fonts` — Poppins typography
- `url_launcher` — Open links & email
- `animate_do` — Fade/slide animations
- `font_awesome_flutter` — Social media icons

## 🎯 Customize
1. Update `lib/core/constants.dart` with your personal info
2. Update `lib/data/demo_data.dart` with your real projects & skills
3. Replace avatar placeholder in `hero_section.dart` with your photo
4. Update CV download link in constants
