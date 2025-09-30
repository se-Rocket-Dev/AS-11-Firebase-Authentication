# Flutter Firebase Auth + Student Event Register (Local DB)

แอปตัวอย่าง **Firebase Authentication (Email/Password)** ที่เพิ่มฟีเจอร์ **ลงทะเบียนเข้าร่วมกิจกรรมของนักศึกษา**  
ข้อมูลนักศึกษา (*รหัส, ชื่อ, นามสกุล, หลักสูตร, ชื่อกิจกรรม*) ถูกบันทึกลง **SQLite (sqflite)** และจัดการสถานะด้วย **Provider**

---

## ✨ ฟีเจอร์
- 🔐 **Auth**: สมัครสมาชิก / เข้าสู่ระบบ / ออกจากระบบ (Firebase Auth)
- 📝 **ลงทะเบียนกิจกรรม (Local DB)**: บันทึกข้อมูลนักศึกษาไว้บนเครื่องด้วย SQLite
- 📋 **รายการผู้ลงทะเบียน**: ดู/ลบ/ลบทั้งหมด
- ✅ **Validation + Snackbar** สื่อสารสถานะชัดเจน
- 🧠 **Provider** จัดการ loading/state
- 🎨 **Gradient UI** + Google Fonts (Prompt)
- 🔁 สลับหน้าอัตโนมัติด้วย `authStateChanges()`

---

## 🧱 โครงสร้างโปรเจกต์
```
lib/
├─ main.dart                         # ฟัง authStateChanges() แล้วสลับหน้า (เข้าหน้ารายการเมื่อ Login)
├─ firebase_options.dart             # สร้างจาก flutterfire configure
├─ models/
│  └─ student.dart
├─ services/
│  └─ local_db.dart                  # Sqflite service
├─ providers/
│  ├─ auth_provider.dart             # AppAuthProvider (Firebase Auth)
│  └─ student_provider.dart          # CRUD กับ SQLite
├─ screens/
│  ├─ auth_screen.dart               # auth container + toggle Login/Register
│  ├─ student_list_screen.dart       # รายชื่อผู้ลงทะเบียน + ปุ่มไปฟอร์ม
│  ├─ event_register_screen.dart     # ฟอร์มลงทะเบียนกิจกรรม
│  └─ reset_password_screen.dart     # ส่งอีเมลรีเซ็ตรหัสผ่าน
├─ widgets/
│  └─ auth_form.dart                 # ฟอร์ม Login/Register + validation
└─ utils/
   └─ snack.dart
```

---

## 📸 ตัวอย่างหน้าจอ

### 1) Authentication
| Login | Register |
|---|---|
| <img src="https://github.com/user-attachments/assets/7c6ef3b4-9bd3-4534-8534-d1f84acb95e9" width="280" /> | <img src="https://github.com/user-attachments/assets/d0213d7b-43ec-46d9-910c-b06875ca52dd" width="280" /> |

**ตรวจผู้ใช้ใน Firebase**
| Users | Project Settings |
|---|---|
| <img src="https://github.com/user-attachments/assets/0fe40896-4c77-4b91-a1da-8dc0a2adb19b" width="420" /> | <img src="https://github.com/user-attachments/assets/c22dcc83-78c8-487b-ab9f-4357560383ed" width="420" /> |

### 2) ลงทะเบียนกิจกรรม (Local DB)
| ฟอร์มลงทะเบียน | แสดงในรายการ |
|---|---|
| <img src="https://github.com/user-attachments/assets/60f1a06a-2c33-4602-bdc6-8e752f0d631d" width="280" /> | <img src="https://github.com/user-attachments/assets/2e92d154-14c6-414f-a67d-147bf34fd8f4" width="280" /> |

---

## 🚀 ติดตั้ง & รัน
> ต้องมี Flutter SDK และ Firebase Project

1. ติดตั้งแพ็กเกจ
   ```bash
   flutter pub get
   ```
2. เชื่อม Firebase (สร้าง `lib/firebase_options.dart` อัตโนมัติ)
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
3. **Android**
   - วาง `android/app/google-services.json`
   - ให้ `applicationId` ตรงกับ Package บน Firebase
   - แนะนำเพิ่ม **SHA‑1/256 (debug)** แล้วดาวน์โหลด `google-services.json` ใหม่
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - รัน
     ```bash
     flutter run -d <android-device>
     ```
---

## 🔄 การใช้งาน
1. เปิดแอป → **Login/Register**
2. Login สำเร็จ → เข้าหน้า **รายการผู้ลงทะเบียน**
3. กด **ลงทะเบียน** → กรอก *รหัส/ชื่อ/นามสกุล/หลักสูตร/ชื่อกิจกรรม* → **บันทึก**
4. ดูรายการ / ลบ / ลบทั้งหมด ได้จากหน้าเดียวกัน
5. **Logout** เพื่อกลับหน้า Auth

---

## 🩹 ปัญหาที่พบบ่อย
- **`[CONFIGURATION_NOT_FOUND]` (Android):** ใช้ emulator Google Play, เพิ่ม SHA‑1/256 (debug) แล้ว `flutter clean && flutter pub get && flutter run`
- **Gradle plugin conflict:** อย่าประกาศ `com.google.gms.google-services` ซ้ำหลายไฟล์
- **iOS min version:** ตั้ง `platform :ios, '15.0'` แล้ว `pod install` ใหม่
