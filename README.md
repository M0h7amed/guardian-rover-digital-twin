# Guardian Rover Digital Twin (Master Integration)

[![MATLAB](https://img.shields.io/badge/MATLAB-R2025b-orange?logo=mathworks)](https://www.mathworks.com/)
[![Simulink](https://img.shields.io/badge/Simulink-Required-blue)](https://www.mathworks.com/products/simulink.html)
[![Stateflow](https://img.shields.io/badge/Stateflow-Required-yellow)](https://www.mathworks.com/products/stateflow.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A system-level Model-Based Design (MBD) digital twin of an autonomous rover, integrating supervisory Stateflow logic, battery equivalent circuit modeling (ECM), and Unreal Engine 3D visualization into a single synchronized Simulink environment.

**Note on Subsystems:** This repository serves as the **top-level master integration file**. The detailed mathematical models and standalone testing for the individual subsystems are maintained in their respective repositories:
* 🔋 **[Guardian-Battery-ECM-Modeling](https://github.com/M0h7amed/Guardian-Battery-ECM-Modeling-)**: Contains the EVE LF50K LiFePO4 Equivalent Circuit Model and EKF state estimation.
* 🚙 **[Guardian-Rover-Control](https://github.com/M0h7amed/Guardian-Rover-Control)**: Contains the core autonomous navigation, sensor debounce logic, and local unicycle control systems.

---

## 📋 Project Objectives

- **System Integration:** Combine separate kinematic, logical, and electrical subsystems into a unified `finals.slx` simulation environment.
- **Power Management Logic:** Implement a dynamic electrical routing switch that connects the kinematic motor draw during active driving states, and forces a -20A charging/recovery current upon mission completion.
- **Unreal Engine 3D Visualization:** Map 2D global coordinates (X, Y, Yaw) into strict 5x3 matrices to physically render the rover's chassis and independent wheels without detachment anomalies.
- **Simulation Stability:** Resolve complex algebraic loops between the vehicle state and battery voltage using discrete Unit Delays (`1/z`) and enforce a synchronized fixed-step solver clock.

---

## 🗂️ Repository Structure

```text
├── Run_Mission.m           # Master initialization script — sets up paths, workspace, and launches the model
├── finals.slx              # Top-level Simulink model (Master Digital Twin)
├── ROVER/                  # Subdirectory containing referenced rover logic and kinematics
├── BATTERY/                # Subdirectory containing referenced battery ECM and power load switching
├── LICENSE                 # MIT License
├── README.md               # Project documentation
└── docs/
    ├── Guardian_Mission_Final_Report.pdf  # Full integration engineering report
    └── simulation_output.png              # Post-simulation plots (Trajectory & Power)
```

---

## ⚙️ Prerequisites

- MATLAB R2025b (Recommended for the latest 3D Simulation Blockset features)
- Simulink
- Stateflow
- Simulink 3D Animation / Automated Driving Toolbox (for Unreal Engine visualization)

---

## 🚀 How to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/M0h7amed/guardian-rover-digital-twin.git
   ```
2. Open MATLAB and set your current working directory to this repository folder. Ensure the `ROVER/` and `BATTERY/` subdirectories are present.
3. Run the master initialization script in your Command Window:
   ```matlab
   Run_Mission.m
   ```
   This script will automatically:
   * Clear legacy workspace data.
   * Use `addpath` to dynamically link the `ROVER` and `BATTERY` subfolders.
   * Define critical logic variables (e.g., the sensor debounce threshold `N_confirm = 5`).
   * Load all base dimensional and electrical variables via sub-scripts.
   * Launch the `finals.slx` master model.
4. Click **Run** in the Simulink model to open the Unreal Engine 3D viewer and watch the rover navigate.
5. Review the post-simulation plots generated from the workspace data (Battery SOC drop vs. Rover Trajectory).

---

## 🛠️ System Architecture Highlights

- **Supervisory Controller (Stateflow):** A state machine evaluating real-time battery health (SOC > 20%) to dynamically scale the rover's physical speed, or trigger a complete abort (Status = 4) if terminal voltage drops below critical safety limits.
- **3D Array Formatting (`pack_3d`):** A custom MATLAB function mapping scalar $X, Y, Yaw$ data into a strict $5 \times 3$ matrix for Translation, Rotation, and Scale. It locks wheel positional offsets to `[0,0,0]` to keep the physical meshes attached to the chassis.
- **Kinematic Translation (`GetVelocity`):** Trigonometric resolver using standard unicycle kinematics to decompose local forward speed ($Vx$) into global map coordinates ($x\_dot = Vx \cdot \cos(yaw)$ and $y\_dot = Vx \cdot \sin(yaw)$).

---

## 📑 Full Project Report

A detailed engineering report covering the integration architecture, solver synchronization, array formatting for the Unreal Engine, and power-state transitions is available here:

📄 [Guardian Mission — Full Technical Integration Report (PDF)](docx/Guardian%20mission%20project%20Report%20.pdf)
---

## 📸 Sample Output



![Simulation Output](docx/Output%20Car%20.png)

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Mohamed Nabil Ali Abd Elaziz Soliman**  
B.S. Mechatronics and Robotics Engineering, Ain Shams University  
Model-Based Design Diploma
