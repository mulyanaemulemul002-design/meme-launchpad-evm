# Integration Guide (Setup & Deployment)

Prerequisites:
- Node.js (>=16), npm/yarn
- Hardhat (atau Foundry/Truffle)
- Alat untuk deployment: ethers.js, hardhat-deploy
- Wallet private key & RPC URL (Alchemy, Infura, or public RPC)

Environment (.env) contoh:

```
PRIVATE_KEY=0x...
RPC_URL=https://rpc.base.org
ETHERSCAN_API_KEY=...
```

Langkah cepat (Hardhat):
1. Buat project baru untuk smart contracts
   - npx hardhat
2. Tambahkan dependensi
   - npm i --save-dev @nomiclabs/hardhat-ethers ethers hardhat-deploy
   - npm i @openzeppelin/contracts
3. Tarik atau adaptasi kontrak dari repo referensi (memeLauncher, fourmeme ABI)
4. Buat deployment scripts
   - Deploy TokenFactory
   - Deploy BondingCurvePool (parameter: initialVirtualReserve, curveParams)
   - Deploy FeeDistributor (alamat dev/creator)
   - Deploy Vesting (gunakan OpenZeppelin VestingWallet)

Contoh deploy script (pseudo):

- deploy/01_deploy_factory.js
- deploy/02_deploy_curve.js
- deploy/03_deploy_fee_distributor.js

Verifikasi setelah deploy:
- Gunakan Hardhat Etherscan plugin untuk verify contracts

Frontend integration:
- Buat config file untuk addresses.json berisi contract addresses
- Implement operator functions: createLaunch(), buyOnCurve(), migrateLiquidity(), claimVested()

Testing:
- Unit tests: coverage untuk buy/sell, fee calc, vesting
- Simulate heavy buys to test migration logic

Security checklist:
- Multisig untuk migration / treasury addresses
- Limit per-address buys (anti-bot) optional
- Time-locks untuk admin functions

