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
│── core/
│ ├── constants/
│ │ ├── app_strings.dart
│ │ └── app_colors.dart
│ ├── services/
│ │ ├── theme/
│ │   ├── app_localization_service.dart
│ │   └── app_color_service.dart
│── main.dart

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

### 2️⃣ Initialize Services in main.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppColorService.init();
  await AppLocalizationService.init();

  runApp(const MyApp());
}

### 3️⃣ Use Localized Strings

Text(AppStrings.loginScreenTitle.tr);
ElevatedButton(
  onPressed: () {},
  child: Text(AppStrings.loginScreenLoginButton.tr),
);

### 4️⃣ Use Dynamic Colors

Container(
  color: AppColors.primary,
  child: Text(
    "Welcome",
    style: TextStyle(color: AppColors.textOnPrimary),
  ),
);

### 5️⃣ Switch Language

await AppLocalizationService.setLanguage("ar"); // switch to Arabic
setState(() {}); // rebuild UI






