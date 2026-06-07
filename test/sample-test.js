const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TokenFactory + BondingCurve (smoke)", function () {
  it("creates token and deploys curve", async function () {
    const [owner, addr1] = await ethers.getSigners();

    const TokenFactory = await ethers.getContractFactory("TokenFactory");
    const factory = await TokenFactory.deploy();
    await factory.deployed();

    const tx = await factory.createToken("UnitTestToken", "UTT", ethers.utils.parseUnits("1000", 18));
    const receipt = await tx.wait();
    const evt = receipt.events.find(e => e.event === 'TokenCreated');
    const tokenAddr = evt.args.token;

    const Token = await ethers.getContractAt("IERC20", tokenAddr);
    const balance = await Token.balanceOf(owner.address);
    expect(balance).to.equal(ethers.utils.parseUnits("1000", 18));
  });
});
