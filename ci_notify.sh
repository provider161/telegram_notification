#!/bin/bash

TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Build status: $1
Branch: $CI_COMMIT_REF_SLUG
Commit title: $CI_COMMIT_TITLE
Commit short SHA: $CI_COMMIT_SHORT_SHA
User: $GITLAB_USER_NAME"
JSON='{
    "chat_id": "'$TELEGRAM_CHAT_ID'",
    "text": "'$TEXT'",
    "disable_notification": true,
    "reply_markup": {"inline_keyboard": [[
        {"text": "Pipeline", "url": "'$CI_PROJECT_URL'/pipelines/'$CI_PIPELINE_ID'/"},
        {"text": "Report",   "url": "'$CI_PROJECT_URL'/pipelines/'$CI_PIPELINE_ID'/test_report/"},
        {"text": "Commit",   "url": "'$CI_PROJECT_URL'/commit/'$CI_COMMIT_SHA'"}
        ]]}
}'

# send message to specific telegram chat
curl -s --max-time $TIME -d "$JSON" -H "Content-Type: application/json" -X POST $URL

# send message to specific telegram user
# curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" "$URL" > /dev/null