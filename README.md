# Gyroscope-Circus-Tricks

## How to run animation

1. Place "animateGyro", "getXdot", "rotateGyro" and, "main" in the same directory.
2. Open main in MATLAB
3. Under the first block of code labelled "User Inputs" set the initial conitions of the gyroscope. Some defualts are provided for you.
4. If the animation is desired to be saved to a file, have REC=1, else REC=0.
5. (Optional) change the damping constants inside of getXdot.m, or set them to 0 to model the gyroscope without friction. This will not result in the gyroscope slowing down and lowering over time. It is recomended to set the gamma velocity to be non zero for more accurate similuation without friction.
6. To re-derive equations of motion, run getEOMs. 
