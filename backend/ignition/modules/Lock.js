/*const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const JAN_1ST_2030 = 1893456000;
const ONE_GWEI = 1_000_000_000n;

module.exports = buildModule("LockModule", (m) => {
  const unlockTime = m.getParameter("unlockTime", JAN_1ST_2030);
  const lockedAmount = m.getParameter("lockedAmount", ONE_GWEI);

  const lock = m.contract("Lock", [unlockTime], {
    value: lockedAmount,
  });

  return { lock };
});*/
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// Define LegalModule
const BlemsModule = buildModule("BlemsModule", (m) => {
    const blems = m.contract("Blems");
    return { blems };
});

// Export LegalModule
module.exports = BlemsModule;
//contract address 0x5fbdb2315678afecb367f032d93f642f64180aa3



