# ThermalConductivitySimulation

You will need to set the system variable "EngineeringToolkit" to point to the path where you downloaded this repository in order to use ANSYS automation scripts.

Open example "cubic test" and run script "exportProblem.py" with the IronPython within ANSYS STEADY-STATE Thermal workbench.

You wont need to "solve" the problem with APDL from ANSYS, ou are recommended to set the mesh sizing to 0.1mm and run the script. A series of prompts will appear for you to setup some configurations, including where to export the results. This is done early so that the program wont have to stop running to query inputs. When the setup is done, you can go drink some coffee. The mesh will be updated automatically (so you dont need to wait for the mesh to be generated before starting the solution), the problem will be exported, solved, imported, and served as a "User defined result" (Temperature) on STEADY-STATE Thermal.