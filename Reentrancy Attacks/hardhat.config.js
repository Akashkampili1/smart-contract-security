require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {

  network:{
    localhost:{
      url:"http://127.0.0.1:8545",
      chainId: 1337
    },
    hardhat:{
      chainId: 1337
    }
  },
  solidity: "0.8.28",
};