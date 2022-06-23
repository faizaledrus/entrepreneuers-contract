// scripts/upgrade_box.js
const { ethers, upgrades } = require("hardhat");

const PROXY = "0x8584df9a2c58620f21dbff64384ff82b89dff755";

async function main() {
    const entrev3 = await ethers.getContractFactory("EntrepreneursV4");
    console.log("Upgrading Entrepreneurs...");
    await upgrades.upgradeProxy(PROXY, entrev3);
    console.log("Entrepreneurs upgraded");
}

main();