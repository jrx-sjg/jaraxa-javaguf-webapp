#!/bin/bash
set -ex
JAVA_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
JAVA_ARTIFACT="app.jar"
KEYSTORE_PATH="/opt/cacerts/"
KEYSTORE="absences-management.keystore"

exec java $JAVA_OPTIONS -Djavax.net.ssl.trustStore=$KEYSTORE_PATH$KEYSTORE -Djavax.net.ssl.trustStorePassword=$KEYSTORE_PASS -Djasypt.encryptor.password=$ENCRYPTOR_PASS -jar $JAVA_ARTIFACT  

