const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// Define LegalModule
const LegalModule = buildModule("LegalModule", (m) => {
    const legal = m.contract("Legal");
    return { legal };
});

// Export LegalModule
module.exports = LegalModule;
//0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266