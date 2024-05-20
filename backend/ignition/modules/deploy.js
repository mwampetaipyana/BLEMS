const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// Define LegalModule
const BlemsModule = buildModule("BlemsModule", (m) => {
    const blems = m.contract("Blems");
    return { blems };
});

// Export LegalModule
module.exports = BlemsModule;
//0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
//contract address 0x5fbdb2315678afecb367f032d93f642f64180aa3