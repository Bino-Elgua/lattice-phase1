module lattice_advanced::batching {
    use std::vector;
    use lattice_advanced::core;
    public fun batch_from_seeds(seeds: vector<u64>): vector<vector<u8>> {
        let mut out = vector::empty<vector<u8>>(); let len=vector::length(&seeds); let mut i=0;
        while (i<len) { let seed = *vector::borrow(&seeds,i); vector::push_back(&mut out, core::from_seed(seed).raw); i=i+1; }; out
    }
}
