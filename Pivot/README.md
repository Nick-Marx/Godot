
# **Pivot**

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

Points_cAfter suffering a headache and possibly a bout of food poisoning, I let my frustration get the better of me and decided to create a new branch in GitHub Desktop to see if coding player movement off the player script would work. This turned out to be the right choice, not only was I able to reproduce the same effects with about 50% less code, but it feels like I was able to fine-tune it more too.  

<img align="right" width=200 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_first_success.gif"/>  
<div align="left">Behold! A stick, jumping between colored dots, while alternating rotation speed and direction. Don't let my skills fool you, timing the center of the dots to increase rotation speed is actually quite tricky.  </div>
---|
## **Second Success -- Changing Colors**  

\*Long Inhale\*  
So... This step was more aggrovating than it should have been. Not only were there no solid answers online, but the solution seemed to come from the left while I was looking right. It turns out that Godot conserves memory by sharing the Material resource amongst every instance of an object that uses the Material. So if I try to change the color of the Material, it changes the color across all instances. I spent about 10 hours testing out different approaches based on hints I got online. What finally ended up working was creating seperate Mesh files for each color that I intend to use, then loading the Meshes into their own variable and applying it whenever I want to change an objects color.  

Forgive me if I didn't find the most efficient or practical way to do this, but it works.  

<img align="right" width=200 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_second_success.gif"/>  

After another hour of tinkering I got more colors and a scoreboard.  
  
<img align="right" width=200 src="https://github.com/Nick-Marx/Godot/blob/main/Pivot/README/pivot_second_success2.gif"/>  

## **Final Thoughts**  

WIP - Placeholder Text -  
Each task in this project challenged me to consider things in a broader scope and think in terms of code reusability and efficiency. Using blueprints definately helped with this and being able to visialize the interactions between classes, objects, variables, and functions. Thank you [The Tech Academy](https://www.learncodinganywhere.com/) for giving me this opportunity and helping me succeed.
