#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WGOALS OGOALS
do
  if [[ $OPPONENT != "opponent" ]]
  then
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # if not found
    if [[ -z $TEAM_ID ]]
    then
      # insert team name
      INSERT_NAME_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      echo $WINNER
    fi
    if [[ -z $TEAM_ID2 ]]
    then
      # insert team name
      INSERT_NAME2_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      echo $OPPONENT
    fi
  fi

if [[ $YEAR != "year" ]]
then
TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
TEAM_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $TEAM_ID, $TEAM_ID2, $WGOALS, $OGOALS)")
fi
done
