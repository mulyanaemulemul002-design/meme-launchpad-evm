# Vesting & Launch Stages

Common stages:
1. Pre-launch / Setup
2. Launch (bonding curve live)
3. Growth (liquidity accumulates)
4. Migration (move to DEX on threshold)
5. Post-launch (vesting release ongoing)

Vesting parameters yang umum:
- startTimestamp
- cliffDuration (seconds)
- duration (seconds)
- totalAmount
- revocable (bool)

Contoh penggunaan OpenZeppelin VestingWallet:

```solidity
// deploy per beneficiary
VestingWallet vest = new VestingWallet(beneficiary, start, duration);
ERC20(token).transfer(address(vest), amountToVest);
```

Multiple beneficiaries:
- Buat schedule per beneficiary atau gunakan multi-schedule manager
- Pastikan claim() hanya mengeluarkan vested amount

Testing tips:
- Gunakan time travel di Hardhat untuk test cliff dan linear release
- Validasi jumlah vested setelah tiap interval

