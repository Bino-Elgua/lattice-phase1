# Lattice Phase 1

## Overview

Lattice Phase 1 is a deterministic Move module implementation on Sui Network that provides a foundation for lattice-based computations. This project includes core Move modules, a CLI SDK, automated testing, and deployment infrastructure.

## Project Structure

```
lattice-phase1/
├── .github/workflows/
│   └── phase1_week1.yml     # GitHub Actions workflow for validation
├── sources/
│   ├── core.move            # Core lattice computation logic
│   ├── oracle.move          # Oracle for deterministic input handling
│   └── gaming.move          # Gaming utilities
├── tests/
│   └── core_tests.move      # Unit tests for core functionality
├── cli/
│   ├── package.json         # Node.js dependencies
│   ├── config.json          # CLI configuration
│   ├── latticeSDK.js        # Lattice SDK implementation
│   ├── index.js             # Basic CLI example
│   └── run.js               # Validation runner
├── scripts/
│   ├── setup_devnet.sh      # Devnet setup script
│   └── deploy_modules.sh    # Module deployment script
├── Move.toml                # Move package configuration
└── README.md                # This file
```

## Features

### Core Module (`lattice::core`)

- **Deterministic Macro Selection**: Select macro based on seed value
- **Deterministic Micro Selection**: Select micro based on seed and macro
- **Activation Logic**: Apply activation flags deterministically
- **Lattice State Creation**: Create complete lattice state from seed

### Oracle Module (`lattice::oracle`)

- **Hash-to-Seed Conversion**: Convert input bytes to deterministic seed
- **Deterministic Lattice Generation**: Generate lattice state from arbitrary input

### Gaming Module (`lattice::gaming`)

- **Random Event Generation**: Generate pseudo-random events from lattice state

## Getting Started

### Prerequisites

- [Sui CLI](https://docs.sui.io/build/install)
- [Node.js](https://nodejs.org/) (v18 or later)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Bino-Elgua/lattice-phase1.git
cd lattice-phase1
```

2. Setup Sui environment:
```bash
./scripts/setup_devnet.sh
```

3. Install CLI dependencies:
```bash
cd cli
npm install
```

### Building and Testing

#### Build Move Modules

```bash
sui move build
```

#### Run Tests

```bash
sui move test
```

#### Deploy to Devnet

```bash
./scripts/deploy_modules.sh
```

### CLI Usage

#### Basic Example

```bash
cd cli
node index.js
```

#### Validation Runner

```bash
cd cli
node run.js --seed 12345
```

## GitHub Actions Workflow

The project includes a comprehensive GitHub Actions workflow (`phase1_week1.yml`) that:

1. **Sets up the Sui environment** using secrets
2. **Requests devnet tokens** from the faucet
3. **Compiles and deploys** Move modules
4. **Runs CLI validation** with multiple seeds
5. **Executes Move tests** iteratively
6. **Uploads artifacts** for analysis

### Required Secrets

To run the workflow, add the following secret to your GitHub repository:

- `SUI_DEVNET_PRIVATE_KEY`: Your Sui devnet private key

### Manual Trigger

The workflow can be triggered manually via GitHub Actions:

1. Go to the "Actions" tab in your repository
2. Select "Phase 1 Week 1 Validation"
3. Click "Run workflow"

## API Reference

### Core Functions

#### `select_macro(seed: u64): u8`
Selects a macro ID based on the provided seed.

#### `select_micro(seed: u64, macro_id: u8): u8`
Selects a micro ID based on seed and macro ID.

#### `apply_activation(seed: u64, macro_id: u8, micro_id: u8): u8`
Applies activation logic to generate activation flags.

#### `create_lattice_state(seed: u64): LatticeState`
Creates a complete lattice state from a seed value.

### Oracle Functions

#### `hash_to_seed(input: vector<u8>): u64`
Converts arbitrary input bytes to a deterministic seed.

#### `deterministic_lattice_from_input(input: vector<u8>): LatticeState`
Generates a lattice state from arbitrary input.

### Gaming Functions

#### `random_event(state: &LatticeState): u8`
Generates a pseudo-random event value from lattice state.

## Development

### Running Local Tests

```bash
# Test Move modules
sui move test

# Test CLI (after deployment)
cd cli
node run.js --seed 42
```

### Deploying to Testnet

1. Update `Move.toml` addresses for testnet
2. Switch Sui client to testnet
3. Request testnet tokens
4. Deploy modules

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Roadmap

- [ ] Enhanced gaming mechanics
- [ ] Advanced oracle functionality
- [ ] Cross-chain integration
- [ ] Performance optimizations
- [ ] Additional testing scenarios

## Support

For questions or issues, please:

1. Check the existing issues
2. Create a new issue with detailed information
3. Include relevant logs and configuration

---

*Built with ❤️ for the Sui ecosystem*