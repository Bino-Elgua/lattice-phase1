module lattice::oracle {
    use sui::hash::keccak256;
    use sui::bcs;
    use std::vector;
    use lattice::core;

    public fun hash_to_seed(input: vector<u8>): u64 {
        let hash_result = keccak256(&input);
        let seed_bytes = vector::slice(&hash_result, 0, 8);
        bcs::peel_u64(&mut bcs::new(seed_bytes))
    }

    public fun deterministic_lattice_from_input(input: vector<u8>): core::LatticeState {
        let seed = hash_to_seed(input);
        core::create_lattice_state(seed)
    }
}