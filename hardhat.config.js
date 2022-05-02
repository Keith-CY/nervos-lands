require("@nomiclabs/hardhat-waffle");

const dotenv = require("dotenv");
dotenv.config({ path: __dirname + "/.env" });
const { RPC_URL, PRIVATE_KEY } = process.env;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "godwoken",
  networks: {
    hardhat: {},
    godwoken: {
      url: RPC_URL,
      accounts: [PRIVATE_KEY],
    },
  },
  solidity: "0.8.0",
};
