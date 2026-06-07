# Fee Distribution

Model umum pembagian fee (bisa disesuaikan):
- Buy/Sell fee: 1% dari nilai transaksi
  - Developer/Protocol: 50% dari fee
  - Creator: 30% dari fee
  - Burn/LP/Community: 20% dari fee

Implementasi Solidity (pattern):

```solidity
function _takeFee(address token, uint256 amount) internal returns (uint256 remaining) {
    uint256 dev = amount * 50 / 100;
    uint256 creator = amount * 30 / 100;
    uint256 rest = amount - dev - creator; // 20%

    IERC20(token).transfer(devAddress, dev);
    IERC20(token).transfer(creatorAddress, creator);
    // rest handled (burn or move to ecosystem)
    return 0; // or amount - fee
}
```

Advanced: swap collected fees to stablecoin before distribution
- Use router to swap tokens -> stable coin
- Accumulate small fees and batch-swap to save gas

Security & Governance:
- Fee rates configurable by governance (timelock + multisig)
- Emergency withdraw only by multisig
- Keep fee addresses changeable only through governance

