module lattice_advanced::core {
    use std::vector;
    
    // Simple struct for lattice state encoding
    public struct LatticeStateData has copy, drop, store {
        raw: vector<u8>
    }
    
    public fun encode_state(macro_id: u8, micro_id: u8, activation: u8): vector<u8> {
        let mut bytes = vector::empty<u8>();
        vector::push_back(&mut bytes, macro_id);
        vector::push_back(&mut bytes, micro_id);
        vector::push_back(&mut bytes, activation);
        bytes
    }
    
    public fun create_lattice_state_data(macro_id: u8, micro_id: u8, activation: u8): LatticeStateData {
        LatticeStateData {
            raw: encode_state(macro_id, micro_id, activation)
        }
    }
    
    public fun decode_state(s: &LatticeStateData): (u8, u8, u8) {
        let macro = *vector::borrow(&s.raw, 0);
        let micro = *vector::borrow(&s.raw, 1);
        let activation = *vector::borrow(&s.raw, 2);
        (macro, micro, activation)
    }
    
    public fun select_macro(seed: u64): u8 {
        ((seed % 64) + 1) as u8
    }
    
    public fun select_micro(seed: u64, macro_id: u8): u8 {
        (((seed + (macro_id as u64)) % 256) + 1) as u8
    }
    
    public fun apply_activation(seed: u64, macro_id: u8, micro_id: u8): u8 {
        (((seed + (macro_id as u64) + (micro_id as u64)) % 128) + 1) as u8
    }
    
    public fun from_seed(seed: u64): LatticeStateData {
        let m = select_macro(seed);
        let mi = select_micro(seed, m);
        let a = apply_activation(seed, m, mi);
        create_lattice_state_data(m, mi, a)
    }
    
    public fun get_raw(s: &LatticeStateData): &vector<u8> {
        &s.raw
    }
}
