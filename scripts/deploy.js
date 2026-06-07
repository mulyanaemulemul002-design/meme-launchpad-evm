const hre = require("hardhat");
require('dotenv').config();

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);

  const TokenFactory = await hre.ethers.getContractFactory("TokenFactory");
  const factory = await TokenFactory.deploy();
  await factory.deployed();
  console.log("TokenFactory deployed to:", factory.address);

  // For BondingCurve we need an ERC20 that supports mint(address,uint256)
  // Deploy a MinimalERC20 via factory for sample
  const tx = await factory.createToken("SampleToken", "SAMP", hre.ethers.parseUnits("1000000", 18));
  const receipt = await tx.wait();
  const event = receipt.events.find(e => e.event === 'TokenCreated');
  const tokenAddress = event.args.token;
  console.log("SampleToken created at:", tokenAddress);

  const BondingCurve = await hre.ethers.getContractFactory("BondingCurve");
  const curve = await BondingCurve.deploy(tokenAddress, hre.ethers.parseUnits("0.0001", "ether"), hre.ethers.parseUnits("0.0000001", "ether"));
  await curve.deployed();
  console.log("BondingCurve deployed to:", curve.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
