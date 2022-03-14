room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

door(office,hall).
door(kitchen,office).
door(hall,'dining room').
door(kitchen,cellar).
door('dining room',kitchen).

:-dynamic location/2.
location(desk, office).
location(apple,kitchen).
location(flashlight,desk).
location('washing machine',cellar).
location(nani,'washing machine').
location(broccoli,kitchen).
location(crackers,kitchen).
location(computer,office).
location(envelope,desk).
location(stamp,envelope).
location(key,envelope).

location_s(object(candle,red,small,1),kitchen).
location_s(object(apple,red,small,1),kitchen).
location_s(object(apple,green,small,1),kitchen).
location_s(object(table,blue,big,50),kitchen).

edible(apple).
edible(crackers).

tastes_yucky(broccoli).

:-dynamic here/1.
here(kitchen).

where_food(X,Y):-location(X,Y),edible(X).
where_food(X,Y):-location(X,Y),tastes_yucky(X).

connect(X,Y):-door(X,Y).
connect(X,Y):-door(Y,X).

list_things(Place):-location(X,Place),tab(2),write(X),nl,fail.
list_things(_).

list_connections(Place):-connect(Place,X),tab(2),write(X),nl,fail.
list_connections(_).

look:-here(Place),write('You are in the '),
      write(Place),nl,write('You can see:'),nl,
      list_things(Place),write('You can go to:'),nl,
      list_connections(Place).
      
can_go(Place):-here(X),connect(X,Place).
can_go(Place):-write('You can not get there from here.'),nl,fail.

move(Place):-retract(here(X)),asserta(here(Place)).

goto(Place):-can_go(Place),move(Place),look.

can_take(Thing):-here(Place),location(Thing,Place).
can_take(Thing):-write('There is no '),write(Thing),write(' here.'),nl,fail.

take_object(X):-retract(location(X,_)),asserta(have(X)),write('taken'),nl.

is_contained_in(T1,T2):-location(T1,T2).
is_contained_in(T1,T2):-location(X,T2),is_contained_in(T1,X).
