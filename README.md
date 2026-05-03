# co10_Escape_Zombies

Custom fork of [co10_Escape](https://github.com/CaptainPStar/co10_Escape) by CaptainPStar. Adds Ravage zombies, a custom revive/spectator system, stackable pain screams, and multiple faction variants set on Chernarus.

## Missions

| Mission | Enemy (OPFOR) | Secondary (IND) | Extraction | Base |
|---------|--------------|-----------------|------------|------|
| **Escape Chernarus (Zombies)** | USMC (RHS) | Militia (RHSGREF nat) | Russian helos | v1.10 |
| **Escape Chernarus - Red Storm (Zombies)** | Russian VDV (RHS AFRF) | Insurgents (RHSGREF ins) | NATO (UH-60, AH-64) | v1.10 |
| **Escape Chernarus - Civil War (Zombies)** | Chedaki/ChDKZ (RHSGREF ins) | NAPA (RHSGREF nat) | CDF (Mi-8) | v1.10 |
| **Escape Chernarus - Ported (Zombies)** | RU + NAPA (CUP) | NAPA (CUP) | USMC (CUP) | Latest upstream |

The **Ported** variant uses the latest upstream co10_Escape framework (398 commits ahead of 1.10) with new features like ambient AI patrols, civilian traffic, garrison system, zone management, and weather overhaul.

## Required Mods

- CUP Terrains (Core, Maps, CWA, Maps 2.0)
- CUP Weapons
- CUP Units
- CUP Vehicles
- CBA_A3
- RHS: USAF
- RHS: AFRF
- RHS: GREF
- RHS: SAF
- 3den Enhanced
- Escape Content
- ALiVE
- [Ravage](https://steamcommunity.com/sharedfiles/filedetails/?id=1373545302) (zombie system)

## Custom Systems

### Ravage Zombies
Zombie spawning via Ravage mod modules placed in the mission.sqm. Config: Runners type, 60 max local / 30 max global, 300m spawn radius, hordes enabled, grab enabled, 30s rise delay.

### ATR Revive + HindsightCamera
Custom revive system (not ACE). When downed:
- Player goes unconscious (not dead) - revive window is **indefinite**
- Locked to first-person view
- "Scream in Agonizing Pain" action available (red text, scroll menu)
- Screams are stackable - spam it and they overlap (uses `playSound3D` via `remoteExec`)
- 41 random scream sound files
- Teammates can drag/revive with first aid kit
- Camera system with mouse control, NV toggle, perspective management

### Intel System
Enemies have a configurable chance (default 50%) to carry intel documents. Loot them from bodies via inventory. Intel reveals the type of nearby POIs on the map (ammo depots, comm centers, crash sites, mortar sites). All POIs show as question marks until intel reveals what they are.

### Grid Caching System (GCS)
Database-backed persistence system with SQL backend, PowerShell installer, and sector-based unit serialization.

## Default Parameters

| Parameter | Default |
|-----------|---------|
| Enemy Skill | Extreme |
| Enemy Squad Size | Players 1:1.5 |
| War-Torn | Enabled |
| Mag Repack | Enabled |
| Intel | Enabled (50% chance) |
| Map Markers | Show as questionmarks (intel reveals type) |
| Respawn Delay | 60s (safety net, revive is indefinite) |

## Key Files

```
Units/UnitClasses.sqf          - Faction definitions, weapons, vehicles, loot tables
include/params.hpp             - Mission parameters and defaults
include/functions.hpp          - CfgFunctions registration
Revive/functions/HSC/          - HindsightCamera spectator system
Revive/functions/Revive/       - ATR Revive core (HandleDamage, Unconscious, etc.)
functions/Intel/               - Intel add/collect/reveal system
functions/Server/fn_initServer.sqf - Server init (AT_Revive_PlayerDamage MUST be set here)
sounds/screams/                - 41 scream .ogg files
sounds/Sounds.hpp              - CfgSounds, CfgSFX, CfgVehicles audio config
mission.sqm                    - Eden editor data (Ravage modules, ALiVE, markers)
```

## Known Gotchas

- `AT_Revive_PlayerDamage` must be initialized in `fn_initServer.sqf` or the HandleDamage EH crashes silently and players die instead of going unconscious
- `fn_createCam.sqf` must exist in `Revive/functions/HSC/` - it creates the camera AND the scream action. Without it, revive camera never initializes
- `mission.sqm` entity `items=` count must match actual number of Item entries or trailing entities (like Ravage modules) get silently skipped
- `Sounds.hpp` must have all Scream classes inside the CfgSounds braces
- `fn_updatePerspective.sqf` line 3 must be `if(true)` to lock first-person when downed. `if(false)` causes infinite recursion crash on V key press
- Intel items are added via `addMagazineGlobal` (not `addItemToUniform`) because CUP units spawn with full inventories that silently reject new items
- Scream stacking requires `playSound3D` via `remoteExec` - `CBA_fnc_globalSay3d` queues sounds sequentially instead of overlapping

## Upstream

Based on [co10_Escape](https://github.com/CaptainPStar/co10_Escape) release 1.10 (July 2020). The Ported variant incorporates the latest upstream framework (Jan 2026).

## Credits

- **CaptainPStar** - co10_Escape original
- **Sal Romano** - Zombie integration, custom revive, faction variants, weapon variety
- **Haleks** - Ravage mod (zombie system)
- **RHS Team** - RHS mod suite
- **CUP Team** - CUP mod suite
