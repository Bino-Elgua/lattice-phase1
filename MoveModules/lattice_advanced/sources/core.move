module lattice_advanced::core {
    use std::vector;
    use sui::bcs;
    struct LatticeState has key { raw: vector<u8> }
    public fun encode_state(macro_id: u8, micro_id: u8, activation: u8): vector<u8> { bcs::to_bytes(&(macro_id, micro_id, activation)) }
    public fun create_lattice_state(macro_id: u8, micro_id: u8, activation: u8): LatticeState { LatticeState { raw: encode_state(macro_id, micro_id, activation) } }
    public fun decode_state(s: &LatticeState): (u8, u8, u8) { bcs::from_bytes::<(u8,u8,u8)>(&s.raw) }
    public fun select_macro(seed: u64): u8 { ((seed % 64)+1) as u8 }
    public fun select_micro(seed: u64, macro_id: u8): u8 { (((seed + (macro_id as u64)) % 256)+1) as u8 }
    public fun apply_activation(seed: u64, macro_id: u8, micro_id: u8): u8 { (((seed + (macro_id as u64) + (micro_id as u64)) % 128)+1) as u8 }
    public fun from_seed(seed: u64): LatticeState {
        let m = select_macro(seed); let mi = select_micro(seed,m); let a = apply_activation(seed,m,mi);
        create_lattice_state(m, mi, a)
    }
}
