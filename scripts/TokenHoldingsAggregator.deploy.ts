import { ethers } from "hardhat";

async function main() {
  const aggregator =
    await (await ethers.getContractFactory("TokenHoldingsAggregator")).deploy();
  await aggregator.deployed();
  console.log(`TokenHoldingsAggregator address: ${aggregator.address}`);
}

main();
