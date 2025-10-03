import { bcs } from "@mysten/bcs";
export interface LatticeState { macro: number; micro: number; activation: number; }

export function decodeLattice(rawHex: string|Uint8Array): LatticeState {
  const bytes = typeof rawHex==="string"?Uint8Array.from(Buffer.from(rawHex.replace(/^0x/,""),"hex")):rawHex;
  const struct = bcs.struct('Lattice', { macro: bcs.u8(), micro: bcs.u8(), activation: bcs.u8() });
  const val = struct.parse(bytes);
  return {macro:Number(val.macro), micro:Number(val.micro), activation:Number(val.activation)};
}
