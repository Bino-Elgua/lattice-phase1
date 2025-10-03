import { SuiClient } from "@mysten/sui/client";
import { Transaction } from "@mysten/sui/transactions";
import { decodeLattice } from "./bcs";

export class LatticeClient {
  client: SuiClient;
  packageId: string;
  
  constructor(packageId: string, rpcUrl?: string) {
    this.client = new SuiClient({url: rpcUrl ?? "https://fullnode.devnet.sui.io:443"});
    this.packageId = packageId;
  }
  
  async callDeterministicLattice(inputBytes: Uint8Array) {
    const tx = new Transaction();
    tx.moveCall({
      target: `${this.packageId}::oracle::deterministic_lattice_from_input`,
      arguments: [tx.pure.vector('u8', Array.from(inputBytes))]
    });
    
    return await this.client.devInspectTransactionBlock({
      transactionBlock: tx,
      sender: '0x0000000000000000000000000000000000000000000000000000000000000000'
    });
  }
  
  decodeState(rawBytes: any) {
    return decodeLattice(rawBytes);
  }
}
