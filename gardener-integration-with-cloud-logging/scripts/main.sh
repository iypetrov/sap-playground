#!/usr/bin/env bash

set -e

_SCRIPT_NAME="${0##*/}"
_SCRIPT_DIR=$( dirname "$( readlink -f -- "${0}" )" )
_PROJECT_DIR="${_SCRIPT_DIR}/.."

# Main entrypoint
function _main() {
    local _cl_creds=$( terraform output -raw cloud_logging_credentials )
    local _dashboards_endpoint=$( echo "${_cl_creds}" | jq -r '.["dashboards-endpoint"]' )
    local _dashboards_username=$( echo "${_cl_creds}" | jq -r '.["dashboards-username"]' )
    local _dashboards_password=$( echo "${_cl_creds}" | jq -r '.["dashboards-password"]' )
    local _ingest_endpoint=$( echo "${_cl_creds}" | jq -r '.["ingest-endpoint"]' )
    local _ingest_username=$( echo "${_cl_creds}" | jq -r '.["ingest-username"]' )
    local _ingest_password=$( echo "${_cl_creds}" | jq -r '.["ingest-password"]' )
    local _ingest_mtls_endpoint=$( echo "${_cl_creds}" | jq -r '.["ingest-mtls-endpoint"]' )
    local _client_ca=$( echo "${_cl_creds}" | jq -r '.["client-ca"]' )
    local _server_ca=$( echo "${_cl_creds}" | jq -r '.["server-ca"]' )
    local _ingest_mtls_cert=$( echo "${_cl_creds}" | jq -r '.["ingest-mtls-cert"]' )
    local _ingest_mtls_key=$( echo "${_cl_creds}" | jq -r '.["ingest-mtls-key"]' )

    # echo "dashboards-endpoint:  ${_dashboards_endpoint}"
    # echo "dashboards-username:  ${_dashboards_username}"
    # echo "dashboards-password:  ${_dashboards_password}"
    # echo "ingest-endpoint:      ${_ingest_endpoint}"
    # echo "ingest-username:      ${_ingest_username}"
    # echo "ingest-password:      ${_ingest_password}"
    # echo "ingest-mtls-endpoint: ${_ingest_mtls_endpoint}"
    # echo ""
    # echo "client-ca:"
    # echo "${_client_ca}"
    # echo "server-ca:"
    # echo "${_server_ca}"
    # echo "ingest-mtls-cert:"
    # echo "${_ingest_mtls_cert}"
    # echo "ingest-mtls-key:"
    # echo "${_ingest_mtls_key}"
}

_main "$@"
