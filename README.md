# Meme Launchpad (EVM)

Repository berisi dokumentasi dan panduan integrasi untuk membangun launchpad meme token di EVM-compatible chains (Base, BSC, Ethereum). Tujuan: memanfaatkan smart contract open-source (bonding curve, liquidity automation, vesting, fee distribution) agar Anda tidak perlu menulis semua smart contract dari nol.

Quick links:
- docs/ARCHITECTURE.md — Arsitektur sistem
- docs/SMART_CONTRACTS.md — Referensi smart contract yang bisa dipakai
- docs/INTEGRATION_GUIDE.md — Langkah setup & deployment
- docs/FEE_DISTRIBUTION.md — Mekanisme pembagian fee
- docs/VESTING_STAGES.md — Vesting & launch stages
- docs/REFERENCES.md — Link sumber & repositori referensi

Quick start (local):
1. Clone repo ini ke lokal.
2. Siapkan project smart contract (Hardhat/Foundry/Truffle) untuk menaruh kontrak Anda.
3. Ikuti `docs/INTEGRATION_GUIDE.md` untuk langkah deploy dan integrasi.

Kontribusi:
- Buat PR ke branch `main`.
- Gunakan issue untuk diskusi fitur dan perbaikan.

License: Tambahkan lisensi yang Anda inginkan (mis. MIT) di file LICENSE.
