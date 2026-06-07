// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * Simple Bonding Curve placeholder (linear approximation).
 * NOTE: This is an illustrative example only. Do NOT use as-is in production.
 * Replace with a tested bonding curve math (integral-based pricing) and rigorous tests.
 */
contract BondingCurve is Ownable {
    ERC20 public token;

    // simple linear curve params: price = basePrice + k * supply
    uint256 public basePrice; // in wei per token (for ETH-based purchases)
    uint256 public k; // slope multiplier (wei)

    uint256 public totalMinted;

    event Bought(address indexed buyer, uint256 amountTokens, uint256 paid);

    constructor(address tokenAddress, uint256 _basePrice, uint256 _k) {
        token = ERC20(tokenAddress);
        basePrice = _basePrice;
        k = _k;
    }

    // naive price calculation: price per token at current supply
    function currentPrice() public view returns (uint256) {
        return basePrice + k * totalMinted;
    }

    // buy tokens by sending ETH. Returns number of tokens minted.
    function buy() external payable returns (uint256) {
        require(msg.value > 0, "Send ETH to buy tokens");
        uint256 price = currentPrice();
        require(price > 0, "Invalid price");

        uint256 amount = msg.value / price;
        require(amount > 0, "Insufficient funds for at least one token");

        // minting requires token to have mint function — this is illustrative.
        // In practice, token should implement a mint function accessible by this contract.
        // For safety, token could be pre-minted and this contract transfers from a reserve.
        
        // attempt low-level call to mint (if token supports it)
        (bool ok, ) = address(token).call(abi.encodeWithSignature("mint(address,uint256)", msg.sender, amount));
        require(ok, "Token mint failed; ensure token supports mint(address,uint256)");

        totalMinted += amount;
        emit Bought(msg.sender, amount, msg.value);
        return amount;
    }

    // Admin functions
    function setParams(uint256 _basePrice, uint256 _k) external onlyOwner {
        basePrice = _basePrice;
        k = _k;
    }

    // withdraw ETH collected
    function withdraw(address payable to) external onlyOwner {
        to.transfer(address(this).balance);
    }
}
