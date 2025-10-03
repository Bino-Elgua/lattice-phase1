module lattice_advanced::oracle {
    use sui::hash::keccak256;
    use std::vector;
    use lattice_advanced::core;
    
    public fun hash_to_seed(input: vector<u8>): u64 {
        let hash = keccak256(&input);
        let mut acc: u64 = 0;
        let len = vector::length(&hash);
        let mut i = 0;
        while (i < 8 && i < len) {
            acc = (acc << 8) | (*vector::borrow(&hash, i) as u64);
            i = i + 1;
        };
        acc
    }
    
    public fun deterministic_lattice_from_input(input: vector<u8>): core::LatticeStateData {
        core::from_seed(hash_to_seed(input))
    }
}
