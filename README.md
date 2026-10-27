# Guardian Rover Digital Twin

A Model-Based Design digital twin of an autonomous rover, integrating Stateflow logic, battery equivalent circuit modeling, and Unreal Engine 3D visualization in Simulink.

## Project Overview
This repository contains the top-level integration environment for the Guardian Mission project. It acts as the master digital twin, uniting separate kinematic, logical, and electrical subsystems into a single synchronized 3D simulation. 

**Note:** The detailed mathematical models for the individual components are maintained in their respective standalone repositories:
* **Guardian-Battery-ECM-Modeling:** Features the EVE LF50K LiFePO4 Equivalent Circuit Model and EKF state estimation.
* **Guardian-Rover-Control:** Contains the core autonomous navigation and local control systems.

This repository focuses strictly on the master integration files (`finals.slx` and `Run_Mission.m`) required to bridge these domains together.

## Key Integration Features
* **Unreal Engine 3D Visualization:** Utilizes a custom `pack_3d` MATLAB function to format 5x3 translation and rotation matrices, accurately rendering the rover's chassis and wheels without physical detachment anomalies.
* **Solver Synchronization:** Enforces a strict Fixed-step solver across all referenced models to maintain real-time synchronization with the 3D physics engine.
* **Algebraic Loop Resolution:** Implements discrete Unit Delays (1/z) between the Stateflow mission status and the battery current draw to ensure stable, continuous simulation without solver freezing.
* **Power Management Logic:** Features a dynamic load-switching mechanism that routes kinematic motor draw during active states and triggers a -20A charging/recovery current upon mission completion (Status >= 4).
* **Global Spatial Tracking:** Resolves local unicycle kinematics (forward speed and yaw) into global X and Y map coordinates via the `GetVelocity` function and discrete-time integrators.

## Execution Instructions
1. Clone this repository. Ensure the `BATTERY` and `Rover` subdirectories are present.
2. Open MATLAB (R2025b recommended).
3. Run the `Run_Mission.m` script. This master script will:
   * Initialize the workspace and add subfolders to the MATLAB path.
   * Set the consecutive detection debounce threshold (`N_confirm = 5`).
   * Load the required kinematic and electrical variables.
   * Execute the `finals.slx` master Simulink model.
4. View the active 3D visualization window and review the post-simulation power and trajectory plots.

## Author
**Mohamed Nabil Ali Abd Elaziz Soliman**  
B.S. Mechatronics and Robotics Engineering, Ain Shams University  
Model-Based Design Diploma (Prepared for Eng. Ahmed Hassan)
