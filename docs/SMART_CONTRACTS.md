# SMART CONTRACTS - Referensi & Komponen yang Bisa Dipakai

Referensi open-source yang relevan:
- Four.meme (BSC) — ABI dan inspirasi bonding curve & auto-liquidity
  - https://github.com/jesusmeme/fourmeme-abi
  - https://github.com/leetesla/bsc-fourmeme-abi

- Meme Launcher (Base) — contoh lengkap Solidity + frontend untuk automated Uniswap V3 liquidity
  - https://github.com/cypherpulse/memeLauncher

- Pump.fun (Solana) — bonding curve + fee distribution pattern. Perlu adaptasi logic ke Solidity.
  - https://github.com/justFiveDev/Solana-Pumpfun-Smart-Contract
  - Public docs: https://github.com/pump-fun/pump-public-docs
  - SDK: https://www.npmjs.com/package/@pump-fun/pump-sdk

Vesting references:
- OpenZeppelin VestingWallet
  - https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/finance/VestingWallet.sol
- Token vesting example
  - https://github.com/MrNuthikatla/token-vesting-contract

Kontrak yang direkomendasikan untuk implementasi EVM:

1. TokenFactory (Solidity)
   - Fungsi: deploy token ERC20 dengan parameter custom
   - Access: onlyOwner/onlyFactoryAllowed

2. BondingCurvePool (Solidity)
   - Fungsi: buy(), sell(), priceForAmount(), amountForPrice()
   - Storage: totalSupplyOnCurve, virtualReserve
   - Events: Bought, Sold, LiquidityMigrated

3. LiquidityManager (Solidity)
   - Fungsi: createDexPool(), addLiquidity(), migrateToDex()
   - Integrasi: router Uniswap/Pancake

4. FeeDistributor (Solidity)
   - Fungsi: takeFee(amount), distribute()
   - Config: devAddress, creatorAddress, protocolShare

5. VestingWallet (use OpenZeppelin)
   - Gunakan OpenZeppelin VestingWallet untuk keamanan dan kompatibilitas

Contoh interface pendek untuk FeeDistributor:

```solidity
interface IFeeDistributor {
    function distribute(address token, uint256 amount) external;
}
```

Catatan:
- Reuse ABI dari fourmeme untuk mengerti parameter kontrak live di BSC, tetapi jangan copy blind ke production.
- Lakukan testing intensif di testnet (Goerli, BSC testnet, Base testnet)
