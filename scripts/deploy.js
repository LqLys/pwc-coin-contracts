// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const PWCToken = await hre.ethers.getContractFactory("PWCToken");
  const pwcToken = await PWCToken.deploy("PWCToken", "PWC");

  await pwcToken.deployed();

  console.log("PWC Token deployed to: ", pwcToken.address);

  const PWCShop = await hre.ethers.getContractFactory("PWCShop");
  const pwcShop = await PWCShop.deploy(pwcToken.address)

  await pwcShop.deployed();

  console.log("PWC Shop deployed to: ", pwcShop.address);


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
