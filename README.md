# Flutter Firebase Auth

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

## 📸 สกรีนช็อต

> ลิงก์ด้านล่างเป็นตัวอย่างตามที่คุณแนบไว้ก่อนหน้า ถ้าต้องการเปลี่ยนภาพ ให้แทนที่ URL ด้วยรูปที่อัปโหลดใน GitHub (เช่นใน Issues/PR หรือ Releases)

### หน้าแรก (Login)
<img width="295" height="522" alt="Screenshot 2568-09-30 at 10 30 32" src="https://github.com/user-attachments/assets/7c6ef3b4-9bd3-4534-8534-d1f84acb95e9" />

### หน้า Register
<img width="305" height="529" alt="Screenshot 2568-09-30 at 10 30 41" src="https://github.com/user-attachments/assets/d0213d7b-43ec-46d9-910c-b06875ca52dd" />

### หลัง Register / ตรวจที่ Firebase
<img width="325" height="676" alt="Screenshot 2568-09-30 at 11 43 09" src="https://github.com/user-attachments/assets/0fe40896-4c77-4b91-a1da-8dc0a2adb19b" />
<img width="1440" height="607" alt="Screenshot 2568-09-30 at 11 43 52" src="https://github.com/user-attachments/assets/c22dcc83-78c8-487b-ab9f-4357560383ed" />

### ทดสอบ Login/Logout
<img width="335" height="678" alt="Screenshot 2568-09-30 at 11 50 58" src="https://github.com/user-attachments/assets/cc1c9dba-ae81-489a-a739-64d83f761ce8" />
<img width="313" height="671" alt="Screenshot 2568-09-30 at 12 05 19" src="https://github.com/user-attachments/assets/8971f3c5-c9a9-4e66-9812-a100940b0dd6" />

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
