
# **Pivot Devlog**

Pivot is a solo project made using the Godot 4.x Engine/GDScript. It is my first project since completeing The Tech Academy's Game Developer Course.  

Start date: 24/09/22 (originally 26/06/22 using Godot 3.x, but had to start over after engine upgrade)  

Skill level: Novice  

## **Overview**

This project is based off of an idea I've been holding for a few years now, along with several others, since I first made the decision to persue game development. I chose this project for it's simplicity yet wide range of concepts to help me practice.  

Pivot is based off an old Mac game that I played in the mid 90's called Spin Doctor. It was very rudimentary in its concepts, so I figured I might be able to recreate a semblance of the game while improving upon it.  

## **Game Summary**</th>

WIP 

## **Initial Setup**

I started by writing my ideas down in a whiteboard app. Getting things out made it very easy to organize them into what order I wanted to complete them. The ideas were vague and turned into an outline of about a page long.  

Being new to Godot, I watched a few tutorials for 2d and 3d until I decided on using 3d for the game. Then I built my folder structure. I'm still not sure what the best practice is, but from what I can find it doesn't really matter for small projects. I decided on grouping things by gameplay layers (eg. maps, player, enemy, collectables).  

## **First Success -- Movement**

Getting the first map, a 'dot' object, and player made were relatively simple and I don't really consider this my first success since a few images floating in space seemed trivial. I spent about 12 hours researching and trying to find/plan out the best way to control the player in relation to the dots. In hindsight, my first attempt was good, but not efficient. Contrary to my first instinct, I decided to build the player movement handling off of the dot scripts since it seemed easiest to pull the positioning of the dots this way as well as control their signals (events).  

After suffering a headache and possibly a bout of food poisoning, I let my frustration get the better of me and decided to create a new branch in GitHub Desktop to see if coding player movement off the player script would work. This turned out to be the right choice, not only was I able to reproduce the same effects with about 50% less code, but it feels like I was able to fine-tune it more too.  

Behold! A stick, jumping between colored dots, while alternating rotation speed and direction. Don't let my skills fool you, timing the center of the dots to increase rotation speed is actually quite tricky. The player can hold down the action button to jump to the next dot, but it won't register as a 'center hit' and won't increase speed.  

<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_first_success.gif"/>  
</div>

## **Second Success -- Changing Colors**  

\*Long Inhale\*  
So... This step was more aggrovating than it should have been. Not only were there no solid answers online, but the solution seemed to come from the left while I was looking right. It turns out that Godot conserves memory by sharing the Material resource amongst every instance of an object that uses the Material. So if I try to change the color of the Material, it changes the color across all instances. I spent about 10 hours testing out different approaches based on hints I got online. What finally ended up working was creating seperate Mesh files for each color that I intend to use, then loading the Meshes into their own variable and applying it whenever I want to change an objects color.  
  
Forgive me if I didn't find the most efficient or practical way to do this, but it works.  
<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_second_success.gif"/>  
</div>  

<br>
After another hour of tinkering I got more colors and a scoreboard.  
<br>
<br>
<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_second_success2.gif"/>  
</div>

## **Auto-Generating Map... and Singletons?¿**

\*Personal Note\* I took a hiatus that was intended to be only a few weeks or a month, but I lost motivation and also got and lost a job in the proceeding months.

So I discovered Godot has it's own form of 'singletons' that it calls Autoload. This has helped me greatly. I managed to find a way to generate dots as the player moves in any direction, but I can't seem to figure out why they will keep generating even if there is a dot already there.

After about 20 hours of research and testing out different approaches, I sought help from a Discord server. The solution ended up being rather simple and seems to be very efficient. Apparently, I misunderstood how Godot handles dictionaries.
<br>
Solution: Create a dictionary of Vector3 coords and the corresponding Dot object, then just look up the coordinates in the dictionary to determine if a Dot needs placed or not.
Amazingly, this seems scalable to 3D and this approach could probably also work when I go to implement obstacles/enemies/collectables.
<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_third_success.gif"/>  
</div>

## **Camera control and obstructions**

Wait... I have an idea. I decided to spend a couple hours redoing my player scene to include a parent node. I hope this wasn't a waste of time, but it seems it would be much simpler to control the camera this way. Oh, also, I moved the camera to be a child of this parent node in the player scene so that it will always follow the player around.

I ran into a problem now. How do I smooth the camera movement if it's tethered to the player position? I can't seem to get lerp or interpolate to work. My head hurts, this is a problem for future me.

For now, I decided to implement a way of hiding objects between the camera viewport and the player. I ended up just using an area shape and setting up signals to toggle the objects visibility.

My next objective is to figure out the best way to keep track of the player orientation. This will directly tie into how I flesh out the map generation. I'm hoping I can find a mathematical way to orient everything, but if I can't the next best thing seems to map out each possible position (24 possible) and changing the player state as needed. This will likely work, but doesn't seem to be very efficient.

Captain's Log 5/31/23: ...I couldn't sleep. As I lie awake my thoughts wander to my project and I ask myself if I'm taking the best approach. Notably, I had two epiphanies: 
<br>
-Instead of making the camera a child of the player, I will make the camera follow a child of the player, specifically the directional lighting since they seem to always be in the exact same spot. This has solved my camera control and smoothing problems. \*happy noises\* (It also seems my player scene restructuring was necessary, glad that hour and a half was worth it)
<br>
-I remembered reading in short about a property of transform called Basis which will return the normalized vector requested. I believe this can solve my orientation problem. Wish me luck.

## **Player Position Orientation and Map Gen Improvement**

Yay! After so many hours of research and dead ends I finally got the player orientation tracking to work. It turns out I just had to brush up on my vector math. This also allowed me to get the map generation fully operational. I still think I can tweak it a bunch, but it works for now.
<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_maj_milestone1.gif"/>  
</div>

If the rest of the project goes smoothly this will officially be the 1/3 completion point.
<br>
A little overview of what I intend to still add:
<br>
-Collectibles/ power-ups, enemies, obstacles
<br>
-Improved HUD
<br>
-Audio (movement-based sound effects and music)

## **Refactoring, Signals, Bumper Obstacle**

\*Personal Note\* Another hiatus (I'd be finished by now if I didn't keep doing this).

Joined the official Godot Discord server. Met some users who gave me a lot of sound advice (and also got some validation for this project - feels good). Using this newfound knowledge, I decided to refactor my code.

Took me the better part of 3 weeks, about 2-12 hours every day:
<br>
-Tossed out a lot of redundant code and moved some function calls around for efficiency.
<br>
-Removed a bunch of unnecessary/duplicate nodes.
<br>
-Set up global signals (learned how to better use signals)
<br>
-Improved a lot of object references in my scripts.
<br>
-Added object fade out distance to help with dizziness when moving

Foolish me, I tried to add a bumper obstacle while refactoring - this is probably why I took so long getting everything to work.
<br>
<br>
Eureka! Everything works as it should.
<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_maj_milestone1_2.gif"/>  
</div>

All-in-all the game is running about 25% better with about 20% fewer lines of code.
<br>
I learned alot and am glad I did this.
<br>
Life is good!

## **Colors! and a Pause Menu**

Decided to add a splash of color by setting the background to randomize and lerp to another color at a steady interval. Need to pick better colors, but it works pretty well.
<br>
No help online for this one, but luckily I was able to stumble my way around it.

Changed player color; I really like this soft neon pick I found.

Made pause menu. This took me longer than I thought it would since there are tons of tutorials out there, but I have the bad habit of trying to change things to meet my needs at the same time I'm learning them so it all breaks and I have to fix it.
<br>
<br>
I know everything's still moving behind the menu so it doesn't really 'pause' anything right now except for the time, but I may eventually add a survival mode that includes an enemy that follows the player which would pause when the menu opens.
<br>
<br>
It's pretty minimalistic, but I like the style so far. I might change the buttons, text, and/or colors eventually.

<div align="center">
<img height=300 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_fourth_success.gif"/>  
</div>
  
## **Final Thoughts**  

WIP - Placeholder Text -  


Note: GitHub MD sucks. It took me so many hours just to get this REAME formatted correctly and it still didn't turn out the way I wanted.
