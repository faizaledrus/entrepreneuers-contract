// scripts/upgrade_box.js
const { ethers, upgrades } = require("hardhat");

const PROXY = "0x1E02FE2899bfAd1768d99C118a7b9FDB0eD946Ee";

async function main() {
    const BoxV2 = await ethers.getContractFactory("BoxV2");
    console.log("Upgrading Box...");
    await upgrades.upgradeProxy(PROXY, BoxV2);
    console.log("Box upgraded");
}

main();