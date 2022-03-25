const { expect } = require("chai");
const { ethers } = require("hardhat");

let contract, signer, alice;

describe("ERC1155Creator", function () {
  
  before("create contract", async function () {
    const Contract = await ethers.getContractFactory("ERC1155Creator");
    contract = await Contract.deploy();
    await contract.deployed();
    [signer, alice] = await ethers.getSigners();
  });

  it("it should create an nft", async function () {
    await contract.generateNFT(86400, 100);
    await contract.connect(alice).mint(0);

    const firstNFT = await contract.balanceOf(
        alice.address,
        0
    );

    expect(parseInt(ethers.utils.formatUnits(firstNFT, 0))).to.be.equal(1);
  });

  it("it should revert nft's mint after a certain period of time", async function () {
    await network.provider.send("evm_increaseTime", [86500]);

    await expect(contract.connect(alice).mint(0)).to.be.revertedWith(
      "minting expired"
    );
  });

  it("it should count 1", async function () {
    const count = await contract.getCountForId(0);

    expect(parseInt(ethers.utils.formatUnits(count, 0))).to.be.equal(1);
  });

  it("it should create a new nft and be able to mint just once", async function () {
    const myNFTid = await contract.generateNFT(86400 * 2, 100);
    await contract.connect(alice).mint(1);

    const secondNFT = await contract.balanceOf(
        alice.address,
        1
    );

    expect(parseInt(ethers.utils.formatUnits(secondNFT, 0))).to.be.equal(1);

    await expect(contract.connect(alice).mint(1)).to.be.revertedWith(
      "already minted"
    );
  });

  it("it should create a new nft and revert after cap", async function () {
    const myNFTid = await contract.generateNFT(86400 * 2, 1);
    await contract.connect(alice).mint(2);

    const secondNFT = await contract.balanceOf(
        alice.address,
        2
    );

    expect(parseInt(ethers.utils.formatUnits(secondNFT, 0))).to.be.equal(1);

    await expect(contract.connect(signer).mint(2)).to.be.revertedWith(
      "all supply have been minted"
    );
  });
});