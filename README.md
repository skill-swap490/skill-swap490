# SkillSwap

SkillSwap is a cross-platform app (Web, iOS, Android) that helps people **learn new skills** and **share their expertise** through peer-to-peer exchanges.

This repository contains the source code for our Senior Design project (COMP 490), built with **Flutter (Dart)** and backed by **Firebase**.

---

## Getting Started

### Run in GitHub Codespaces (Web)
1. Open this repo in **Codespaces**.
2. In the terminal, run:
   ```bash
   flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
   ```
3. Click the **Forwarded Port 8080** link to preview.

### Run Locally

1. Install Flutter: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
2. Clone the repo:
   ```bash
   git clone https://github.com/skill-swap490/skill-swap490.git
   cd skill-swap490
   ```
3. Run (web, using Chrome):
   ```bash
   flutter run -d chrome
   ```

---

## Project Structure

```text
skill-swap490/
├─ lib/                     # Main app code (Dart/Flutter)
│  ├─ screens/              # UI pages (Intro, Browse, Messages, etc.)
│  └─ services/             # App logic (Auth, Chat, Matching) [to be added]
├─ web/                     # Web entry (index.html), icons
├─ android/                 # Android scaffolding (Gradle, manifests)
├─ ios/                     # iOS scaffolding (Xcode project, plist)
├─ windows/ linux/ macos/   # Desktop scaffolding (optional)
├─ test/                    # Unit/widget tests
├─ pubspec.yaml             # Packages & app metadata (like package.json)
├─ pubspec.lock             # Locked dependency versions (auto-generated)
├─ analysis_options.yaml    # Lint rules
├─ docs/                    # Deliverables (PDFs, slides, reports)
└─ README.md
```

---

## Documentation

For full technical details, see the **Wiki**:

* **Wiki Home:** [https://github.com/jkalski/490-Senior-Design/wiki](https://github.com/jkalski/490-Senior-Design/wiki)
* **Architecture Overview:** [https://github.com/jkalski/490-Senior-Design/wiki/Architecture-Overview](https://github.com/jkalski/490-Senior-Design/wiki/Architecture-Overview)
* **Database Schema:** [https://github.com/jkalski/490-Senior-Design/wiki/Database-Schema](https://github.com/jkalski/490-Senior-Design/wiki/Database-Schema)
* **Views (UI/UX):** [https://github.com/jkalski/490-Senior-Design/wiki/Views](https://github.com/jkalski/490-Senior-Design/wiki/Views)
* **REST API & Controllers:** [https://github.com/jkalski/490-Senior-Design/wiki/REST-API-&-Controllers](https://github.com/jkalski/490-Senior-Design/wiki/REST-API-&-Controllers)
* **Deployment Plan:** [https://github.com/jkalski/490-Senior-Design/wiki/Deployment](https://github.com/jkalski/490-Senior-Design/wiki/Deployment)
* **Design Considerations:** [https://github.com/jkalski/490-Senior-Design/wiki/Design-Considerations](https://github.com/jkalski/490-Senior-Design/wiki/Design-Considerations)


---

## Team

* Talin Keshesh — Backend Functions & Auth
* Sako Asatryan — Data Models & Chat
* Zakir Rizvi — CI/CD & Testing
* BachViet Nguyen — Search/AI & Location Services
* Justin Kalski — Lead Frontend & Integrations
