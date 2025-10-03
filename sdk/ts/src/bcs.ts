import { BCS } from "@mysten/bcs";
export interface LatticeState { macro: number; micro: number; activation: number; }
const bcs = new BCS(); bcs.registerStructType("lattice",{ macro:"u8", micro:"u8", activation:"u8" });
export function decodeLattice(rawHex: string|Uint8Array): LatticeState {
  const bytes = typeof rawHex==="string"?Buffer.from(rawHex.replace(/^0x/,""),"hex"):rawHex;
  const val = bcs.de("lattice", bytes); return {macro:Number(val.macro), micro:Number(val.micro), activation:Number(val.activation)};
}
