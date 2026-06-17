# Day 2: Layout, Forma dhe Validim

Welcome to Day 2 of the BGT School Internal Internship! This document covers the learning materials and describes the **Student Portal App** built today.

---

## 1. Çfarë mësuam sot

| Koncept | Shpjegim |
| :--- | :--- |
| **StatelessWidget vs StatefulWidget** | `StatelessWidget` nuk ka gjendje të ndryshueshme. `StatefulWidget` ka `State<T>` dhe `setState()` për të ndërtuar ri-widget-in kur të dhënat ndryshojnë. |
| **Layout Widgets** | `Padding`, `SizedBox`, `Expanded`, `Card`, `GridView`, `ListView`, `AnimatedList` |
| **TextField & Controller** | `TextEditingController` lidh widget-in me logjikën. `TextFormField` + `Form` mundëson validim automatik. |
| **Form Validation** | `validator:` callback, `autovalidateMode: AutovalidateMode.onUserInteraction`, dhe `_formKey.currentState!.validate()` |
| **ThemeData** | Tema e errët me ngjyra të personalizuara nëpërmjet `ColorScheme.dark()` dhe `InputDecorationTheme` |
| **Responsiveness** | `MediaQuery.of(context).size.width` për të dalluar desktop nga mobile dhe ndryshuar layout-in |

---

## 2. Aplikacioni: Student Portal

### Funksionalitetet
1. **Lista e Studentëve** – shfaq kartat e të gjithë studentëve me emër, email, departament, GPA dhe badge statusi.
2. **Dashboard Stats** – tregon numrin total të studentëve dhe GPA mesatare.
3. **Forma e Regjistrimit** – lejon shtimin e studentëve të rinj.
4. **Validim i plotë** – tregon mesazhe gabimi nën çdo fushë nëse:
   - Emri është bosh ose ka më pak se 3 karaktere.
   - Email-i nuk ka formatin e saktë (regex).
   - ID e studentit nuk është saktësisht 6 shifra.
   - GPA nuk është ndërmjet 1.0 dhe 10.0.
5. **Responsive** – në desktop (> 768px) forma shfaqet si sidebar; në mobile si modal bottom sheet.
6. **Animacion** – studentët e rinj shfaqen me `AnimatedList` + `SizeTransition` + `FadeTransition`.

---

## 3. Shembull kodi – Validimi i Email-it

```dart
String? _validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email-i nuk mund të jetë bosh.';
  }
  final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false);
  if (!emailRegex.hasMatch(value.trim())) {
    return 'Shkruani një email të vlefshëm (p.sh. emri@domain.com).';
  }
  return null;
}
```

---

## 4. Lidhja me C (Java e Ditës 1)

| Logjika C | Ekuivalenti Dart/Flutter |
| :--- | :--- |
| `if (strlen(name) < 3)` | `if (value.trim().length < 3)` |
| `sscanf(input, "%lf", &gpa); if (gpa < 1 \|\| gpa > 10)` | `double? gpa = double.tryParse(v); if (gpa < 1.0 \|\| gpa > 10.0)` |
| `regex.h` për pattern matching | `RegExp(r'...')` i Dart |

---

## 5. Commits të bëra sot

| # | Mesazhi i Commit-it | Funksionaliteti |
|:---|:---|:---|
| 1 | `Day 2 - Commit 1: Setup student portal app and initial layout` | Struktura fillestare e projektit, layout dhe të dhëna mock |
| 2 | `Day 2 - Commit 2: Add StatefulWidget form UI and responsive layout` | Forma e shtimit të studentëve, sidebar/bottom sheet |
| 3 | `Day 2 - Commit 3: Add full form validation with inline error messages` | Validim regex, rangjeve dhe mesazheve inline |
| 4 | `Day 2 - Commit 4: Final visual polish, AnimatedList, empty state, error borders` | Animacion, gjendja bosh, tema e finalizuar |

---

## 6. Si të ekzekutoni aplikacionin

### Online (FlutLab / DartPad)
1. Ngarkoni dosjen `Day2/student_portal_app/` në [FlutLab.io](https://flutlab.io).
2. Klikoni **Run**.

### Lokalisht
```bash
cd "Day2/student_portal_app"
flutter pub get
flutter run
```
