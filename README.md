# 🌍 Flutter Dynamic Localization & Theming

A Flutter setup for **dynamic localization** (multi-language support) and **dynamic theming** (colors from remote JSON).  
This makes your app flexible, customizable, and easy to update without shipping new builds.

---

## 🚀 Features
- ✅ Dynamic **Localization** using JSON  
- ✅ Easy `.tr` extension for translations  
- ✅ Dynamic **Color Theming** from JSON  
- ✅ Centralized `AppStrings` & `AppColors` constants  
- ✅ Works with **GitHub Pages** or any hosted JSON  
- ✅ Simple MVVM-friendly structure  

---

## 📂 Project Structure
lib/
 ├── core/
 │   ├── constants/
 │   │   └── app_strings.dart
 │   │   └── app_colors.dart
 │   ├── services/
 │   │   ├── app_localization_service.dart
 │   │   └── app_color_service.dart
 │   └── theme/
 └── main.dart


---

## ⚡ Quick Start

### 1️⃣ Install dependencies
```bash
flutter pub get

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppColorService.init();
  await AppLocalizationService.init();

  runApp(const MyApp());
}
```


### 2️⃣ Initialize Services in main.dart
```bash

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppColorService.init();
  await AppLocalizationService.init();

  runApp(const MyApp());
}
```


### 3️⃣ Use Localized Strings
```bash

Text(AppStrings.loginScreenTitle.tr);
ElevatedButton(
  onPressed: () {},
  child: Text(AppStrings.loginScreenLoginButton.tr),
);
```


### 4️⃣ Use Dynamic Colors
```bash

Container(
  color: AppColors.primary,
  child: Text(
    "Welcome",
    style: TextStyle(color: AppColors.textOnPrimary),
  ),
);
```


### 5️⃣ Switch Language
```bash

await AppLocalizationService.setLanguage("ar"); // switch to Arabic
setState(() {}); // rebuild UI
```

## 📝 Example JSON Files
🌐 Localization (e.g., en.json)
```bash

{
  "splash_screen": {
    "retry": "Retry",
    "failed_to_load_colors": "Failed to load colors",
    "loading": "Loading..."
  },
  "login_screen": {
    "title": "Login",
    "email_hint": "Email Address",
    "password_hint": "Password",
    "login_button": "Login",
    "forgot_password": "Forgot Password?"
  },
  "home_screen": {
    "title": "Home",
    "welcome_message": "Welcome to DSFH!"
  }
}
```

## 🎨 Colors (e.g., colors.json)
```bash

{
  "primary": "#008AAB",
  "secondary": "#FF9800",
  "background": "#F5F5F5",
  "textPrimary": "#212121",
  "textOnPrimary": "#FFFFFF"
}
```

## 🛠 Development Notes

Host your en.json, ar.json, colors.json on GitHub Pages or an API.

Services (AppColorService and AppLocalizationService) fetch JSON at startup.

Use .tr for translations and AppColors.xyz for colors.

Designed to be used with MVVM + BLoC/Cubit.

## 🤝 Contributing

Contributions are welcome!

Fork the repo

Create a feature branch (git checkout -b feature/new-feature)

Commit changes (git commit -m 'Add new feature')

Push and create a Pull Request

## 📜 License

This project is licensed under the MIT License.
You are free to use and modify it for personal and commercial projects.


## 👨‍💻 Author

[![GitHub - Irshad Fakeeh](https://img.shields.io/badge/GitHub-Irshad%20Fakeeh-blue?logo=github)](https://github.com/Irshad-Fakeeh)




---

👉 This README includes:
- What the project is  
- Features  
- Setup guide  
- Example usage  
- JSON examples  
- Contribution guide  
- License & author  

Do you want me to also add **GitHub Pages hosting steps** (so others know how to serve the JSON files for their app)?





