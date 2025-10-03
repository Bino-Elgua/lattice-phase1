module lattice_advanced::batching {
    use std::vector;
    use lattice_advanced::core;
    
    public fun batch_from_seeds(seeds: vector<u64>): vector<vector<u8>> {
        let mut out = vector::empty<vector<u8>>();
        let len = vector::length(&seeds);
        let mut i = 0;
        while (i < len) {
            let seed = *vector::borrow(&seeds, i);
            let m = core::select_macro(seed);
            let mi = core::select_micro(seed, m);
            let a = core::apply_activation(seed, m, mi);
            let encoded = core::encode_state(m, mi, a);
            vector::push_back(&mut out, encoded);
            i = i + 1;
        };
        out
    }
}
