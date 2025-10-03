import { SuiClient } from "@mysten/sui"; import { decodeLattice } from "./bcs";
export class LatticeClient {
  client: SuiClient; packageId:string;
  constructor(packageId:string,rpcUrl?:string){this.client=new SuiClient({url:rpcUrl??"https://fullnode.devnet.sui.io:443"});this.packageId=packageId;}
  async callDeterministicLattice(inputBytes: Uint8Array){return await this.client.callFunction({packageObjectId:this.packageId,module:"oracle",function:"deterministic_lattice_from_input",typeArguments:[],arguments:[inputBytes]});}
  decodeState(rawBytes:any){return decodeLattice(rawBytes);}
}
