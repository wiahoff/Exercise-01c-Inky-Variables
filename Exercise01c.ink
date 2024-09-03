/*
This is a comment block. It won't be read as an Ink story.
Comments are very useful for leaving ideas for story and functionalty

This exercise will demonstrate the following in the example video:
 - Variable types: integer, float, boolean
 - Variable assignment
 - Printing variables
 - Variable checking
 
 In the assignment:
 - Add four more knots
 - Assign at least TWO new variables through player choices
 - Print at least one of the variables to the player in a passage
 - Check the value of a variable and have it do something
*/

VAR matches = 3
VAR pickaxe = false
VAR dynamite = 0

-> cave_mouth

== cave_mouth ==
You are at the enterance to a cave. {not match_pickup:There is a match on the floor.} The cave extends to the east and west. You have {matches} {matches == 1: match}{matches > 1: matches}.



+ [Take the east tunnel] -> east_tunnel
+ [Take the west tunnel] -> west_tunnel
* [Pick up the match] -> match_pickup

== east_tunnel ==
You are in the east tunnel. It is very dark, you can't see anything.
* {matches > 0} [Light match] -> east_tunnel_lit
+ [Go back] -> cave_mouth
-> END

== west_tunnel ==
You are in the west tunnel. It is too dark to see anything.{west_tunnel_lit and not rock_smash: You know there is a rock in this room.}
*{pickaxe}{west_tunnel_lit}[Smash the rock with your pickaxe] -> rock_smash
* {matches > 0} [Light match] -> west_tunnel_lit
+ {rock_smash} [Follow the light] -> underground_lantern
+ [Go back] -> cave_mouth
-> END

=== match_pickup ===
~ matches += 1
You now have {matches} {matches == 1: match}{matches > 1: matches}
+[Go back] -> cave_mouth
-> END

== east_tunnel_lit ==
~ matches -= 1
The light of your match reveals an abandoned pickaxe. The match quickly burns out.
*[Grab pickaxe] -> pickaxe_pickup
-> END

==pickaxe_pickup==
You pick up the rusty pickaxe. 
~pickaxe = true
+[Go back] -> east_tunnel

==west_tunnel_lit==
~ matches -= 1
Your match lights up the area for a brief moment. You can see a large rock blocking the path.
*{pickaxe}[Smash the rock with your pickaxe] -> rock_smash
+[Go back] -> west_tunnel

==rock_smash==
~pickaxe = false
As you smash the rock your pickaxe breaks. You see a light in the distance.
+[Go back] -> west_tunnel

==underground_lantern==
You find yourself in front of a lit lantern, a bizzare find in a blocked off cave. You see other lanterns in the distance. You see another path shrouded in darkness.
+[Follow the lanterns] -> lantern_path
+[Enter the dark path] -> dark_path
+[Go back] -> west_tunnel

==dark_path==
It is too dark to see anything.
*{matches > 0}[Light a match] -> dark_path_lit
+[Go back] -> underground_lantern

==dark_path_lit==
You see a piece of dynamite on the floor
*[Pick up dynamite] -> dynamite_pickup

==dynamite_pickup==
You pick up the dynamite
~ dynamite += 1
+[Go back] -> dark_path

==lantern_path==
You follow the path which leads to a massive crystal.
*{dynamite > 0}[Blow up the crystal] -> crystal_end
+[Go back] -> underground_lantern

==crystal_end==
You collect as many fragments as you can. You are now rich!
-> END

