# Program Description
This program calculates the converter currents based on the input parameters. The program is written in Fortran programming language and requires Fortran compiler to be installed to run the program.

## Input Parameters

The following input parameters are used in the program:

- pref: reference active power
- qref: reference reactive power
- ugrid: grid voltage magnitude
- xconv: converter impedance
- ThetaGrid_Degree: grid voltage angle in degrees
- Synch: synchronization flag (0 or 1)
- Grid_Form: grid form (0, 1, or 999)

## Output
The program calculates the active and reactive power based on the input parameters and prints the results to the console.

## How to Run the Program
Install Fortran compiler on your system.
Open a terminal or command prompt and navigate to the directory where the program file (Conv_Ctrl.f90) is located.
Type gfortran Conv_Ctrl.f90 -o Conv_Ctrl and press Enter to compile the program.
Type ./Conv_Ctrl and press Enter to run the program.
Note: The output of the program will be printed to the console.
