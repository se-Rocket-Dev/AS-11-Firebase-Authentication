# Flutter Firebase Auth + Student Event Register (Local DB)

แอปตัวอย่าง **ระบบยืนยันตัวตน (Firebase Authentication)** พร้อม **ลงทะเบียนเข้าร่วมกิจกรรมของนักศึกษา**  
ข้อมูลนักศึกษา (รหัส, ชื่อ, นามสกุล, หลักสูตร, ชื่อกิจกรรม) ถูกบันทึกลง **ฐานข้อมูลภายในเครื่อง (SQLite - sqflite)** และจัดการสถานะด้วย **Provider**  
UI ใช้พื้นหลัง **Gradient โทนฟ้า–ม่วง**, มี **Validation + Snackbar**, และสลับหน้าอัตโนมัติด้วย `FirebaseAuth.instance.authStateChanges()`

---

## ✨ ฟีเจอร์
- 🔐 **Email/Password Auth**: สมัครสมาชิก / เข้าสู่ระบบ / ออกจากระบบ
- 🧾 **ลงทะเบียนกิจกรรม (Local DB)**: บันทึก *รหัส, ชื่อ, นามสกุล, หลักสูตร, ชื่อกิจกรรม* ด้วย SQLite
- 🗂 **รายชื่อผู้ลงทะเบียน**: ดูรายการ / ลบรายการ / ลบทั้งหมด
- ✅ **Form Validation** + **Snackbar** แจ้งเตือน
- 🧠 **State Management**: `provider` (ChangeNotifier)
- 🎨 **Gradient UI** + Google Fonts (Prompt)
- 🧭 ป้องกันการใช้ `context` หลัง widget dispose (`if (!mounted) return;`)
- 🔁 Routing อัตโนมัติจาก `authStateChanges()`

---

## 🧱 โครงสร้างโปรเจกต์ (สำคัญ)
```
lib/
├─ main.dart                         # ฟัง authStateChanges() แล้วสลับหน้า (ไปหน้ารายการหลัง Login)
├─ firebase_options.dart             # สร้างจาก flutterfire configure
├─ models/
│  └─ student.dart                   # โมเดล Student
├─ services/
│  └─ local_db.dart                  # Sqflite service
├─ providers/
│  ├─ auth_provider.dart             # AppAuthProvider (Firebase Auth)
│  └─ student_provider.dart          # จัดการ CRUD กับ SQLite
├─ screens/
│  ├─ auth_screen.dart               # UI ครอบฟอร์ม + สลับ Login/Register
│  ├─ student_list_screen.dart       # รายการผู้ลงทะเบียน + ปุ่มไปหน้าฟอร์ม
│  ├─ event_register_screen.dart     # ฟอร์มลงทะเบียนกิจกรรม
│  └─ reset_password_screen.dart     # ส่งอีเมลรีเซ็ตรหัสผ่าน
├─ widgets/
│  └─ auth_form.dart                 # ฟอร์ม Login/Register + validation
└─ utils/
   └─ snack.dart                     # helper แสดง SnackBar
```

---

## 📸 ตัวอย่างหน้าจอ

### 1) Authentication
**Login**
<img width="295" height="522" alt="Screenshot 2568-09-30 at 10 30 32" src="https://github.com/user-attachments/assets/7c6ef3b4-9bd3-4534-8534-d1f84acb95e9" />

**Register**
<img width="305" height="529" alt="Screenshot 2568-09-30 at 10 30 41" src="https://github.com/user-attachments/assets/d0213d7b-43ec-46d9-910c-b06875ca52dd" />

**ตรวจผู้ใช้ใน Firebase**
<img width="325" height="676" alt="Screenshot 2568-09-30 at 11 43 09" src="https://github.com/user-attachments/assets/0fe40896-4c77-4b91-a1da-8dc0a2adb19b" />
<img width="1440" height="607" alt="Screenshot 2568-09-30 at 11 43 52" src="https://github.com/user-attachments/assets/c22dcc83-78c8-487b-ab9f-4357560383ed" />

### 2) ลงทะเบียนกิจกรรม (Local DB)
**ฟอร์มลงทะเบียน**
<img width="324" height="688" alt="Screenshot 2568-09-30 at 12 28 57" src="https://github.com/user-attachments/assets/60f1a06a-2c33-4602-bdc6-8e752f0d631d" />

**บันทึกสำเร็จ / แสดงในรายการ**
<img width="314" height="640" alt="Screenshot 2568-09-30 at 12 29 57" src="https://github.com/user-attachments/assets/2e92d154-14c6-414f-a67d-147bf34fd8f4" />

---

## 🧰 เทคโนโลยีที่ใช้
- **Flutter** (Material 3)
- **Firebase**: `firebase_auth`, `firebase_core`
- **Local DB**: `sqflite`, `path`
- **State Management**: `provider`
- **Font/UI**: `google_fonts` (Prompt), Gradient UI

---

## 🚀 การติดตั้ง & รัน
> ต้องติดตั้ง Flutter SDK และมีบัญชี Firebase

1) **ติดตั้งแพ็กเกจ**
```bash
flutter pub get
```

2) **เชื่อม Firebase** (สร้าง `lib/firebase_options.dart` อัตโนมัติ)
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

3) **Android**
- วาง `google-services.json` ที่ `android/app/`
- ให้ `applicationId` ตรงกับที่ลงทะเบียนใน Firebase
- แนะนำเพิ่ม **SHA‑1/256 (debug)** ใน Firebase แล้วดาวน์โหลด `google-services.json` ใหม่
  ```bash
  cd android
  ./gradlew signingReport
  ```
- รัน
  ```bash
  flutter run -d <android-device-or-emulator>
  ```
- *แนะนำใช้อีมูเลเตอร์ Google Play (มีไอคอน Play Store)*

4) **iOS** (ถ้าใช้)
- แก้ `ios/Podfile` → `platform :ios, '15.0'`
- เปิด Xcode ให้ `Bundle Identifier` ตรงกับ Firebase
- รันบน Simulator/Device (Apple Silicon ใช้ simulator arm64)

---

## 🔄 การใช้งาน (Flow)
1) เปิดแอป → **Login/Register**
2) Login สำเร็จ → ไปหน้า **รายการผู้ลงทะเบียน**
3) กด **ลงทะเบียน** → กรอก *รหัส/ชื่อ/นามสกุล/หลักสูตร/ชื่อกิจกรรม* → **บันทึก**
4) ดูรายการ ลบรายการ หรือลบทั้งหมดได้
5) กด **Logout** → กลับหน้า Auth อัตโนมัติ

---

## 🩹 Troubleshooting
- **`[CONFIGURATION_NOT_FOUND]` (Android)**  
  ใช้ emulator **Google Play**, เพิ่ม SHA‑1/256 (debug), ดาวน์โหลด `google-services.json` ใหม่, แล้ว `flutter clean && flutter pub get && flutter run`
- **Gradle plugin version conflict**  
  อย่าประกาศ `com.google.gms.google-services` ซ้ำหลายเวอร์ชันในไฟล์ Gradle
- **iOS: min iOS ต่ำเกินไป**  
  ตั้ง `platform :ios, '15.0'` ใน `Podfile` แล้ว `flutter clean && cd ios && pod install && cd ..`
