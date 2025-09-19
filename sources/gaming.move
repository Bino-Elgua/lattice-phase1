module lattice::gaming {
    use lattice::core;

    public fun random_event(state: &core::LatticeState): u8 {
        ((core::get_macro_id(state) as u64 + core::get_micro_id(state) as u64 + core::get_activation_flags(state) as u64) % 100 + 1) as u8
    }
}