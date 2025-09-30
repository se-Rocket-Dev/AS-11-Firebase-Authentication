# Flutter Firebase Auth (Provider + Gradient UI)

แอปตัวอย่างระบบ **Authentication** ด้วย **Firebase Authentication** บน **Flutter**  
รองรับ **Login / Register / Reset Password** พร้อม **Validation**, **Snackbar**, **State Management ด้วย Provider**, และ **พื้นหลัง Gradient โทนฟ้า–ม่วง**  
สลับหน้าจออัตโนมัติด้วย `FirebaseAuth.instance.authStateChanges()` (Logout แล้วกลับหน้า Auth ทันที)

---

## ✨ ฟีเจอร์

- 🔐 **Email/Password Auth** (สมัครสมาชิก/เข้าสู่ระบบ/ออกจากระบบ)
- 🛠 **Reset Password** (ส่งลิงก์รีเซ็ตผ่านอีเมล)
- ✅ **Form Validation** + **Snackbar** แจ้งเตือนสวย ๆ
- 🧠 **Provider (ChangeNotifier)** จัดการ state และ loading
- 🎨 **Gradient UI** โทนฟ้า–ม่วง + Google Fonts (Prompt)
- 🧭 ป้องกันการใช้ `context` หลัง widget dispose (`if (!mounted) return;`)
- 🔁 Routing อัตโนมัติจาก **authStateChanges()** (ไม่ต้องกด back stack เอง)

---

## 🧱 โครงสร้างโปรเจกต์

```
lib/
├─ main.dart                         # ฟัง authStateChanges() แล้วสลับหน้า
├─ firebase_options.dart             # สร้างจาก flutterfire configure
├─ providers/
│  └─ auth_provider.dart             # AppAuthProvider (ChangeNotifier)
├─ screens/
│  ├─ auth_screen.dart               # UI ครอบฟอร์ม + ปุ่มสลับ Login/Register
│  ├─ home_screen.dart               # หน้าหลัก + ปุ่ม Logout
│  └─ reset_password_screen.dart     # ส่งอีเมลรีเซ็ตรหัสผ่าน
├─ widgets/
│  └─ auth_form.dart                 # ฟอร์ม Login/Register + validation
└─ utils/
   └─ snack.dart                     # helper แสดง SnackBar
```

---

## 🧰 เทคโนโลยีที่ใช้

- **Flutter** (Material 3)
- **Firebase**: `firebase_auth`, `firebase_core`
- **State Management**: `provider`
- **UI/Font**: `google_fonts (Prompt)`

---

## 🚀 การติดตั้ง & รัน

> ต้องติดตั้ง Flutter SDK และมีบัญชี Firebase

1. **โคลนโปรเจกต์**
   ```bash
   git clone <repo-url>
   cd <project-folder>
   flutter pub get
   ```

2. **เชื่อม Firebase**
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   จะได้ไฟล์ `lib/firebase_options.dart` อัตโนมัติ

3. **Android**
   - วาง `google-services.json` ที่ `android/app/`
   - ตรวจ `applicationId` ให้ตรงกับ package ที่ลงทะเบียนใน Firebase
   - แนะนำเพิ่ม **SHA-1/256 (debug)** ใน Firebase แล้วดาวน์โหลด `google-services.json` ใหม่  
     ดูค่าได้จาก:
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - รัน
     ```bash
     flutter run -d <android-device-or-emulator>
     ```
   - **แนะนำใช้อีมูเลเตอร์ Google Play (มีไอคอน ▶️ Play Store)**

4. **iOS (ถ้าใช้)**
   - แก้ `ios/Podfile`:
     ```ruby
     platform :ios, '15.0'
     ```
   - เปิดโครงการ iOS ด้วย Xcode แล้วให้ `Bundle Identifier` ตรงกับที่ลงทะเบียนใน Firebase
   - รันบน Simulator/Device (Apple Silicon ใช้ iOS simulator arm64)

---

## 🔄 วิธีใช้งาน (Flow)

1. เปิดแอป → หน้า **Login**
2. สลับไป **Register** หากยังไม่มีบัญชี
3. สมัครสำเร็จหรือ Login สำเร็จ → ไป **หน้า Home**
4. กด **Logout** → แอปกลับหน้า **Auth** อัตโนมัติ (เพราะเราฟัง `authStateChanges()`)

---

## 🧭 แนวทางออกแบบสำคัญ

- ใช้ `StreamBuilder<User?>` ฟัง `FirebaseAuth.instance.authStateChanges()` ใน `main.dart` เพื่อสลับหน้า → ไม่ต้องจัดการ stack เองตอน logout
- ในงาน async (เช่น signIn/signUp) ใช้ `if (!mounted) return;` ก่อนใช้ `context` เพื่อกัน error หลัง dispose
- จัดการ loading ใน Provider (`ChangeNotifier`) แล้ว `context.watch()` เพื่อ disable ปุ่ม/แสดงวงกลมโหลด

---

## 🩹 Troubleshooting

- **`[CONFIGURATION_NOT_FOUND]` (Android)**
  - ใช้ emulator **Google Play**
  - เพิ่ม **SHA-1/256 (debug)** ที่ Firebase แล้ว **ดาวน์โหลด `google-services.json` ใหม่**
  - ลบแอปจาก emulator แล้ว `flutter clean && flutter pub get && flutter run`
- **Gradle plugin version conflict**
  - อย่าประกาศ `com.google.gms.google-services` ซ้ำหลายเวอร์ชันทั้งใน `settings.gradle.kts` และ `android/build.gradle.kts`
- **iOS build error: min iOS too low**
  - ตั้ง `platform :ios, '15.0'` ใน `Podfile` และ `flutter clean && cd ios && pod install && cd ..`

---

## 📄 ใบอนุญาต
MIT (หรือเติมตามที่คุณต้องการ)

---

## 🙌 เครดิต
UI/Flow และ README นี้มาจากการปรับปรุงโปรเจกต์จริง เพื่อให้อ่านง่ายและครบถ้วนสำหรับผู้ใช้ใหม่
