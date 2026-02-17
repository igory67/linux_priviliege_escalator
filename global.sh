#!/bin/bash

export HOMESEARCH="/home/ /root/ /var/www $(cat /etc/passwd 2>/dev/null | grep 'sh$' | cut -d ":" -f 6 | grep -E -v '^/root|^/home|^/var/www' | tr '\n' " ")"
export SEARCH_IN_FOLDER=""
export USER=$(whoami)
#echo $HOMESEARCH

echo_not_found()
{
	echo "Not found: $1" 
}

print_2title()
{
#	echo\ "=================== $1 =================="
	printf "\n${BLUE}==================||$1||=====================${NC}\n\n"
}

small_print()
{
	printf "${PRINTF_BOLD}%s${NC}\n" "$1"
}

print_small_title()
{
	printf   "\n==${PRINTF_BOLD_BLUE}==%s==${NC}==\n" "$1"
}

print_red()
{
    printf  "${PRINTF_RED}%s${NC}\n" "$1"
}

print_red_yellow() 
{
    printf   "${PRINTF_RED_YELLOW}%s${NC}\n" "$1"
}

print_green() 
{
    printf   "${PRINTF_BOLD_GREEN}%s${NC}\n" "$1"
}


print_blue()
{
	printf   "${PRINTF_BOLD_BLUE}%s${NC}\n" "$1"
}
print_cyan()
{
	printf   "${PRINTF_CYAN_BLUE}%s${NC}\n" "$1"

}

export C=$(printf '\033')
export RED="${C}[1;31m"
export GREEN="${C}[1;32m"
export YELLOW="${C}[1;33m"
export BLUE="${C}[1;34m"
export NC="${C}[0m"

export SED_RED="${C}[1;31m&${C}[0m"
export SED_GREEN="${C}[1;32m&${C}[0m"
export SED_YELLOW="${C}[1;33m&${C}[0m"
export SED_BLUE="${C}[1;34m&${C}[0m"
export SED_CYAN="${C}[0;36m&${C}[0m"
export SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
export SED_LIGHT_CYAN="${C}[1;96m&${C}[0m"
 
export PRINTF_RED='\033[0;31m'
export PRINTF_GREEN='\033[0;32m'
export PRINTF_YELLOW='\033[1;33m'
export PRINTF_BLUE='\033[0;34m'
export PRINTF_CYAN='\033[0;36m'
export PRINTF_RED_YELLOW='\033[1;31;43m'  
export PRINTF_NC='\033[0m' 
export PRINTF_BOLD='\033[1m'

export PRINTF_BOLD_RED='\033[1;31m'
export PRINTF_BOLD_GREEN='\033[1;32m'
export PRINTF_BOLD_YELLOW='\033[1;33m'
export PRINTF_BOLD_BLUE='\033[1;34m'

if echo | sed -r "" >/dev/null 2>&1; then
	export E="r"
else
	export E="E"
fi

#if [ $(id -u) -eq 0 ]; then
#	export IAMROOT="1"
#else
#	export IAMROOT=""
#fi

if ([ -f /usr/bin/id ] && [ "$(/usr/bin/id -u)" -eq "0" ]) || [ "`whoami 2>/dev/null`" = "root" ]; then
	IAMROOT="1"
	MAXPATH_FIND_W="3"
else
	IAMROOT=""
	MAXPATH_FIND_W="7"
fi 

#export shscripsG=".*"
#export Wfolders=".*"
#writable folders!
for grp in $(groups $USER 2>/dev/null | cut -d ":" -f2); do
  wgroups="$wgroups -group $grp -or "
done

export wgroups="$(echo $wgroups | sed -e 's/ -or$//')"

export WF=$(find / maxdepth $MAXPATH_FIND_W -type d ! -path "/proc/*" '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w and '(' $wgroups ')' ')' ')' 2>/dev/null | sort)
export shscriptsG="/0trace.sh|/alsa-info.sh|amuFormat.sh|/blueranger.sh|/crosh.sh|/dnsmap-bulk.sh|/dockerd-rootless.sh|/dockerd-rootless-setuptool.sh|/get_bluetooth_device_class.sh|/gettext.sh|/go-rhn.sh|/gvmap.sh|/kernel_log_collector.sh|/lesspipe.sh|/lprsetup.sh|/mksmbpasswd.sh|/pm-utils-bugreport-info.sh|/power_report.sh|/prl-opengl-switcher.sh|/setuporamysql.sh|/setup-nsssysinit.sh|/readlink_f.sh|/rescan-scsi-bus.sh|/start_bluetoothd.sh|/start_bluetoothlog.sh|/testacg.sh|/testlahf.sh|/unix-lpr.sh|/url_handler.sh|/write_gpt.sh"
export Wfolders=$(printf "%s" "$WF" | tr '\n' '|')"|[a-zA-Z]+[a-zA-Z0-9]* +\*"
export mail_apps="Postfix|Dovecot|Exim|SquirrelMail|Cyrus|Sendmail|Courier"

export sh_usrs=$(cat /etc/passwd 2>/dev/null | grep -v "^root:" | grep -i "sh$" | cut -d ":" -f 1 | tr '\n' '|' | sed 's/|bin|/|bin[[:space:]:]|^bin$|/' | sed 's/|sys|/|sys[[:space:]:]|^sys$|/' | sed 's/|daemon|/|daemon[[:space:]:]|^daemon$|/')"ImPoSSssSiBlEee" #Modified bin, sys and daemon so they are not colored everywhere
export nosh_usrs=$(cat /etc/passwd 2>/dev/null | grep -i -v "sh$" | grep -v "$USER" | sort | cut -d ":" -f 1 | tr '\n' '|' | sed 's/|bin|/|bin[[:space:]:]|^bin$|/')"ImPoSSssSiBlEee"
export knw_usrs='_amavisd|_analyticsd|_appinstalld|_appleevents|_applepay|_appowner|_appserver|_appstore|_ard|_assetcache|_astris|_atsserver|_avbdeviced|_calendar|_captiveagent|_ces|_clamav|_cmiodalassistants|_coreaudiod|_coremediaiod|_coreml|_ctkd|_cvmsroot|_cvs|_cyrus|_datadetectors|_demod|_devdocs|_devicemgr|_diskimagesiod|_displaypolicyd|_distnote|_dovecot|_dovenull|_dpaudio|_driverkit|_eppc|_findmydevice|_fpsd|_ftp|_fud|_gamecontrollerd|_geod|_hidd|_iconservices|_installassistant|_installcoordinationd|_installer|_jabber|_kadmin_admin|_kadmin_changepw|_knowledgegraphd|_krb_anonymous|_krb_changepw|_krb_kadmin|_krb_kerberos|_krb_krbtgt|_krbfast|_krbtgt|_launchservicesd|_lda|_locationd|_logd|_lp|_mailman|_mbsetupuser|_mcxalr|_mdnsresponder|_mobileasset|_mysql|_nearbyd|_netbios|_netstatistics|_networkd|_nsurlsessiond|_nsurlstoraged|_oahd|_ondemand|_postfix|_postgres|_qtss|_reportmemoryexception|_rmd|_sandbox|_screensaver|_scsd|_securityagent|_softwareupdate|_spotlight|_sshd|_svn|_taskgated|_teamsserver|_timed|_timezone|_tokend|_trustd|_trustevaluationagent|_unknown|_update_sharing|_usbmuxd|_uucp|_warmd|_webauthserver|_windowserver|_www|_wwwproxy|_xserverdocs|daemon\W|^daemon$|message\+|syslog|www|www-data|mail|noboby|Debian\-\+|rtkit|systemd\+'

export commonrootdirsG="^/$|/bin$|/boot$|/.cache$|/cdrom|/dev$|/etc$|/home$|/lost+found$|/lib$|/lib32$|libx32$|/lib64$|lost\+found|/media$|/mnt$|/opt$|/proc$|/root$|/run$|/sbin$|/snap$|/srv$|/sys$|/tmp$|/usr$|/var$"
export ROOT_FOLDER="/"
export notBackup="/tdbbackup$|/db_hotbackup$|/linux-headers-|/python3|/lxd|/systemd"
export notExtensions="\.tif$|\.tiff$|\.gif$|\.jpeg$|\.jpg|\.jif$|\.jfif$|\.jp2$|\.jpx$|\.j2k$|\.j2c$|\.fpx$|\.pcd$|\.png$|\.pdf$|\.flv$|\.mp4$|\.mp3$|\.gifv$|\.avi$|\.mov$|\.mpeg$|\.wav$|\.doc$|\.docx$|\.xls$|\.xlsx$|\.svg$"
export pwd_inside_history="az login|enable_autologin|7z|unzip|useradd|linenum|mkpasswd|htpasswd|openssl|PASSW|passw|shadow|roadrecon auth|root|snyk|sudo|^su|pkexec|^ftp|mongo|psql|mysql|rdesktop|Save-AzContext|xfreerdp|^ssh|steghide|@|KEY=|TOKEN=|BEARER=|Authorization:|chpasswd"
export knw_emails=".*@aivazian.fsnet.co.uk|.*@angband.pl|.*@canonical.com|.*centos.org|.*debian.net|.*debian.org|.*@jff.email|.*kali.org|.*linux.it|.*@linuxia.de|.*@lists.debian-maintainers.org|.*@mit.edu|.*@oss.sgi.com|.*@qualcomm.com|.*redhat.com|.*ubuntu.com|.*@vger.kernel.org|mmyangfl@gmail.com|rogershimizu@gmail.com|thmarques@gmail.com"
export NoEnvVars="LESS_TERMCAP|JOURNAL_STREAM|XDG_SESSION|DBUS_SESSION|systemd\/sessions|systemd_exec|MEMORY_PRESSURE_WATCH|RELEVANT*|FIND*|^VERSION=|dbuslistG|mygroups|ldsoconfdG|pwd_inside_history|kernelDCW_Ubuntu_Precise|kernelDCW_Ubuntu_Trusty|kernelDCW_Ubuntu_Xenial|kernelDCW_Rhel|^sudovB=|^rootcommon=|^mounted=|^mountG=|^notmounted=|^mountpermsB=|^mountpermsG=|^kernelB=|^C=|^RED=|^GREEN=|^Y=|^B=|^NC=|TIMEOUT=|groupsB=|groupsVB=|knw_grps=|sidG|sidB=|sidVB=|sidVB2=|sudoB=|sudoG=|sudoVB=|timersG=|capsB=|notExtensions=|Wfolders=|writeB=|writeVB=|_usrs=|compiler=|LS_COLORS=|pathshG=|notBackup=|processesDump|processesB|commonrootdirs|USEFUL_SOFTWARE|PSTORAGE_|^PATH=|^INVOCATION_ID=|^WATCHDOG_PID=|^LISTEN_PID="
export EnvVarsRed="[pP][aA][sS][sS][wW]|[aA][pP][iI][kK][eE][yY]|[aA][pP][iI][_][kK][eE][yY]|KRB5CCNAME|[aA][pP][iI][_][kK][eE][yY]|[aA][wW][sS]|[aA][zZ][uU][rR][eE]|[gG][cC][pP]|[aA][pP][iI]|[sS][eE][cC][rR][eE][tT]|[sS][qQ][lL]|[dD][aA][tT][aA][bB][aA][sS][eE]|[tT][oO][kK][eE][nN]"
export TIMEOUT="$(command -v timeout 2>/dev/null || echo -n '')"

export pwd_in_variables1="Dgpg.passphrase|Dsonar.login|Dsonar.projectKey|GITHUB_TOKEN|HB_CODESIGN_GPG_PASS|HB_CODESIGN_KEY_PASS|PUSHOVER_TOKEN|PUSHOVER_USER|VIRUSTOTAL_APIKEY|ACCESSKEY|ACCESSKEYID|ACCESS_KEY|ACCESS_KEY_ID|ACCESS_KEY_SECRET|ACCESS_SECRET|ACCESS_TOKEN|ACCOUNT_SID|ADMIN_EMAIL|ADZERK_API_KEY|ALGOLIA_ADMIN_KEY_1|ALGOLIA_ADMIN_KEY_2|ALGOLIA_ADMIN_KEY_MCM|ALGOLIA_API_KEY|ALGOLIA_API_KEY_MCM|ALGOLIA_API_KEY_SEARCH|ALGOLIA_APPLICATION_ID|ALGOLIA_APPLICATION_ID_1|ALGOLIA_APPLICATION_ID_2|ALGOLIA_APPLICATION_ID_MCM|ALGOLIA_APP_ID|ALGOLIA_APP_ID_MCM|ALGOLIA_SEARCH_API_KEY|ALGOLIA_SEARCH_KEY|ALGOLIA_SEARCH_KEY_1|ALIAS_NAME|ALIAS_PASS|ALICLOUD_ACCESS_KEY|ALICLOUD_SECRET_KEY|amazon_bucket_name|AMAZON_SECRET_ACCESS_KEY|ANDROID_DOCS_DEPLOY_TOKEN|android_sdk_license|android_sdk_preview_license|aos_key|aos_sec|APIARY_API_KEY|APIGW_ACCESS_TOKEN|API_KEY|API_KEY_MCM|API_KEY_SECRET|API_KEY_SID|API_SECRET|appClientSecret|APP_BUCKET_PERM|APP_NAME|APP_REPORT_TOKEN_KEY|APP_TOKEN|ARGOS_TOKEN|ARTIFACTORY_KEY|ARTIFACTS_AWS_ACCESS_KEY_ID|ARTIFACTS_AWS_SECRET_ACCESS_KEY|ARTIFACTS_BUCKET|ARTIFACTS_KEY|ARTIFACTS_SECRET|ASSISTANT_IAM_APIKEY|AURORA_STRING_URL|AUTH0_API_CLIENTID|AUTH0_API_CLIENTSECRET|AUTH0_AUDIENCE|AUTH0_CALLBACK_URL|AUTH0_CLIENT_ID"
export pwd_in_variables2="AUTH0_CLIENT_SECRET|AUTH0_CONNECTION|AUTH0_DOMAIN|AUTHOR_EMAIL_ADDR|AUTHOR_NPM_API_KEY|AUTH_TOKEN|AWS-ACCT-ID|AWS-KEY|AWS-SECRETS|AWS.config.accessKeyId|AWS.config.secretAccessKey|AWSACCESSKEYID|AWSCN_ACCESS_KEY_ID|AWSCN_SECRET_ACCESS_KEY|AWSSECRETKEY|AWS_ACCESS|AWS_ACCESS_KEY|AWS_ACCESS_KEY_ID|AWS_CF_DIST_ID|AWS_DEFAULT|AWS_DEFAULT_REGION|AWS_S3_BUCKET|AWS_SECRET|AWS_SECRET_ACCESS_KEY|AWS_SECRET_KEY|AWS_SES_ACCESS_KEY_ID|AWS_SES_SECRET_ACCESS_KEY|B2_ACCT_ID|B2_APP_KEY|B2_BUCKET|baseUrlTravis|bintrayKey|bintrayUser|BINTRAY_APIKEY|BINTRAY_API_KEY|BINTRAY_KEY|BINTRAY_TOKEN|BINTRAY_USER|BLUEMIX_ACCOUNT|BLUEMIX_API_KEY|BLUEMIX_AUTH|BLUEMIX_NAMESPACE|BLUEMIX_ORG|BLUEMIX_ORGANIZATION|BLUEMIX_PASS|BLUEMIX_PASS_PROD|BLUEMIX_SPACE|BLUEMIX_USER|BRACKETS_REPO_OAUTH_TOKEN|BROWSERSTACK_ACCESS_KEY|BROWSERSTACK_PROJECT_NAME|BROWSER_STACK_ACCESS_KEY|BUCKETEER_AWS_ACCESS_KEY_ID|BUCKETEER_AWS_SECRET_ACCESS_KEY|BUCKETEER_BUCKET_NAME|BUILT_BRANCH_DEPLOY_KEY|BUNDLESIZE_GITHUB_TOKEN|CACHE_S3_SECRET_KEY|CACHE_URL|CARGO_TOKEN|CATTLE_ACCESS_KEY|CATTLE_AGENT_INSTANCE_AUTH|CATTLE_SECRET_KEY|CC_TEST_REPORTER_ID|CC_TEST_REPOTER_ID|CENSYS_SECRET|CENSYS_UID|CERTIFICATE_OSX_P12|CF_ORGANIZATION|CF_PROXY_HOST|channelId|CHEVERNY_TOKEN|CHROME_CLIENT_ID"
export pwd_in_variables3="CHROME_CLIENT_SECRET|CHROME_EXTENSION_ID|CHROME_REFRESH_TOKEN|CI_DEPLOY_USER|CI_NAME|CI_PROJECT_NAMESPACE|CI_PROJECT_URL|CI_REGISTRY_USER|CI_SERVER_NAME|CI_USER_TOKEN|CLAIMR_DATABASE|CLAIMR_DB|CLAIMR_SUPERUSER|CLAIMR_TOKEN|CLIENT_ID|CLIENT_SECRET|CLI_E2E_CMA_TOKEN|CLI_E2E_ORG_ID|CLOUDAMQP_URL|CLOUDANT_APPLIANCE_DATABASE|CLOUDANT_ARCHIVED_DATABASE|CLOUDANT_AUDITED_DATABASE|CLOUDANT_DATABASE|CLOUDANT_ORDER_DATABASE|CLOUDANT_PARSED_DATABASE|CLOUDANT_PROCESSED_DATABASE|CLOUDANT_SERVICE_DATABASE|CLOUDFLARE_API_KEY|CLOUDFLARE_AUTH_EMAIL|CLOUDFLARE_AUTH_KEY|CLOUDFLARE_EMAIL|CLOUDFLARE_ZONE_ID|CLOUDINARY_URL|CLOUDINARY_URL_EU|CLOUDINARY_URL_STAGING|CLOUD_API_KEY|CLUSTER_NAME|CLU_REPO_URL|CLU_SSH_PRIVATE_KEY_BASE64|CN_ACCESS_KEY_ID|CN_SECRET_ACCESS_KEY|COCOAPODS_TRUNK_EMAIL|COCOAPODS_TRUNK_TOKEN|CODACY_PROJECT_TOKEN|CODECLIMATE_REPO_TOKEN|CODECOV_TOKEN|coding_token|CONEKTA_APIKEY|CONFIGURATION_PROFILE_SID|CONFIGURATION_PROFILE_SID_P2P|CONFIGURATION_PROFILE_SID_SFU|CONSUMERKEY|CONSUMER_KEY|CONTENTFUL_ACCESS_TOKEN|CONTENTFUL_CMA_TEST_TOKEN|CONTENTFUL_INTEGRATION_MANAGEMENT_TOKEN|CONTENTFUL_INTEGRATION_SOURCE_SPACE|CONTENTFUL_MANAGEMENT_API_ACCESS_TOKEN|CONTENTFUL_MANAGEMENT_API_ACCESS_TOKEN_NEW|CONTENTFUL_ORGANIZATION"
export pwd_in_variables4="CONTENTFUL_PHP_MANAGEMENT_TEST_TOKEN|CONTENTFUL_TEST_ORG_CMA_TOKEN|CONTENTFUL_V2_ACCESS_TOKEN|CONTENTFUL_V2_ORGANIZATION|CONVERSATION_URL|COREAPI_HOST|COS_SECRETS|COVERALLS_API_TOKEN|COVERALLS_REPO_TOKEN|COVERALLS_SERVICE_NAME|COVERALLS_TOKEN|COVERITY_SCAN_NOTIFICATION_EMAIL|COVERITY_SCAN_TOKEN|CYPRESS_RECORD_KEY|DANGER_GITHUB_API_TOKEN|DATABASE_HOST|DATABASE_NAME|DATABASE_PORT|DATABASE_USER|DATABASE_PASSWORD|datadog_api_key|datadog_app_key|DB_CONNECTION|DB_DATABASE|DB_HOST|DB_PORT|DB_PW|DB_USER|DDGC_GITHUB_TOKEN|DDG_TEST_EMAIL|DDG_TEST_EMAIL_PW|DEPLOY_DIR|DEPLOY_DIRECTORY|DEPLOY_HOST|DEPLOY_PORT|DEPLOY_SECURE|DEPLOY_TOKEN|DEPLOY_USER|DEST_TOPIC|DHL_SOLDTOACCOUNTID|DH_END_POINT_1|DH_END_POINT_2|DIGITALOCEAN_ACCESS_TOKEN|DIGITALOCEAN_SSH_KEY_BODY|DIGITALOCEAN_SSH_KEY_IDS|DOCKER_EMAIL|DOCKER_KEY|DOCKER_PASSDOCKER_POSTGRES_URL|DOCKER_RABBITMQ_HOST|docker_repo|DOCKER_TOKEN|DOCKER_USER|DOORDASH_AUTH_TOKEN|DROPBOX_OAUTH_BEARER|ELASTICSEARCH_HOST|ELASTIC_CLOUD_AUTH|env.GITHUB_OAUTH_TOKEN|env.HEROKU_API_KEY|ENV_KEY|ENV_SECRET|ENV_SECRET_ACCESS_KEY|eureka.awsAccessId"
export pwd_in_variables5="eureka.awsSecretKey|ExcludeRestorePackageImports|EXPORT_SPACE_ID|FIREBASE_API_JSON|FIREBASE_API_TOKEN|FIREBASE_KEY|FIREBASE_PROJECT|FIREBASE_PROJECT_DEVELOP|FIREBASE_PROJECT_ID|FIREBASE_SERVICE_ACCOUNT|FIREBASE_TOKEN|FIREFOX_CLIENT|FIREFOX_ISSUER|FIREFOX_SECRET|FLASK_SECRET_KEY|FLICKR_API_KEY|FLICKR_API_SECRET|FOSSA_API_KEY|ftp_host|FTP_LOGIN|FTP_PW|FTP_USER|GCLOUD_BUCKET|GCLOUD_PROJECT|GCLOUD_SERVICE_KEY|GCS_BUCKET|GHB_TOKEN|GHOST_API_KEY|GH_API_KEY|GH_EMAIL|GH_NAME|GH_NEXT_OAUTH_CLIENT_ID|GH_NEXT_OAUTH_CLIENT_SECRET|GH_NEXT_UNSTABLE_OAUTH_CLIENT_ID|GH_NEXT_UNSTABLE_OAUTH_CLIENT_SECRET|GH_OAUTH_CLIENT_ID|GH_OAUTH_CLIENT_SECRET|GH_OAUTH_TOKEN|GH_REPO_TOKEN|GH_TOKEN|GH_UNSTABLE_OAUTH_CLIENT_ID|GH_UNSTABLE_OAUTH_CLIENT_SECRET|GH_USER_EMAIL|GH_USER_NAME|GITHUB_ACCESS_TOKEN|GITHUB_API_KEY|GITHUB_API_TOKEN|GITHUB_AUTH|GITHUB_AUTH_TOKEN|GITHUB_AUTH_USER|GITHUB_CLIENT_ID|GITHUB_CLIENT_SECRET|GITHUB_DEPLOYMENT_TOKEN|GITHUB_DEPLOY_HB_DOC_PASS|GITHUB_HUNTER_TOKEN|GITHUB_KEY|GITHUB_OAUTH|GITHUB_OAUTH_TOKEN|GITHUB_RELEASE_TOKEN|GITHUB_REPO|GITHUB_TOKEN|GITHUB_TOKENS|GITHUB_USER|GITLAB_USER_EMAIL|GITLAB_USER_LOGIN|GIT_AUTHOR_EMAIL|GIT_AUTHOR_NAME|GIT_COMMITTER_EMAIL|GIT_COMMITTER_NAME|GIT_EMAIL|GIT_NAME|GIT_TOKEN|GIT_USER"
export pwd_in_variables6="GOOGLE_CLIENT_EMAIL|GOOGLE_CLIENT_ID|GOOGLE_CLIENT_SECRET|GOOGLE_MAPS_API_KEY|GOOGLE_PRIVATE_KEY|gpg.passphrase|GPG_EMAIL|GPG_ENCRYPTION|GPG_EXECUTABLE|GPG_KEYNAME|GPG_KEY_NAME|GPG_NAME|GPG_OWNERTRUST|GPG_PASSPHRASE|GPG_PRIVATE_KEY|GPG_SECRET_KEYS|gradle.publish.key|gradle.publish.secret|GRADLE_SIGNING_KEY_ID|GREN_GITHUB_TOKEN|GRGIT_USER|HAB_AUTH_TOKEN|HAB_KEY|HB_CODESIGN_GPG_PASS|HB_CODESIGN_KEY_PASS|HEROKU_API_KEY|HEROKU_API_USER|HEROKU_EMAIL|HEROKU_TOKEN|HOCKEYAPP_TOKEN|INTEGRATION_TEST_API_KEY|INTEGRATION_TEST_APPID|INTERNAL-SECRETS|IOS_DOCS_DEPLOY_TOKEN|IRC_NOTIFICATION_CHANNEL|JDBC:MYSQL|jdbc_databaseurl|jdbc_host|jdbc_user|JWT_SECRET|KAFKA_ADMIN_URL|KAFKA_INSTANCE_NAME|KAFKA_REST_URL|KEYSTORE_PASS|KOVAN_PRIVATE_KEY|LEANPLUM_APP_ID|LEANPLUM_KEY|LICENSES_HASH|LICENSES_HASH_TWO|LIGHTHOUSE_API_KEY|LINKEDIN_CLIENT_ID|LINKEDIN_CLIENT_SECRET|LINODE_INSTANCE_ID|LINODE_VOLUME_ID|LINUX_SIGNING_KEY|LL_API_SHORTNAME|LL_PUBLISH_URL|LL_SHARED_KEY|LOOKER_TEST_RUNNER_CLIENT_ID|LOOKER_TEST_RUNNER_CLIENT_SECRET|LOOKER_TEST_RUNNER_ENDPOINT|LOTTIE_HAPPO_API_KEY|LOTTIE_HAPPO_SECRET_KEY|LOTTIE_S3_API_KEY|LOTTIE_S3_SECRET_KEY|mailchimp_api_key|MAILCHIMP_KEY|mailchimp_list_id|mailchimp_user|MAILER_HOST|MAILER_TRANSPORT|MAILER_USER"
export pwd_in_variables7="MAILGUN_APIKEY|MAILGUN_API_KEY|MAILGUN_DOMAIN|MAILGUN_PRIV_KEY|MAILGUN_PUB_APIKEY|MAILGUN_PUB_KEY|MAILGUN_SECRET_API_KEY|MAILGUN_TESTDOMAIN|ManagementAPIAccessToken|MANAGEMENT_TOKEN|MANAGE_KEY|MANAGE_SECRET|MANDRILL_API_KEY|MANIFEST_APP_TOKEN|MANIFEST_APP_URL|MapboxAccessToken|MAPBOX_ACCESS_TOKEN|MAPBOX_API_TOKEN|MAPBOX_AWS_ACCESS_KEY_ID|MAPBOX_AWS_SECRET_ACCESS_KEY|MG_API_KEY|MG_DOMAIN|MG_EMAIL_ADDR|MG_EMAIL_TO|MG_PUBLIC_API_KEY|MG_SPEND_MONEY|MG_URL|MH_APIKEY|MILE_ZERO_KEY|MINIO_ACCESS_KEY|MINIO_SECRET_KEY|MYSQLMASTERUSER|MYSQLSECRET|MYSQL_DATABASE|MYSQL_HOSTNAMEMYSQL_USER|MY_SECRET_ENV|NETLIFY_API_KEY|NETLIFY_SITE_ID|NEW_RELIC_BETA_TOKEN|NGROK_AUTH_TOKEN|NGROK_TOKEN|node_pre_gyp_accessKeyId|NODE_PRE_GYP_GITHUB_TOKEN|node_pre_gyp_secretAccessKey|NPM_API_KEY|NPM_API_TOKEN|NPM_AUTH_TOKEN|NPM_EMAIL|NPM_SECRET_KEY|NPM_TOKEN|NUGET_APIKEY|NUGET_API_KEY|NUGET_KEY|NUMBERS_SERVICE|NUMBERS_SERVICE_PASS|NUMBERS_SERVICE_USER|OAUTH_TOKEN|OBJECT_STORAGE_PROJECT_ID|OBJECT_STORAGE_USER_ID|OBJECT_STORE_BUCKET|OBJECT_STORE_CREDS|OCTEST_SERVER_BASE_URL|OCTEST_SERVER_BASE_URL_2|OC_PASS|OFTA_KEY|OFTA_SECRET|OKTA_CLIENT_TOKEN|OKTA_DOMAIN|OKTA_OAUTH2_CLIENTID|OKTA_OAUTH2_CLIENTSECRET|OKTA_OAUTH2_CLIENT_ID|OKTA_OAUTH2_CLIENT_SECRET"
export pwd_in_variables8="OKTA_OAUTH2_ISSUER|OMISE_KEY|OMISE_PKEY|OMISE_PUBKEY|OMISE_SKEY|ONESIGNAL_API_KEY|ONESIGNAL_USER_AUTH_KEY|OPENWHISK_KEY|OPEN_WHISK_KEY|OSSRH_PASS|OSSRH_SECRET|OSSRH_USER|OS_AUTH_URL|OS_PROJECT_NAME|OS_TENANT_ID|OS_TENANT_NAME|PAGERDUTY_APIKEY|PAGERDUTY_ESCALATION_POLICY_ID|PAGERDUTY_FROM_USER|PAGERDUTY_PRIORITY_ID|PAGERDUTY_SERVICE_ID|PANTHEON_SITE|PARSE_APP_ID|PARSE_JS_KEY|PAYPAL_CLIENT_ID|PAYPAL_CLIENT_SECRET|PERCY_TOKEN|PERSONAL_KEY|PERSONAL_SECRET|PG_DATABASE|PG_HOST|PLACES_APIKEY|PLACES_API_KEY|PLACES_APPID|PLACES_APPLICATION_ID|PLOTLY_APIKEY|POSTGRESQL_DB|POSTGRESQL_PASS|POSTGRES_ENV_POSTGRES_DB|POSTGRES_ENV_POSTGRES_USER|POSTGRES_PORT|PREBUILD_AUTH|PROD.ACCESS.KEY.ID|PROD.SECRET.KEY|PROD_BASE_URL_RUNSCOPE|PROJECT_CONFIG|PUBLISH_KEY|PUBLISH_SECRET|PUSHOVER_TOKEN|PUSHOVER_USER|PYPI_PASSOWRD|QUIP_TOKEN|RABBITMQ_SERVER_ADDR|REDISCLOUD_URL|REDIS_STUNNEL_URLS|REFRESH_TOKEN|RELEASE_GH_TOKEN|RELEASE_TOKEN|remoteUserToShareTravis|REPORTING_WEBDAV_URL|REPORTING_WEBDAV_USER|repoToken|REST_API_KEY|RINKEBY_PRIVATE_KEY|ROPSTEN_PRIVATE_KEY|route53_access_key_id|RTD_KEY_PASS|RTD_STORE_PASS|RUBYGEMS_AUTH_TOKEN|s3_access_key|S3_ACCESS_KEY_ID|S3_BUCKET_NAME_APP_LOGS|S3_BUCKET_NAME_ASSETS|S3_KEY"
export pwd_in_variables9="S3_KEY_APP_LOGS|S3_KEY_ASSETS|S3_PHOTO_BUCKET|S3_SECRET_APP_LOGS|S3_SECRET_ASSETS|S3_SECRET_KEY|S3_USER_ID|S3_USER_SECRET|SACLOUD_ACCESS_TOKEN|SACLOUD_ACCESS_TOKEN_SECRET|SACLOUD_API|SALESFORCE_BULK_TEST_SECURITY_TOKEN|SANDBOX_ACCESS_TOKEN|SANDBOX_AWS_ACCESS_KEY_ID|SANDBOX_AWS_SECRET_ACCESS_KEY|SANDBOX_LOCATION_ID|SAUCE_ACCESS_KEY|SECRETACCESSKEY|SECRETKEY|SECRET_0|SECRET_10|SECRET_11|SECRET_1|SECRET_2|SECRET_3|SECRET_4|SECRET_5|SECRET_6|SECRET_7|SECRET_8|SECRET_9|SECRET_KEY_BASE|SEGMENT_API_KEY|SELION_SELENIUM_SAUCELAB_GRID_CONFIG_FILE|SELION_SELENIUM_USE_SAUCELAB_GRID|SENDGRID|SENDGRID_API_KEY|SENDGRID_FROM_ADDRESS|SENDGRID_KEY|SENDGRID_USER|SENDWITHUS_KEY|SENTRY_AUTH_TOKEN|SERVICE_ACCOUNT_SECRET|SES_ACCESS_KEY|SES_SECRET_KEY|setDstAccessKey|setDstSecretKey|setSecretKey|SIGNING_KEY|SIGNING_KEY_SECRET|SIGNING_KEY_SID|SNOOWRAP_CLIENT_SECRET|SNOOWRAP_REDIRECT_URI|SNOOWRAP_REFRESH_TOKEN|SNOOWRAP_USER_AGENT|SNYK_API_TOKEN|SNYK_ORG_ID|SNYK_TOKEN|SOCRATA_APP_TOKEN|SOCRATA_USER|SONAR_ORGANIZATION_KEY|SONAR_PROJECT_KEY|SONAR_TOKEN|SONATYPE_GPG_KEY_NAME|SONATYPE_GPG_PASSPHRASE|SONATYPE_PASSSONATYPE_TOKEN_USER|SONATYPE_USER|SOUNDCLOUD_CLIENT_ID|SOUNDCLOUD_CLIENT_SECRET|SPACES_ACCESS_KEY_ID|SPACES_SECRET_ACCESS_KEY"
export pwd_in_variables10="SPA_CLIENT_ID|SPOTIFY_API_ACCESS_TOKEN|SPOTIFY_API_CLIENT_ID|SPOTIFY_API_CLIENT_SECRET|sqsAccessKey|sqsSecretKey|SRCCLR_API_TOKEN|SSHPASS|SSMTP_CONFIG|STARSHIP_ACCOUNT_SID|STARSHIP_AUTH_TOKEN|STAR_TEST_AWS_ACCESS_KEY_ID|STAR_TEST_BUCKET|STAR_TEST_LOCATION|STAR_TEST_SECRET_ACCESS_KEY|STORMPATH_API_KEY_ID|STORMPATH_API_KEY_SECRET|STRIPE_PRIVATE|STRIPE_PUBLIC|STRIP_PUBLISHABLE_KEY|STRIP_SECRET_KEY|SURGE_LOGIN|SURGE_TOKEN|SVN_PASS|SVN_USER|TESCO_API_KEY|THERA_OSS_ACCESS_ID|THERA_OSS_ACCESS_KEY|TRAVIS_ACCESS_TOKEN|TRAVIS_API_TOKEN|TRAVIS_COM_TOKEN|TRAVIS_E2E_TOKEN|TRAVIS_GH_TOKEN|TRAVIS_PULL_REQUEST|TRAVIS_SECURE_ENV_VARS|TRAVIS_TOKEN|TREX_CLIENT_ORGURL|TREX_CLIENT_TOKEN|TREX_OKTA_CLIENT_ORGURL|TREX_OKTA_CLIENT_TOKEN|TWILIO_ACCOUNT_ID|TWILIO_ACCOUNT_SID|TWILIO_API_KEY|TWILIO_API_SECRET|TWILIO_CHAT_ACCOUNT_API_SERVICE|TWILIO_CONFIGURATION_SID|TWILIO_SID|TWILIO_TOKEN|TWITTEROAUTHACCESSSECRET|TWITTEROAUTHACCESSTOKEN|TWITTER_CONSUMER_KEY|TWITTER_CONSUMER_SECRET|UNITY_SERIAL|URBAN_KEY|URBAN_MASTER_SECRET|URBAN_SECRET|userTravis|USER_ASSETS_ACCESS_KEY_ID|USER_ASSETS_SECRET_ACCESS_KEY|VAULT_APPROLE_SECRET_ID|VAULT_PATH|VIP_GITHUB_BUILD_REPO_DEPLOY_KEY|VIP_GITHUB_DEPLOY_KEY|VIP_GITHUB_DEPLOY_KEY_PASS"
export pwd_in_variables11="VIRUSTOTAL_APIKEY|VISUAL_RECOGNITION_API_KEY|V_SFDC_CLIENT_ID|V_SFDC_CLIENT_SECRET|WAKATIME_API_KEY|WAKATIME_PROJECT|WATSON_CLIENT|WATSON_CONVERSATION_WORKSPACE|WATSON_DEVICE|WATSON_DEVICE_TOPIC|WATSON_TEAM_ID|WATSON_TOPIC|WIDGET_BASIC_USER_2|WIDGET_BASIC_USER_3|WIDGET_BASIC_USER_4|WIDGET_BASIC_USER_5|WIDGET_FB_USER|WIDGET_FB_USER_2|WIDGET_FB_USER_3|WIDGET_TEST_SERVERWORDPRESS_DB_USER|WORKSPACE_ID|WPJM_PHPUNIT_GOOGLE_GEOCODE_API_KEY|WPT_DB_HOST|WPT_DB_NAME|WPT_DB_USER|WPT_PREPARE_DIR|WPT_REPORT_API_KEY|WPT_SSH_CONNECT|WPT_SSH_PRIVATE_KEY_BASE64|YANGSHUN_GH_TOKEN|YT_ACCOUNT_CHANNEL_ID|YT_ACCOUNT_CLIENT_ID|YT_ACCOUNT_CLIENT_SECRET|YT_ACCOUNT_REFRESH_TOKEN|YT_API_KEY|YT_CLIENT_ID|YT_CLIENT_SECRET|YT_PARTNER_CHANNEL_ID|YT_PARTNER_CLIENT_ID|YT_PARTNER_CLIENT_SECRET|YT_PARTNER_ID|YT_PARTNER_REFRESH_TOKEN|YT_SERVER_API_KEY|ZHULIANG_GH_TOKEN|ZOPIM_ACCOUNT_KEY"

export notexec="000|/site-packages|/python|/node_modules|\.sample|/gems|/cgroup|/dpkg|/selftests|/shell|/linux-headers-"
export ITALIC="${C}[3m"

export STRACE="$(command -v strace 2>/dev/null || echo -n '')"
export STRINGS="$(command -v strings 2>/dev/null || echo -n '')"

export cfuncs='file|free|main|more|read|split|write'
export LDD="$(command -v ldd 2>/dev/null || echo -n '')"
export READELF="$(command -v readelf 2>/dev/null || echo -n '')"

export sidG1="/abuild-sudo$|/accton$|/allocate$|/ARDAgent$|/arping$|/atq$|/atrm$|/authpf$|/authpf-noip$|/authopen$|/batch$|/bbsuid$|/bsd-write$|/btsockstat$|/bwrap$|/cacaocsc$|/camel-lock-helper-1.2$|/ccreds_validate$|/cdrw$|/chage$|/check-foreground-console$|/chrome-sandbox$|/chsh$|/cons.saver$|/crontab$|/ct$|/cu$|/dbus-daemon-launch-helper$|/deallocate$|/desktop-create-kmenu$|/dma$|/dma-mbox-create$|/dmcrypt-get-device$|/doas$|/dotlockfile$|/dotlock.mailutils$|/dtaction$|/dtfile$|/eject$|/execabrt-action-install-debuginfo-to-abrt-cache$|/execdbus-daemon-launch-helper$|/execdma-mbox-create$|/execlockspool$|/execlogin_chpass$|/execlogin_lchpass$|/execlogin_passwd$|/execssh-keysign$|/execulog-helper$|/exim4|/expiry$|/fdformat$|/fstat$|/fusermount$|/fusermount3$"
export sidG2="/gnome-pty-helper$|/glines$|/gnibbles$|/gnobots2$|/gnome-suspend$|/gnometris$|/gnomine$|/gnotski$|/gnotravex$|/gpasswd$|/gpg$|/gpio$|/gtali|/.hal-mtab-lock$|/helper$|/imapd$|/inndstart$|/kismet_cap_nrf_51822$|/kismet_cap_nxp_kw41z$|/kismet_cap_ti_cc_2531$|/kismet_cap_ti_cc_2540$|/kismet_cap_ubertooth_one$|/kismet_capture$|/kismet_cap_linux_bluetooth$|/kismet_cap_linux_wifi$|/kismet_cap_nrf_mousejack$|/ksu$|/list_devices$|/load_osxfuse$|/locate$|/lock$|/lockdev$|/lockfile$|/login_activ$|/login_crypto$|/login_radius$|/login_skey$|/login_snk$|/login_token$|/login_yubikey$|/lpc$|/lpd$|/lpd-port$|/lppasswd$|/lpq$|/lpr$|/lprm$|/lpset$|/lxc-user-nic$|/mahjongg$|/mail-lock$|/mailq$|/mail-touchlock$|/mail-unlock$|/mksnap_ffs$|/mlocate$|/mlock$|/mount$|/mount.cifs$|/mount.ecryptfs_private$|/mount.nfs$|/mount.nfs4$|/mount_osxfuse$|/mtr$|/mutt_dotlock$"
export sidG3="/ncsa_auth$|/netpr$|/netkit-rcp$|/netkit-rlogin$|/netkit-rsh$|/netreport$|/netstat$|/newgidmap$|/newtask$|/newuidmap$|/nvmmctl$|/opieinfo$|/opiepasswd$|/pam_auth$|/pam_extrausers_chkpwd$|/pam_timestamp_check$|/pamverifier$|/pfexec$|/ping$|/ping6$|/pmconfig$|/pmap$|/polkit-agent-helper-1$|/polkit-explicit-grant-helper$|/polkit-grant-helper$|/polkit-grant-helper-pam$|/polkit-read-auth-helper$|/polkit-resolve-exe-helper$|/polkit-revoke-helper$|/polkit-set-default-helper$|/postdrop$|/postqueue$|/poweroff$|/ppp$|/procmail$|/pstat$|/pt_chmod$|/pwdb_chkpwd$|/quota$|/rcmd|/remote.unknown$|/rlogin$|/rmformat$|/rnews$|/run-mailcap$|/sacadm$|/same-gnome$|screen.real$|/security_authtrampoline$|/sendmail.sendmail$|/shutdown$|/skeyaudit$|/skeyinfo$|/skeyinit$|/sliplogin|/slocate$|/smbmnt$|/smbumount$|/smpatch$|/smtpctl$|/sperl5.8.8$|/ssh-agent$|/ssh-keysign$|/staprun$|/startinnfeed$|/stclient$|/su$|/suexec$|/sys-suspend$|/sysstat$|/systat$"
export sidG4="/telnetlogin$|/timedc$|/tip$|/top$|/traceroute6$|/traceroute6.iputils$|/trpt$|/tsoldtlabel$|/tsoljdslabel$|/tsolxagent$|/ufsdump$|/ufsrestore$|/ulog-helper$|/umount.cifs$|/umount.nfs$|/umount.nfs4$|/unix_chkpwd$|/uptime$|/userhelper$|/userisdnctl$|/usernetctl$|/utempter$|/utmp_update$|/uucico$|/uuglist$|/uuidd$|/uuname$|/uusched$|/uustat$|/uux$|/uuxqt$|/VBoxHeadless$|/VBoxNetAdpCtl$|/VBoxNetDHCP$|/VBoxNetNAT$|/VBoxSDL$|/VBoxVolInfo$|/VirtualBoxVM$|/vmstat$|/vmware-authd$|/vmware-user-suid-wrapper$|/vmware-vmx$|/vmware-vmx-debug$|/vmware-vmx-stats$|/vncserver-x11$|/volrmmount$|/w$|/wall$|/whodo$|/write$|/X$|/Xorg.wrap$|/Xsun$|/Xvnc$|/yppasswd$"

export capsB="=ep|cap_chown|cap_former|cap_setfcap|cap_dac_override|cap_dac_read_search|cap_setuid|cap_setgid|cap_kill|cap_net_bind_service|cap_net_raw|cap_net_admin|cap_sys_admin|cap_sys_ptrace|cap_sys_module"

# export sidVB='peass{SUIDVB1_HERE}'
# export sidVB2='peass{SUIDVB2_HERE}'
#1/08
export profiledG="01-locale-fix.sh|256term.csh|256term.sh|abrt-console-notification.sh|appmenu-qt5.sh|apps-bin-path.sh|bash_completion.sh|cedilla-portuguese.sh|colorgrep.csh|colorgrep.sh|colorls.csh|colorls.sh|colorxzgrep.csh|colorxzgrep.sh|colorzgrep.csh|colorzgrep.sh|csh.local|cursor.sh|gawk.csh|gawk.sh|im-config_wayland.sh|kali.sh|lang.csh|lang.sh|less.csh|less.sh|flatpak.sh|sh.local|vim.csh|vim.sh|vte.csh|vte-2.91.sh|which2.csh|which2.sh|xauthority.sh|Z97-byobu.sh|xdg_dirs_desktop_session.sh|Z99-cloudinit-warnings.sh|Z99-cloud-locale-test.sh"

export writeVB="/etc/anacrontab|/etc/apt/apt.conf.d|/etc/bash.bashrc|/etc/bash_completion|/etc/bash_completion.d/|/etc/cron|/etc/environment|/etc/environment.d/|/etc/group|/etc/incron.d/|/etc/init|/etc/ld.so.conf.d/|/etc/master.passwd|/etc/passwd|/etc/profile.d/|/etc/profile|/etc/rc.d|/etc/shadow|/etc/skey/|/etc/sudoers|/etc/sudoers.d/|/etc/supervisor/conf.d/|/etc/supervisor/supervisord.conf|/etc/systemd|/etc/sys|/lib/systemd|/etc/update-motd.d/|/root/.ssh/|/run/systemd|/usr/lib/cron/tabs/|/usr/lib/systemd|/systemd/system|/var/db/yubikey/|/var/spool/anacron|/var/spool/cron/crontabs|"$(echo $PATH 2>/dev/null | sed 's/:\.:/:/g' | sed 's/:\.$//g' | sed 's/^\.://g' | sed 's/:/$|^/g') #Add Path but remove simple dot in PATH
export writeB="00-header|10-help-text|50-motd-news|80-esm|91-release-upgrade|\.sh$|\./|/authorized_keys|/bin/|/boot/|/etc/apache2/apache2.conf|/etc/apache2/httpd.conf|/etc/hosts.allow|/etc/hosts.deny|/etc/httpd/conf/httpd.conf|/etc/httpd/httpd.conf|/etc/inetd.conf|/etc/incron.conf|/etc/login.defs|/etc/logrotate.d/|/etc/modprobe.d/|/etc/pam.d/|/etc/php.*/fpm/pool.d/|/etc/php/.*/fpm/pool.d/|/etc/rsyslog.d/|/etc/skel/|/etc/sysconfig/network-scripts/|/etc/sysctl.conf|/etc/sysctl.d/|/etc/uwsgi/apps-enabled/|/etc/xinetd.conf|/etc/xinetd.d/|/etc/|/home//|/lib/|/log/|/mnt/|/root|/sys/|/usr/bin|/usr/games|/usr/lib|/usr/local/bin|/usr/local/games|/usr/local/sbin|/usr/sbin|/sbin/|/var/log/|\.timer$|\.service$|.socket$"

check_critical_root_path()
{
    folder_path="$1"
    
    # Check write permissions on the path itself
    if [ -w "$folder_path" ]; then
		print_red_yellow "You can write here!"
		print_red_yellow "$folder_path"
	fi
	# echo "$folder_path"
#	echo $folder_path

	writable_files=$(find "$folder_path" -type f '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' 2>/dev/null)
	# echo "$writable_files"
	if [ -n "$writable_files" ]; then
		print_red_yellow "You can write here!"
		print_red_yellow "$writable_files"
	fi
	
	unowned_files=$(find "$folder_path" -type f -not -user root 2>/dev/null)
	# echo "$unowned_files"
	if [ -n "$unowned_files" ]; then
		small_print "Files not owned by root!"
		small_print "$unowned_files"
    fi
}

# check_critical_root_path() {
#     folder_path="$1"
	
#     if [ -w "$folder_path" ]; then
#         print_red_yellow "You have write privileges over the whole folder: "
# 		print_red_yellow "$folder_path"
#     fi

#     # +w ones
#     writable_files=$(find "$folder_path" -type f \( -user "$USER" -o -perm -o=w \) 2>/dev/null)

#     if [ -n "$writable_files" ]; then
#         print_red_yellow "You have write privileges over these files:"
#         echo "$writable_files" | while read -r file; do
#             print_red_yellow "  $file"
#         done
#     fi

#     # Check for non-root owned files
#     unowned_files=$(find "$folder_path" -type f -not -user root 2>/dev/null)
#     if [ -n "$unowned_files" ]; then
#         small_print "Files not owned by root:"
#         echo "$unowned_files" | while read -r file; do
#             print_red "  $file"
#         done
#     fi
# }

export sudoB="$(whoami)|ALL:ALL|ALL : ALL|ALL|env_keep|NOPASSWD|SETENV|/apache2|/cryptsetup|/mount"
export sudoG="NOEXEC"

#start with " /", end with "$", divide path and vulnversion "%". SPACE IS ONLY ALLOWED AT BEGINNING, DONT USE IT IN VULN DESCRIPTION
export sidB="/apache2$%Read_root_passwd__apache2_-f_/etc/shadow\(CVE-2019-0211\)\
 /at$%RTru64_UNIX_4.0g\(CVE-2002-1614\)\
 /abrt-action-install-debuginfo-to-abrt-cache$%CENTOS_7.1/Fedora22\
 /chfn$%SuSE_9.3/10\
 /chkey$%Solaris_2.5.1\
 /chkperm$%Solaris_7.0_\
 /chpass$%2Vulns:OpenBSD_6.1_to_OpenBSD 6.6\(CVE-2019-19726\)--OpenBSD_2.7_i386/OpenBSD_2.6_i386/OpenBSD_2.5_1999/08/06/OpenBSD_2.5_1998/05/28/FreeBSD_4.0-RELEASE/FreeBSD_3.5-RELEASE/FreeBSD_3.4-RELEASE/NetBSD_1.4.2\
 /chpasswd$%SquirrelMail\(2004-04\)\
 /dtappgather$%Solaris_7_<_11_\(SPARC/x86\)\(CVE-2017-3622\)\
 /dtprintinfo$%Solaris_10_\(x86\)_and_lower_versions_also_SunOS_5.7_to_5.10\
 /dtsession$%Oracle_Solaris_10_1/13_and_earlier\(CVE-2020-2696\)\
 /enlightenment_backlight$%Before_0.25.4_\(CVE-2022-37706\)\
 /enlightenment_ckpasswd$%Before_0.25.4_\(CVE-2022-37706\)\
 /enlightenment_sys$%Before_0.25.4_\(CVE-2022-37706\)\
 /eject$%FreeBSD_mcweject_0.9/SGI_IRIX_6.2\
 /ibstat$%IBM_AIX_Version_6.1/7.1\(09-2013\)\
 /kcheckpass$%KDE_3.2.0_<-->_3.4.2_\(both_included\)\
 /kdesud$%KDE_1.1/1.1.1/1.1.2/1.2\
 /keybase-redirector%CentOS_Linux_release_7.4.1708\
 /login$%IBM_AIX_3.2.5/SGI_IRIX_6.4\
 /lpc$%S.u.S.E_Linux_5.2\
 /lpr$%BSD/OS2.1/FreeBSD2.1.5/NeXTstep4.x/IRIX6.4/SunOS4.1.3/4.1.4\(09-1996\)\
 /mail.local$%NetBSD_7.0-7.0.1__6.1-6.1.5__6.0-6.0.6\
 /mount$%Apple_Mac_OSX\(Lion\)_Kernel_xnu-1699.32.7_except_xnu-1699.24.8\
 /movemail$%Emacs\(08-1986\)\
 /mrinfo$%NetBSD_Sep_17_2002_https://securitytracker.com/id/1005234\
 /mtrace$%NetBSD_Sep_17_2002_https://securitytracker.com/id/1005234\
 /netprint$%IRIX_5.3/6.2/6.3/6.4/6.5/6.5.11\
 /newgrp$%HP-UX_10.20\
 /ntfs-3g$%Debian9/8/7/Ubuntu/Gentoo/others/Ubuntu_Server_16.10_and_others\(02-2017\)\
 /passwd$%Apple_Mac_OSX\(03-2006\)/Solaris_8/9\(12-2004\)/SPARC_8/9/Sun_Solaris_2.3_to_2.5.1\(02-1997\)\
 /pkexec$%Linux4.10_to_5.1.17\(CVE-2019-13272\)/rhel_6\(CVE-2011-1485\)/Generic_CVE-2021-4034\
 /pppd$%Apple_Mac_OSX_10.4.8\(05-2007\)\
 /pt_chown$%GNU_glibc_2.1/2.1.1_-6\(08-1999\)\
 /pulseaudio$%\(Ubuntu_9.04/Slackware_12.2.0\)\
 /rcp$%RedHat_6.2\
 /rdist$%Solaris_10/OpenSolaris\
 /rsh$%Apple_Mac_OSX_10.9.5/10.10.5\(09-2015\)\
 /screen$%GNU_Screen_4.5.0\
 /sdtcm_convert$%Sun_Solaris_7.0\
 /sendmail$%Sendmail_8.10.1/Sendmail_8.11.x/Linux_Kernel_2.2.x_2.4.0-test1_\(SGI_ProPack_1.2/1.3\)\
 /snap-confine$%Ubuntu_snapd<2.37_dirty_sock_Local_Privilege_Escalation\(CVE-2019-7304\)\
 /sudo%check_if_the_sudo_version_is_vulnerable\
 /Serv-U%FTP_Server<15.1.7(CVE-2019-12181)\
 /sudoedit$%Sudo/SudoEdit_1.6.9p21/1.7.2p4/\(RHEL_5/6/7/Ubuntu\)/Sudo<=1.8.14\
 /tmux$%Tmux_1.3_1.4_privesc\(CVE-2011-1496\)\
 /traceroute$%LBL_Traceroute_\[2000-11-15\]\
 /ubuntu-core-launcher$%Befre_1.0.27.1\(CVE-2016-1580\)\
 /umount$%BSD/Linux\(08-1996\)\
 /umount-loop$%Rocks_Clusters<=4.1\(07-2006\)\
 /uucp$%Taylor_UUCP_1.0.6\
 /XFree86$%XFree86_X11R6_3.3.x/4.0/4.x/3.3\(03-2003\)\
 /xlock$%BSD/OS_2.1/DG/UX_7.0/Debian_1.3/HP-UX_10.34/IBM_AIX_4.2/SGI_IRIX_6.4/Solaris_2.5.1\(04-1997\)\
 /xscreensaver%Solaris_11.x\(CVE-2019-3010\)\
 /xorg$%Xorg_1.19_to_1.20.x\(CVE_2018-14665\)/xorg-x11-server<=1.20.3/AIX_7.1_\(6.x_to_7.x_should_be_vulnerable\)_X11.base.rte<7.1.5.32_and_\
 /xterm$%Solaris_5.5.1_X11R6.3\(05-1997\)/Debian_xterm_version_222-1etch2\(01-2009\)"

#bruteforcing moment
export top2000pwds="123456 password 123456789 12345678 12345 qwerty 123123 111111 abc123 1234567 dragon 1q2w3e4r sunshine 654321 master 1234 football 1234567890 000000 computer 666666 superman michael internet iloveyou daniel 1qaz2wsx monkey shadow jessica letmein baseball whatever princess abcd1234 123321 starwars 121212 thomas zxcvbnm trustno1 killer welcome jordan aaaaaa 123qwe freedom password1 charlie batman jennifer 7777777 michelle diamond oliver mercedes benjamin 11111111 snoopy samantha victoria matrix george alexander secret cookie asdfgh 987654321 123abc orange fuckyou asdf1234 pepper hunter silver joshua banana 1q2w3e chelsea 1234qwer summer qwertyuiop phoenix andrew q1w2e3r4 elephant rainbow mustang merlin london garfield robert chocolate 112233 samsung qazwsx matthew buster jonathan ginger flower 555555 test caroline amanda maverick midnight martin junior 88888888 anthony jasmine creative patrick mickey 123 qwerty123 cocacola chicken passw0rd forever william nicole hello yellow nirvana justin friends cheese tigger mother liverpool blink182 asdfghjkl andrea spider scooter richard soccer rachel purple morgan melissa jackson arsenal 222222 qwe123 gabriel ferrari jasper danielle bandit angela scorpion prince maggie austin veronica nicholas monster dexter carlos thunder success hannah ashley 131313 stella brandon pokemon joseph asdfasdf 999999 metallica december chester taylor sophie samuel rabbit crystal barney xxxxxx steven ranger patricia christian asshole spiderman sandra hockey angels security parker heather 888888 victor harley 333333 system slipknot november jordan23 canada tennis qwertyui casper gemini asd123 winter hammer cooper america albert 777777 winner charles butterfly swordfish popcorn penguin dolphin carolina access 987654 hardcore corvette apples 12341234 sabrina remember qwer1234 edward dennis cherry sparky natasha arthur vanessa marina leonardo johnny dallas antonio winston \
snickers olivia nothing iceman destiny coffee apollo 696969 windows williams school madison dakota angelina anderson 159753 1111 yamaha trinity rebecca nathan guitar compaq 123123123 toyota shannon playboy peanut pakistan diablo abcdef maxwell golden asdasd 123654 murphy monica marlboro kimberly gateway bailey 00000000 snowball scooby nikita falcon august test123 sebastian panther love johnson godzilla genesis brandy adidas zxcvbn wizard porsche online hello123 fuckoff eagles champion bubbles boston smokey precious mercury lauren einstein cricket cameron angel admin napoleon mountain lovely friend flowers dolphins david chicago sierra knight yankees wilson warrior simple nelson muffin charlotte calvin spencer newyork florida fernando claudia basketball barcelona 87654321 willow stupid samson police paradise motorola manager jaguar jackie family doctor bullshit brooklyn tigers stephanie slayer peaches miller heaven elizabeth bulldog animal 789456 scorpio rosebud qwerty12 franklin claire american vincent testing pumpkin platinum louise kitten general united turtle marine icecream hacker darkness cristina colorado boomer alexandra steelers serenity please montana mitchell marcus lollipop jessie happy cowboy 102030 marshall jupiter jeremy gibson fucker barbara adrian 1qazxsw2 12344321 11111 startrek fishing digital christine business abcdefg nintendo genius 12qwaszx walker q1w2e3 player legend carmen booboo tomcat ronaldo people pamela marvin jackass google fender asdfghjk Password 1q2w3e4r5t zaq12wsx scotland phantom hercules fluffy explorer alexis walter trouble tester qwerty1 melanie manchester gordon firebird engineer azerty 147258 virginia tiger simpsons passion lakers james angelica 55555 vampire tiffany september private maximus loveme isabelle isabella eclipse dreamer changeme cassie badboy 123456a stanley sniper rocket passport pandora justice infinity cookies barbie xavier unicorn superstar \
stephen rangers orlando money domino courtney viking tucker travis scarface pavilion nicolas natalie gandalf freddy donald captain abcdefgh a1b2c3d4 speedy peter nissan loveyou harrison friday francis dancer 159357 101010 spitfire saturn nemesis little dreams catherine brother birthday 1111111 wolverine victory student france fantasy enigma copper bonnie teresa mexico guinness georgia california sweety logitech julian hotdog emmanuel butter beatles 11223344 tristan sydney spirit october mozart lolita ireland goldfish eminem douglas cowboys control cheyenne alex testtest stargate raiders microsoft diesel debbie danger chance asdf anything aaaaaaaa welcome1 qwert hahaha forest eternity disney denise carter alaska zzzzzz titanic shorty shelby pookie pantera england chris zachary westside tamara password123 pass maryjane lincoln willie teacher pierre michael1 leslie lawrence kristina kawasaki drowssap college blahblah babygirl avatar alicia regina qqqqqq poohbear miranda madonna florence sapphire norman hamilton greenday galaxy frankie black awesome suzuki spring qazwsxedc magnum lovers liberty gregory 232323 twilight timothy swimming super stardust sophia sharon robbie predator penelope michigan margaret jesus hawaii green brittany brenda badger a1b2c3 444444 winnie wesley voodoo skippy shithead redskins qwertyu pussycat houston horses gunner fireball donkey cherokee australia arizona 1234abcd skyline power perfect lovelove kermit kenneth katrina eugene christ thailand support special runner lasvegas jason fuckme butthead blizzard athena abigail 8675309 violet tweety spanky shamrock red123 rascal melody joanna hello1 driver bluebird biteme atlantis arnold apple alison taurus random pirate monitor maria lizard kevin hummer holland buffalo 147258369 007007 valentine roberto potter magnolia juventus indigo indian harvey duncan diamonds daniela christopher bradley bananas warcraft sunset simone renegade \
redsox philip monday mohammed indiana energy bond007 avalon terminator skipper shopping scotty savannah raymond morris mnbvcxz michele lucky lucifer kingdom karina giovanni cynthia a123456 147852 12121212 wildcats ronald portugal mike helpme froggy dragons cancer bullet beautiful alabama 212121 unknown sunflower sports siemens santiago kathleen hotmail hamster golfer future father enterprise clifford christina camille camaro beauty 55555555 vision tornado something rosemary qweasd patches magic helena denver cracker beaver basket atlanta vacation smiles ricardo pascal newton jeffrey jasmin january honey hollywood holiday gloria element chandler booger angelo allison action 99999999 target snowman miguel marley lorraine howard harmony children celtic beatrice airborne wicked voyager valentin thx1138 thumper samurai moonlight mmmmmm karate kamikaze jamaica emerald bubble brooke zombie strawberry spooky software simpson service sarah racing qazxsw philips oscar minnie lalala ironman goddess extreme empire elaine drummer classic carrie berlin asdfg 22222222 valerie tintin therock sunday skywalker salvador pegasus panthers packers network mission mark legolas lacrosse kitty kelly jester italia hiphop freeman charlie1 cardinal bluemoon bbbbbb bastard alyssa 0123456789 zeppelin tinker surfer smile rockstar operator naruto freddie dragonfly dickhead connor anaconda amsterdam alfred a12345 789456123 77777777 trooper skittles shalom raptor pioneer personal ncc1701 nascar music kristen kingkong global geronimo germany country christmas bernard benson wrestling warren techno sunrise stefan sister savage russell robinson oracle millie maddog lightning kingston kennedy hannibal garcia download dollar darkstar brutus bobby autumn webster vanilla undertaker tinkerbell sweetpea ssssss softball rafael panasonic pa55word keyboard isabel hector fisher dominic darkside cleopatra blue assassin amelia vladimir roland \
nigger national monique molly matthew1 godfather frank curtis change central cartman brothers boogie archie warriors universe turkey topgun solomon sherry sakura rush2112 qwaszx office mushroom monika marion lorenzo john herman connect chopper burton blondie bitch bigdaddy amber 456789 1a2b3c4d ultimate tequila tanner sweetie scott rocky popeye peterpan packard loverboy leonard jimmy harry griffin design buddha 1 wallace truelove trombone toronto tarzan shirley sammy pebbles natalia marcel malcolm madeline jerome gilbert gangster dingdong catalina buddy blazer billy bianca alejandro 54321 252525 111222 0000 water sucker rooster potato norton lucky1 loving lol123 ladybug kittycat fuck forget flipper fireman digger bonjour baxter audrey aquarius 1111111111 pppppp planet pencil patriots oxford million martha lindsay laura jamesbond ihateyou goober giants garden diana cecilia brazil blessing bishop bigdog airplane Password1 tomtom stingray psycho pickle outlaw number1 mylove maurice madman maddie lester hendrix hellfire happy1 guardian flamingo enter chichi 0987654321 western twister trumpet trixie socrates singer sergio sandman richmond piglet pass123 osiris monkey1 martina justine english electric church castle caesar birdie aurora artist amadeus alberto 246810 whitney thankyou sterling star ronnie pussy printer picasso munchkin morpheus madmax kaiser julius imperial happiness goodluck counter columbia campbell blessed blackjack alpha 999999999 142536 wombat wildcat trevor telephone smiley saints pretty oblivion newcastle mariana janice israel imagine freedom1 detroit deedee darren catfish adriana washington warlock valentina valencia thebest spectrum skater sheila shaggy poiuyt member jessica1 jeremiah jack insane iloveu handsome goldberg gabriela elijah damien daisy buttons blabla bigboy apache anthony1 a1234567 xxxxxxxx toshiba tommy sailor peekaboo motherfucker montreal manuel madrid kramer \
katherine kangaroo jenny immortal harris hamlet gracie fucking firefly chocolat bentley account 321321 2222 1a2b3c thompson theman strike stacey science running research polaris oklahoma mariposa marie leader julia island idontknow hitman german felipe fatcat fatboy defender applepie annette 010203 watson travel sublime stewart steve squirrel simon sexy pineapple phoebe paris panzer nadine master1 mario kelsey joker hongkong gorilla dinosaur connie bowling bambam babydoll aragorn andreas 456123 151515 wolves wolfgang turner semperfi reaper patience marilyn fletcher drpepper dorothy creation brian bluesky andre yankee wordpass sweet spunky sidney serena preston pauline passwort original nightmare miriam martinez labrador kristin kissme henry gerald garrett flash excalibur discovery dddddd danny collins casino broncos brendan brasil apple123 yvonne wonder window tomato sundance sasha reggie redwings poison mypassword monopoly mariah margarita lionking king football1 director darling bubba biscuit 44444444 wisdom vivian virgin sylvester street stones sprite spike single sherlock sandy rocker robin matt marianne linda lancelot jeanette hobbes fred ferret dodger cotton corona clayton celine cannabis bella andromeda 7654321 4444 werewolf starcraft sampson redrum pyramid prodigy paul michel martini marathon longhorn leopard judith joanne jesus1 inferno holly harold happy123 esther dudley dragon1 darwin clinton celeste catdog brucelee argentina alpine 147852369 wrangler william1 vikings trigger stranger silvia shotgun scarlett scarlet redhead raider qweasdzxc playstation mystery morrison honda february fantasia designer coyote cool bulldogs bernie baby asdfghj angel1 always adam 202020 wanker sullivan stealth skeeter saturday rodney prelude pingpong phillip peewee peanuts peace nugget newport myself mouse memphis lover lancer kristine james1 hobbit halloween fuckyou1 finger fearless dodgers delete cougar \
charmed cassandra caitlin bismillah believe alice airforce 7777 viper tony theodore sylvia suzanne starfish sparkle server samsam qweqwe public pass1234 neptune marian krishna kkkkkk jungle cinnamon bitches 741852 trojan theresa sweetheart speaker salmon powers pizza overlord michaela meredith masters lindsey history farmer express escape cuddles carson candy buttercup brownie broken abc12345 aardvark Passw0rd 141414 124578 123789 12345678910 00000 universal trinidad tobias thursday surfing stuart stinky standard roller porter pearljam mobile mirage markus loulou jjjjjj herbert grace goldie frosty fighter fatima evelyn eagle desire crimson coconut cheryl beavis anonymous andres africa 134679 whiskey velvet stormy springer soldier ragnarok portland oranges nobody nathalie malibu looking lemonade lavender hitler hearts gotohell gladiator gggggg freckles fashion david1 crusader cosmos commando clover clarence center cadillac brooks bronco bonita babylon archer alexandre 123654789 verbatim umbrella thanks sunny stalker splinter sparrow selena russia roberts register qwert123 penguins panda ncc1701d miracle melvin lonely lexmark kitkat julie graham frances estrella downtown doodle deborah cooler colombia chemistry cactus bridge bollocks beetle anastasia 741852963 69696969 unique sweets station showtime sheena santos rock revolution reading qwerasdf password2 mongoose marlene maiden machine juliet illusion hayden fabian derrick crazy cooldude chipper bomber blonde bigred amazing aliens abracadabra 123qweasd wwwwww treasure timber smith shelly sesame pirates pinkfloyd passwords nature marlin marines linkinpark larissa laptop hotrod gambit elvis education dustin devils damian christy braves baller anarchy white valeria underground strong poopoo monalisa memory lizzie keeper justdoit house homer gerard ericsson emily divine colleen chelsea1 cccccc camera bonbon billie bigfoot badass asterix anna animals \
andy achilles a1s2d3f4 violin veronika vegeta tyler test1234 teddybear tatiana sporting spartan shelley sharks respect raven pentium papillon nevermind marketing manson madness juliette jericho gabrielle fuckyou2 forgot firewall faith evolution eric eduardo dagger cristian cavalier canadian bruno blowjob blackie beagle admin123 010101 together spongebob snakes sherman reddog reality ramona puppies pedro pacific pa55w0rd omega noodle murray mollie mister halflife franco foster formula1 felix dragonball desiree default chris1 bunny bobcat asdf123 951753 5555 242424 thirteen tattoo stonecold stinger shiloh seattle santana roger roberta rastaman pickles orion mustang1 felicia dracula doggie cucumber cassidy britney brianna blaster belinda apple1 753951 teddy striker stevie soleil snake skateboard sheridan sexsex roxanne redman qqqqqqqq punisher panama paladin none lovelife lights jerry iverson inside hornet holden groovy gretchen grandma gangsta faster eddie chevelle chester1 carrot cannon button administrator a 1212 zxc123 wireless volleyball vietnam twinkle terror sandiego rose pokemon1 picture parrot movies moose mirror milton mayday maestro lollypop katana johanna hunting hudson grizzly gorgeous garbage fish ernest dolores conrad chickens charity casey blueberry blackman blackbird bill beckham battle atlantic wildfire weasel waterloo trance storm singapore shooter rocknroll richie poop pitbull mississippi kisses karen juliana james123 iguana homework highland fire elliot eldorado ducati discover computer1 buddy1 antonia alphabet 159951 123456789a 1123581321 0123456 zaq1xsw2 webmaster vagina unreal university tropical swimmer sugar southpark silence sammie ravens question presario poiuytrewq palmer notebook newman nebraska manutd lucas hermes gators dave dalton cheetah cedric camilla bullseye bridget bingo ashton 123asd yahoo volume valhalla tomorrow starlight scruffy roscoe richard1 positive \
plymouth pepsi patrick1 paradox milano maxima loser lestat gizmo ghetto faithful emerson elliott dominique doberman dillon criminal crackers converse chrissy casanova blowme attitude"

#asdasd