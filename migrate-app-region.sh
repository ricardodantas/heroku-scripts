SOURCE_APP=$1
TARGET_APP=$2

echo "Installing the heroku plugin..."
heroku plugins:install heroku-fork

echo "Starting the REGION migration..."
heroku fork --from $SOURCE_APP --to $TARGET_APP --region eu

echo "Complete the next steps:"

echo "1. UPDATE the custom DNS/SSL settings"
open https://devcenter.heroku.com/articles/app-migration#dns-preparation
open https://dashboard.heroku.com/apps/$SOURCE_APP/settings
open https://dashboard.heroku.com/apps/$TARGET_APP/settings

echo "2. Copy cronjobs to the new migrated app"
open https://devcenter.heroku.com/articles/app-migration#scheduler
heroku addons:open scheduler -a $SOURCE_APP
heroku addons:open scheduler -a $TARGET_APP

# echo "3. Update database settings..."
# heroku maintenance:on -a $SOURCE_APP
# open https://devcenter.heroku.com/articles/app-migration#database-preparation
# heroku maintenance:off -a $SOURCE_APP
