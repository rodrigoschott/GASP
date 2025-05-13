# GASP Dynamic Additive Overlay (DAO) - Project Manual

This manual consolidates information about the GASP Dynamic Additive Overlay (DAO) project, an Unreal Engine template, based on video descriptions and transcripts from the UnrealDevOp channel. It covers the project overview, core components, data assets, item management, animation layers, implementation details, project setup, version history, tools, and additional tips.

## Table of Contents

1.  [Project Overview & Philosophy](#1-project-overview--philosophy)
    1.1. [Developer Resources](#11-developer-resources)
    1.2. [Educational Purpose & Licensing](#12-educational-purpose--licensing)
    1.3. [Evolving Project](#13-evolving-project)
    1.4. [Data-Driven Approach](#14-data-driven-approach)
    1.5. [Dynamic Additive Overlay (DAO) System](#15-dynamic-additive-overlay-dao-system)
    1.6. [Motion Matching Integration](#16-motion-matching-integration)
    1.7. [Replication](#17-replication)
    1.8. [Project Management & Access](#18-project-management--access)
2.  [Initial Project Setup](#2-initial-project-setup)
3.  [Core Character & Animation Blueprints](#3-core-character--animation-blueprints)
    3.1. [`CBP_SandboxCharacter_DAO` (Character Blueprint)](#31-cbp_sandboxcharacter_dao-character-blueprint)
    3.2. [`ABP_SandboxCharacter_DAO` (Main Animation Blueprint)](#32-abp_sandboxcharacter_dao-main-animation-blueprint)
4.  [Data Assets & Configuration](#4-data-assets--configuration)
    4.1. [Primary Data Assets (PDAs) for Items/Actions](#41-primary-data-assets-pdas-for-itemsactions)
    4.2. [Data Assets for Layering (`PDA_OverlayLayering`)](#42-data-assets-for-layering-pda_overlaylayering)
    4.3. [Data Assets for Live Retargeting (`PDA_LiveRetargeting_Settings`, `DA_HOS_IK_Offset`)](#43-data-assets-for-live-retargeting-pda_liveretargeting_settings-da_hos_ik_offset)
    4.4. [Chooser Tables (`CHT_...`)](#44-chooser-tables-cht_)
    4.5. [Gameplay Tags (`GT_...`)](#45-gameplay-tags-gt_)
5.  [Item & Slot Management](#5-item--slot-management)
    5.1. [`AC_HeldObject_Master` & `AC_Gun` (Actor Components)](#51-ac_heldobject_master--ac_gun-actor-components)
    5.2. [`BP_HeldObjects_Master` (Base Item Actor)](#52-bp_heldobjects_master-base-item-actor)
    5.3. [`AC_SlotManager` (Actor Component on `CBP_SandboxCharacter_DAO`)](#53-ac_slotmanager-actor-component-on-cbp_sandboxcharacter_dao)
    5.4. [`BP_Slot_Master` (Base Slot Actor)](#54-bp_slot_master-base-slot-actor)
6.  [Specialized Animation Layers & Poses](#6-specialized-animation-layers--poses)
    6.1. [Linked Anim Layers (`ALI_...`)](#61-linked-anim-layers-ali_)
    6.2. [Control Rig Poses (`CR_...`, various pose assets `PA_...`)](#62-control-rig-poses-cr_-various-pose-assets-pa_)
    6.3. [Pose Drivers & Corrective Animations](#63-pose-drivers--corrective-animations)
7.  [Implementation Guide](#7-implementation-guide)
    7.1. [Project Summary](#71-project-summary)
    7.2. [Main Classes & Blueprints (Implementation Context)](#72-main-classes--blueprints-implementation-context)
    7.3. [Key Feature Implementation Locations & Video References](#73-key-feature-implementation-locations--video-references)
8.  [Version Updates & Key Changes (Chronological)](#8-version-updates--key-changes-chronological)
    (Includes versions 1.49 down to 1.24)
9.  [Detailed Mechanics (Integrated from Video Reference Guide)](#9-detailed-mechanics-integrated-from-video-reference-guide)
    9.1. [Item and Held Objects System (`AC_HeldObject_Master`, `AC_Gun`)](#91-item-and-held-objects-system-ac_heldobject_master-ac_gun)
    9.2. [Slot and Holster System (`AC_SlotManager`)](#92-slot-and-holster-system-ac_slotmanager)
    9.3. [Animation and Layering System](#93-animation-and-layering-system)
    9.4. [Character Setup & Retargeting](#94-character-setup--retargeting)
    9.5. [Specific Gameplay Mechanics](#95-specific-gameplay-mechanics)
10. [Tools & External Software](#10-tools--external-software)
11. [Additional Topics and Tips](#11-additional-topics-and-tips)

---

## 1. Project Overview & Philosophy

The GASP Dynamic Additive Overlay (DAO) project by UnrealDevOp is an advanced character animation and interaction system for Unreal Engine, built upon the Game Animation Sample Project (GASP) and its motion matching capabilities. It emphasizes a highly data-driven architecture using Data Assets, Chooser Tables, and Gameplay Tags to manage character states, animation layering, item handling (weapons, flashlights, etc.), and live retargeting for diverse character anatomies. Key features include a custom dynamic additive overlay system for realistic weapon holding during movement, a precise aim offset system (including distance-based compensation), a robust item slot and holstering mechanism, and progressively implemented network replication.

### 1.1. Developer Resources

- **BuyMeACoffee:** [https://buymeacoffee.com/j0hnc0nn0r](https://buymeacoffee.com/j0hnc0nn0r)
- **Project Files (Ko-fi):** [https://ko-fi.com/unrealdevop](https://ko-fi.com/unrealdevop)
- **Official Documentation (GitBook):** [https://unreal-devop.gitbook.io/gasp-dynamicadditiveoverlay](https://unreal-devop.gitbook.io/gasp-dynamicadditiveoverlay)
- **Discord:** [https://discord.gg/38ceaJ67Eu](https://discord.gg/38ceaJ67Eu)
  - **Key Videos:** Links to the Discord are in most video descriptions.

### 1.2. Educational Purpose & Licensing

- **Description:** The project is primarily intended as an educational tool to demonstrate advanced animation techniques within Unreal Engine, particularly building upon the Game Animation Sample Project (GASP). While educational, it's released under an MIT license, which is generally permissive. However, the creator has implemented a EULA via Ko-fi that requires attribution (credit via a BSD 3-Clause style notice) if used in a compiled game, and restricts reselling the source code.
- **Key Video:** "Unreal Engine 5; GASP-DAO (Major Changes And Why)" (discusses the move to Ko-fi and the EULA).

### 1.3. Evolving Project

- **Description:** The creator consistently emphasizes that GASP-DAO is an actively evolving project. Features are frequently added, refactored, and improved. This means that specific Blueprint setups, variable names, or even entire sub-systems might change between versions. Users should expect this and refer to the latest overview videos for the most current information.
- **Key Videos:** This is a recurring theme in most update overview videos (e.g., "Unreal Engine 5 - GASP DAO (Update 1.10)", "Unreal Engine 5; GASP DAO (v1.3x) series", etc.).

### 1.4. Data-Driven Approach

- **Description:** A cornerstone of GASP-DAO is its heavily data-driven architecture. This primarily involves:
  - **Primary Data Assets (PDAs):** Used to store configurations for items, weapons, IK offsets, layering settings, etc. (e.g., `PDA_ActionData_Weapon`, `PDA_HeldObjectSettings`).
  - **Chooser Tables:** Unreal Engine's Chooser system is used extensively to select appropriate Data Assets at runtime based on context (e.g., character type, equipped item, character state). This allows for dynamic selection of animation sets, IK settings, and more.
  - **Gameplay Tags:** Widely used for identifying states (character states, item states, stances), item types, and as keys in maps within Data Assets (e.g., for selecting montages or IK offsets).
- **Purpose:** This approach promotes flexibility, reduces hardcoding, makes it easier to add new content (characters, weapons) with varied behaviors, and manage complex interactions.
- **Key Videos:** "GASP DAO V1.47 (Item Handling System)" (excellent example for item and character data), "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (general data asset usage), "Unreal Engine 5; GASP DAO (V1.31 Overview)" (Chooser usage for Live Retargeting assets).

### 1.5. Dynamic Additive Overlay (DAO) System

- **Description:** This is the custom animation layering system built by the creator, inspired by concepts from the Advanced Locomotion System (ALS). It allows for complex character animation by dynamically layering poses (like holding a weapon) with base locomotion and other additive animations. It's the foundation for how weapons, items, and different states are visually represented on the character.
- **Key Videos:** "Unreal Engine 5 - Advanced Motion Matching Dynamic Overlay Layering (Coming Soon)" (introduces the concept), "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (explains layering setup), "Unreal Engine 5.4 - Motion Matching; Dynamic Additive Layering (Part 1)" (detailed setup).

### 1.6. Motion Matching Integration

- **Description:** The entire system is built upon and enhances Unreal Engine's Motion Matching, as provided in the Game Animation Sample Project (GASP). Familiarity with GASP's core motion matching principles is beneficial.
- **Key Videos:** This is foundational to almost all videos. "Unreal Engine 5 - ALS vs Motion Matching (Performance Profiling)" discusses performance aspects.

### 1.7. Replication

- **Description:** Network replication for multiplayer has been progressively added and refined. Initial versions might have had limited replication. Features like item handling, aiming states, traversal, and projectile spawning have seen specific replication updates. The creator sometimes used plugins like SmoothSync for testing but these are not included in the project.
- **Key Videos:** "Unreal Engine 5; GASP DAO (v1.33 Overview)" (mentions traversal replication refactor), "Unreal Engine 5; GASP DAO (v1.25 Overview)" (discusses aim offset replication, projectile replication with SmoothSync for testing), "GASP_DynamicAdditiveOverlay(1.37)" (Distance Based AO replication, ItemsInHand replication refactor).

### 1.8. Project Management & Access

- **GitHub Repository:**
  - **Details:** The GASP-DAO project was moved to a GitHub repository to facilitate version control, updates, and community access. Initially, it was a private repo, then public using Git LFS (Large File Storage) for larger assets. Later, the project was refactored to reduce overall size and remove the dependency on LFS, making it more accessible. The setup process involves cloning the DAO repo and then copying over files from a base Game Animation Sample Project.
  - **Key Videos:** "Unreal Engine 5; GASP DAO (New GitHub Repo)", "Unreal Engine 5; GASP DAO (GitHub Setup)", "Unreal Engine 5; Gasp-DAO (v1.40 Overview)" (new setup process without LFS).
- **Ko-fi:**
  - **Details:** Used for distributing project files (both direct downloads and repo access) and for users to support the project's development. The creator implemented a paywall and EULA via Ko-fi for legal protection and to ensure attribution.
  - **Key Videos:** This is mentioned in the description of almost all recent videos as the source for project files. "Unreal Engine 5; GASP-DynamicAdditiveOverlay (Major Changes And Why)" explains the move to Ko-fi.

---

## 2. Initial Project Setup

The initial project setup, especially when using the GitHub repository, involves the following steps:

1.  **Clone the Repository:**
    - Use GitHub Desktop or the command line to clone the repository: `https://github.com/JC0NN0R/GASP-DynamicAdditiveOverlay`.
    - **Note:** The project might use Git LFS (Large File Storage). Ensure Git LFS is installed.
2.  **Create a Base GASP Project (Game Animation Sample Project):**
    - In the Epic Games Launcher, create a new "Game Animation Sample Project" using the compatible engine version (e.g., UE 5.x, check project specifics for exact version).
3.  **Copy GASP Files to Cloned Repository:**
    - Copy the contents of the newly created GASP project folder into the cloned repository folder.
    - **Attention:** When copying, if prompted to replace files in the `Config` folder, **DO NOT REPLACE** the files in the cloned repository. The cloned repository's `Config` files contain DAO-specific settings like Gameplay Tags.
4.  **Project Configuration in Unreal Engine:**
    - Open the `.uproject` file from the cloned repository.
    - **World Settings:** Set the `Default Pawn Class` to `CBP_SandboxCharacter_DAO` (located in `Content/DAO/CharData/` or similar).
    - **Gameplay Tags:** Verify in `Edit > Project Settings > Gameplay Tags` that the DAO tag tables are loaded (e.g., `GT_DAOHeldObjectStatesStances`, `GT_MetaHumanTags`). If not, add them. Tables are usually in `Content/DAO/Blueprints/Data/GameplayTags/` or character-specific data folders.
    - **Virtual Bones (for UEFN Mannequin):**
      - Open the Skeletal Mesh of `UEFN_Mannequin` (usually in `Content/Characters/UEFN_Mannequin/Meshes/`).
      - Add the following Virtual Bones if they don't exist:
        - `VB foot_root` (Source: `root`, Target: `root`)
        - `VB foot_l` (Source: `foot_l`, Target: `foot_l`)
        - `VB foot_r` (Source: `foot_r`, Target: `foot_r`)
        - `VB hand_r` (Source: `hand_l`, Target: `hand_r`)
        - `VB hand_l` (Source: `hand_r`, Target: `hand_l`)
    - **Sockets (for Retargeted/MetaHuman Characters):**
      - For custom characters (MetaHumans, Character Creator, etc.), add a socket named `HeldObject_R` to the right-hand bone (e.g., `hand_r`) and `HeldObject_L` to the left-hand bone (`hand_l`). The transforms of these sockets can be adjusted in the character-specific `LiveRetargeting` Data Asset.
    - **NavMesh:** Add a `Nav Mesh Bounds Volume` to your level for AI and some movement mechanics to function correctly.

---

## 3. Core Character & Animation Blueprints

### 3.1. `CBP_SandboxCharacter_DAO` (Character Blueprint)

- **Role:** The primary player character Blueprint. It inherits from GASP's `SandboxCharacter` (or a similar base) and is responsible for:
  - Input handling (Enhanced Input Actions).
  - Managing character states via Gameplay Tags (e.g., `HeldObjectState`, `StanceState`, `DAO.HeldObject.State.Rifle`, `DAO.HeldObject.Stance.Aim`).
  - Initiating actions like firing, reloading, equipping/holstering items, traversal, and contextual animations.
  - Communicating necessary data to the `ABP_SandboxCharacter_DAO` (e.g., `IsAiming`, `CurrentHeldObjectStateTagContainer`).
  - Managing the `AC_SlotManager` component for item inventory/holstering.
  - Handling replication for character states and actions.
  - Calculating and applying Distance Based Aim Offset (DBAO).
  - It's the central hub for character-related logic.
- **Location:** `Content/DAO/CharData/CBP_SandboxCharacter_DAO.uasset` (or similar path, may vary slightly by version)
- **Key Features to Edit/Implement Here:**
  - **Input Actions:** (Located in `Content/Input/`) Mapped in `IMC_Sandbox_DAO`. Logic for these actions (e.g., switching weapons, firing, aiming, interacting) is implemented in the Event Graph of `CBP_SandboxCharacter_DAO`.
    - _Video Reference:_ "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (00:18:15 Input), "Unreal Engine 5; GASP DAO (v1.38 Overview)" (00:08:00 InputActions hotkey in bubble).
  - **Held Object/Weapon Logic:** Switching weapons, managing `HeldObjectState` (Gameplay Tag), initiating fire/reload. Replication of held object states.
    - _Video Reference:_ "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (00:41:56 Switching Held Object States), "Unreal Engine 5; GASP DAO (v1.25 Overview)" (Projectile Replication).
  - **Live Retargeting Setup (for this character type):** While individual character assets have their own IK Retargeters, `CBP_SandboxCharacter_DAO` (and its children) manage which `PDA_LiveRetargeting_Settings` or `DA_HOS_IK_Offset` Data Assets are used based on the equipped item, stance, and character type (often via Choosers).
    - _Video Reference:_ "Unreal Engine 5 - GASP DAO (Update 1.08 Live Retargeting)", "Unreal Engine 5 GASP DAO (V1.31 Overview)" (Choosers for Live Retargeting Assets).
  - **Traversal Logic:** Initiating GASP's traversal system and handling item auto-holster/equip during traversal.
    - _Video Reference:_ "Unreal Engine 5; GASP DAO (v1.33 Overview)" (Traversal replication refactor), "GASP_DynamicAdditiveOverlay(1.48)" (Traversal interruption fixes).
  - **Contextual Animations:** Initiating and managing contextual animation scenes (e.g., pistol pickup, takedowns).
    - _Video Reference:_ "Unreal Engine 5; Pistol Pickup Part 3 (Setup)", "Unreal Engine 5; Player Take Down Part 2 (Setup)".
  - **Distance Based Aim Offset (DBAO) Calculation:** Logic for calculating the DBAO is in this BP.
    - _Video Reference:_ "Unreal Engine 5; Gasp-DAO (Distance Based AO)".
- **Key Video References (General):**
  - General Logic & Input: "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (00:21:30 Blueprint Intro, 00:18:15 Input)
  - Item & State Handling: "Unreal Engine 5 GASP DAO (V1.31 Overview)" (HeldObjectState Gameplay Tag), "Unreal Engine 5; GASP-DAO v1.46 (Overview)" (Pickup Logic)

### 3.2. `ABP_SandboxCharacter_DAO` (Main Animation Blueprint)

- **Role:** The primary Animation Blueprint for the main character. It integrates GASP's Motion Matching with DAO's custom layering systems. It drives:
  - GASP Motion Matching for base locomotion.
  - The custom Dynamic Additive Overlay system for layering poses (e.g., weapon holding) onto locomotion.
  - Aim Offset calculations and application (Universal AO and Custom Per-Weapon AO).
  - IK (Hand & Foot), including Hand IK for weapon holding and Foot IK for ground alignment.
  - Playing animation montages on various slots (`OverlayFullBody`, `OverlayUpperBody`, etc.).
  - Linking to specialized `ALI_...` (Anim Layers) for item-specific animation logic.
- **Location:** `Content/DAO/CharData/ABP_SandboxCharacter_DAO.uasset` (or similar path)
- **Key Features to Edit/Implement Here:**
  - **Dynamic Additive Overlay Layering:** The core layering logic is in the AnimGraph. Settings are driven by Data Assets selected via Choosers.
    - _Video Reference:_ "Unreal Engine 5.4 - Motion Matching; Dynamic Additive Layering (Part 1)", "Unreal Engine 5 - GASP DAO (Update 1.10)" (Layering Expansion).
  - **Aim Offset Logic:** Applying pitch and yaw rotations for aiming. Can switch between Universal AO and Custom AO poses.
    - _Video Reference:_ "Unreal Engine 5 GASP DAO (V1.30 Overview)" (Universal Aim Offset), "GASP_DynamicAdditiveOverlay(1.43)" (Custom Aim Offsets reintroduced), "Unreal Engine 5; GASP-DAO V1.44 (HotPatch Overview)" (Offset Root Bone interaction with Aim Offset for responsiveness).
  - **Hand IK:** Two-Bone IK setup for left/right hands, often using Virtual Bones as targets. Includes the "Procedural Offset Hack" for stable hand placement.
    - _Video Reference:_ "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (01:32:27 Socket Based Offsets / Procedural Offset Hack), "Unreal Engine 5 - GASP Dynamic Additive Overlay (Overview v1.16)" (HandIK section).
  - **Foot Locking & Foot IK:** Integration of GASP's foot placement and locking.
    - _Video Reference:_ "GASP_DynamicAdditiveOverlay(1.48)" (Foot Locking Reintroduced).
  - **Montage Slots:** Defining and using animation slots (`OverlayFullBody`, `OverlayUpperBody`, etc.) for playing montages.
    - _Video Reference:_ "Unreal Engine 5 - GASP DAO (Update 1.15)" (New slots).
  - **Custom Idle & Turn In Place:** Logic for custom idle states and alternative Turn-In-Place mechanics.
    - _Video Reference:_ "Unreal Engine 5 - GASP DAO (Update 1.20)", "Unreal Engine 5; GASP DAO - Custom Idle & TurnInPlace (Breakdown)".
- **Key Video References (General):**
  - Overall Structure: "Unreal Engine 5 - GASP Dynamic Additive Overlay (Overview v1.16)" (0:24:25 Animation Blueprint)

---

## 4. Data Assets & Configuration

Central to DAO's data-driven design.

### 4.1. Primary Data Assets (PDAs) for Items/Actions (e.g., `PDA_ActionData_Weapon`, `PDA_ItemCharData`, `DA_AD_Weapon_M9`)

- **Location:** Various subfolders under `Content/DAO/Blueprints/Data/`, `Content/DAO/Characters/[CharType]/Data/`, or `Content/DAO/Blueprints/HeldObjects/[WeaponName]/Data/`. Older versions might have `Content/DAO/Blueprints/Data/ActionData/`.
- **Role:** Store configuration for weapons, items, and actions. This includes:
  - Skeletal Mesh for the weapon.
  - `ItemID` (Gameplay Tag identifying the item).
  - `LinkedAnimLayerClass` (e.g., `ALI_Pistol_DAO`).
  - Animation Montages (equip, unequip, fire, reload) looked up by Gameplay Tags.
  - `HeldObjectOffset` settings (offsets for hand placement, often per stance, leading to `DA_HOS_IK_Offset` assets).
  - Define item properties, animation montages (equip, unequip, fire, reload), linked anim layers, and character-specific IK offsets.
- **Editing:** Modify these to change weapon meshes, animations, or character-specific holding offsets.
- **Key Videos:** "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (Action Data, 00:27:27), "GASP DAO V1.47 (Item Handling System)" (Item Char Data and Choosers).

### 4.2. Data Assets for Layering (`PDA_OverlayLayering`, e.g., `PDA_OverlayLayering_Rifle_IdleAim`)

- **Location:** `Content/DAO/Blueprints/Data/LayeringData/`
- **Role:** Define how the Dynamic Additive Overlay system behaves for different states (e.g., Idle Aiming, Running Ready). Controls blend weights and spaces (Mesh/Local) for legs, pelvis, spine, arms, head.
- **Editing:** Adjust these to change how stiff or dynamic the character appears when holding items in various states.
- **Key Videos:** "Unreal Engine 5.4 - Motion Matching; Dynamic Additive Layering (Part 1)", "Unreal Engine 5 - GASP DAO (Overview v1.16)" (Layering Data Assets, 0:45:45).

### 4.3. Data Assets for Live Retargeting (`PDA_LiveRetargeting_Settings`, `DA_HOS_IK_Offset`, e.g., `DA_HOS_IK_Offset_MetaHumanTall_M9_Aim`)

- **Location:** Typically character-specific, e.g., `Content/DAO/Characters/MetaHumans/Rigs/[CharName]/HeldObjects/[WeaponName]/` or within broader Data Asset folders.
- **Role:**
  - `PDA_LiveRetargeting_Settings`: Stores IK chain adjustments (FK, IK, Speed Planting) for live retargeted characters.
  - `DA_HOS_IK_Offset`: Stores the precise X,Y,Z location and Pitch,Yaw,Roll rotation offsets for the character's hands (L/R) for a specific weapon in a specific stance. Fine-tuned using the in-game debug widget.
- **Editing:** Crucial for correcting hand placement and aim for different characters using the same animations.
- **Key Videos:** "Unreal Engine 5 - GASP DAO (Update 1.08 Live Retargeting)", "Unreal Engine 5; GASP DAO (v1.21 Overview)" (Data Asset Hand Correction Overview, 07:47), "Unreal Engine 5; GASP DAO (v1.3x) (Custom Character Setup)".

### 4.4. Chooser Tables (`CHT_...`)

- **Location:** `Content/DAO/Blueprints/Data/Choosers/` (main ones), or character-specific data folders.
- **Role:** Dynamically select Data Assets at runtime. For example, a Chooser selects the correct `PDA_OverlayLayering` based on current character state (e.g., `HeldObjectState`, `Stance`, `IsMoving`). Another Chooser selects the correct `PDA_LiveRetargeting_Settings` or `DA_HOS_IK_Offset` based on character type and equipped item.
- **Editing:** Modify Choosers to change which Data Assets are loaded for specific contexts.
- **Key Videos:**
  - Layering Settings: "Unreal Engine 5 - GASP Dynamic Additive Overlay (Overview v1.16)" (Chooser for Layering Data, 0:56:26 Updating Layering Data)
  - Live Retargeting Assets: "Unreal Engine 5 GASP DAO (V1.31 Overview)"
  - Item Character Data: "GASP DAO V1.47 (Item Handling System)" (00:04:35 Char Data Chooser)

### 4.5. Gameplay Tags (`GT_...`)

- **Location:** Managed in Project Settings and stored as Data Table assets (e.g., `GT_DAO_States`, `GT_MetaHumanTags`) usually in `Content/DAO/Blueprints/Data/GameplayTags/` (or similar, project settings also manage these). Tags are often organized into separate tables.
- **Role:** Identify states (character states, item states, stances like `DAO.HeldObject.State.Rifle`, `DAO.HeldObject.Stance.Aim`), item types, character types, and serve as keys in Data Asset maps.
- **Editing:** Add new tags in Project Settings or by editing the Data Table assets.
- **Key Videos:** "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (Gameplay Tags, 00:34:53), "Unreal Engine 5; GASP DAO (v1.38 Overview)" (Gameplay Tags separated into tables, Tag separation).

---

## 5. Item & Slot Management

### 5.1. `AC_HeldObject_Master` & `AC_Gun` (Actor Components)

- **Location:** `Content/DAO/Blueprints/HeldObjects/Components/` (or similar).
- **Role:** These components are attached to item Blueprints.
  - `AC_HeldObject_Master`: Base component for all equippable/interactable items. Manages `ItemID` (Gameplay Tag), `DisplayName`, attachment socket names, physics replication, and the core equip/unequip event-driven logic via Montage Notifies. Fires events for equip/unequip lifecycle.
  - `AC_Gun`: Child/Inherits from `AC_HeldObject_Master`, adds firearm-specific logic like firing and reloading.
- **Editing:** Extend these to add new item types or modify core item behaviors. The actual equip/unequip montage logic is largely driven by this component interacting with the `AC_SlotManager`.
- **Key Videos:**
  - Detailed Breakdown: "GASP DAO V1.47 (Item Handling System)" (deep dive into these components)
  - Refactor for Item Logic: "Unreal Engine 5; GASP-DAO v1.46 (Overview)" (refactor of these components)

### 5.2. `BP_HeldObjects_Master` (Base Item Actor)

- **Location:** `Content/DAO/Blueprints/HeldObjects/BP_HeldObjects_Master.uasset` (or similar).
- **Role:** The base/Parent Blueprint class for all physical pickupable item actors in the world (weapons, flashlights). Must have a PrimitiveComponent (Static or Skeletal Mesh) as its root for proper physics and pickup. It includes the `AC_HeldObject_Master` component.
- **Editing:** Create children of this BP for new items.
- **Key Videos:**
  - Refactor: "Unreal Engine 5; GASP-DAO v1.46 (Overview)" (refactor to use components)
  - Interaction: "Unreal Engine 5; GASP DAO v1.35 (Project Setup & Intro '1')" (08:46 Handling Items)

### 5.3. `AC_SlotManager` (Actor Component on `CBP_SandboxCharacter_DAO`)

- **Location:** Attached to `CBP_SandboxCharacter_DAO`. Can also be found in `Content/DAO/Blueprints/Components/AC_SlotManager.uasset` (or similar).
- **Role:** Manages item slots (holsters) on the character. Handles attaching/detaching items and Slot Actors to character sockets. Defines which items can go into which slots using Gameplay Tags. Manages the character's item slots, attachment of items to these slots, and the logic for drawing and holstering items.
- **Editing:** Configure `ItemSlots` array in `CBP_SandboxCharacter_DAO`'s `AC_SlotManager` component details to define new holsters or attachment points.
- **Key Videos:**
  - Detailed Explanation: "Unreal Engine 5; GASP-DAO (Slot Manager and Item Handling)"
  - Slot Actor Setup: "Unreal Engine 5; GASP-DAO (Slot Actor Setup Explained)"
  - Refactoring for Event-Driven System: "Unreal Engine 5; Gasp-DAO V1.45 (Overview)"

### 5.4. `BP_Slot_Master` (Base Slot Actor)

- **Location:** `Content/DAO/Blueprints/HeldObjects/Slots/BP_Slot_Master.uasset` (or similar).
- **Role:** Parent/Base Blueprint class for visual holsters or attachment points that are themselves actors in the world (and can be picked up from v1.38+). These are attached to the character by `AC_SlotManager` and items are then attached to these `BP_Slot_Master` instances. Contains an `AC_HeldObject_SlotActor` component.
- **Editing:** Create children of this for new holster types.
- **Key Videos:** "Unreal Engine 5; GASP-DAO (Slot Actor Setup Explained)".

---

## 6. Specialized Animation Layers & Poses

### 6.1. Linked Anim Layers (`ALI_...`, e.g., `ALI_Pistol_DAO`, `ALI_Rifle_DAO`)

- **Role:** Specialized Animation Blueprint Layers that provide item-specific animation logic (state machines for idle, locomotion, aiming, firing) that gets linked into the main `ABP_SandboxCharacter_DAO`. Child ALI classes can be created for specific weapons to override poses.
- **Location:** `Content/DAO/Character/Animations/LinkedAnimLayers/` (or weapon-specific subfolders, may be item-specific).
- **Editing:** Duplicate and modify these to create animation sets for new weapon types or to customize existing ones.
- **Key Video References:**
  - Setup: "Unreal Engine 5 GASP DAO (V1.30 Overview)" (Linked Anim Layer Child Classes)
  - Data Flow: "Unreal Engine 5; GASP DAO (v1.23 Overview)" (06:04 Linked Anim Layers)
  - Caching MainAnimBP values: "GASP_DynamicAdditiveOverlay(1.48)"
  - Output warnings fixed: "Unreal Engine 5; GASP DAO (v1.33 Overview)"

### 6.2. Control Rig Poses (`CR_...`, various pose assets `PA_...`)

- **Location:** Poses are often stored near their related animations or in dedicated "Poses" folders (e.g., `Content/DAO/Character/Animations/UEFN/Poses/`).
- **Role:** Control Rigs (e.g., `CR_UEFN_Mannequin_Body`) are used within Sequencer to create/modify static poses. These are then baked into single-frame animation sequences or `PoseAsset` files. Used for idle stances, aiming poses, Aim Offset poses, etc.
- **Editing:** Use Sequencer with the appropriate Control Rig to create or adjust poses.
- **Key Videos:** "Unreal Engine 5 - GASP DAO; Adding States (Part 1)" (modifying one-handed poses), "Unreal Engine 5; GASP DAO - Fixing Animations For Custom Guns" (modifying rifle poses).

### 6.3. Pose Drivers & Corrective Animations

- **Location:** Often part of a Post Process AnimBP (e.g., `ABP_CorrectivePoseDriver_Metahuman`). `PoseAsset` files store the target poses.
- **Role:** Used to drive corrective bone adjustments based on the rotation of a source bone (e.g., forearm twist based on hand rotation) to improve deformation.
- **Editing:** Modify the `PoseAsset` or the `PoseDriver` node settings in the Post Process AnimBP.
- **Key Videos:** "Unreal Engine 5; Post Process Corrective Bone Pose Drivers".

---

## 7. Implementation Guide

### 7.1. Project Summary

The GASP Dynamic Additive Overlay (DAO) project by UnrealDevOp is an advanced character animation and interaction system for Unreal Engine, built upon the Game Animation Sample Project (GASP) and its motion matching capabilities. It emphasizes a highly data-driven architecture using Data Assets, Chooser Tables, and Gameplay Tags to manage character states, animation layering, item handling (weapons, flashlights, etc.), and live retargeting for diverse character anatomies. Key features include a custom dynamic additive overlay system for realistic weapon holding during movement, a precise aim offset system (including distance-based compensation), a robust item slot and holstering mechanism, and progressively implemented network replication. The project is intended for educational purposes but has evolved into a comprehensive template suitable for third-person action games.

### 7.2. Main Classes & Blueprints (Implementation Context)

This section lists the primary Blueprints and assets involved in the DAO system, reiterating their roles in the context of implementation. For full details on each, refer to their respective sections earlier in this document.

1.  **`CBP_SandboxCharacter_DAO` (Character Blueprint)**: Central logic for input, state management, item interaction, traversal, contextual animations, replication, and DBAO.
2.  **`ABP_SandboxCharacter_DAO` (Main Animation Blueprint)**: Drives Motion Matching, Dynamic Additive Overlay, Aim Offset, IK, montages, and links to `ALI_...`.
3.  **`ALI_...` (Linked Anim Layers)**: Item-specific animation logic (state machines, poses).
4.  **`AC_SlotManager` (Actor Component)**: Manages character item slots, holstering, and item attachment.
5.  **`AC_HeldObject_Master` & `AC_Gun` (Actor Components)**: Attached to items; manage item ID, attachment, physics, equip/unequip events (`AC_HeldObject_Master`), and firearm logic (`AC_Gun`).
6.  **`BP_HeldObjects_Master` (Actor Blueprint)**: Base class for all physical item actors.
7.  **`BP_Slot_Master` (Actor Blueprint)**: Base class for visual holster actors.
8.  **Primary Data Assets (`PDA_...`) & Data Assets (`DA_...`)**: Define item properties, animation montages, layering settings, IK offsets, etc.
9.  **Chooser Tables (`CHT_...`)**: Dynamically select Data Assets at runtime.
10. **Gameplay Tag Tables (`GT_...`)**: Define Gameplay Tags for states, item types, etc.

### 7.3. Key Feature Implementation Locations & Video References

Here's a breakdown of where to edit/implement features and relevant tutorial videos:

**1. Animation Layering (Dynamic Additive Overlay)**

- **Description:** The core system that blends weapon holding/action poses with base locomotion.
- **Where to Edit/Implement:**
  - **Logic:** `ABP_SandboxCharacter_DAO` (AnimGraph, "Dynamic Additive Overlay" or similar custom nodes/layers).
  - **Settings:** `PDA_OverlayLayering_...` Data Assets (define blend weights, mesh/local space for different body parts).
  - **Selection:** `CHT_OverlayLayering` (or similar Chooser Table) selects the appropriate `PDA_OverlayLayering` based on character state.
- **Video References:**
  - Setup: "Unreal Engine 5.4 - Motion Matching; Dynamic Additive Layering (Part 1)"
  - Expansion: "Unreal Engine 5 - GASP DAO (Update 1.10)"
  - Overview: "Unreal Engine 5 - GASP Dynamic Additive Overlay (Overview v1.16)" (0:32:15 Animation Layering)

**2. Aim Offset System**

- **Description:** Allows the character to aim up, down, left, and right independently of their movement direction. Includes Universal AO (shared poses) and Custom AO (weapon-specific poses), and Distance Based Aim Offset (DBAO).
- **Where to Edit/Implement:**
  - **Logic & Calculation:** `ABP_SandboxCharacter_DAO` (calculates yaw/pitch, applies to spine/blendspace), `CBP_SandboxCharacter_DAO` (DBAO calculation, setting aim values).
  - **Poses:** Aim Offset poses (e.g., `AO_Pistol_Aim_U`, `AO_Pistol_Aim_LDRD`) created in Sequencer using Control Rig, often stored as single-frame animations or within `PoseAsset` files. The Universal AO poses are usually in `Content/DAO/Character/Animations/UEFN/AimOffset/UniversalAimOffset/`.
  - **Data Assignment:** Custom AO poses are assigned in the child `ALI_...` (Linked Anim Layer) for the specific weapon (see `GASP_DynamicAdditiveOverlay(1.43)`). DBAO toggle in `CBP_SandboxCharacter_DAO` details.
- **Video References:**
  - General: "Unreal Engine 5; GASP DAO (v1.32 Overview)" (Default Look Aim, Yaw AO to root), "Unreal Engine 5; GASP DAO (v1.18 Overview)" (AimOffset corrections).
  - Custom AO: "GASP_DynamicAdditiveOverlay(1.43)"
  - DBAO: "Unreal Engine 5; Gasp-DAO (Distance Based AO)"
  - Responsiveness Fix: "GASP DAO V1.44 (Update Overview)" (Root bone release logic, also referred to as "Unreal Engine 5; GASP-DAO V1.44 (HotPatch Overview)")

**3. Item & Weapon Handling (Equip, Holster, Fire, Reload)**

- **Description:** System for managing how the character picks up, equips, uses, and holsters items.
- **Where to Edit/Implement:**
  - **Core Logic:** `AC_HeldObject_Master` (base item behavior), `AC_Gun` (firing/reloading), `AC_SlotManager` (holstering/drawing logic on character).
  - **Initiation:** `CBP_SandboxCharacter_DAO` (handles input to trigger equip, fire, reload, drop).
  - **Animation Montages:** Defined in item-specific Data Assets (e.g., `DA_AD_Weapon_M9`). Create new montages for new actions.
  - **Montage Notifies:** Events like `AttachHandR`, `DetachHandR` within montages trigger state changes in `AC_HeldObject_Master`.
- **Video References:**
  - Item System: "GASP DAO V1.47 (Item Handling System)"
  - Slot Manager: "Unreal Engine 5; GASP-DAO (Slot Manager and Item Handling)"
  - Event-Driven Equips: "Unreal Engine 5; Gasp-DAO V1.45 (Overview)"

**4. Live Retargeting & Character Setup**

- **Description:** System for adapting UEFN Mannequin animations to characters with different anatomies (e.g., MetaHumans, CC4 characters) at runtime.
- **Where to Edit/Implement:**
  - **IK Retargeter Asset:** Each character type needs an `IKRetargeter` asset (e.g., `IKR_UEFNtoMetaHuman`). Edit this to define bone chains and basic retargeting settings.
  - **Character Blueprint:** Child of `CBP_SandboxCharacter_DAO`. Assigns its specific `IKRetargeter` asset in Class Defaults. Assigns its unique Gameplay Tag.
  - **Live Retargeting Data Assets (`DA_HOS_IK_Offset_...`):** Store hand IK offsets (translation/rotation) for this character, per weapon, per stance. Crucial for precise hand placement. These are selected by a Chooser Table (e.g., `CHT_m_med_nrw_IKRetargeting` for a medium normal weight male MetaHuman) in the character's Blueprint.
  - **Live Retargeting Debug Widget:** Found in `Content/DAO/Blueprints/Widgets/WBP_LiveRetargeting_DebugTool` (or similar). Used in-game to adjust and copy/paste `DA_HOS_IK_Offset` values.
- **Video References:**
  - Setup: "Unreal Engine 5; GASP DAO (v1.3x) (Custom Character Setup)" and "(MetaHuman Setup)"
  - Data Assets for Correction: "Unreal Engine 5; GASP DAO (v1.21 Overview)" (07:47 Data Asset Hand Correction)
  - Anatomy: "How Anatomy Effects Animation Retargeting"

**5. Hand IK ("Procedural Offset Hack")**

- **Description:** Ensures the character's off-hand stays correctly on two-handed weapons, or main hand on one-handed weapons if precise dynamic adjustment is needed.
- **Where to Edit/Implement:**
  - **AnimBP Logic:** `ABP_SandboxCharacter_DAO` (TwoBoneIK nodes targeting Virtual Bones like `VB hand_r`). The "Procedural Offset Hack" calculates the `EffectorLocation` for these IK nodes in the Character Blueprint's Tick/EventGraph to avoid thread desync.
  - **Virtual Bones:** Must be created on the character's skeleton.
  - **Enable/Disable:** Via animation curves (`EnableHandLIK`, `EnableHandRIK`, `DisableHandIK`, `DisableIK`) in montages or specific animation states.
- **Video References:**
  - Procedural Offset Hack: "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (01:32:27 Socket Based Offsets / Procedural Offset Hack)
  - Hand IK in Linked Layers: Discussed in various Linked Anim Layer setup videos.

**6. Traversal System**

- **Description:** Mantling, vaulting, climbing using GASP's contextual system.
- **Where to Edit/Implement:**
  - **Initiation:** `CBP_SandboxCharacter_DAO` (handles input, triggers traversal).
  - **Auto Holster/Equip:** Logic within `CBP_SandboxCharacter_DAO` and `AC_SlotManager` to automatically put away/retrieve items during traversal.
- **Video References:**
  - Replication: "Unreal Engine 5; GASP DAO (v1.33 Overview)" (Traversal replication refactor)
  - Interruption Fixes: "GASP_DynamicAdditiveOverlay(1.48)" (Traversal interruption fixes)

**7. Contextual Animations (Pickups, Takedowns)**

- **Description:** Synchronized interactions between characters or characters and objects.
- **Where to Edit/Implement:**
  - **Scene Assets:** `ContextualAnimScene` asset (defines roles, animations, entry points). `ContextualAnimRole` asset (defines participant roles).
  - **Initiation & Logic:** `CBP_SandboxCharacter_DAO` (queries scene, moves character, starts scene).
  - **Animations:** Custom animations/montages created (e.g., using QuickMagic, Cascador, or manually in Sequencer).
- **Video References:**
  - Pistol Pickup: "Unreal Engine 5; Pistol Pickup Part 1, 2, 3, 4"
  - Takedown: "Unreal Engine 5; Player Take Down Part 1, 2"

**8. Replication**

- **Description:** Making the system work in a networked multiplayer environment.
- **Where to Edit/Implement:**
  - **Character States:** `CBP_SandboxCharacter_DAO` (replicating `HeldObjectState`, `IsAiming`, `TraversalResult` via RepNotifies).
  - **RPCs:** Client-to-Server RPCs in `CBP_SandboxCharacter_DAO` for actions like firing, equipping. Multicast RPCs for cosmetic events.
  - **Item Physics & State:** `AC_HeldObject_Master` (physics replication), `AC_SlotManager` (replicating slot states, item attachments).
- **Video References:**
  - Initial replication pass: "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (00:37:00 Short Replication Intro)
  - Specific feature replication: "Unreal Engine 5; GASP DAO (v1.25 Overview)" (AimOffset, Projectile Replication), "Unreal Engine 5; GASP DAO (v1.33 Overview)" (Traversal replication).

**9. Custom Poses & Animations**

- **Description:** Creating new idle poses, aim poses, action montages.
- **Where to Edit/Implement:**
  - **Tools:** Unreal Engine Sequencer with Control Rig, Blender (for weight painting on custom rigs), AccuRig (for re-rigging), QuickMagic (AI mocap), Cascador.
  - **Integration:**
    - Static poses are added to `LinkedAnimLayers` or `AimOffset` assets.
    - Action montages are added to `PDA_ActionData_Weapon` or similar Data Assets.
    - Custom Idles are integrated into the Motion Matching database via Chooser Tables.
- **Video References:**
  - Control Rig for Poses: "Unreal Engine 5 - GASP DAO; Adding States (Part 1)", "Unreal Engine 5; GASP DAO - Fixing Animations For Custom Guns"
  - Synty Character Re-rigging/Weighting: "Synty - ReRigging Char (with AccuRig) Part 1", "Synty - ReRigging Char (Correcting Finger Weights) Part 2"
  - AI Mocap for Contextual Anim: "Unreal Engine 5; Pistol Pickup Part 1 (Quick Magic Cleanup)"

---

## 8. Version Updates & Key Changes (Chronological)

This section details significant changes and features introduced in various versions of the GASP-DAO project. Refer to the specific "Update Overview" videos for each version for more in-depth explanations.

- **Key Videos for this section:** All videos titled "Update Overview," "Overview," or "HotPatch Overview" (e.g., "GASP DAO V1.44 (Update Overview)", "Unreal Engine 5; Gasp-DAO V1.45 (Overview)", "Unreal Engine 5; GASP-DAO v1.49 (Corruption⁄Bug Fix)").

### Version 1.49 (Corruption/Bug Fix)

- Likely addresses project corruption issues or critical bugs from previous versions. Specific details would be in the video "Unreal Engine 5; GASP-DAO v1.49 (Corruption⁄Bug Fix)".

### Version 1.48

- **Foot Locking Reintroduced:** Addressed synchronization issues between `OffsetRootBone` and Turn In Place animations.
- **Rifle:** Attachments moved to the front, character sockets added, and an animation montage created.
- **Pistols:** Left/Right hand equips reworked for smoother blending.
- **Flashlight:** Equip montage created.
- **`AC_HeldObject_Master`:**
  - Fixed delayed attachment issue when dual wielding that caused stuttering on live retargeted characters.
  - Fixed a bug in montage interruption that didn't consider primary and secondary item montages.
- **`CBP_SandboxCharacter_DAO`:**
  - Fixed a bug when switching characters that generated errors (items are now destroyed).
  - Fixed an issue where traversal interruptions (e.g., reloading during equip) prevented auto-equip.
  - Added `AreItemsBeingHandled` interface function to check if items are being equipped before allowing reload/fire montages.
- **`AC_Gun`:** Logic to prevent reload from being interrupted by fire montages or other reloads; logic to avoid interrupting equips.
- **Linked Anim Layers:** Now cache `MainAnim` values instead of direct property access calls to prevent null reference warnings during initialization.

### Version 1.47 (Item Handling System)

- **`AC_HeldObject_Master`:** Stores data related to item handling.
  - `Item ID` and `Display Name` (latter not actively used but present for custom UI).
  - `Aim Socket Name`: Used to determine the origin of the aim trace.
  - `GetItemCharData` function (from `BPI_Items`) must be overridden in child classes to provide character-specific data for the item.
- **Montages and Gameplay Tags:** Animation montages (equip, unequip, etc.) are fetched from a Data Asset using Gameplay Tags for efficiency.
- **`Exclude Weapon Bones`:** Metadata curve in montages to prevent GASP's overlay logic from affecting weapon bones during specific animations.
- **`Disable Hand IK`:** Metadata curve to disable hand IK during montages where the animation already positions the hand correctly, avoiding unwanted blending.
- **`Montage Notify`:** Used to trigger events at specific points in a montage (e.g., `Attach_Hand`, `Attach_Hand_L`).
- **`AC_Gun`:** Component for weapon logic.
  - `AO Debug Tool`: Tool for visualizing aim offsets (green line for screen center, blue line for weapon barrel).
- **Projectile Aim Rotation:** By default, projectiles follow the weapon barrel's rotation. Can be configured to follow camera rotation (with caveats regarding accuracy due to third-person camera offset).
- **Distance-Based Aim Offset:** Mechanism to compensate for third-person camera offset, making aiming accurate relative to the screen center, regardless of distance.

### Version 1.46 (Item System Refactor)

- **Pickup Logic:** Moved to a Trace system in `CBP_SandboxCharacter_DAO`.
- **`AC_SlotManager`:** Explicit actor casting removed; uses direct function calls on item actor components.
- **`AC_HeldObject_Master`:** Most item logic moved to this component. Choosers remain in item Blueprints due to reference limitations.
- **`AC_HeldObject_SlotActor`:** Additional logic specific to slot actors.
- **`AC_Gun`:** Component for weapon firing and reloading logic.
- **`BP_HeldObjects_Master`:** Refactored to use components and have a `PrimitiveComponent` as its root for better collision and physics replication.
- **`PDA_ItemData`:** Removed; `ItemID` is now in `AC_HeldObject_Master`.

### Version 1.45 (Event-Driven Equip/Holster System)

- **Synchronized Equip/Unequip System:** Refactored to be event-driven, using `Montage Notify Events` for better timing and replication.
  - `Unequip` montages, if not provided, can play the `equip` montage in reverse.
  - Events like `OnMontageAttach` and `OnMontageEquip` are used to synchronize item attachment and state updates.
- **Auto Equip/Unequip in Traversal:** Logic to automatically holster and re-equip weapons during and after traversal actions (climbing, vaulting, etc.).
- **Animation Cancelling in Slot Manager:** A 2-second window added for auto re-equip after traversal, which can be interrupted by the player. To be improved with animation cancelling in Slot Manager.

### Version 1.44 (Update Overview / HotPatch Overview)

- **`ABP_SandboxCharacter_DAO`:** (Note: `ABP_Sandbox_DAO` might be a typo in source, usually `ABP_SandboxCharacter_DAO`)
  - Interpolation and `Counter-Root Compensation` disconnected (temporarily or for adjustment).
  - `Offset Root Bone Max Rotation Error` set to 89 degrees to limit root bone counter-rotation and prevent excessive foot sliding in extreme rotations.
- **Aim Responsiveness:** Significantly improved, but with the side effect of potential foot sliding at larger rotation angles.
- **Reverting Changes:** Instructions on how to revert to previous behavior (reconnect `Interpolation` and `Counter-Root Compensation`, and adjust `Max Rotation Error`).
- **Root bone release logic:** (From "GASP DAO V1.44 (Update Overview)") for aim responsiveness.

### Version 1.43 (Update Overview)

- **Aim Offset:**
  - Disabled by default in the `Unarmed` state.
  - Custom Aim Offsets reintroduced for some weapons/states (e.g., left-hand pistol, flashlight), while others use a universal Aim Offset.
  - Fixed weapon "jerking" issue while aiming by considering the `Offset Root Bone`.
  - Fixed an issue where there was no control over Aim Offset when linking a layer in an `Unarmed` state.
  - Aim Offset interpolation refactored.
- **Turn In Place:** Fixed a bug causing an 8-frame slide due to a sync issue between `OffsetRootBone` and Turn In Place animations (when `Foot Locking` is disabled).
- **`AC_SlotManager`:** Redundant `Item Reference` parameter removed from `HolsterItem` function.
- **`CBP_SandboxCharacter_DAO`:** Fixed a bug related to switching weapons by index (number keys) for left-handed items; replication set up.

### Version 1.42 (Update Overview)

- **Slot-Specific Equipping:** Examples of how to equip items in specific slots (right hand, left hand, dual wield) using new Input Actions.
- **`AC_SlotManager`:** Removed redundant parameter from `DrawHolsteredItem`; added helper function `DrawHolsteredItem_ByIndex`.

### Version 1.41 (Update Overview)

- **Contextual Anim Scene for Pistol Pickup:** Added an example of pistol pickup using the `Contextual Animation Scene` system.
- **Intro Map:** Added an initial map (to be expanded).
- **Unarmed Overlay State Support:** `DefaultOverlayData` now loads data for the unarmed state.

### Version 1.40 (Update Overview - Setup)

- **Project Setup:** Details on setting up the project from the repository, including copying Game Animation Sample files, verifying Gameplay Tags, and configuring Default Pawn Class.
- **Pickup Items:** How to add items to the level and basic pickup/interaction logic.
- **Item Character Data:** Explanation of how character-specific data for items is managed via Choosers and Data Assets, using Gameplay Tags.
- **Slot Manager:** Introduction to the slot system for holsters and managing equipped items.

### Version 1.39 (Update Overview - Hotfix)

- **Slot Manager:**
  - `FindSlotActorByRef` renamed to `FindSlotActorConfigurationByRef` and fixed (was searching for the reference it already had).
  - Fixed a bug where a replaced Slot Actor would not be attached to a socket.
- **`ABP_SandboxCharacter_DAO`:** Neutral Pose updated to match GASP Idle Pose, improving transitions.

### Version 1.38 (Update Overview)

- **Gameplay Tags:** Separated into individual Gameplay Tag Tables for better organization and management.
- **`BP_Slot_Master`:** Item slots are now identified via GameplayTag.
- **`AC_SlotManager`:** Pickup function refactored to unify pickup of items and slot actors. Slot actors can now be picked up. Added comments and fixed an invalid reference error when getting attached items from a slot.
- **`ABP_SandboxCharacter_DAO`:** Arm exclusion in Additive Layering reduced to hands to decrease desynchronization at the shoulders.
- **`CBP_SandboxCharacter_DAO`:**
  - Fixed a bug where items holstered before a Traversal were drawn again afterwards.
  - InputActions now display the hotkey in the bubble for easier identification.
- **Layering Settings Adjustments:** For Rifle Ready to reduce left arm issues.

### Version 1.37 (Update Overview)

- **Animation and Physics Support for Item Skeletal Meshes:** Added support for items (like weapons) that are Skeletal Meshes to have their own Animation Blueprints and simulate physics correctly.
- **Distance Based Aim Offset Replication:** Added.
- **`ItemsInHand` Replication Refactor:** To reduce server traffic.
- **Pickup Manager Logic Moved to `AC_SlotManager`:** To reduce logic in Character BP and make it easier to manage.
- **Distance Based Aim Offset Bug Fixed:** "Snapping" issue when aiming up quickly.
- **`AC_SlotManager`:** Now has arrays to add starting Slot Actors and Items.

### Version 1.36 (Update Overview - Distance Based AO)

- **Distance Based Aim Offset (DBAO):** Introduced to make aiming accurate relative to the screen center, compensating for third-person camera offset.
  - Disabled by default. Enable via: `CBP_SandboxCharacter_DAO > Details > DAO Aim Distance > Use Distance-Based AO`.
  - **Note:** When zeroing character aim, disable DBAO to avoid incorrect results.
- **Rifle Holster Bug:** Fixed issue where picking up a rifle then a pistol would incorrectly discard the rifle.

### Version 1.35 (Update Overview - Custom Character & Bow Setup)

- **Focus on Custom Character and Bow Setup:** Demonstrations on:
  - Exporting assets (bow, poses) from ALS.
  - Importing and retargeting poses to UE4 Mannequin skeleton and then to UEFN Mannequin.
  - Separating pose sets (e.g., `Bow_Relaxed`, `Bow_Aim`, `Bow_Ready`).
  - Using Control Rig to adjust poses (especially hands and posture) for the new character/weapon.
  - Setting up the item BP for the bow.
  - Setting up the AnimSet (Linked Anim Layer) for the bow, assigning corrected poses.
  - Adjusting Layering Settings for the bow state.
  - Setting up slots and holsters.
- **Finger Correction for MetaHumans:** All MetaHumans had their hands corrected for more precise weapon holding.
- **Auto-Aim Reintroduced and Improved:** Weapon aims automatically on fire and returns to rest.
- **Montage Handling Refactored.**
- **Crouch Layering Issue (Idle):** Fixed.
- **Unarmed Mode Reintroduced.**

### Version 1.34 (Update Overview)

- **Held Object Tags:** Corrected for characters.
- **IK Retarget Settings Update:** Now also updated when the weapon changes, not just on Linked Anim Layer stance changes.
- **Weapon Cycle:** Fixed to cycle left and right correctly.
- **Leg Layering Reconnected.**
- **Old Slots Removed.**
- **Rifle Fire Montage Updated to Use Correct Slot.**

### Version 1.33 (Update Overview)

- **MetaHuman Aim Accuracy:** All MetaHuman weapons adjusted for precise aiming.
- **MetaHuman Finger Grips:** Improved for all weapons.
- **Auto-Aim Reintroduced and Improved:** Character aims automatically when firing, then returns to rest state.
- **Montage Handling Refactored.**
- **Crouch Layering Issue (Idle):** Fixed.
- **Linked Anim Layer Output Warnings Resolved.**
- **Unarmed Mode Reintroduced:** With refactoring for proper support.
- **Traversal replication refactor.**

### Version 1.32 (Update Overview)

- **"Default Look Aim" Logic:** Introduced for when not aiming with a weapon.
- **Weapon Clipping:** Weapon no longer clips into the character's body when not aiming (idle or turning in place).
- **Yaw AO Partially Applied to Root Bone:** For increased responsiveness (at a small cost of potential foot slide).
- **Logic Reverted to Pre-OffsetRootBone:** To simplify Aim Offset process and reduce logical overhead.

### Version 1.31 (Update Overview)

- **Choosers in Animation Blueprint:** No longer used for selecting/applying Layering Settings. Linked Anim Layers now store and load these settings, removing the need for the animation system to track `CurrentHeldObjectState`.
- **Weapon Meshes:** Now stored in their Data Assets to centralize weapon data.
- **Live Retargeting Assets:** No longer stored in a Map. Now handled in the Character Blueprint using Choosers. Requires `HeldObjectState Gameplay Tag` to be added to a `Gameplay Tag Container`.
- **Finger Retargeting Correction:** Method for fixing finger retargeting issues, involving retargeting poses, modifying them, retargeting back, and configuring character-specific Data Actions and Linked Anim Layers.

### Version 1.30 (Update Overview)

- **Universal Aim Offset:** Replaced the previous Aim Offset system.
  - **Drawbacks:** May cause weapon clipping with the body at extreme angles (e.g., looking down) if a custom Aim Offset is not provided.
- **Aim Offset "Wrapping" Issue Fixed.**
- **New Overlay Layer for Upper Body:** Added to the Dynamic Additive Overlay system.
- **Linked Anim Layer Child Classes:** Introduced to allow customization of poses and animation logic per weapon/item type.
  - Pose variables (e.g., `Pistol_Aiming_Pose`, `Rifle_Moving_Ready_Pose`) are defined in these child classes.

### Version 1.28 (Update Overview - Fluid AimOffset)

- **Aim Offset Latency/Jittering Issue Overcome:** The order of operation of the `Offset Root Bone` relative to Aim Offset calculation was crucial.
- **Copy Motion:** Explanation of how `Copy Motion` works and why the order of `Pose History` and `Offset Root Bone` is important.
- **Overlay Pose Alignment:** The overlay pose needs to be aligned with the root rotation of the Motion Matching pose for `Mesh Space Rotation Blend` to work correctly. This is achieved using `Get Actor Transform` and `Inverse Transform Rotation`.
- **Layering Settings Adjustments:** Particularly for the `Pistol Linked Anim Layer`, to use `Copy Motion` for the right arm (weapon hand) and apply `Motion Matching Arm Swing` to the left arm.
- **Aim Offset Calculation Refined.**
- **Hand IK Pole Vector Fixed.**

### Version 1.27 (Update Overview - Copy Motion)

- **Alternative Animation System with `Copy Motion` Introduced:**
  - `Copy Motion` is used to transfer movement from a source (e.g., Motion Matching locomotion animation) to specific bones of a static base pose (e.g., weapon holding pose).
  - Allows reintroducing dynamic movement to otherwise static overlay poses.
  - Configured via Data Assets (`CM_Data_Map` and `PDA_CopyMotion_DataAsset`) for different stances.
  - The `Pose History` node must precede the `Copy Motion` node in the AnimGraph.
  - The `Offset Root Bone` should precede `Pose History`.
- **`Copy Motion` Node Structure:**
  - `Use Base Pose From Reference`: If checked, uses `Base Pose Reference` (usually `Pose History` output) and `Base Pose` (static pose to animate) to calculate a movement delta.
  - `Bone To Modify`: Bone in the static pose that will receive movement.
  - `Source Bone`: Bone in `Base Pose Reference` from which movement is copied.
  - `Copy Space Bone Name`: Defines coordinate space for copying (e.g., `spine_05`).
  - `Apply Space Bone Name`: Defines coordinate space for applying movement.
  - `Translation/Rotation Scale`: Allows scaling of copied movement.
  - `Target Curve Name`: Used with `Leg IK` for fine control.
- **Application:**
  - For pistols, `Copy Motion` was not used in aiming state to maintain precision but used in the "ready" (not aiming) state.
  - For rifles (two-handed weapons), `Copy Motion` was applied for more dynamism.
- **Copy Motion Specific Linked Anim Layers:** Created (`CM_Pistol_LinkAnimLayer`, `CM_Rifle_LinkAnimLayer`) to encapsulate `Copy Motion` logic.

### Version 1.25 (Update Overview)

- **Replication Fixes:**
  - Jump now works correctly in a replicated environment.
  - AimOffset is now replicated and without the previous jittering issue.
  - Projectile now replicates correctly on Dedicated Servers.
- **Other Fixes:**
  - 1H (one-handed) pistol animation had odd aiming; fixed.
- **Additions:**
  - Left-hand fighting punch (cooldown handled with a `Montage Event`).

### Version 1.24 (Update Overview - Breakdown Part 1)

- **Educational Purpose:** Project is MIT licensed for educational use.
- **Input Mechanics:**
  - Keys 1, 2, 3: Pistol, Rifle.
  - Key 4: Fighting Stance (with punch).
  - Key N: Emote/Dance (layering example).
  - Key G: Alternative Turn in place (with motion warping).
- **Aiming System and Debug:**
  - Green line: From weapon muzzle to screen center.
  - Blue line: Weapon barrel direction.
  - Numbers in top corner: Angular offsets for aim precision debugging.
- **Live Retargeting and Anatomy:** Anatomical differences between characters cause aim offsets. The system includes adjustments for this.
- **Folder Structure:**
  - Main Blueprints in `Content/Blueprints/DAO/` (path may vary, e.g. `Content/DAO/Blueprints/`).
  - Custom animations in `Content/Characters/UEFN_Mannequin/Animations/DAO_Anims/`.
- **Held Object System:**
  - Managed via `CBP_SandboxCharacter_DAO`.
  - Uses Data Assets (`PDA_ActionData_Weapon`, `PDA_ActionData_Fight`) for weapon/action info (animations, tags, etc.).
  - `Held Object Offset` (via `PDA_HeldObject_Offset` Data Assets) for real-time editor correction of weapon position in hand.
- **Gameplay Tags:** Extensively used for states, weapons, actions. Main table: `Content/Blueprints/DAO/Data/GT_DAO_States.uasset` (path may vary).
- **Layered Montages:** System for overlaying animations (e.g., reload over aim pose) using `Layering Settings` (Data Assets) controlling body part effects (mesh space vs. local space, blend weights).
- **Live Retargeting:**
  - Characters (MetaHumans, etc.) use `Live Retargeting` for UEFN Mannequin animations.
  - `IK Retargeter Assets` for bone mapping.
  - `PDA_LiveRetargeting_Settings` (Data Assets) for IK Chain adjustments (FK, IK, Speed Planting) per stance/weapon, allowing fine posture/aim correction per character.
- **Firing Mechanic:**
  - `BasicProjectile` function in `CBP_SandboxCharacter_DAO`.
  - Can use `BaseAimRotation` (camera rotation) or weapon muzzle rotation.
  - `AO_DebugTool` for visualizing/adjusting precision.
- **Socket-Based Offsets:** Used for left-hand placement on two-handed weapons, using a "Procedural Offset Hack" to avoid Game Thread/Anim Graph desync lag.
- **AimOffset Interpolation:** Logic for smooth AimOffset transitions.

---

## 9. Detailed Mechanics (Integrated from Video Reference Guide)

This section further details core mechanics, integrating information primarily from the "Video Reference Guide" structure provided in the source text.

### 9.1. Item and Held Objects System (`AC_HeldObject_Master`, `AC_Gun`)

- **Core Component: `AC_HeldObject_Master`**
  - **Description:** An Actor Component attached to all equippable/pickupable item Blueprints (guns, flashlights, even holsters if they are pickupable). It's the brain for individual item behavior.
  - **Functionality:** Handles replication setup for the item actor (sets "Replicates," "Replicate Movement"). Stores the item's unique `ItemID` (Gameplay Tag) and `DisplayName`. Contains parameters for `AimSocketName` (muzzle), `HandSocketNameL/R` (character hand sockets this item attaches to), and `HolsterSocketName` (if this item _is_ a holster, where other items attach _to it_). Manages the core item lifecycle through its `HandleItem_New` function (covering Pickup, Equip, Holster, Unequip) which is often triggered by Montage Notifies (e.g., `AttachHandR`, `DetachHandR`) played during equip/unequip animations. It also fires an `OnTaskFinished` event dispatcher.
  - Manages data like `ItemID`, `DisplayName`, `AimSocketName`.
  - Contains logic for physics replication (using UE 5.x `Reimulate` mode).
  - `Physics Disabled Delay`: Time before physics is disabled after the item is dropped.
  - Interface `BPI_Items` with functions like `GetItemCharData` (must be overridden to provide character-specific data for the item) and `GetItemMesh`.
- **`AC_Gun`:** Component specific to firearms, inherits from `AC_HeldObject_Master`.
  - Contains logic for firing (`Fire`) and reloading (`Reload`), usually triggered by events from the `BPI_Guns` interface.
  - Manages the `AO_DebugTool` for visualizing aim precision.
  - Controls projectile logic, including initial projectile offset from the muzzle.
- **Item Blueprints (e.g., `BP_Gun_M9`, `BP_Item_Flashlight`)**
  - **Description:** These are the actual item actors. They are typically children of a base class like `BP_HeldObject_Master` (from DAO).
  - **Setup:** Contain a Skeletal Mesh Component (for animated weapons) or Static Mesh Component. The root component _must_ be a PrimitiveComponent (Mesh) for proper physics replication. They must have "Replicates" checked. They will have the `AC_HeldObjectMaster` component.
  - **Interface Implementation:** Crucially, they must implement the `BPI_Items` interface and override the `GetItemCharData` function. This function is called by the character system to fetch character-specific animation and IK settings for this item. `GetItemCharData` typically returns a "Character Data Chooser" asset (e.g., `CHT_m_med_nrw_IKRetargeting`).
- **Sockets for Attachment**
  - **Character Hand Sockets:** Defined on the character's skeleton (e.g., `HeldObject_R`, `HeldObject_L` for IK characters, `weapon_r` for UEFN mannequins). The `HandSocketNameR/L` on an item's `AC_HeldObjectMaster` specifies which of these the item attaches to.
  - **Weapon Muzzle Sockets:** Defined on the weapon's skeletal mesh (e.g., "AimSocket," "MuzzleFlashSocket"). Used for spawning projectiles, particle effects, and the Distance Based Aim Offset debug trace.
  - **Item-to-Item Sockets (Holsters):** A socket defined on a holster item's mesh (e.g., a "PistolAttachPoint" on a hip holster). The `HolsterSocketName` on the `AC_HeldObjectMaster` of the _gun_ would refer to this socket name on the _holster_ it can attach to.
- **Data Assets for Items & Character-Item Interaction**
  - **Action Data Assets (`PDA_ActionData_Weapon`, `PDA_ActionData_Fight`):** Store information about specific actions, like animation montages (equip, unequip, fire, reload), cooldown tags, etc. Accessed via the `HeldObjectState` on the character.
  - **Item Definition (`FDAO_HeldObjectDefinition` struct, often within a Character Data Asset like `DA_CD_UEFN_Mannequin`):** Item-specific. Stores the weapon's Skeletal Mesh, its `ItemID` struct (containing its GameplayTag like `DAO.HeldObject.State.Rifle.M1A1` and DisplayName), the `LinkedAnimLayerClass` (e.g., `ABP_HeldObjectAnimLayer_MM_Rifle_M1A1`) that dictates its holding/aiming animations, and references to its Fire/Reload montages.
  - **Character Data Asset (e.g., `DA_CD_UEFN_Mannequin`):** Character-and-Item specific. This is what the Character Data Chooser (e.g. `CHT_...`) returns when a character equips an item. It contains the `HeldObjectOffset` map.
  - **`HeldObjectOffset` Map (within Character Data Asset):** A TMap where the Key is a Stance Gameplay Tag (e.g., `DAO.HeldObject.Stance.Aim`, `DAO.HeldObject.Stance.Ready`) and the Value is a `DA_HOS_IK_Offset` Data Asset.
  - **`DA_HOS_IK_Offset` (Data Asset for Hand IK Offset):** Stores the precise `StaticLocalOffset` (Vector) and `StaticRotationOffset` (Rotator) for the character's Left and Right hand IK targets, relative to the weapon's hand attachment socket. These values are unique for a specific character type, holding a specific weapon, in a specific stance. They are fine-tuned using the in-game "Game Anims" / "Live Retargeting" debug widget.

### 9.2. Slot and Holster System (`AC_SlotManager`)

- The `AC_SlotManager` is a character component responsible for managing "slots" where items (or their "holsters") can be attached.
- **Slot Configuration:**
  - `ItemSlots` (Array in `AC_SlotManager`): Defines each available slot on the character.
    - `SocketName`: The character skeleton socket where the Slot Actor attaches.
    - `PreferredReachingHand`: The hand used to interact with this slot.
    - `AllowedSlotGameplayTag` (renamed to `SlotID` in v1.38+): A Gameplay Tag identifying the slot type (e.g., `Slot.Hip.Pistol.M9`).
- **Slot Actors (e.g., `BP_Slot_Hip_Pistol_M9`)**:
  - Actors representing visual holsters or attachment points.
  - Contain an `AC_HeldObject_SlotActor` (child of `AC_HeldObject_Master`).
  - `SlotTag` (Gameplay Tag in `AC_HeldObject_SlotActor`): Must match an `AllowedSlotGameplayTag` / `SlotID` in `AC_SlotManager`.
  - `AcceptedItemTags` (Gameplay Tag Container): Defines which item `ItemID` tags can be holstered in this slot actor.
- **Holster/Equip Logic:**
  - When holstering, `AC_SlotManager` finds a compatible and available Slot Actor.
  - Item attaches to the `HolsterSocketName` (defined in `BP_Slot_Master`) of the Slot Actor.
- **Multi-Item/Slot Management:**
  - Supports carrying multiple items in different slots.
  - `CycleHolsteredItems` function for switching between holstered items.
  - `TryFreeHand` logic attempts to holster the current item to free a hand.
- **Pickup of Items and Slot Actors:**
  - From v1.38+, Slot Actors can also be pickup items.
  - `AC_SlotManager` logic unified for picking up both items and Slot Actors.
- **Starting Items/Slots:** `AC_SlotManager` can be configured to equip initial items and Slot Actors at `BeginPlay`.

### 9.3. Animation and Layering System

- **Base on Motion Matching (GASP):** The system uses the Game Animation Sample Project (GASP) as its foundation for primary locomotion, driven by Motion Matching.
- **Core Animation Blueprint (`ABP_SandboxCharacter_DAO`)**
  - **Description:** The central AnimBP for DAO characters. It manages base locomotion (from GASP's Motion Matching), the dynamic additive overlay system, aim offsets, IK (hand and foot), and links to specialized Animation Layers for held objects.
  - **Communication:** Uses Blueprint Interfaces (BPIs) to get data from the Character Blueprint (e.g., current overlay state, movement parameters) to keep the AnimGraph performant (avoiding direct casting on worker threads).
- **Dynamic Additive Overlay Layering**
  - **Description:** The system for applying weapon holding poses or other states over the base locomotion.
  - **Mechanism:** Typically involves a `Make Dynamic Additive` node (using a "Neutral Pose" and the current "Locomotion Pose" as inputs) and then an `Apply Additive` node to apply the resulting difference to an "Overlay Pose" (e.g., character holding a rifle). This is done for various body parts (legs, pelvis, spine, arms, head) with controllable weights and blend spaces (Mesh Space or Local Space).
  - **Control:** Layering behavior (which parts of the body are affected, how much, and in which space) is defined in `PDA_OverlayLayering` Data Assets, which are selected at runtime by Chooser Tables based on character state.
  - **Key Videos:** "Unreal Engine 5.4 - Motion Matching; Dynamic Additive Layering (Part 1)" (detailed setup), "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (early explanation), "Unreal Engine 5 - GASP DAO (Update 1.10)" (layering expansion).
- **Linked Anim Layers (`ALI_`)**
  - **Description:** Specialized Animation Blueprint Layers that provide animations and logic specific to a type of held object (e.g., `ALI_Pistol_DAO`, `ALI_Rifle_DAO`).
  - **Functionality:** They contain state machines for idle, locomotion (e.g., using a BlendSpace like `BS_Pistol_Locomotion`), aiming, and firing animations pertinent to that item category. They read variables (like `IsMoving`, `IsAiming`) from the main AnimBP.
  - **Linking:** The `LinkedAnimLayerClass` is specified in the item's Action Data Asset (e.g., `DA_AD_Weapon_MyNewGun`). The main AnimBP's `DynamicAdditiveOverlay` node (or equivalent) then uses this linked layer.
  - **Hierarchy:** Child linked anim layers can be created to override poses for specific weapons while inheriting base logic.
  - **Key Videos:** "Unreal Engine 5 GASP DAO (V1.30 Overview)" (discusses child linked anim layers), "GASP_DynamicAdditiveOverlay(1.48)" (caching MainAnimBP values).
- **Montages**
  - **Description:** Used for discrete actions like firing, reloading, equipping, unequipping, emotes, and contextual takedowns.
  - **Playback:** Played on specific animation slots (e.g., `OverlayFullBody`, `OverlayUpperBody`, `DefaultSlot`). The slot determines how the montage blends with the rest of the animation graph.
  - **Custom Layering:** Layering settings for the overlay system can be temporarily overridden or injected while a montage is playing, via Blueprint Interface calls from the character to the AnimBP.
  - **Metadata Curves:** Special curves within montages like `DisableIK` (disables all IK), `DisableHandIK` (disables only hand IK), or `ExcludeWeaponBones` (prevents overlay from affecting weapon bone transforms if the montage animates the weapon directly) control behavior of the DAO system during montage playback.
  - **Key Videos:** "Unreal Engine 5 - GASP DAO (Update 1.15)" (new slots like `OverlayFullBody`), "Unreal Engine 5 - GASP DAO (Update 1.14)" (injecting layering settings for montages), "GASP DAO V1.47 (Item Handling System)" (metadata curves).
- **Aim Offset System**
  - **Description:** Allows the character's upper body/weapon to aim independently of the lower body's orientation.
  - **Evolution:** The system has been refactored multiple times. Early versions used spine bone manipulation. Later versions incorporated Blend Spaces and then specific Aim Offset assets. A "Universal Aim Offset" was introduced, with options for custom per-weapon aim offsets.
  - **Distance Based Aim Offset (DBAO):** A more advanced system to ensure projectile paths align accurately with the center-screen crosshair.
  - **Key Videos:** "Unreal Engine 5 GASP DAO (V1.30 Overview)" (Universal Aim Offset), "Unreal Engine 5; Gasp-DAO (Distance Based AO)", "GASP_DynamicAdditiveOverlay(1.43)" (Custom Aim Offsets reintroduced).
- **Hand IK**
  - **Description:** Primarily Two-Bone IK used to keep the character's off-hand correctly placed on two-handed weapons.
  - **Targets:** Uses Virtual Bones (e.g., `VB hand_r`).
  - **Procedural Offset Hack:** Addresses latency/jitter issues between game thread and animation thread.
  - **Control:** Enabled/disabled via animation curves (`EnableHandLIK`, `EnableHandRIK`, `DisableHandIK`).
  - **Key Videos:** "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)" (explains the hack).
- **Foot IK & Foot Locking**
  - **Description:** Uses GASP's built-in foot placement system.
  - **Issues & Fixes:** Addressed sync issues between OffsetRootBone and Turn In Place animations.
  - **Key Videos:** "GASP_DynamicAdditiveOverlay(1.48)" (Foot Locking reintroduced).
- **Copy Motion Node (Experimental Alternative Layering)**
  - **Description:** An alternative animation layering technique that copies bone transforms from a source animation to a target pose.
  - **Setup:** Requires a `Pose History` node before the `CopyMotion` node.
  - **Use Cases:** Experimented with for layering locomotion onto stiff weapon poses.
  - **Key Videos:** "Unreal Engine 5; Copy Motion Intro Part 1", "Unreal Engine 5; GASP DAO - Copy Motion (V1.27 Overview)".
- **Control Rig for Poses**
  - **Description:** Used in Sequencer for creating/modifying static animation poses (idle, aim, ready stances).
  - **Workflow:** Bake animation to Control Rig, adjust, bake back to animation or pose asset.
  - **Key Videos:** "Unreal Engine 5 - GASP DAO; Adding States (Part 1)", "Unreal Engine 5; GASP DAO - Fixing Animations For Custom Guns".
- **Pose Drivers (Corrective Animations)**
  - **Description:** Drives corrective bone adjustments based on source bone rotation (e.g., forearm twist from hand rotation).
  - **Mechanism:** Uses a Pose Asset and a Pose Driver node in an AnimBP (often Post Process).
  - **Key Video:** "Unreal Engine 5; Post Process Corrective Bone Pose Drivers".

### 9.4. Character Setup & Retargeting

- **Anatomy & Retargeting Challenges**
  - **Description:** Differing bone lengths and proportions make animation retargeting complex. End effectors (hands) won't align in world space even with perfectly matched base poses. Manual adjustments or IK offset systems are necessary.
  - **Key Video:** "How Anatomy Effects Animation Retargeting".
- **Live Retargeting vs. Hard Retargeting**
  - **Description:** DAO primarily uses Live Retargeting (IK Retargeter asset at runtime) for scalability, despite a per-character performance cost. Hard retargeting (baking animations) increases memory usage.
  - **Key Video:** "Unreal Engine 5; Retargeting vs Live Retargeting¿".
- **Setting Up Custom Characters (MetaHumans, Synty, Character Creator)**
  - **MetaHumans:** Use optimized game-ready versions. Setup involves child BP, assigning meshes, AnimBP, IK Retargeter. Hand placements managed by `DA_HOS_IK_Offset` Data Assets via Choosers.
    - **Key Videos:** "Unreal Engine 5; GASP DAO - Setting Up A Custom MetaHuman", "GASP DAO V1.47 (Item Handling System)".
  - **Synty Characters:** Re-rigging (e.g., AccuRig) and significant weight painting (Blender) highly recommended.
    - **Key Videos:** "Synty - ReRigging Char (with AccuRig) Part 1", "Synty - ReRigging Char (Correcting Finger Weights) Part 2".
  - **Character Creator (CC4) Characters:** Typically UE4-compatible skeleton. Requires IK Rig/Retargeter. Add hand sockets (`HeldObject_R/L`).
    - **Key Video:** "Unreal Engine 5; GASP DAO v1.35 (Custom Character Setup '2')".
  - **General Custom Character Setup:** Duplicate existing DAO character BP, replace mesh, assign AnimBP, IK Retargeter, Gameplay Tags, and Data Assets for offsets.
    - **Key Videos:** "Unreal Engine 5; GASP DAO v1.35 (Initial Custom Character Setup '1')".
- **Virtual Bones**
  - **Description:** Created on skeletons (e.g., `VB hand_r`) as stable IK targets and for the "Procedural Offset Hack." Must be created on the target character's skeleton as Live Retargeting doesn't transfer them.
  - **Key Videos:** "Unreal Engine 5; GASP DAO (GitHub Setup)", "Unreal Engine 5; GASP DAO Full Setup & Troubleshooting (v1.3x)".

### 9.5. Specific Gameplay Mechanics

- **Traversal (Mantling/Vaulting)**
  - **Description:** Leverages GASP's built-in traversal system.
  - **Item Handling:** DAO system auto-unequips/re-equips items during traversal, with logic for interruptions.
  - **Key Videos:** "Unreal Engine 5 GASP DAO (V1.30 Overview)", "GASP_DynamicAdditiveOverlay(1.48)".
- **Contextual Animations (Pickups, Takedowns)**
  - **Description:** Uses UE's Contextual Animation Scene system for synchronized interactions.
  - **Setup:** Requires Scene Asset, Role Asset, animations (montages), and `ContextualAnimSceneActor` component on actors.
  - **Execution:** Player/AI queries scene, moves to entry point, system plays synchronized animations.
  - **Examples:** Pistol pickup, player takedown.
  - **Key Videos:** Pistol Pickup Series ("Unreal Engine 5; Pistol Pickup Part 1-4"), Takedown Series ("Unreal Engine 5; Player Take Down Part 1-2").
- **Turn In Place**
  - **Description:** Animations and logic for character rotation while stationary.
  - **Issues & Evolution:** Addressed responsiveness and visual artifacts (foot sliding) by custom TIP animations and syncing OffsetRootBone.
  - **Key Videos:** "Unreal Engine 5 - GASP DAO (Update 1.20)", "Unreal Engine 5; GASP DAO - Custom Idle & TurnInPlace (Breakdown)".
- **Custom Idle States**
  - **Description:** Allows different idle states beyond standard GASP idles (e.g., alert, relaxed).
  - **Mechanism:** New states in Motion Matching database (via Chooser Tables), transitions controlled by Character BP/AnimBP logic.
  - **Key Videos:** "Unreal Engine 5 - GASP DAO (Update 1.20)", "Unreal Engine 5; GASP DAO - Custom Idle & TurnInPlace (Breakdown)".

---

## 10. Tools & External Software

- **10.1. AccuRig (Reallusion):**
  - **Purpose:** Recommended for re-rigging character models, especially those with problematic initial skeletons like some Synty characters.
  - **Key Video:** "Synty - ReRigging Char (with AccuRig) Part 1".
- **10.2. Blender:**
  - **Purpose:** Used for 3D modeling tasks, particularly for detailed weight painting corrections on characters after they have been re-rigged with tools like AccuRig.
  - **Key Video:** "Synty - ReRigging Char (Correcting Finger Weights) Part 2".
- **10.3. QuickMagic.AI:**
  - **Purpose:** An AI Motion Capture tool used to generate base animation clips from video footage, which are then cleaned up and used for contextual interactions (like the pistol pickup).
  - **Key Video:** "Unreal Engine 5; Pistol Pickup Part 1 (Quick Magic Cleanup)".
- **10.4. Cascador:**
  - **Purpose:** Animation software mentioned for creating or editing animations, particularly transitions between different character states or custom idles.
  - **Key Video:** "Unreal Engine 5; GASP DAO - Custom Idle & TurnInPlace (Breakdown)".
- **10.5. iClone (Reallusion):**
  - **Purpose:** Animation software used for creating or modifying animations. The creator noted some issues with pelvis offsets on animations exported from iClone.
  - **Key Video:** "UE 5; GASP-DAO Breakdown - Part 1 (v1.24)".

---

## 11. Additional Topics and Tips

- **Troubleshooting Common Issues:**
  - **Git Repository Corruption with Cloud Sync:** It is highly recommended NOT to use services like Google Drive, OneDrive, etc., to synchronize the folder of a Git repository as it can corrupt the internal `.git` files.
  - **`desktop.ini` Errors:** Can arise from the aforementioned corruption or broken references. Deleting `desktop.ini` files from within the `.git` folder (with caution) or re-creating the `upstream` remote might help.
  - **Missing `GraphFormatter` Plugin:** If a project is opened without a required plugin, UE will show a "Missing Modules" error. The plugin can be disabled by editing the `.uproject` file or removing the plugin's folder from `Project/Plugins/`.
- **AI Movement (`MoveTo` with Motion Matching):**
  - The proper way to get AI to move with Motion Matching is to enable "Use Acceleration for Paths" in the Character Movement Component's Nav Movement properties.
  - Assign an AI Controller to the character. The AI Controller can then use `AI Move To` tasks.
  - Ensure a NavMeshBoundsVolume covers the walkable areas.
  - **Key Videos:** "Unreal Engine 5; Motion Matching Ai MoveTo (The Proper Way To Do It)", "Unreal Engine 5; Motion Matching Ai MoveTo (Trouble Shooting)".
- **Performance Profiling (ALS vs. Motion Matching):**
  - The creator conducted performance tests comparing GASP-DAO (Motion Matching based) with Advanced Locomotion System (ALS). Results vary based on character count and scene complexity, but DAO with Live Retargeting generally has a measurable but often acceptable performance cost.
  - **Key Video:** "Unreal Engine 5 - ALS vs Motion Matching (Performance Profiling)".
- **Quixel Megascans Access:**
  - A video clarifies that free Megascans obtained via an Epic Games content license through Quixel.com or Bridge would eventually be sunsetted from those platforms and would not automatically transfer to Epic's Fab marketplace (only assets from paid Quixel subscriptions would). Users would access Megascans via Fab.
  - **Key Video:** "Quixel is Shutting Down (Get MegaScans From FAB)".
- **Enhanced Input with Widgets:**
  - It's possible to use Enhanced Input Actions from Widgets, but they won't fire if the Player Controller's Input Mode is set to 'UI Only'. It works with 'Game and UI' or 'Game Only'.
  - **Key Video:** "Unreal Engine 5; Enhanced Input With Widgets".

This manual is a starting point. It is recommended to consult the original videos and the official GitBook documentation for more detailed and visual information.
