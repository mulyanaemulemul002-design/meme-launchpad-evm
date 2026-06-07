// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * Minimal ERC20 used by TokenFactory.
 * In production, prefer OpenZeppelin presets and extended security checks.
 */
contract MinimalERC20 is ERC20, Ownable {
    constructor(string memory name_, string memory symbol_, address initialHolder, uint256 initialSupply) ERC20(name_, symbol_) {
        _mint(initialHolder, initialSupply);
        transferOwnership(initialHolder);
    }
}

/**
 * TokenFactory deploys new ERC20 tokens for launches.
 * Creator can set initial supply and will receive it.
 */
contract TokenFactory {
    event TokenCreated(address indexed token, address indexed creator, string name, string symbol, uint256 supply);

    function createToken(string memory name_, string memory symbol_, uint256 supply_) external returns (address) {
        MinimalERC20 token = new MinimalERC20(name_, symbol_, msg.sender, supply_);
        emit TokenCreated(address(token), msg.sender, name_, symbol_, supply_);
        return address(token);
    }
}
