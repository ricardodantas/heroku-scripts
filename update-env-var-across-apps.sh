
HEROKU_SOURCE_APP=$1
HEROKU_ENVVAR_TO_SYNC=$2
HEROKU_APPS_LIST=$3

heroku maintenance:on --app $HEROKU_SOURCE_APP
heroku maintenance:off --app $HEROKU_SOURCE_APP

echo "UPDATE ENV VAR from $HEROKU_SOURCE_APP..."
HEROKU_ENVVAR_VALUE=$(heroku config:get $HEROKU_ENVVAR_TO_SYNC --app $HEROKU_SOURCE_APP >&1)

IFS=', ' read -r -a array <<< $HEROKU_APPS_LIST
for element in "${array[@]}"
do
  heroku maintenance:on --app $element
  heroku config:set $HEROKU_ENVVAR_TO_SYNC=$HEROKU_ENVVAR_VALUE --app $element
  heroku maintenance:off --app $element
done
