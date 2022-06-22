// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
    const Azuko = await ethers.getContractFactory("Azuko");
    console.log("Deploying Azuko...");
    const azuko = await upgrades.deployProxy(Azuko, [], {
        initializer: "initialize",
    });
    await azuko.deployed();
    console.log("Azuko deployed to:", azuko.address);
}

main();