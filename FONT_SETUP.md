# Font Setup — One-Time Step

The project uses **locally bundled Poppins** instead of the `google_fonts` package
to avoid runtime fetch errors on all platforms.

---

## Option A — Automatic (run the script)

```bash
cd portfolio_app
bash download_fonts.sh
```

---

## Option B — Manual (2 minutes)

1. Go to: https://fonts.google.com/specimen/Poppins
2. Click **"Download family"** (top right)
3. Extract the ZIP — you'll get a folder with many `.ttf` files
4. Create the folder `portfolio_app/assets/fonts/`
5. Copy **exactly these 6 files** into it:

```
assets/fonts/
├── Poppins-Regular.ttf
├── Poppins-Italic.ttf
├── Poppins-Medium.ttf
├── Poppins-SemiBold.ttf
├── Poppins-Bold.ttf
└── Poppins-ExtraBold.ttf
```

6. Then run:
```bash
flutter pub get
flutter run
```

---

## Option C — Use any other font you already have

If you have another `.ttf` font locally, update `pubspec.yaml`
to point to it and change `fontFamily: 'Poppins'` in
`lib/core/poppins.dart` to your font name.

---

## Why no `google_fonts` package?

The `google_fonts` package fetches fonts at runtime from Google's CDN.
On some setups (offline, firewalls, certain Android emulators) this fails silently
and text renders with the default system font. Bundling fonts locally is the
production-safe approach for all 6 platforms.
