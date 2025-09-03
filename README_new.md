# Flutter Health App 🏥

A modern German healthcare application built with Flutter, featuring a centralized theme system and responsive design.

## ✨ Features

- **German Healthcare Interface**: Complete healthcare management system in German
- **Care Level Requests**: Submit and manage Pflegegrad applications with PDF uploads
- **Responsive Design**: Optimized for mobile, tablet, and desktop devices
- **Centralized Theme System**: Consistent colors, styles, and responsive utilities
- **Material Design 3**: Modern UI components and design patterns
- **Backend Integration**: Node.js server for file uploads and data management

## 🏗️ Architecture

### Theme System
- **AppColors**: 25+ centralized color definitions
- **AppStyles**: Reusable style components
- **ResponsiveUtils**: 15+ responsive design utilities

### Code Organization
```
lib/
├── components/          # Reusable UI components
│   ├── care_level/     # Care level specific components
│   ├── home/           # Home screen components
│   └── shared/         # Shared components
├── screens/            # Application screens
├── services/           # API and business logic
├── theme/              # Centralized theme system
└── utils/              # Utility functions
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.35.2)
- Dart SDK
- Node.js (for backend)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/flutter-health-app.git
cd flutter-health-app
```

2. Install Flutter dependencies:
```bash
flutter pub get
```

3. Install backend dependencies:
```bash
cd backend
npm install
```

4. Start the backend server:
```bash
npm start
```

5. Run the Flutter app:
```bash
flutter run -d web
```

## 🎨 Theme System Features

### Code Reduction Achieved
- **25-37% code reduction** per component file
- **100% elimination** of duplicate responsive calculations
- **Centralized color management** with 25+ color constants
- **Consistent styling** across all components

### Responsive Design
- Mobile-first approach
- Tablet and desktop optimizations
- Dynamic font sizes and spacing
- Adaptive layouts

## 🛠️ Tech Stack

- **Frontend**: Flutter, Dart, Material Design 3
- **Backend**: Node.js, Express, Multer
- **State Management**: StatefulWidget
- **File Handling**: file_picker package
- **HTTP Requests**: http package

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👤 Author

**Tugba Uzun**
- Email: tugbaa.uzunn.tu@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Healthcare professionals for domain knowledge
