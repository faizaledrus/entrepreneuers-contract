// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
    const Azuko = await ethers.getContractFactory("Entrepreneurs");
    console.log("Deploying Entrepreneurs...");
    const entrepreneurs = await upgrades.deployProxy(Azuko, [], {
        initializer: "initialize",
    });
    await entrepreneurs.deployed();
    console.log("Entrepreneurs deployed to:", entrepreneurs.address);
}

main();