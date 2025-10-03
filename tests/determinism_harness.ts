function pseudoSeeds(n:number){const arr=[]; for(let i=1;i<=n;i++)arr.push(BigInt(i)); return arr;}
function runHarness(iterations=1000){const seeds=pseudoSeeds(iterations); const seen=new Map(); for(const s of seeds){const macro=Number((s%64n)+1n); const micro=Number(((s+BigInt(macro))%256n)+1n); const activation=Number(((s+BigInt(macro)+BigInt(micro))%128n)+1n); const key=`${macro}-${micro}-${activation}`; seen.set(key,(seen.get(key)||0)+1);} console.log("Harness complete. Unique states:",seen.size);}
runHarness(1000);
