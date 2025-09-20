#[test_only]
module lattice::core_tests {
    use lattice::core;

    #[test]
    fun test_deterministic_macro_selection() {
        let seed = 12345;
        let result1 = core::select_macro(seed);
        let result2 = core::select_macro(seed);
        assert!(result1 == result2, 0);
    }

    #[test]
    fun test_deterministic_micro_selection() {
        let seed = 12345;
        let macro_id = 10;
        let result1 = core::select_micro(seed, macro_id);
        let result2 = core::select_micro(seed, macro_id);
        assert!(result1 == result2, 1);
    }

    #[test]
    fun test_deterministic_activation() {
        let seed = 12345;
        let macro_id = 10;
        let micro_id = 20;
        let result1 = core::apply_activation(seed, macro_id, micro_id);
        let result2 = core::apply_activation(seed, macro_id, micro_id);
        assert!(result1 == result2, 2);
    }

    #[test]
    fun test_create_lattice_state() {
        let seed = 12345;
        let state1 = core::create_lattice_state(seed);
        let state2 = core::create_lattice_state(seed);
        // Test that the states are identical (deterministic)
        assert!(core::get_macro_id(&state1) == core::get_macro_id(&state2), 3);
        assert!(core::get_micro_id(&state1) == core::get_micro_id(&state2), 4);
        assert!(core::get_activation_flags(&state1) == core::get_activation_flags(&state2), 5);
    }
}