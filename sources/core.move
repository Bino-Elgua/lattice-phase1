module lattice::core {
    use std::vector;
    use sui::bcs;

    struct LatticeState has copy, drop, store {
        macro_id: u8,
        micro_id: u8, 
        activation_flags: u8
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

    public fun create_lattice_state(seed: u64): LatticeState {
        let macro = select_macro(seed);
        let micro = select_micro(seed, macro);
        let activation = apply_activation(seed, macro, micro);

        LatticeState {
            macro_id: macro,
            micro_id: micro,
            activation_flags: activation
        }
    }

    // Getter functions for LatticeState
    public fun get_macro_id(state: &LatticeState): u8 {
        state.macro_id
    }

    public fun get_micro_id(state: &LatticeState): u8 {
        state.micro_id
    }

    public fun get_activation_flags(state: &LatticeState): u8 {
        state.activation_flags
    }
}