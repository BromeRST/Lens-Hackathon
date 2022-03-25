const hre = require("hardhat");

async function main() {
  const NFTcontract = await hre.ethers.getContractFactory("ERC1155Creator");
  const nftContract = await NFTcontract.deploy();

  await nftContract.deployed();

  console.log("ERC1155Creator deployed to:", nftContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
