const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// Define LegalModule
const LegalModule = buildModule("LegalModule", (m) => {
    const legal = m.contract("Legal");
    return { legal };
});

// Export LegalModule
module.exports = LegalModule;
