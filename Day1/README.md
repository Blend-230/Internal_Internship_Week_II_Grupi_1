# Day 1: Dart Refresher & Flutter Setup

Welcome to Day 1 of the BGT School Internal Internship! This document covers the core learning materials, a syntax comparison between C and Dart, an overview of Flutter, and details about the implemented **Profile Card App**.

---

## 1. C vs Dart: Language Comparison

Since you are transitioning from C to Dart, you will find many structural similarities because Dart is a C-style syntax language. However, Dart is modern, fully object-oriented, and garbage-collected.

| Concept | C Language | Dart Language | Key Differences / Notes |
| :--- | :--- | :--- | :--- |
| **Variables** | `int x = 10;`<br>`float y = 5.5;` | `int x = 10;`<br>`double y = 5.5;`<br>`var z = "Hello";` | Dart uses `double` for decimals. `var` allows type inference. Dart is strongly typed. |
| **Constants** | `#define PI 3.14`<br>`const int MAX = 100;` | `const double pi = 3.14;`<br>`final String name = "Dones";` | `const` is compile-time constant.<br>`final` is run-time constant (can only be set once). |
| **Conditionals** | `if (x > 5) { ... } else { ... }` | `if (x > 5) { ... } else { ... }` | Exactly the same syntax. |
| **Loops** | `for (int i=0; i<5; i++)`<br>`while (cond)` | `for (int i=0; i<5; i++)`<br>`while (cond)` | Exactly the same syntax. |
| **Functions** | `int sum(int a, int b) {`<br>`  return a + b;`<br>`}` | `int sum(int a, int b) {`<br>`  return a + b;`<br>`}` | Dart also supports **Arrow functions**: `int sum(int a, int b) => a + b;` |
| **Entry Point** | `int main() { return 0; }` | `void main() { runApp(MyApp()); }` | `void main()` is the standard entry point. |
| **Null Safety** | Pointers can be `NULL` (unsafe). | Types are non-nullable by default (`int?` can be null). | Dart has sound null safety to prevent runtime crashes. |

---

## 2. What is Flutter and Why Use It?

**Flutter** is Google's open-source UI software development kit (SDK). It is used to build natively compiled applications for:
* **Mobile** (iOS & Android)
* **Web** (Chrome, Safari, Firefox, Edge)
* **Desktop** (Windows, macOS, Linux)
* **Embedded Devices**

### Why is Flutter used?
1. **Single Codebase**: Write once, deploy everywhere.
2. **Fast Development (Hot Reload)**: Instantly see code changes in the emulator or browser without losing app state.
3. **High Performance**: Renders directly using the Impeller (or Skia) graphics engine, bypassing native OEM widgets for a consistent 60fps/120fps UI.
4. **Rich Widget Library**: Comes packed with fully customizable Material Design and Cupertino (iOS-style) widgets.

---

## 3. Basic Flutter App Architecture

A Flutter app is a tree of widgets. Here is the structure used in our app:
* **`main()`**: The entry point of the Dart program.
* **`runApp(Widget app)`**: An internal Flutter function that inflates the given widget and attaches it to the screen.
* **`MaterialApp`**: The root widget that sets up the theme, navigation, localizations, and Material design configurations.
* **`Scaffold`**: Implements the basic Material Design visual layout structure (provides slots for an AppBar, Body, Drawer, SnackBar, BottomNavigationBar, etc.).

---

## 4. Basic Widgets Used in the Profile Card App

1. **`Text`**: Renders text on the screen with customizable styles (`TextStyle`).
2. **`Icon` / `IconButton`**: Displays interactive graphical icons.
3. **`Image`**: Loads and displays images (e.g., using `AssetImage` for local assets).
4. **`Container`**: A convenience widget that combines common painting, positioning, and sizing properties (padding, margin, decoration/borders, colors, and shadow).
5. **`Row`**: A layout widget that arranges its children horizontally.
6. **`Column`**: A layout widget that arranges its children vertically.
7. **`ElevatedButton` / `ElevatedButton.icon`**: A Material button with a shadow that elevates when pressed.
8. **`Card`**: A panel with slightly rounded corners and an elevation shadow, perfect for profiles.
9. **`LinearProgressIndicator`**: A horizontal bar showing progress, used here to represent skill levels.

---

## 5. Development Workflow & Troubleshooting

### Hot Reload vs Hot Restart
* **Hot Reload (`r`)**: Injects updated source code files into the Dart Virtual Machine. Flutter rebuilds the widget tree, allowing you to quickly view changes **without losing the current state** of the app.
* **Hot Restart (`R`)**: Re-initializes the app state from scratch and rebuilds the widget tree (takes slightly longer, but clears memory and resets variable states).

### Common Build/Run Errors
1. **Asset Not Registered**: If your image is not loading, ensure it is added to `assets/` and registered inside `pubspec.yaml` with correct indentation (2 spaces):
   ```yaml
   flutter:
     assets:
       - assets/images/profile_avatar.png
   ```
2. **Layout Overflow**: If you see a yellow-and-black striped bar on the screen, a widget is larger than its constraints.
   * *Fix*: Wrap columns in a `SingleChildScrollView` or use `Expanded` / `Flexible` widgets.
3. **Const Type Mismatch**: Putting `const` before a widget tree that contains dynamic elements.
   * *Fix*: Remove the `const` keyword from the parent widget, and apply it only to its static leaf children.

---

## 6. How to Run the App

### Option A: Online Sandbox (FlutLab / Replit / DartPad)
1. Zip or upload the `profile_card_app` folder contents.
2. In FlutLab or Replit, click **Run** or **Build**.
3. The online emulator will display the web preview of the profile card.

### Option B: Local Setup (Command Line)
Once Flutter SDK is installed and configured in your environment:
1. Navigate to the project folder:
   ```bash
   cd "Day1/profile_card_app"
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
