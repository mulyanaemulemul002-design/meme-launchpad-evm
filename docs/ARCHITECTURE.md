# Arsitektur Sistem

Tujuan: membangun launchpad token yang cepat, aman, dan reuseable untuk EVM. Komponen utama:

1. TokenFactory / Launcher
   - Deploy ERC20 token (parameter supply, name, symbol, tax/fee flags)
   - Menyediakan integrasi dengan BondingCurve contract atau langsung set token ke pool

2. BondingCurvePool
   - Menangani pembelian/penjualan token melalui kurva harga (bonding curve)
   - Menghitung harga per token berdasarkan supply yang berubah
   - Menyimpan virtual reserves jika diperlukan

3. LiquidityManager
   - Mengotomasi pembuatan liquidity di DEX (Uniswap/PancakeSwap)
   - Migrasi otomatis ke DEX saat threshold tercapai (rug-proof)

4. VestingManager
   - Mengatur vesting schedules (cliff, linear release)
   - Interface ke OpenZeppelin VestingWallet atau custom vesting contract

5. FeeDistributor
   - Mengumpulkan dan mendistribusikan fee transaksi ke developer/creator/protocol
   - Opsional: swap fee token ke stablecoin lalu transfer

6. Frontend & Backend
   - Frontend React/Vue untuk UX launch flow
   - Backend optional untuk monitoring, off-chain calculations, analytics

Sequence flow (simplified):
1. Creator mendaftar di frontend -> memberikan parameter launch
2. TokenFactory deploy token contract
3. BondingCurvePool dibuat (virtual reserve optional)
4. Penjualan dimulai — peserta beli token lewat bonding curve
5. FeeDistributor memotong fee pada tiap beli/jual dan mendistribusikan
6. Saat threshold tercapai LiquidityManager migrasi likuiditas ke DEX
7. VestingManager mengontrol release token creator/team

Safety & best practices:
- Gunakan OpenZeppelin untuk ERC20 dan access control
- Batasi akses admin dan gunakan multisig untuk operasi kunci (migration)
- Lakukan audit minimal untuk kontrak yang berinteraksi dengan dana
