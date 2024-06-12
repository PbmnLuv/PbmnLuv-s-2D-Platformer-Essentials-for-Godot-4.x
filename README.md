This project is sample/skeleton project for anyone who wants to make a 2D Platformer in Godot 4.x with ease.
All important variables and modes are able to be set on the editor through the inspector!

It features:
 -> Player Script:
    - Basic moving scripts, with acceleration, maximum velocity, separate break speed.
    - Gravity control, including a toggle for enabling 'holding the jump button to go higher' and a variable which controls its intensity.
    - Control the number of possible jumps.
    - 3 different modes for Coyote Time:
      - None (no coyote time)
      - Inifinite (inifinite amount of time to perform the jumps)
      - Limited Time (perform the jump withing the specified time in milliseconds)
-> Camera Script:
  - Needs a reference for the Player Node.
  -> Has 3 different modes:
     - Fixed: Camera is fixed to the Player Node.
     - Follow: Camera follow the player node.
     - "Follow Interactive": Is an improved version of Follow camera in which you can set it to look ahead when moving forward or backwards and also look up and down
     - Both "Follow Camera" modes have a toggle for the jump follow, which sets whether the camera follows the player upon jumping or not. You can also control the intensity of this jump follow, by changing the
       jumpFollowReducer variable. The bigger it is the less intense the follow will be on the jump.
  
