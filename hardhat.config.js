require("@nomiclabs/hardhat-waffle");
require('dotenv').config();
require("@nomiclabs/hardhat-etherscan");


module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: process.env.MUMBAY_URL || "",
      accounts:
        process.env.PK !== undefined ? [process.env.PK] : [],
      gasPrice: 40000000000, // default is 'auto' which breaks chains without the london hardfork
    },
  },

  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
