import { SuiClient, getFullnodeUrl } from "@mysten/sui/client";
import { Transaction } from "@mysten/sui/transactions";
import fs from 'fs';

export class LatticeSDK {
    constructor() {
        this.client = new SuiClient({ url: getFullnodeUrl('devnet') });
        this.config = JSON.parse(fs.readFileSync('config.json', 'utf8'));
    }

    async generateLattice(seed) {
        try {
            const tx = new Transaction();
            
            // Convert seed to vector<u8>
            const seedBytes = new TextEncoder().encode(seed.toString());
            
            tx.moveCall({
                target: `${this.config.packageId}::oracle::deterministic_lattice_from_input`,
                arguments: [
                    tx.pure.vector('u8', [...seedBytes])
                ]
            });

            const result = await this.client.devInspectTransactionBlock({
                transactionBlock: tx,
                sender: '0x0000000000000000000000000000000000000000000000000000000000000000'
            });
            
            return this.parseLatticeResult(result);
        } catch (error) {
            throw new Error(`Lattice generation failed: ${error}`);
        }
    }

    parseLatticeResult(result) {
        if (result.results && result.results[0]) {
            return {
                success: true,
                result: result.results[0],
                effects: result.effects
            };
        }
        return result;
    }
}