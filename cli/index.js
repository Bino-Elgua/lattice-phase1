import { LatticeSDK } from "./latticeSDK.js";

async function main() {
    const sdk = new LatticeSDK();
    const seed = 12345;
    
    try {
        const lattice = await sdk.generateLattice(seed);
        console.log("Deterministic Lattice Output:", JSON.stringify(lattice, null, 2));
    } catch (error) {
        console.error("Error:", error.message);
    }
}

main().catch(console.error);