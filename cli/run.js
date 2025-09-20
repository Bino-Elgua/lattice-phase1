import { LatticeSDK } from "./latticeSDK.js";
import { parseArgs } from "util";

async function main() {
    const { values } = parseArgs({
        options: {
            seed: { type: "string", default: "12345" }
        }
    });

    const sdk = new LatticeSDK();
    const seed = parseInt(values.seed) || 12345;
    
    try {
        console.log(`[${new Date().toISOString()}] Running lattice generation with seed: ${seed}`);
        const lattice = await sdk.generateLattice(seed);
        console.log(`[${new Date().toISOString()}] Success - Lattice generated:`, JSON.stringify(lattice, null, 2));
    } catch (error) {
        console.error(`[${new Date().toISOString()}] Error:`, error.message);
        process.exit(1);
    }
}

main().catch(console.error);