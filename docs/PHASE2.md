# Phase 2 - Advanced Lattice Implementation

This directory contains the Phase 2 implementation of the Lattice project, featuring advanced Move modules, TypeScript SDK, and enhanced tooling.

## Structure

### Move Modules (`MoveModules/lattice_advanced/`)

The advanced Move package includes:

- **core.move**: Core lattice logic with BCS-compatible encoding
  - `LatticeStateData` struct for efficient state storage
  - Deterministic selection functions (macro, micro, activation)
  - State encoding/decoding utilities

- **oracle.move**: Hash-based deterministic generation
  - Keccak256 hash-to-seed conversion
  - Deterministic lattice generation from arbitrary input

- **batching.move**: Batch processing capabilities
  - Process multiple seeds efficiently
  - Returns vector of encoded states

### TypeScript SDK (`sdk/ts/`)

Production-ready SDK for Sui integration:

- **BCS utilities** for encoding/decoding lattice states
- **LatticeClient** for on-chain interactions
- Compatible with @mysten/sui v1.39.0

#### Usage Example

```typescript
import { LatticeClient } from "lattice-sdk-ts";

const client = new LatticeClient("PACKAGE_ID");
const input = new TextEncoder().encode("test");
const result = await client.callDeterministicLattice(input);
```

### CLI Tool (`cli/src/`)

Command-line interface for lattice operations:

```bash
# Local preview with seed
ts-node src/index.ts --seed 12345

# On-chain call with input
ts-node src/index.ts --input 0xdeadbeef
```

### Testing (`tests/`)

- **determinism_harness.ts**: Validates deterministic behavior across 1000 iterations
- Ensures unique state generation
- Tests algorithmic consistency

## Building

### TypeScript SDK

```bash
cd sdk/ts
npm install
npm run build
```

### CLI Tool

```bash
cd cli
npm install
npm run build
```

## Testing

### Run Determinism Harness

```bash
cd tests
npx ts-node determinism_harness.ts
```

Expected output: `Harness complete. Unique states: 256`

## CI/CD

The Phase 2 CI workflow (`.github/workflows/phase2_ci.yml`) automatically:

1. Builds the TypeScript SDK
2. Runs the determinism harness
3. Validates all components

## Dependencies

- **@mysten/sui**: ^1.39.0
- **@mysten/bcs**: ^1.8.0
- **TypeScript**: ^5.5.0
- **Node.js**: v20+

## Move Edition

All Move modules use the **2024 edition** with proper syntax for:
- Mutable variables (`let mut`)
- Proper vector operations
- Compatible struct definitions

## Notes

- Phase 1 modules remain in `sources/` directory
- Phase 2 uses separate `MoveModules/lattice_advanced/` directory
- Both phases can coexist in the same repository
- SDK is backward compatible with Phase 1 if package IDs are provided
