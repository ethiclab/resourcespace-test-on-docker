#!/bin/bash
cp /tmp/config.php /tmp/resourcespace/include/config.php
service mysql start &&
mysql < /tmp/ini.sql &&
php -c /tmp/php.ini test.php
TEST_RESULT=$?
if (($TEST_RESULT != 0))
then
    mysql rs_test_db < /tmp/query.sql
fi
