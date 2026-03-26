# RemediationScript-CompliancePolicy

# 🔧 Intune Remediation Scripts – Windows

A curated collection of **PowerShell remediation scripts for Windows devices**, designed to be deployed via **Microsoft Intune Proactive Remediations**.

This repository focuses on **security drift correction**, ensuring endpoints remain compliant with defined baselines and Zero Trust principles.

---

## 🎯 Purpose

Modern endpoint environments drift.

Even with strong baselines, devices can become **non-compliant over time** due to:
- User changes
- Application behavior
- OS inconsistencies
- Policy gaps

This repository provides **automated remediation scripts** to bring devices back into a **secure and compliant state**.

---

## ⚙️ Use Case

These scripts are intended for:

- Microsoft Intune (Endpoint Analytics → Proactive Remediations)
- Cloud-native / Entra ID joined devices
- Security baseline enforcement
- Continuous compliance monitoring

---

## 🧱 Structure

Each remediation follows a consistent pattern:
/ScriptName
├── Detect.ps1
├── Remediate.ps1
└── README.md

### Detect Script
- Checks current state
- Returns:
  - `0` = Compliant
  - `1` = Non-compliant

### Remediation Script
- Applies required fix
- Logs actions
- Returns:
  - `0` = Success
  - `1` = Failed

---

## 🔐 Focus Areas

Scripts in this repository typically cover:

- Defender configuration (AV, ASR, Tamper Protection)
- Windows security settings
- BitLocker enforcement
- Firewall configuration
- Registry-based hardening
- CIS / Microsoft Security Baseline alignment
- Local security policies
- OS configuration drift

---

## 🚀 Deployment (Intune)

1. Go to **Microsoft Intune Admin Center**
2. Navigate to: Reports → Endpoint Analytics → Proactive Remediations
3. Create a new remediation:
- Upload `Detect.ps1`
- Upload `Remediate.ps1`
4. Assign to device group
5. Configure schedule

---

## 🧠 Design Principles

- **Idempotent** → Safe to run multiple times  
- **Minimal impact** → No unnecessary changes  
- **Transparent** → Clear logging and output  
- **Secure by default** → Align with Zero Trust  
- **Cloud-native first** → No legacy dependencies  

---

## 📊 Why Remediation Matters

Compliance policies alone only **detect issues**.

Remediation ensures:
- Faster recovery from drift
- Reduced operational overhead
- Improved security posture
- Better user experience

---

## ⚠️ Important Notes

- Always test scripts in **pilot groups**
- Validate against your **security baseline**
- Some settings may conflict with:
- GPO (Hybrid environments)
- Third-party tools
- Use with proper change management

---

## 🤝 Contributing

Contributions are welcome.

When adding new scripts:
- Follow the standard structure
- Include documentation
- Keep scripts clean and readable
- Avoid environment-specific dependencies

---

## 📌 Disclaimer

These scripts are provided **as-is**.

Test thoroughly before deploying to production environments.

---

## 🔗 Inspiration

This project is inspired by the need for **continuous compliance**, similar in spirit to tools like:
- HardeningKitty (Windows baseline validation)

---

## 👨‍💻 Author

Simon Eriksen  
Cloud Solutions Architect | Microsoft MVP  
Focused on Intune, Security, and Modern Endpoint Management

---

## ⭐ Support

If you find this useful:
- Star the repo
- Share feedback
- Contribute improvements
