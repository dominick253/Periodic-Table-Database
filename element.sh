#!/bin/bash
#feat:
#refactor:
#chore:
#test:
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [ -z "$1" ]
then
  echo "Please provide an element as an argument."
  exit 0
fi



if [[ $1 =~ ^-?[0-9]+$ ]]; then
    RESULT=$($PSQL "SELECT 'The element with atomic number ' || e.atomic_number || ' is ' || e.name || ' (' || e.symbol || '). It''s a ' || t.type || ', with a mass of ' || p.atomic_mass || ' amu. ' || e.name || ' has a melting point of ' || p.melting_point_celsius || ' celsius and a boiling point of ' || p.boiling_point_celsius || ' celsius.' FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number = '$1'")
else
    RESULT=$($PSQL "SELECT 'The element with atomic number ' || e.atomic_number || ' is ' || e.name || ' (' || e.symbol || '). It''s a ' || t.type || ', with a mass of ' || p.atomic_mass || ' amu. ' || e.name || ' has a melting point of ' || p.melting_point_celsius || ' celsius and a boiling point of ' || p.boiling_point_celsius || ' celsius.' FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.symbol = '$1' OR e.name = '$1'")
fi

if [ -z "$RESULT" ]
  then
    echo "I could not find that element in the database."
else
    echo "$RESULT"
fi
