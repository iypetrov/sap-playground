#!/usr/bin/env bash
# Configure Shoot cluster control plane observability signals (metrics, logs, events)
# to be forwarded to SAP Cloud Logging.

set -e

_SCRIPT_NAME="${0##*/}"
_SCRIPT_DIR=$( dirname "$( readlink -f -- "${0}" )" )
_PROJECT_DIR="${_SCRIPT_DIR}/.."

# Main entrypoint
function _main() {
    # Retrieve SAP Cloud Logging instance credentials from Terraform state.
    local _cl_creds=$( terraform output -raw cloud_logging_credentials )
    local _dashboards_endpoint=$( echo "${_cl_creds}" | jq -r '.["dashboards-endpoint"]' )
    local _dashboards_username=$( echo "${_cl_creds}" | jq -r '.["dashboards-username"]' )
    local _dashboards_password=$( echo "${_cl_creds}" | jq -r '.["dashboards-password"]' )

    local _ingest_otlp_endpoint=$( echo "${_cl_creds}" | jq -r '.["ingest-otlp-endpoint"]' )
    local _ingest_otlp_cert=$( echo "${_cl_creds}" | jq -r '.["ingest-otlp-cert"]' )
    local _ingest_otlp_key=$( echo "${_cl_creds}" | jq -r '.["ingest-otlp-key"]' )
    local _server_ca=$( echo "${_cl_creds}" | jq -r '.["server-ca"]' )

    kubectl --kubeconfig $KUBECONFIG_VIRTUAL --namespace garden-local \
        create secret generic cloud-logging-otlp \
        --from-file=ca.crt=<(printf '%s\n' "${_server_ca}") \
        --from-file=client.crt=<(printf '%s\n' "${_ingest_otlp_cert}") \
        --from-file=client.key=<(printf '%s\n' "${_ingest_otlp_key}") \
		--dry-run=client -o yaml

    echo "dashboards-endpoint:  ${_dashboards_endpoint}"
    echo "dashboards-username:  ${_dashboards_username}"
    echo "dashboards-password:  ${_dashboards_password}"
    echo "ingest-otlp-endpoint: ${_ingest_otlp_endpoint}"
    # echo ""
    # echo "server-ca:"
    # echo "${_server_ca}"
    # echo "ingest-otlp-cert:"
    # echo "${_ingest_otlp_cert}"
    # echo "ingest-otlp-key:"
    # echo "${_ingest_otlp_key}"
}

_main "$@"
