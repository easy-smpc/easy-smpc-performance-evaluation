-- Change to db
\c easybackend;

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
e85bc1bb-366d-4884-a2e0-6a5c87fce3e9	\N	auth-cookie	afa54666-f1b9-40de-9536-29bb76f3fd42	7f229f96-c54a-47fd-8c96-574f5a12d3de	2	10	f	\N	\N
33ede520-d4e2-4491-b3bc-3bb1eb2e3e40	\N	auth-spnego	afa54666-f1b9-40de-9536-29bb76f3fd42	7f229f96-c54a-47fd-8c96-574f5a12d3de	3	20	f	\N	\N
31d9712d-3726-4791-aae2-7052e4dffdb1	\N	identity-provider-redirector	afa54666-f1b9-40de-9536-29bb76f3fd42	7f229f96-c54a-47fd-8c96-574f5a12d3de	2	25	f	\N	\N
5fd5f73b-3ab2-4f99-9620-add9a2860d1c	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	7f229f96-c54a-47fd-8c96-574f5a12d3de	2	30	t	4c44a0ff-ba3d-4fd7-82b3-146c689dcf9c	\N
1ae87a91-e557-4ec8-aa69-d1f0d40773a8	\N	auth-username-password-form	afa54666-f1b9-40de-9536-29bb76f3fd42	4c44a0ff-ba3d-4fd7-82b3-146c689dcf9c	0	10	f	\N	\N
62d5473c-12d3-4af1-b2a5-85f8f6577cb3	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	4c44a0ff-ba3d-4fd7-82b3-146c689dcf9c	1	20	t	2329f411-9c78-4612-8fa5-a4d31898b9b1	\N
6c3823d7-2573-40c6-9618-64b4b4d691ff	\N	conditional-user-configured	afa54666-f1b9-40de-9536-29bb76f3fd42	2329f411-9c78-4612-8fa5-a4d31898b9b1	0	10	f	\N	\N
bc9b73c0-57bc-473d-824b-b8c3fc097f00	\N	auth-otp-form	afa54666-f1b9-40de-9536-29bb76f3fd42	2329f411-9c78-4612-8fa5-a4d31898b9b1	0	20	f	\N	\N
e1f653da-7a99-45a1-81c3-6401503c542c	\N	direct-grant-validate-username	afa54666-f1b9-40de-9536-29bb76f3fd42	20618c14-29d5-4714-a1a4-3a0b48318292	0	10	f	\N	\N
05512450-2d7a-4750-bbe5-b46add3fd735	\N	direct-grant-validate-password	afa54666-f1b9-40de-9536-29bb76f3fd42	20618c14-29d5-4714-a1a4-3a0b48318292	0	20	f	\N	\N
489a6852-e96a-4a31-9657-2c8a174a016d	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	20618c14-29d5-4714-a1a4-3a0b48318292	1	30	t	931179fb-04de-40cc-b491-ecc641cab410	\N
f207ca0b-cfe3-4103-8cbc-31e9308aca2c	\N	conditional-user-configured	afa54666-f1b9-40de-9536-29bb76f3fd42	931179fb-04de-40cc-b491-ecc641cab410	0	10	f	\N	\N
ff7c2e7d-9139-4ed4-a8f0-4628616227f5	\N	direct-grant-validate-otp	afa54666-f1b9-40de-9536-29bb76f3fd42	931179fb-04de-40cc-b491-ecc641cab410	0	20	f	\N	\N
5f48b1d0-997d-4089-8620-42c5ee2dd30a	\N	registration-page-form	afa54666-f1b9-40de-9536-29bb76f3fd42	51440119-960a-4a32-b1b7-fee99be36244	0	10	t	494c2ba6-8eca-458b-94b3-d392dbd2fdd9	\N
820b97b8-512d-449e-beee-df7648bbb80a	\N	registration-user-creation	afa54666-f1b9-40de-9536-29bb76f3fd42	494c2ba6-8eca-458b-94b3-d392dbd2fdd9	0	20	f	\N	\N
4f5adaeb-3a5a-40f2-923c-cd1f98a02aad	\N	registration-profile-action	afa54666-f1b9-40de-9536-29bb76f3fd42	494c2ba6-8eca-458b-94b3-d392dbd2fdd9	0	40	f	\N	\N
f5216d37-d1df-45d0-9409-90d1d6b412d3	\N	registration-password-action	afa54666-f1b9-40de-9536-29bb76f3fd42	494c2ba6-8eca-458b-94b3-d392dbd2fdd9	0	50	f	\N	\N
ea1badc2-d287-4211-9348-e718d8825f66	\N	registration-recaptcha-action	afa54666-f1b9-40de-9536-29bb76f3fd42	494c2ba6-8eca-458b-94b3-d392dbd2fdd9	3	60	f	\N	\N
d89287fa-4c87-479f-9e70-b164c672851d	\N	reset-credentials-choose-user	afa54666-f1b9-40de-9536-29bb76f3fd42	f4e345d6-6b3b-40e9-a520-2ad726d600f7	0	10	f	\N	\N
5cd18b26-4a85-41f9-a2bb-c50e00190d3b	\N	reset-credential-email	afa54666-f1b9-40de-9536-29bb76f3fd42	f4e345d6-6b3b-40e9-a520-2ad726d600f7	0	20	f	\N	\N
c456b481-9c02-4ddd-847b-d06e14193610	\N	reset-password	afa54666-f1b9-40de-9536-29bb76f3fd42	f4e345d6-6b3b-40e9-a520-2ad726d600f7	0	30	f	\N	\N
a3cae996-6818-4ed0-9ffe-e5bdfa130116	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	f4e345d6-6b3b-40e9-a520-2ad726d600f7	1	40	t	70dd24eb-2800-4779-9b3c-a4deb344ed21	\N
10722b38-a32f-4262-812a-55de8b4ed899	\N	conditional-user-configured	afa54666-f1b9-40de-9536-29bb76f3fd42	70dd24eb-2800-4779-9b3c-a4deb344ed21	0	10	f	\N	\N
380bbe8d-5f24-4231-a58b-debd21dae144	\N	reset-otp	afa54666-f1b9-40de-9536-29bb76f3fd42	70dd24eb-2800-4779-9b3c-a4deb344ed21	0	20	f	\N	\N
66353fe3-177b-4364-b5e5-00c4a0e13f55	\N	client-secret	afa54666-f1b9-40de-9536-29bb76f3fd42	e271c895-d606-436c-8003-4380af301103	2	10	f	\N	\N
d90a8ad8-18a3-4fe8-a9c4-7c0793202130	\N	client-jwt	afa54666-f1b9-40de-9536-29bb76f3fd42	e271c895-d606-436c-8003-4380af301103	2	20	f	\N	\N
e18d13b3-77e8-4efd-a70d-7451f803baa2	\N	client-secret-jwt	afa54666-f1b9-40de-9536-29bb76f3fd42	e271c895-d606-436c-8003-4380af301103	2	30	f	\N	\N
dbba1bfa-3606-4e55-9a28-297ab1bf02eb	\N	client-x509	afa54666-f1b9-40de-9536-29bb76f3fd42	e271c895-d606-436c-8003-4380af301103	2	40	f	\N	\N
90396d6b-5b5f-4514-8792-c9e493377bc0	\N	idp-review-profile	afa54666-f1b9-40de-9536-29bb76f3fd42	f012f9bc-767b-42c5-8077-bd14aa92eca0	0	10	f	\N	033bb6ff-5ca2-466c-a433-5719752e6287
22892d9e-d8b9-4a51-8748-9fb87db6a848	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	f012f9bc-767b-42c5-8077-bd14aa92eca0	0	20	t	f6e1e9f1-b4a8-4555-a209-5b378203a3f5	\N
47d5e35d-16a5-412d-b2cf-950f0d3ed6d7	\N	idp-create-user-if-unique	afa54666-f1b9-40de-9536-29bb76f3fd42	f6e1e9f1-b4a8-4555-a209-5b378203a3f5	2	10	f	\N	42c479bf-ed65-43d3-839a-d00e5cc377ce
d1ca0491-8514-4610-a688-f2a47bd285f4	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	f6e1e9f1-b4a8-4555-a209-5b378203a3f5	2	20	t	ac35f4c6-47bc-414f-8b50-8bf4fc3b430b	\N
1fb7de29-b61f-4881-9e74-41e8578c6337	\N	idp-confirm-link	afa54666-f1b9-40de-9536-29bb76f3fd42	ac35f4c6-47bc-414f-8b50-8bf4fc3b430b	0	10	f	\N	\N
767c6f62-4bd5-4b93-89e6-edfe70afd178	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	ac35f4c6-47bc-414f-8b50-8bf4fc3b430b	0	20	t	d7524ecb-451f-4170-9bba-ce5e69977edf	\N
da38509a-a1ab-4b2b-884a-d429f806c469	\N	idp-email-verification	afa54666-f1b9-40de-9536-29bb76f3fd42	d7524ecb-451f-4170-9bba-ce5e69977edf	2	10	f	\N	\N
6928c7ff-44df-46b5-b68e-e34eff29c317	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	d7524ecb-451f-4170-9bba-ce5e69977edf	2	20	t	6ca4524f-f231-462f-9f00-2502ca32df24	\N
c0c9d5c7-0c4c-4c0c-a5c2-360f6e58b3cd	\N	idp-username-password-form	afa54666-f1b9-40de-9536-29bb76f3fd42	6ca4524f-f231-462f-9f00-2502ca32df24	0	10	f	\N	\N
b2d52bb2-9e6c-441b-9b70-c6bebfec841f	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	6ca4524f-f231-462f-9f00-2502ca32df24	1	20	t	197c9257-fa2a-482d-997b-a12d3f35f619	\N
036ca497-c767-4557-b573-1f511a878cab	\N	conditional-user-configured	afa54666-f1b9-40de-9536-29bb76f3fd42	197c9257-fa2a-482d-997b-a12d3f35f619	0	10	f	\N	\N
4dc1cf7b-f288-4cf6-a724-07cc5bd54e67	\N	auth-otp-form	afa54666-f1b9-40de-9536-29bb76f3fd42	197c9257-fa2a-482d-997b-a12d3f35f619	0	20	f	\N	\N
7e92a648-45da-4b61-984b-71f9d0d73fa7	\N	http-basic-authenticator	afa54666-f1b9-40de-9536-29bb76f3fd42	a0a78cc1-6ea7-438e-987b-19f2943e3db8	0	10	f	\N	\N
ea803239-58d7-4253-b282-691069fab7ae	\N	docker-http-basic-authenticator	afa54666-f1b9-40de-9536-29bb76f3fd42	053a930a-5024-4066-8196-b8259c624e8c	0	10	f	\N	\N
aeaae229-e472-4d9c-b70c-c7fc0bddf16d	\N	no-cookie-redirect	afa54666-f1b9-40de-9536-29bb76f3fd42	ec0da042-401d-47fa-a93d-69a53a847261	0	10	f	\N	\N
8b91af80-0311-4047-88ca-e8fe6cd14276	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	ec0da042-401d-47fa-a93d-69a53a847261	0	20	t	a8b37d5f-5e3c-403f-9066-150ea13148d7	\N
75f6611a-992b-4efb-be48-25e62ea5c06a	\N	basic-auth	afa54666-f1b9-40de-9536-29bb76f3fd42	a8b37d5f-5e3c-403f-9066-150ea13148d7	0	10	f	\N	\N
b2d29a46-6ccd-450e-a17b-daa3e9dd779a	\N	basic-auth-otp	afa54666-f1b9-40de-9536-29bb76f3fd42	a8b37d5f-5e3c-403f-9066-150ea13148d7	3	20	f	\N	\N
93abe87f-ce3b-47c9-b42d-eda557c361ea	\N	auth-spnego	afa54666-f1b9-40de-9536-29bb76f3fd42	a8b37d5f-5e3c-403f-9066-150ea13148d7	3	30	f	\N	\N
6c6d4366-e27d-4efc-9f0c-d39d3fa0adad	\N	idp-email-verification	easybackend	5233e062-9a33-4c0a-8988-b61682a8212f	2	10	f	\N	\N
0db11ffe-29c1-4d84-9117-194a473d14ad	\N	\N	easybackend	5233e062-9a33-4c0a-8988-b61682a8212f	2	20	t	7e0764f4-b611-432e-a5a8-97556fe2e1e1	\N
938a9080-b522-411d-ad3b-f29518036a9e	\N	basic-auth	easybackend	e958c5c6-5f20-461c-b5cf-3feecf39723a	0	10	f	\N	\N
71ea7297-b92c-4919-9c7c-2ab582267132	\N	basic-auth-otp	easybackend	e958c5c6-5f20-461c-b5cf-3feecf39723a	3	20	f	\N	\N
faec7285-7022-4f85-b951-1d2912773a0f	\N	auth-spnego	easybackend	e958c5c6-5f20-461c-b5cf-3feecf39723a	3	30	f	\N	\N
3ce8dc79-a978-4681-a94d-dce6fd6613bd	\N	conditional-user-configured	easybackend	d83f4f2e-f01b-4c9c-ac06-de220bb54375	0	10	f	\N	\N
1c906523-6990-4b5b-a7f2-b2ce17de7100	\N	auth-otp-form	easybackend	d83f4f2e-f01b-4c9c-ac06-de220bb54375	0	20	f	\N	\N
e02e7c56-ecc2-42e4-b9d0-53445fc756ff	\N	conditional-user-configured	easybackend	62d2c958-77a1-4c82-a092-df47948bacfe	0	10	f	\N	\N
e68b1500-6f4a-4c06-90d5-cbccd6c8637b	\N	direct-grant-validate-otp	easybackend	62d2c958-77a1-4c82-a092-df47948bacfe	0	20	f	\N	\N
bbcbcdc0-7f94-4257-88e9-742b4138588e	\N	conditional-user-configured	easybackend	d1eb013b-0d3f-4d7b-9d01-8fb3b9063b0a	0	10	f	\N	\N
6ce13ebe-3b97-4001-835d-144d3abb38d6	\N	auth-otp-form	easybackend	d1eb013b-0d3f-4d7b-9d01-8fb3b9063b0a	0	20	f	\N	\N
8d99045b-428e-4d96-bf94-50ea9b812443	\N	idp-confirm-link	easybackend	a26d6419-676d-476e-ae9a-f61027cdc99a	0	10	f	\N	\N
3ab06822-74d3-4df0-986c-c6d729e499d1	\N	\N	easybackend	a26d6419-676d-476e-ae9a-f61027cdc99a	0	20	t	5233e062-9a33-4c0a-8988-b61682a8212f	\N
86cbe957-28d9-4b88-8e33-f066e1dd2d1c	\N	conditional-user-configured	easybackend	7484cb70-28e8-4626-8b26-3965f07fa9a7	0	10	f	\N	\N
8cb0195e-25e3-434e-97db-4f3a835b5876	\N	reset-otp	easybackend	7484cb70-28e8-4626-8b26-3965f07fa9a7	0	20	f	\N	\N
e50d46f2-4f85-4faf-b82c-15d46719d297	\N	idp-create-user-if-unique	easybackend	b52391e7-8753-4b14-aa8f-01b02d2a5629	2	10	f	\N	4b128241-75b4-415a-a7e4-26f3770dea17
58fc0a62-d5ba-473e-acfc-e5bb465adb45	\N	\N	easybackend	b52391e7-8753-4b14-aa8f-01b02d2a5629	2	20	t	a26d6419-676d-476e-ae9a-f61027cdc99a	\N
e996387a-c3ca-4b07-bcd0-f03162cab59c	\N	idp-username-password-form	easybackend	7e0764f4-b611-432e-a5a8-97556fe2e1e1	0	10	f	\N	\N
e24772d1-4189-43d9-872b-83e755039e6d	\N	\N	easybackend	7e0764f4-b611-432e-a5a8-97556fe2e1e1	1	20	t	d1eb013b-0d3f-4d7b-9d01-8fb3b9063b0a	\N
64a1f0c0-72e3-4163-a692-c3c69d8e27b9	\N	auth-cookie	easybackend	0d9f5e77-0339-4d99-b787-d5264b222719	2	10	f	\N	\N
c6afd339-8b57-446d-a3b5-8bc62575cf01	\N	auth-spnego	easybackend	0d9f5e77-0339-4d99-b787-d5264b222719	3	20	f	\N	\N
53d7f2d2-c6a0-489c-8576-577c9d7ef085	\N	identity-provider-redirector	easybackend	0d9f5e77-0339-4d99-b787-d5264b222719	2	25	f	\N	\N
6d132638-a428-4bb2-9b3f-4799a018b9c0	\N	\N	easybackend	0d9f5e77-0339-4d99-b787-d5264b222719	2	30	t	1bca5208-e448-4287-8641-9b0e07546e86	\N
10a23bac-600b-487f-aae4-44769d7127c6	\N	client-secret	easybackend	f29f34ee-5f8b-456a-8578-fc8a49453277	2	10	f	\N	\N
1faad4df-f773-46f9-8a67-877ce45e76cc	\N	client-jwt	easybackend	f29f34ee-5f8b-456a-8578-fc8a49453277	2	20	f	\N	\N
6954fd33-cce7-4f96-8c56-440958de8d8f	\N	client-secret-jwt	easybackend	f29f34ee-5f8b-456a-8578-fc8a49453277	2	30	f	\N	\N
15171eeb-c280-405d-b36b-1068144917fb	\N	client-x509	easybackend	f29f34ee-5f8b-456a-8578-fc8a49453277	2	40	f	\N	\N
839eed92-d785-4236-ba0f-54d0d1ddf9f0	\N	direct-grant-validate-username	easybackend	9cc13fec-c2fc-4ee9-9cfa-f7a85ac3072e	0	10	f	\N	\N
26a84a98-2c2d-4029-8ca7-e20aee6da56e	\N	direct-grant-validate-password	easybackend	9cc13fec-c2fc-4ee9-9cfa-f7a85ac3072e	0	20	f	\N	\N
de52b876-40ec-48d0-aac8-505dc61a227f	\N	\N	easybackend	9cc13fec-c2fc-4ee9-9cfa-f7a85ac3072e	1	30	t	62d2c958-77a1-4c82-a092-df47948bacfe	\N
bc691f7d-b0ee-4664-9360-551fb74436f4	\N	docker-http-basic-authenticator	easybackend	e4717031-ae75-4679-a227-c2cf38a590a9	0	10	f	\N	\N
bab7ebad-cf92-4f60-bfe9-a7e171dbf96f	\N	idp-review-profile	easybackend	a1b43a35-d294-4e53-9d26-62e0a0a65068	0	10	f	\N	9bd1fa89-eee9-44dc-8478-f44c067e0e2f
48bf64d9-8e9c-455f-a7c8-de4bcc20c1ac	\N	\N	easybackend	a1b43a35-d294-4e53-9d26-62e0a0a65068	0	20	t	b52391e7-8753-4b14-aa8f-01b02d2a5629	\N
6346c647-b5c5-466e-bc57-f5e6fb5a1a94	\N	auth-username-password-form	easybackend	1bca5208-e448-4287-8641-9b0e07546e86	0	10	f	\N	\N
6d9f7939-fb80-4782-8a37-e738f0e393b0	\N	\N	easybackend	1bca5208-e448-4287-8641-9b0e07546e86	1	20	t	d83f4f2e-f01b-4c9c-ac06-de220bb54375	\N
b8d4bf00-d51f-41ba-aa7b-94a323191ee8	\N	no-cookie-redirect	easybackend	11dee0ef-55c3-4cb9-b586-67966b1a4e93	0	10	f	\N	\N
6f89bf4d-7659-4756-ae32-328e4698dc86	\N	\N	easybackend	11dee0ef-55c3-4cb9-b586-67966b1a4e93	0	20	t	e958c5c6-5f20-461c-b5cf-3feecf39723a	\N
f37747b5-ddae-46bb-8b12-1822e100b15c	\N	registration-page-form	easybackend	67912c08-47f9-430e-819d-f68612305d84	0	10	t	c849b9cb-8d7b-4e28-9a75-b7f82924eed4	\N
312c9af8-12bf-4910-98fa-ff214431f5e8	\N	registration-user-creation	easybackend	c849b9cb-8d7b-4e28-9a75-b7f82924eed4	0	20	f	\N	\N
2e2f0d41-4c84-466b-8bba-3ae5cd27a40e	\N	registration-profile-action	easybackend	c849b9cb-8d7b-4e28-9a75-b7f82924eed4	0	40	f	\N	\N
d7ccaac3-7706-4d1a-874c-557455a10530	\N	registration-password-action	easybackend	c849b9cb-8d7b-4e28-9a75-b7f82924eed4	0	50	f	\N	\N
c312f7d7-143f-42ed-bfca-dcedcf647823	\N	registration-recaptcha-action	easybackend	c849b9cb-8d7b-4e28-9a75-b7f82924eed4	3	60	f	\N	\N
ba56ad83-afa8-48f8-8ae4-d4bdd8a435bc	\N	reset-credentials-choose-user	easybackend	de1df936-ab14-41af-8798-3e9b7d3ea2fb	0	10	f	\N	\N
71493db3-61be-4da8-ae18-4f149e9b87d9	\N	reset-credential-email	easybackend	de1df936-ab14-41af-8798-3e9b7d3ea2fb	0	20	f	\N	\N
15236e4b-cc74-4965-a548-04f86cc71ead	\N	reset-password	easybackend	de1df936-ab14-41af-8798-3e9b7d3ea2fb	0	30	f	\N	\N
4d26617a-ba6d-488d-acf4-b125226fa6b2	\N	\N	easybackend	de1df936-ab14-41af-8798-3e9b7d3ea2fb	1	40	t	7484cb70-28e8-4626-8b26-3965f07fa9a7	\N
6f7df524-f2ff-4734-97f7-85680f0b701d	\N	http-basic-authenticator	easybackend	d73d1c17-0d89-43f2-ac0f-d1acfbbb1a5b	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
7f229f96-c54a-47fd-8c96-574f5a12d3de	browser	browser based authentication	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
4c44a0ff-ba3d-4fd7-82b3-146c689dcf9c	forms	Username, password, otp and other auth forms.	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
2329f411-9c78-4612-8fa5-a4d31898b9b1	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
20618c14-29d5-4714-a1a4-3a0b48318292	direct grant	OpenID Connect Resource Owner Grant	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
931179fb-04de-40cc-b491-ecc641cab410	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
51440119-960a-4a32-b1b7-fee99be36244	registration	registration flow	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
494c2ba6-8eca-458b-94b3-d392dbd2fdd9	registration form	registration form	afa54666-f1b9-40de-9536-29bb76f3fd42	form-flow	f	t
f4e345d6-6b3b-40e9-a520-2ad726d600f7	reset credentials	Reset credentials for a user if they forgot their password or something	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
70dd24eb-2800-4779-9b3c-a4deb344ed21	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
e271c895-d606-436c-8003-4380af301103	clients	Base authentication for clients	afa54666-f1b9-40de-9536-29bb76f3fd42	client-flow	t	t
f012f9bc-767b-42c5-8077-bd14aa92eca0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
f6e1e9f1-b4a8-4555-a209-5b378203a3f5	User creation or linking	Flow for the existing/non-existing user alternatives	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
ac35f4c6-47bc-414f-8b50-8bf4fc3b430b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
d7524ecb-451f-4170-9bba-ce5e69977edf	Account verification options	Method with which to verity the existing account	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
6ca4524f-f231-462f-9f00-2502ca32df24	Verify Existing Account by Re-authentication	Reauthentication of existing account	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
197c9257-fa2a-482d-997b-a12d3f35f619	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
a0a78cc1-6ea7-438e-987b-19f2943e3db8	saml ecp	SAML ECP Profile Authentication Flow	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
053a930a-5024-4066-8196-b8259c624e8c	docker auth	Used by Docker clients to authenticate against the IDP	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
ec0da042-401d-47fa-a93d-69a53a847261	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	t	t
a8b37d5f-5e3c-403f-9066-150ea13148d7	Authentication Options	Authentication options.	afa54666-f1b9-40de-9536-29bb76f3fd42	basic-flow	f	t
5233e062-9a33-4c0a-8988-b61682a8212f	Account verification options	Method with which to verity the existing account	easybackend	basic-flow	f	t
e958c5c6-5f20-461c-b5cf-3feecf39723a	Authentication Options	Authentication options.	easybackend	basic-flow	f	t
d83f4f2e-f01b-4c9c-ac06-de220bb54375	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
62d2c958-77a1-4c82-a092-df47948bacfe	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
d1eb013b-0d3f-4d7b-9d01-8fb3b9063b0a	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
a26d6419-676d-476e-ae9a-f61027cdc99a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	easybackend	basic-flow	f	t
7484cb70-28e8-4626-8b26-3965f07fa9a7	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	easybackend	basic-flow	f	t
b52391e7-8753-4b14-aa8f-01b02d2a5629	User creation or linking	Flow for the existing/non-existing user alternatives	easybackend	basic-flow	f	t
7e0764f4-b611-432e-a5a8-97556fe2e1e1	Verify Existing Account by Re-authentication	Reauthentication of existing account	easybackend	basic-flow	f	t
0d9f5e77-0339-4d99-b787-d5264b222719	browser	browser based authentication	easybackend	basic-flow	t	t
f29f34ee-5f8b-456a-8578-fc8a49453277	clients	Base authentication for clients	easybackend	client-flow	t	t
9cc13fec-c2fc-4ee9-9cfa-f7a85ac3072e	direct grant	OpenID Connect Resource Owner Grant	easybackend	basic-flow	t	t
e4717031-ae75-4679-a227-c2cf38a590a9	docker auth	Used by Docker clients to authenticate against the IDP	easybackend	basic-flow	t	t
a1b43a35-d294-4e53-9d26-62e0a0a65068	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	easybackend	basic-flow	t	t
1bca5208-e448-4287-8641-9b0e07546e86	forms	Username, password, otp and other auth forms.	easybackend	basic-flow	f	t
11dee0ef-55c3-4cb9-b586-67966b1a4e93	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	easybackend	basic-flow	t	t
67912c08-47f9-430e-819d-f68612305d84	registration	registration flow	easybackend	basic-flow	t	t
c849b9cb-8d7b-4e28-9a75-b7f82924eed4	registration form	registration form	easybackend	form-flow	f	t
de1df936-ab14-41af-8798-3e9b7d3ea2fb	reset credentials	Reset credentials for a user if they forgot their password or something	easybackend	basic-flow	t	t
d73d1c17-0d89-43f2-ac0f-d1acfbbb1a5b	saml ecp	SAML ECP Profile Authentication Flow	easybackend	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
033bb6ff-5ca2-466c-a433-5719752e6287	review profile config	afa54666-f1b9-40de-9536-29bb76f3fd42
42c479bf-ed65-43d3-839a-d00e5cc377ce	create unique user config	afa54666-f1b9-40de-9536-29bb76f3fd42
4b128241-75b4-415a-a7e4-26f3770dea17	create unique user config	easybackend
9bd1fa89-eee9-44dc-8478-f44c067e0e2f	review profile config	easybackend
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
033bb6ff-5ca2-466c-a433-5719752e6287	missing	update.profile.on.first.login
42c479bf-ed65-43d3-839a-d00e5cc377ce	false	require.password.update.after.registration
4b128241-75b4-415a-a7e4-26f3770dea17	false	require.password.update.after.registration
9bd1fa89-eee9-44dc-8478-f44c067e0e2f	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
b70c8f9d-82f3-401a-9005-5a393c1bd232	t	f	master-realm	0	f	\N	\N	t	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f63eb124-b58b-40ee-819e-453e94b161b4	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7a2eab98-0f24-4b45-937c-e478397bd2b9	t	f	broker	0	f	\N	\N	t	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
1979644c-bf75-4f1c-819a-76aa1f290c73	t	f	admin-cli	0	t	\N	\N	f	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
15b2959b-7590-4380-8b13-409c21e10307	t	f	easybackend-realm	0	f	\N	\N	t	\N	f	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	0	f	f	easybackend Realm	f	client-secret	\N	\N	\N	t	f	f	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	t	f	account	0	t	\N	/realms/easybackend/account/	f	\N	f	easybackend	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	t	f	account-console	0	t	\N	/realms/easybackend/account/	f	\N	f	easybackend	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	t	f	admin-cli	0	t	\N	\N	f	\N	f	easybackend	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	t	f	broker	0	f	\N	\N	t	\N	f	easybackend	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	t	t	easy-client	0	t	\N	\N	f	\N	f	easybackend	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	f	realm-management	0	f	\N	\N	t	\N	f	easybackend	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	t	f	security-admin-console	0	t	\N	/admin/easybackend/console/	f	\N	f	easybackend	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	+	post.logout.redirect.uris
f63eb124-b58b-40ee-819e-453e94b161b4	+	post.logout.redirect.uris
f63eb124-b58b-40ee-819e-453e94b161b4	S256	pkce.code.challenge.method
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	+	post.logout.redirect.uris
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	S256	pkce.code.challenge.method
544e5eb0-3d17-4823-a9af-f15e289f63bc	+	post.logout.redirect.uris
4f8b866a-cccf-4fe0-b2fb-72261ea37634	+	post.logout.redirect.uris
4f8b866a-cccf-4fe0-b2fb-72261ea37634	S256	pkce.code.challenge.method
07a3c06c-18cf-4d21-bda1-995c98922c2b	+	post.logout.redirect.uris
2ef67323-2a80-4467-91f7-a5dfc6491cae	+	post.logout.redirect.uris
465801a7-31ff-4a32-8201-2761bb5ab7ea	true	backchannel.logout.session.required
465801a7-31ff-4a32-8201-2761bb5ab7ea	false	backchannel.logout.revoke.offline.tokens
465801a7-31ff-4a32-8201-2761bb5ab7ea	+	post.logout.redirect.uris
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	+	post.logout.redirect.uris
0c1072d0-fbe2-4759-9c08-a399a7faa47b	+	post.logout.redirect.uris
0c1072d0-fbe2-4759-9c08-a399a7faa47b	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
fc4e269d-9da9-48fc-bc13-09a788c394cf	offline_access	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect built-in scope: offline_access	openid-connect
f44d1541-7fca-489c-9d0e-a6d98107dd68	role_list	afa54666-f1b9-40de-9536-29bb76f3fd42	SAML role list	saml
369932d2-b468-4d87-973c-db2efeac294e	profile	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect built-in scope: profile	openid-connect
aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	email	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect built-in scope: email	openid-connect
91630347-a9f2-4acc-aacf-dc3a46c9982b	address	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect built-in scope: address	openid-connect
b0ef0719-1ae9-4089-aa46-9c451c5d84fe	phone	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect built-in scope: phone	openid-connect
c7d4a324-f5e5-4a21-a9e9-04f7146285e1	roles	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect scope for add user roles to the access token	openid-connect
92c4f294-f8b9-4f28-921d-f05a6a1309df	web-origins	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect scope for add allowed web origins to the access token	openid-connect
00e4766f-f244-4410-b5c7-3ac05becf484	microprofile-jwt	afa54666-f1b9-40de-9536-29bb76f3fd42	Microprofile - JWT built-in scope	openid-connect
6a39a1c4-d923-4eac-9cd0-56fd5e809733	acr	afa54666-f1b9-40de-9536-29bb76f3fd42	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
476bbd3c-ef76-44cf-971b-f9d61899128a	acr	easybackend	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
6cb0c8c9-4089-49a0-b39a-43268e5ae246	roles	easybackend	OpenID Connect scope for add user roles to the access token	openid-connect
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	offline_access	easybackend	OpenID Connect built-in scope: offline_access	openid-connect
b0df9abe-928c-45ce-847d-12a7251cee9a	email	easybackend	OpenID Connect built-in scope: email	openid-connect
7209fb8c-3f21-442e-8c71-aa3336dc2f45	phone	easybackend	OpenID Connect built-in scope: phone	openid-connect
240fc8d7-4ea6-4701-9d56-b9cca566061a	web-origins	easybackend	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	microprofile-jwt	easybackend	Microprofile - JWT built-in scope	openid-connect
12ea9885-c85d-4ab3-bbfb-b9c706495db5	role_list	easybackend	SAML role list	saml
fb2df94f-824a-4682-baf9-9da7047671d2	profile	easybackend	OpenID Connect built-in scope: profile	openid-connect
d56a3de7-1416-4106-895d-ee839a2278fd	address	easybackend	OpenID Connect built-in scope: address	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
fc4e269d-9da9-48fc-bc13-09a788c394cf	true	display.on.consent.screen
fc4e269d-9da9-48fc-bc13-09a788c394cf	${offlineAccessScopeConsentText}	consent.screen.text
f44d1541-7fca-489c-9d0e-a6d98107dd68	true	display.on.consent.screen
f44d1541-7fca-489c-9d0e-a6d98107dd68	${samlRoleListScopeConsentText}	consent.screen.text
369932d2-b468-4d87-973c-db2efeac294e	true	display.on.consent.screen
369932d2-b468-4d87-973c-db2efeac294e	${profileScopeConsentText}	consent.screen.text
369932d2-b468-4d87-973c-db2efeac294e	true	include.in.token.scope
aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	true	display.on.consent.screen
aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	${emailScopeConsentText}	consent.screen.text
aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	true	include.in.token.scope
91630347-a9f2-4acc-aacf-dc3a46c9982b	true	display.on.consent.screen
91630347-a9f2-4acc-aacf-dc3a46c9982b	${addressScopeConsentText}	consent.screen.text
91630347-a9f2-4acc-aacf-dc3a46c9982b	true	include.in.token.scope
b0ef0719-1ae9-4089-aa46-9c451c5d84fe	true	display.on.consent.screen
b0ef0719-1ae9-4089-aa46-9c451c5d84fe	${phoneScopeConsentText}	consent.screen.text
b0ef0719-1ae9-4089-aa46-9c451c5d84fe	true	include.in.token.scope
c7d4a324-f5e5-4a21-a9e9-04f7146285e1	true	display.on.consent.screen
c7d4a324-f5e5-4a21-a9e9-04f7146285e1	${rolesScopeConsentText}	consent.screen.text
c7d4a324-f5e5-4a21-a9e9-04f7146285e1	false	include.in.token.scope
92c4f294-f8b9-4f28-921d-f05a6a1309df	false	display.on.consent.screen
92c4f294-f8b9-4f28-921d-f05a6a1309df		consent.screen.text
92c4f294-f8b9-4f28-921d-f05a6a1309df	false	include.in.token.scope
00e4766f-f244-4410-b5c7-3ac05becf484	false	display.on.consent.screen
00e4766f-f244-4410-b5c7-3ac05becf484	true	include.in.token.scope
6a39a1c4-d923-4eac-9cd0-56fd5e809733	false	display.on.consent.screen
6a39a1c4-d923-4eac-9cd0-56fd5e809733	false	include.in.token.scope
476bbd3c-ef76-44cf-971b-f9d61899128a	false	include.in.token.scope
476bbd3c-ef76-44cf-971b-f9d61899128a	false	display.on.consent.screen
6cb0c8c9-4089-49a0-b39a-43268e5ae246	false	include.in.token.scope
6cb0c8c9-4089-49a0-b39a-43268e5ae246	true	display.on.consent.screen
6cb0c8c9-4089-49a0-b39a-43268e5ae246	${rolesScopeConsentText}	consent.screen.text
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	${offlineAccessScopeConsentText}	consent.screen.text
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	true	display.on.consent.screen
b0df9abe-928c-45ce-847d-12a7251cee9a	true	include.in.token.scope
b0df9abe-928c-45ce-847d-12a7251cee9a	true	display.on.consent.screen
b0df9abe-928c-45ce-847d-12a7251cee9a	${emailScopeConsentText}	consent.screen.text
7209fb8c-3f21-442e-8c71-aa3336dc2f45	true	include.in.token.scope
7209fb8c-3f21-442e-8c71-aa3336dc2f45	true	display.on.consent.screen
7209fb8c-3f21-442e-8c71-aa3336dc2f45	${phoneScopeConsentText}	consent.screen.text
240fc8d7-4ea6-4701-9d56-b9cca566061a	false	include.in.token.scope
240fc8d7-4ea6-4701-9d56-b9cca566061a	false	display.on.consent.screen
240fc8d7-4ea6-4701-9d56-b9cca566061a		consent.screen.text
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	true	include.in.token.scope
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	false	display.on.consent.screen
12ea9885-c85d-4ab3-bbfb-b9c706495db5	${samlRoleListScopeConsentText}	consent.screen.text
12ea9885-c85d-4ab3-bbfb-b9c706495db5	true	display.on.consent.screen
fb2df94f-824a-4682-baf9-9da7047671d2	true	include.in.token.scope
fb2df94f-824a-4682-baf9-9da7047671d2	true	display.on.consent.screen
fb2df94f-824a-4682-baf9-9da7047671d2	${profileScopeConsentText}	consent.screen.text
d56a3de7-1416-4106-895d-ee839a2278fd	true	include.in.token.scope
d56a3de7-1416-4106-895d-ee839a2278fd	true	display.on.consent.screen
d56a3de7-1416-4106-895d-ee839a2278fd	${addressScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	369932d2-b468-4d87-973c-db2efeac294e	t
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	00e4766f-f244-4410-b5c7-3ac05becf484	f
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
f63eb124-b58b-40ee-819e-453e94b161b4	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
f63eb124-b58b-40ee-819e-453e94b161b4	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
f63eb124-b58b-40ee-819e-453e94b161b4	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
f63eb124-b58b-40ee-819e-453e94b161b4	369932d2-b468-4d87-973c-db2efeac294e	t
f63eb124-b58b-40ee-819e-453e94b161b4	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
f63eb124-b58b-40ee-819e-453e94b161b4	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
f63eb124-b58b-40ee-819e-453e94b161b4	00e4766f-f244-4410-b5c7-3ac05becf484	f
f63eb124-b58b-40ee-819e-453e94b161b4	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
f63eb124-b58b-40ee-819e-453e94b161b4	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
1979644c-bf75-4f1c-819a-76aa1f290c73	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
1979644c-bf75-4f1c-819a-76aa1f290c73	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
1979644c-bf75-4f1c-819a-76aa1f290c73	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
1979644c-bf75-4f1c-819a-76aa1f290c73	369932d2-b468-4d87-973c-db2efeac294e	t
1979644c-bf75-4f1c-819a-76aa1f290c73	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
1979644c-bf75-4f1c-819a-76aa1f290c73	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
1979644c-bf75-4f1c-819a-76aa1f290c73	00e4766f-f244-4410-b5c7-3ac05becf484	f
1979644c-bf75-4f1c-819a-76aa1f290c73	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
1979644c-bf75-4f1c-819a-76aa1f290c73	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
7a2eab98-0f24-4b45-937c-e478397bd2b9	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
7a2eab98-0f24-4b45-937c-e478397bd2b9	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
7a2eab98-0f24-4b45-937c-e478397bd2b9	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
7a2eab98-0f24-4b45-937c-e478397bd2b9	369932d2-b468-4d87-973c-db2efeac294e	t
7a2eab98-0f24-4b45-937c-e478397bd2b9	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
7a2eab98-0f24-4b45-937c-e478397bd2b9	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
7a2eab98-0f24-4b45-937c-e478397bd2b9	00e4766f-f244-4410-b5c7-3ac05becf484	f
7a2eab98-0f24-4b45-937c-e478397bd2b9	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
7a2eab98-0f24-4b45-937c-e478397bd2b9	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
b70c8f9d-82f3-401a-9005-5a393c1bd232	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
b70c8f9d-82f3-401a-9005-5a393c1bd232	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
b70c8f9d-82f3-401a-9005-5a393c1bd232	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
b70c8f9d-82f3-401a-9005-5a393c1bd232	369932d2-b468-4d87-973c-db2efeac294e	t
b70c8f9d-82f3-401a-9005-5a393c1bd232	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
b70c8f9d-82f3-401a-9005-5a393c1bd232	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
b70c8f9d-82f3-401a-9005-5a393c1bd232	00e4766f-f244-4410-b5c7-3ac05becf484	f
b70c8f9d-82f3-401a-9005-5a393c1bd232	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
b70c8f9d-82f3-401a-9005-5a393c1bd232	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	369932d2-b468-4d87-973c-db2efeac294e	t
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	00e4766f-f244-4410-b5c7-3ac05becf484	f
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	fb2df94f-824a-4682-baf9-9da7047671d2	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	b0df9abe-928c-45ce-847d-12a7251cee9a	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	d56a3de7-1416-4106-895d-ee839a2278fd	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	fb2df94f-824a-4682-baf9-9da7047671d2	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	b0df9abe-928c-45ce-847d-12a7251cee9a	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	d56a3de7-1416-4106-895d-ee839a2278fd	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	fb2df94f-824a-4682-baf9-9da7047671d2	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	b0df9abe-928c-45ce-847d-12a7251cee9a	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	d56a3de7-1416-4106-895d-ee839a2278fd	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	fb2df94f-824a-4682-baf9-9da7047671d2	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	b0df9abe-928c-45ce-847d-12a7251cee9a	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	d56a3de7-1416-4106-895d-ee839a2278fd	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	fb2df94f-824a-4682-baf9-9da7047671d2	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	b0df9abe-928c-45ce-847d-12a7251cee9a	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	d56a3de7-1416-4106-895d-ee839a2278fd	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	fb2df94f-824a-4682-baf9-9da7047671d2	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	b0df9abe-928c-45ce-847d-12a7251cee9a	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	d56a3de7-1416-4106-895d-ee839a2278fd	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	fb2df94f-824a-4682-baf9-9da7047671d2	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	b0df9abe-928c-45ce-847d-12a7251cee9a	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	d56a3de7-1416-4106-895d-ee839a2278fd	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
fc4e269d-9da9-48fc-bc13-09a788c394cf	9956840c-a772-452e-8302-56028cd98a00
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	678f24aa-3aba-4eb0-973f-d309185f17e6
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7fe5fae2-167b-4388-898c-93ef6f47ec09	Trusted Hosts	afa54666-f1b9-40de-9536-29bb76f3fd42	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
21d479cb-0e11-470b-b915-581cb2fd2226	Consent Required	afa54666-f1b9-40de-9536-29bb76f3fd42	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
7317d83f-90f1-4754-89a1-d56761565f58	Full Scope Disabled	afa54666-f1b9-40de-9536-29bb76f3fd42	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
99bd9dc3-5477-4f67-875f-64a0c47820e6	Max Clients Limit	afa54666-f1b9-40de-9536-29bb76f3fd42	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	Allowed Protocol Mapper Types	afa54666-f1b9-40de-9536-29bb76f3fd42	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
41d0607e-8c7c-4a0e-8edf-b26d9ac92187	Allowed Client Scopes	afa54666-f1b9-40de-9536-29bb76f3fd42	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	anonymous
4e30ce60-d87e-4214-97b9-f70f0953b079	Allowed Protocol Mapper Types	afa54666-f1b9-40de-9536-29bb76f3fd42	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	authenticated
30248ff7-b7af-4850-aa3f-ebb6a431dd1d	Allowed Client Scopes	afa54666-f1b9-40de-9536-29bb76f3fd42	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	authenticated
542763bd-036b-4cc5-8911-447bfa0b1c6e	rsa-generated	afa54666-f1b9-40de-9536-29bb76f3fd42	rsa-generated	org.keycloak.keys.KeyProvider	afa54666-f1b9-40de-9536-29bb76f3fd42	\N
aed1a3d1-bd3e-43a4-8177-ecc4348044b1	rsa-enc-generated	afa54666-f1b9-40de-9536-29bb76f3fd42	rsa-enc-generated	org.keycloak.keys.KeyProvider	afa54666-f1b9-40de-9536-29bb76f3fd42	\N
eeeaa075-a5b5-48b4-8240-48c46df0bece	hmac-generated	afa54666-f1b9-40de-9536-29bb76f3fd42	hmac-generated	org.keycloak.keys.KeyProvider	afa54666-f1b9-40de-9536-29bb76f3fd42	\N
d3d5e991-d861-4892-8b62-1f1662cb37ba	aes-generated	afa54666-f1b9-40de-9536-29bb76f3fd42	aes-generated	org.keycloak.keys.KeyProvider	afa54666-f1b9-40de-9536-29bb76f3fd42	\N
84848ca9-be49-4b20-a666-aff5b11216fa	Allowed Protocol Mapper Types	easybackend	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
d8557e95-7de5-4ea3-afde-3d8964bb3bdc	Full Scope Disabled	easybackend	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
b28839bf-6efa-4442-9be5-7379be25cda9	Allowed Client Scopes	easybackend	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	Trusted Hosts	easybackend	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
02814cda-c71d-45a7-99c5-beded15d4359	Allowed Protocol Mapper Types	easybackend	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	authenticated
36e9f968-e081-44ec-b4c8-b1b05aa09070	Max Clients Limit	easybackend	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
5da1f15d-ab9f-4dfc-8d4b-a7789f540d3d	Consent Required	easybackend	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
adc1273e-e6ff-49ca-95f8-0a8bf03dd6cf	Allowed Client Scopes	easybackend	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	authenticated
03ed8280-7c45-44ca-83f6-363589c55b82	rsa-enc-generated	easybackend	rsa-enc-generated	org.keycloak.keys.KeyProvider	easybackend	\N
8cd8c284-c649-4903-b41e-d6ebf8d8351e	rsa-generated	easybackend	rsa-generated	org.keycloak.keys.KeyProvider	easybackend	\N
2330b1b1-7bfc-402f-ac7c-282e7132f7eb	aes-generated	easybackend	aes-generated	org.keycloak.keys.KeyProvider	easybackend	\N
71ead344-21fd-4681-aba7-b18011f01638	hmac-generated	easybackend	hmac-generated	org.keycloak.keys.KeyProvider	easybackend	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
8b922e70-fec7-4fe7-a0f3-7cef3bfedf37	30248ff7-b7af-4850-aa3f-ebb6a431dd1d	allow-default-scopes	true
b4d3d397-c778-4e05-9b45-8adefbb05562	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ff09f68e-616f-476a-9c19-38b22d1b0d9e	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3e37de41-c54b-4b1d-bf07-8703ce28714c	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	oidc-full-name-mapper
daa38673-9a66-443e-8a15-df1ff1436c89	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
143ddb71-9189-419c-b448-42832ca7c878	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	saml-user-property-mapper
5a8c98f7-8dd8-494b-9940-6a15fd514797	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	saml-user-attribute-mapper
58b5f91c-7b44-4f65-b8a6-f0e8441d96db	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	saml-role-list-mapper
bba61648-f850-4a54-9305-7baf66ec1e03	4e30ce60-d87e-4214-97b9-f70f0953b079	allowed-protocol-mapper-types	oidc-address-mapper
da5f7c93-884e-4cf0-afe6-ef52f9239df9	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	saml-user-property-mapper
c29fecbd-a430-465f-8ebc-df06f5c16b4a	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	saml-user-attribute-mapper
d4cb5d37-050c-4c36-8dae-a2ac778a0c64	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	oidc-full-name-mapper
7156ef33-2161-44f9-895d-1a963194587a	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bd40c9d5-aeac-4768-a760-6199e3d17efb	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	oidc-address-mapper
bc689f4d-a821-4fca-87aa-4a92ff614dee	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e98fd712-62b9-4758-9547-02182081bc6d	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f8567cb0-7ed7-412f-a72e-7129984094e4	f3e5e7d3-e382-4c95-b575-0e5179d7e5b4	allowed-protocol-mapper-types	saml-role-list-mapper
b42fdd97-282f-4ada-973c-38e05c0aea05	41d0607e-8c7c-4a0e-8edf-b26d9ac92187	allow-default-scopes	true
ad1f0f99-b167-45e5-b25f-2db9dff74396	7fe5fae2-167b-4388-898c-93ef6f47ec09	client-uris-must-match	true
4470d71c-3c4c-4b98-8a61-d840be7dca5c	7fe5fae2-167b-4388-898c-93ef6f47ec09	host-sending-registration-request-must-match	true
4784cfbc-b4fa-4c7d-9adb-d4d792dfee26	99bd9dc3-5477-4f67-875f-64a0c47820e6	max-clients	200
4c304e76-56fb-46fc-b1c2-d0fc216e8b80	d3d5e991-d861-4892-8b62-1f1662cb37ba	kid	9b9f5957-d4b3-46a3-9053-18e80da013cd
a71d2172-76be-44cd-acb4-9752720d3bcd	d3d5e991-d861-4892-8b62-1f1662cb37ba	secret	6GnUpL5sOUg2LCsWeWf4Yg
509775f6-59a6-4598-9e2a-11a2ebdf08d9	d3d5e991-d861-4892-8b62-1f1662cb37ba	priority	100
38ba64fb-d0e0-41b7-a454-80f88d5645da	aed1a3d1-bd3e-43a4-8177-ecc4348044b1	privateKey	MIIEpAIBAAKCAQEAsAzs8Wak0mhPZV4/C0IH8Rwv7rD7+kWAq1Y4kvMkSfLFAkXECOhj/Cd3KR+BnWaH2pqmjgLkpbrOGnpJ9v8RO/syF7D1b26JuAWLFQFgiq0hXkf8uWppMS/Yd+NQiDhORzQqGEBemjL5HZ8ZjouDu5kCENQCsj3WZlDzL0MtHP1WS4oBjTdy5rkWi23XOLhnNpyMy5ENrkiVuAw9oVKXgkUe4qQzIh+g2y3y/WLaPeI0tVjWT5nj85AaDu9Zv/2KrI43WKyy/GQZkEFlNouu5a3RPXOwvs09o+HekOxkU21Z5GKAHb4fyTHGL7vknvMxpLXeXEt8NR8vz5/T2/dFKwIDAQABAoIBABOyHoATX7U6fkd099CmnoTXBnXJzyb8x5xjlQi7sv+i7W+HpprohOcc8zPilnmpkuFeE+wnXrU75PsJW2UKvD7dp4kG/y5sS3QPCrRa5xYcsHL/0sJbqVEbbThcchILWpaUu3DjIrJVqZEqz40nBqHiSFzhmzudt3LS86IB/fYUIgM0IuVRxuo5Tgb4/PVO003A+HEM/DrLxjBbblYWcU4hw5f6p09Z2TPlKWyiKhudSIN0CsQ0Vdw+GFTD+uRlGpAgkXSrEsk7E/3/UkHZItLGbUQxE9IfZHDN1YbfnG3Bi4ODpVNKDfTGltv6eUs6W6MJPTZtg+yTaMaufamZJ2ECgYEA5TOBk7jMQ3HT7DZodI52bNWSIANsr1QBRKpbz/u+8IfWnQ8YUdzndrtRnhw40npMhnSmpB2tNeLgxCMyyCKGAeQZWanpk9b4PttWMAMsGm6lxZaVDvzs1d2BJxN1C+O57ahZ1L2yKgXv7zvQd2VYJYvtu4cTVWHcc/Kz5lQyBF8CgYEAxKKAmsABLIYQ3uezREc+vpVngK7QP1r6DJ1YNSuf9rR+XkqZc7ShB/xxlXryNaaOae6x+pndPrwNKxWfz3jgLWa5PrRUh1K/DM7HuY8m/lTpCgYtQtC1TNA24GLkBtN9eBGbJTKJ5DTIfICDMc8yD63o8qlFMp+b7jU2oodkkrUCgYBIYTOSStF2mwOpnKTv6e1MAUXcBjjURVsBLCtCSuXJX5xOjO3JLFGMFSt5GsB291gjPcNCIH0Kf1MrnVH0EbLv9fBreFTi8wgCEZHuJ5JN5pNDCoKX8Rd5kjGu/V4BGzEj8/4qSJ1y190lV2ZFziM/+ChjCAz68aSEmShmnEAPUQKBgQC4SEOWxFNVUuAEx8kuOEcJfiPeafcpKS4nHF9KlXP5VfcIj4l48tPoFCKvIOZWeZ4GkXmjjwfWf48nzcBURMh0RE1gAskledsrOa/cq9iziwhMKLXKZKdFMe38JTHnY9W27WklV1P716v9YsORrskQAMDMiu8bHpKYkK5/a7xJ8QKBgQC1klN43EWFgqEl/3gwXM3E/3BFCs+piv7wBr2TPXyddAzEdb2si6sRoi+f2A+DSmoQ8TD/9K4cQpWsNH1JHaiISwS4Jp69V1s4PlQKfE8hNgxjbcS0GZKzY7MH3DW/eSVUd/u86O9ic2B2ijPXGfIELZs2rfh3VPVEDr6IiUw3hA==
71f68450-fdbe-45fd-b6a2-6389351b0606	aed1a3d1-bd3e-43a4-8177-ecc4348044b1	certificate	MIICmzCCAYMCBgGEmxH7OjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTIxMTY0MDU3WhcNMzIxMTIxMTY0MjM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwDOzxZqTSaE9lXj8LQgfxHC/usPv6RYCrVjiS8yRJ8sUCRcQI6GP8J3cpH4GdZofamqaOAuSlus4aekn2/xE7+zIXsPVvbom4BYsVAWCKrSFeR/y5amkxL9h341CIOE5HNCoYQF6aMvkdnxmOi4O7mQIQ1AKyPdZmUPMvQy0c/VZLigGNN3LmuRaLbdc4uGc2nIzLkQ2uSJW4DD2hUpeCRR7ipDMiH6DbLfL9Yto94jS1WNZPmePzkBoO71m//YqsjjdYrLL8ZBmQQWU2i67lrdE9c7C+zT2j4d6Q7GRTbVnkYoAdvh/JMcYvu+Se8zGktd5cS3w1Hy/Pn9Pb90UrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF5BPu3ZuUvP9t0a/3danPakR9rxarew4VGDyz5cpJFAYYNSToPaHTusjW4sSvhqlAbju4n+q5yP1+elOhPGyBlm8QYCUJZc30Db2usrVDntv1ByIqJM2EdM+w78tFJWUNH5lIYl4+wxZV8GlqeB/9pNbR07CuCgu+BrmnuJY1dMp0TpmtWf3jETxqKKGGdNG2qhS6rqjA/BvErST4YBJwBL3AdumYC9nac5KNjWyJ8NgPRbBCJi8eySLLtfu/Nb9FAI+clHhp2UfIRnYWVLNwt/Mg88nlP3ScML7H9gGMz5j9LKr+ZAUpalzrWN75qXG1vfjG+QcgIhb7tubGln1Pc=
6cb71e84-a5c1-473d-af32-4839d3405be9	aed1a3d1-bd3e-43a4-8177-ecc4348044b1	priority	100
f727636e-045d-4f7b-a442-c28195c92310	aed1a3d1-bd3e-43a4-8177-ecc4348044b1	keyUse	ENC
2946497a-0374-4923-ac2f-9e7872d3a5ce	aed1a3d1-bd3e-43a4-8177-ecc4348044b1	algorithm	RSA-OAEP
353e447e-65d2-4b7d-8335-d7bde6cd55e9	542763bd-036b-4cc5-8911-447bfa0b1c6e	certificate	MIICmzCCAYMCBgGEmxH5+zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTIxMTY0MDU3WhcNMzIxMTIxMTY0MjM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCjuuJ2PymrZtQRiyGmRMIy5vcNi2sDddgyqn8+4J5ZqDvCqBo4AoG7faXnSoBcEhaEmnVnQNu0eOn+XS++y6nPbS3Vtm10fc4z+5bIb7JBSg1M9eHqTTptLwiqkTjdpWC55wO6kq9huX9lcS1KauuLcOaeBe7YaaidJ6oA8bKw8e2B+K4V2n3iGboLYwh26+3G7s4ne5x0d+iUaT6FGq8NCy6gBUZ+A9B4hqivcgJBNqkQJDChsGAqFyPVXnI6KxStDXphfuoMj/Q1mgjr5gW4a9yvNzF2tfuzC7JtZH1V9mlza3YMzqVp9aVu36Q+aG917x+xQnwIsxa+8+GZ3+ynAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKCyftC/gNIb3yXdFgRntJgXsg2a3b+76mGfob+ynsBHTPMkYYtRqwMdqyRamqw/SHAeChmv9eP/2//PjR5H9TlOq/IGBdDhdhYDQrRG4KYJbbzjbLSGVepnIUeS6Y3aj81tgAn1K5QUIEQorc35KKQoQ6G9nMYahxSeFIs3+S3rpQhjBPiXJOu/3KXRuGMX2FAKVbwrOUOOdzHjRlq3Mt16nGx1iOENGfOTyhRtUqPK9iNKSFqgeHuIhxFgAEcMVHvTf8tZyRbArshZRb/rNai2+2CihZvoG9cOT6TJyw/eozUvYoEBgrzpky19MTAu4UfqQRymGhhRV9yG8Xd823c=
35de04db-cfea-436d-9507-6e19b2b4e093	542763bd-036b-4cc5-8911-447bfa0b1c6e	priority	100
fbdcbf3d-bb6e-4d4b-94d8-b0dddfb165cc	542763bd-036b-4cc5-8911-447bfa0b1c6e	keyUse	SIG
eee1d646-1c73-472a-8a3c-d6d0a6f5f474	542763bd-036b-4cc5-8911-447bfa0b1c6e	privateKey	MIIEogIBAAKCAQEAo7ridj8pq2bUEYshpkTCMub3DYtrA3XYMqp/PuCeWag7wqgaOAKBu32l50qAXBIWhJp1Z0DbtHjp/l0vvsupz20t1bZtdH3OM/uWyG+yQUoNTPXh6k06bS8IqpE43aVguecDupKvYbl/ZXEtSmrri3DmngXu2GmonSeqAPGysPHtgfiuFdp94hm6C2MIduvtxu7OJ3ucdHfolGk+hRqvDQsuoAVGfgPQeIaor3ICQTapECQwobBgKhcj1V5yOisUrQ16YX7qDI/0NZoI6+YFuGvcrzcxdrX7swuybWR9VfZpc2t2DM6lafWlbt+kPmhvde8fsUJ8CLMWvvPhmd/spwIDAQABAoIBAAEimDG8Q2T8v1lBcn0ttpDqRDASwSfWt7v0uk/ljiMa5RJ9LGgwzsuMJZVCzkMD+woVVpi+itV0Fxqhv5dPaVX0Z2itrtZ80kOHBelzQBzosZJ5Y2XZdNSC2969/GwjaKESflaKDEuGGrWwoQ/gs8spuFGLz1/XHp3Umu8ONI91uehAIcLzwuKhIk+UlvSRKbDVewidoHb+wwo2EBJli8SIbrhSxKLsQPk07jvagDQpfjHAR5oTw+xhKfURWtnOvScbhFkyIyDOLJLZdjguR+a6cRoseeWvgnYX5FJndDRBrB3xeV+zIqDi02xqOn7l89ktEVWaFAtYKxr5nzvnDekCgYEA4SkWpKQHfmgL6sddPVlk3N715qSnRpZN5Tss6+qAuW+9GCxpVMAtmJF4rIdR07PryZd5grncrlPln27xNeSj2bhEZzChjl3gscjsw5wSwpIe9WbV7l7S83W5ByCgg7kjYTK6OfwQeV5rHItlMNHKZoxyTBmbSN3hNtpd0lCHkfUCgYEAuifUVE4TQ8Y6ktMF6uUQU8NLY8tmYaNKDa8bStQC0IkIXo5dW74v7f/mNvhz+dJFBi66i3yjcjZFCJBevhO+Jukjv78KcRjnrUFiHjmK2cHG0mfFRxjofMoW6yS1ztF1CFT1ZR/xenx6Z+VPSFciJGRxiBZpG0579BTgx+rQ9qsCgYAnq9Ckg44adISdAjFobMa7r8ENuTcL1dG1sN5yVqgFhC2CA9kvKIkgF4l2hIUjUtEZfMnZAZxjTr7nf2magEVqR/AtakEcz2eWi3tD38ziYVJ5FHxe+nAam0RVgCcn7kfQiVqMeuAAMmWW6uySVHRf6yD8TYqxpP5YZtMfCjdIvQKBgDxrZwAB40DRGvvCoB4QQM9fCJ4YS1+PVx6/4dTUoSE8CMpf3K9FOFs//mGDHGlONPb/va4+QvJz6M4RxZ5d3A7XBrJaeDIjCjbyjL0Qoh9xRG3QHnin/fVaxjuFy7iXxStyH7+1sXO26SfFhokNNtim/S5VT8H8JEEhcZ+ReEdHAoGAJ7RPfZ4U0BoSU+U1xHj7HMkgKlojP5tCX7m3Z1JfE6sT2zUB3sINKKZRrnh0TE7V98soGhK+SL8WH7wWZX3Or2NI66997dS7PYVj2aw6XQYKqJImN42GcehKT+Oa/U6KKj8E3aZirKh+wX4q8BptYZ31/gLdHVLYXi4LYIsWTic=
c1ce5908-823f-418f-a96b-76291cab0e25	eeeaa075-a5b5-48b4-8240-48c46df0bece	secret	H0xzRVDPRx-sXPwHvhPQqg4N2r1n5Toqi2tj5KaJUAFu1_WYE8VNu5LE5rRikDGuCHdHZ1UdEdBG4CVGtJyeAQ
deef077b-551f-44b7-8005-2d9c9a6b4f36	eeeaa075-a5b5-48b4-8240-48c46df0bece	priority	100
6f5c18b9-8204-4470-9c17-02aa3d20e2a0	eeeaa075-a5b5-48b4-8240-48c46df0bece	algorithm	HS256
e12ef972-7fdc-44b1-b93d-224bf31e3e28	eeeaa075-a5b5-48b4-8240-48c46df0bece	kid	e24d8813-5a7b-447c-8710-ecb691d29f1b
51ff62ca-7e98-4bba-98f5-5f88f74f02c4	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7a9e5aee-6c81-4e64-9b9a-1b880bc35fc4	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d843495a-c16e-4757-972a-7e61e144703c	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-user-property-mapper
f6e421dc-4d93-4331-bf8d-af84e2d7c918	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-role-list-mapper
bcd0f62a-8bee-4cb7-8688-5cec4abc046d	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-user-attribute-mapper
e642a66f-9576-4727-b723-46bb38f47fd5	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8bf30b47-197f-4f75-aa80-9635ca645845	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-full-name-mapper
5adc0165-0784-4ae3-aa51-075a2e290fee	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-address-mapper
c60656b8-0206-401f-b3e4-2e04df1db17c	03ed8280-7c45-44ca-83f6-363589c55b82	algorithm	RSA-OAEP
58494ea4-de7c-4647-a769-6c2b924ae6fc	03ed8280-7c45-44ca-83f6-363589c55b82	priority	100
65500b5d-ebfc-402b-8ca2-10836c4ebdb8	03ed8280-7c45-44ca-83f6-363589c55b82	certificate	MIICpTCCAY0CBgGEmxIG6TANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtlYXN5YmFja2VuZDAeFw0yMjExMjExNjQxMDBaFw0zMjExMjExNjQyNDBaMBYxFDASBgNVBAMMC2Vhc3liYWNrZW5kMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuEgvz5tHek7j9tCOXyP+ujk9GEmQm+KWliLJHBSChfzYfAZbTn6yVbDfqIvPGr2QEJx/VtJ9ml7kGGCzl3xXmEtaU1GkfvD8x731+HsEdAfpK69fNmwXTGf2TxdZJXGFT9ve3vvjKusgTxIGaiby6e+U0sTH18gPqSTzDlFsa0MABinzSgPZxhlXR/jt6q3PNh6IpKms8TPw7bO6Ang9v4h/JGt8RxLp+4DbWhdTJhGmG8IgZaSUDx2nTpy0VdmgnpV06SGbMfjBODav7obJC9b5flBjw5fLbsG4kOypOBQTwUpyCbeL1o60WI0OeMxxZsrkSminWwk05aSGMW4h5wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCjVGPIkhV0sJDeJCXW2I+w91VCcJ3umES7GWn9Uo+9+BxbfoorPAv7Ak5rwpnDK0YA+qB9HQbGCDCrAAacwbt1twxIl6thHoonDnz/wcf5bT/0zgTRXhDLaoVro/DfPsoFzj8ZpIHUkdZwO78JZOVA56Y3m9EZgKaRwl+THtXIubEWeJfNwUNS2fxWJAEF/4Kq7+GZOGFQVspgwFth+mPXQg2lGcHhKE8hMgL8oTMdMHGLywWrPXUsuOc9tFNfsVEuIml6N9ChvNhioyc2reiHmzlA/l4Avns4qhD/vF4dHljPZ4glRZEmuTQLb8fjxAp/Xi2F0j+Do/gdAiepOgNc
afec7e27-548c-4f93-8700-10087b412438	03ed8280-7c45-44ca-83f6-363589c55b82	privateKey	MIIEpAIBAAKCAQEAuEgvz5tHek7j9tCOXyP+ujk9GEmQm+KWliLJHBSChfzYfAZbTn6yVbDfqIvPGr2QEJx/VtJ9ml7kGGCzl3xXmEtaU1GkfvD8x731+HsEdAfpK69fNmwXTGf2TxdZJXGFT9ve3vvjKusgTxIGaiby6e+U0sTH18gPqSTzDlFsa0MABinzSgPZxhlXR/jt6q3PNh6IpKms8TPw7bO6Ang9v4h/JGt8RxLp+4DbWhdTJhGmG8IgZaSUDx2nTpy0VdmgnpV06SGbMfjBODav7obJC9b5flBjw5fLbsG4kOypOBQTwUpyCbeL1o60WI0OeMxxZsrkSminWwk05aSGMW4h5wIDAQABAoIBAFmIFNaAIieNqZrR88HMiqcuRP0GTMA3w6K4zs2aN1nioMkNC5Jk4r7YOqm4F0xuGc7AQevMQ2LbRGWFoetw6VvgDEfbrBhSe/WNWLI7DkxTRZlIUHFv7ZfdEKGXfeO/th24/JyIc3N4Hc/cuYocVzuJ/1uxaEhxdg5fGcl0jMDFTttOrnNJmaTHQbbySeTWO4bQUZN9CHCoP5VrenryilJiOlyVTgM8nnvYNc+lJGz8oFyZA30xmoJ/6YqD0B1YEFkW0vJ6SVLyPOOVz6l0gfUPQ+F5NKulXK3dTVxXRJZQMTnm72X1uoAUswtlDt7l4wFbZ6kQxKUBqjgTp+EqLDkCgYEA34lBJpTjcYGJQfZpJglPNpt9xeureMkrcUgaPuI/2iy66vXJ1v16w+vCe+YESQQuHW4UyWc1vtnRMRXtegby7JHlEf6e8/Xegpd5COR7uN0Agg56z6PR+55mLxRxBnOPJXSmU3Q95+KlGXBd1eqr+hMBV6ovqlA2OQpQBVsu++8CgYEA0wuFF7ShuGuZIu7OLVQ5mMbJCcxmneLHS7LXTlCqYxNY7GU1y5oki/UqZecYlzbs3JIe6cisF7HcM7HE6Sqgf/b4rKYvFhj1d3Xo5OCYY2nMQIqUMxf6QzozhyAW4t7aLvgN30b1cyrJ138IEVDiLSnnO67Cd8/gOFDw+byooYkCgYEAz/j1Qp4Xlk08lMBbR+Y1asr0E6aWHISeBIFe2c7KNYSUS3JuXbXr+Ehq47c3mW9oMD1w3YlG+c/Rz2dlULkSXoPGqh1JahUA9mNTWrCpY29Kv7YVEQaLoRzYWUkddzEgp2qGLPLjfdDiZm6i/xmc88em4hcWzdBfAmbT2IfjiMUCgYA00YNDxY9b6oHu/jlXmua3V7jk3OUpyqH6Tg4YqZObLDJrJ4FpLXDMHlW4HzhGUBbDtUZLWE/JtlfYEDup52M344WlIApUy3ZTqYzaC2PYLZhS5tvkVbHqtVxEC0HvEbslWiuOn+G6KxFM/5vzSXzxtLUMeNZuyfXh4lANEKxbkQKBgQCQLzXZFz9EKhaJTQGTTiYJGHKrs8tRVaWcpGTCv9NWtBCOfn0WdOb0qsaTRre/V0gKQbwCmY2tyw5h3O85q/0tIFWpQMeM17bt3MKx5RkWf+fARvmr3Q5VNJCRfP/S0KniUl/Ev/ddOTNB7hhaHC2qvGa3qoUul4QJMf+OR8lnmg==
b440f61f-45db-4e2a-98e0-dbb7b17a6bca	8cd8c284-c649-4903-b41e-d6ebf8d8351e	priority	100
b588b997-feca-4a40-9a6f-ce00895901f5	8cd8c284-c649-4903-b41e-d6ebf8d8351e	privateKey	MIIEpAIBAAKCAQEAq2p967gqsqS01x6kYQFC96OCrXzRNCoLEOroVjXgU4rukt4jV9fYrHv8/EZ9eABzEqjWd7Vhx3PSAJ7Q0cKWHPFI1xVMauWJWwndElgmFmd3U1RN5KrUn4ZbFQqkNIYL2ItrAL49uvVYfSSnY+22vpGu2Agw94i/1LrpEU3/71n75YTjnGQiJF8Lg+JR7oDbjuDZZOogfubAhWyNWdHgUIous4RsOwZFSaLEI5PYC11EfRY3j+jLCFK4ncQ5Vg48Y8ZRj/pAzrBxrMdjt3I0cusM1HTQjc0he263ESrT6Y1OiwoDnSU2ctIIqPnqa9gN3skotfoapV79iHKCkAqiawIDAQABAoIBABklYB+KPslCHD1Kg3avhrFpTSxCGTZ7zG/I5hhvgt7+jI0DBVBHm8OB1NT1SkamWjsshXm+I//sX6wzoBKFZxwL0VGsEC/GSGYQhlvAjqXOu9R/k4WuAc79GLN3gisqVuaHXUUYo1mf0EFbdSrVnm9KU8nhOb22U93TJYmiVZ846KAKFESNxPaRibtOJG2F9fQvtWBlyQ8TkIQW/13Rrb4cg4VxDxy7kTTWEnWxL4I1oZUzgWuwRM92cswus/8g02dn4bWeW/yKyllDvAYqNyN/hSk6t0/Qc+BitpMSjxQwgzF/CcGj6cjK30W2LnzgaAd800xHCPbKkHAraeCJ5ZECgYEA1Y9eTktZE4Fbu23o7ENiUclzz9tvI9dC1w+zL7jqH1LeTjUprxQI5EeWPkn2b2ygQPnMISXD1zqe4I+6GkJmht4fcA8B+Er8lgXjga7LaT+VuARr0uIFOgiymksK4vpXhq/3eDCCyx4Dmebp6DgWxtXDyczskLWvfEUqmoF0p08CgYEAzXsXZbBsUJyOP7bBpUO9XEl0qhmc0Znv3Yov7WWoO0WBp6vEHfoGHU8urbELIvpOx68/5i+7LF5CFTqTFxfJgyLUELOdOgFCPW2IFtAWb6liM51JJkp9MdLzvS+Kcs4Yj0xJryQORv37bpUuu1gNMiluURZ4mlf5BK2i606NTCUCgYEAofkNA8DuHHceRffEk31AEtwB9IJvtvVLAqYrt2Q+XeeSKCr2JI3DeLA66Z9bQ4NVwDI1emaUNKeHXLZl5gi6jkvl+C3JxrHJBVgOB4u1R2wsd9cSmG1InY1/OLr11NUekU7hGM1iRf/Lp2yVt8TisYfr6SB9w/uoz03+VBUfjs0CgYA0INAUuicgZDcqLsD9nivB59iy9oB0JCtX9qCmBy4gq0dzM/4y5KT8doQPCGUc4Idv3SPGz8EaRmdZX1zFdQFoRUOrYQW4G22ki88EipHGjiAdm/9cuXT9WNkA27ix21sbr2zaA7mjhPduXGZYnMPsP9p+s8aw0TSZXTuBmpH6CQKBgQCmtUYoFSMyq22lrPSZPSEZNzvS1wx8zcvm8vwasR4eGehU5djTHDh26O+WPN2OicCBtdp1nnS1eZ82ETqlEL4joXxnbH2iK0/B8Qd+nw+XqQw12Dx3I60Ly2GkdCkbmuPmjS8/a4z+gRr0wjQi26SVKQId92X1psjAon87QiIMVw==
0c2be089-c64d-44db-9d76-cd246437686b	8cd8c284-c649-4903-b41e-d6ebf8d8351e	certificate	MIICpTCCAY0CBgGEmxIHqTANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtlYXN5YmFja2VuZDAeFw0yMjExMjExNjQxMDBaFw0zMjExMjExNjQyNDBaMBYxFDASBgNVBAMMC2Vhc3liYWNrZW5kMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq2p967gqsqS01x6kYQFC96OCrXzRNCoLEOroVjXgU4rukt4jV9fYrHv8/EZ9eABzEqjWd7Vhx3PSAJ7Q0cKWHPFI1xVMauWJWwndElgmFmd3U1RN5KrUn4ZbFQqkNIYL2ItrAL49uvVYfSSnY+22vpGu2Agw94i/1LrpEU3/71n75YTjnGQiJF8Lg+JR7oDbjuDZZOogfubAhWyNWdHgUIous4RsOwZFSaLEI5PYC11EfRY3j+jLCFK4ncQ5Vg48Y8ZRj/pAzrBxrMdjt3I0cusM1HTQjc0he263ESrT6Y1OiwoDnSU2ctIIqPnqa9gN3skotfoapV79iHKCkAqiawIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBBDJ1OOggnSRxQgYd3q55Nr5BGXDxwhqufcSwhsY1yEofop9kwstLnYCzN0xiH0by+XwXhaLlyHOTubppW36h7MN3IKRp/oXA230omOqWiptEQIBcP+TcmFwfZGWlVXEfvHvpHOSMoXM2+2Kt6l7/WMnbd1kqp/ou6E2iVrbYkrEKFyAD1NSxv/D5bYN4NBg3vUTfGj+2egAyY0IdeQR+urfZAho8Jfqkby8p9xwA5ZM5TszGI+EsxaZZMaoG8SoA9GGj4jA+LOSjZsV/zo0w0Qe4NAGj4PCEiZT4vDAlpo62P22qF472pMvBZIPgHWJihEY0RUbZEs1maWSO5aedr
f34c3611-232c-4ccc-a827-fc2427d4e7aa	b28839bf-6efa-4442-9be5-7379be25cda9	allow-default-scopes	true
8476be34-7127-4dd0-824b-93b2c3da1669	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	priority	100
c0ffc244-12b1-46b3-8e8d-a66c6fe8c3a8	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	kid	c21c414b-216e-4049-98ba-66bf51eef02b
86ea93dc-fb5b-4541-980c-b3c95c67e84b	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	secret	EGNLaWRykPHEsn-sAg-k6A
e0260b07-6918-447d-a9c6-8a4824f297e1	8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	client-uris-must-match	true
dd594b75-d89f-444e-a99a-0750f1ab823d	8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	host-sending-registration-request-must-match	true
c623b3df-f8a5-448a-af9f-8240b490f27d	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-role-list-mapper
65e3c1de-9991-4a64-b71f-8403c0d459c0	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-user-property-mapper
142aab24-0245-4c32-9033-33e86ba91217	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c0818c2c-93ab-497f-a1c3-6045a997dc30	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-full-name-mapper
304f6a40-c3f2-4831-975f-aaf9edbd73a0	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
64d811d4-4d9a-43cd-ba61-8107cda10955	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-user-attribute-mapper
8056c60a-ea86-4208-b90a-f3176a3bc72c	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d31999fa-3a33-46ea-beba-ce49174dfd96	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-address-mapper
8f531ef9-a8d0-4ecd-b704-780392d9d619	71ead344-21fd-4681-aba7-b18011f01638	kid	50d5fc23-c878-45a3-8bd3-5279cd2dc874
ec06c225-8408-445e-aaf2-c9277110a71d	71ead344-21fd-4681-aba7-b18011f01638	priority	100
12150020-0210-4a73-a3ab-6ac83429323d	71ead344-21fd-4681-aba7-b18011f01638	secret	vMd0z55c64M53ANZazgokGzYQyf2WXaoHh0yj08vMfGm6gq63CuDUKL29Qwc65kd4gdQFqUn-bpUVH46ELqD7w
c51ec84d-af6e-41fd-84ef-9a5911730728	71ead344-21fd-4681-aba7-b18011f01638	algorithm	HS256
cd8329c0-e6bd-45a2-b8cf-b9afe33b68d1	36e9f968-e081-44ec-b4c8-b1b05aa09070	max-clients	200
929e8162-e940-4cb2-a874-9b34fa5b507b	adc1273e-e6ff-49ca-95f8-0a8bf03dd6cf	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
4a9430bc-1541-49ac-b9ff-1cde6087d429	96aaaee4-f26f-46c4-8f7c-a198b47eff09
4a9430bc-1541-49ac-b9ff-1cde6087d429	cf32da3a-ae72-416c-a338-3abd883108e6
4a9430bc-1541-49ac-b9ff-1cde6087d429	4f51b7ba-aaf6-42e5-949a-93d7e1865ba3
4a9430bc-1541-49ac-b9ff-1cde6087d429	010b2992-7932-45cc-9a58-b9cec3ea821a
4a9430bc-1541-49ac-b9ff-1cde6087d429	f6e3a967-5b54-42c7-970c-3b7e411e8112
4a9430bc-1541-49ac-b9ff-1cde6087d429	194627ed-80de-4063-83f2-5870ddb6be01
4a9430bc-1541-49ac-b9ff-1cde6087d429	18043834-1719-4984-9e3e-1057ff9a7f3a
4a9430bc-1541-49ac-b9ff-1cde6087d429	7c83e344-bd7f-4550-b4bb-2dc3a2a1a810
4a9430bc-1541-49ac-b9ff-1cde6087d429	2cf12aa0-9932-4042-a001-54b32baaf24c
4a9430bc-1541-49ac-b9ff-1cde6087d429	b0e4222a-b505-4015-b4c6-c981b1a2dfc0
4a9430bc-1541-49ac-b9ff-1cde6087d429	d985cbe6-6cb4-4bec-b15f-bb75265c5465
4a9430bc-1541-49ac-b9ff-1cde6087d429	7ba5f537-e166-4e72-bde0-48f9c8a181de
4a9430bc-1541-49ac-b9ff-1cde6087d429	15726d39-5885-4acf-b86a-5ba7e67f6e00
4a9430bc-1541-49ac-b9ff-1cde6087d429	8ea20c6c-6495-41fa-99d2-47382f6c8425
4a9430bc-1541-49ac-b9ff-1cde6087d429	dc5e1017-1068-4341-a67d-bea3f304693a
4a9430bc-1541-49ac-b9ff-1cde6087d429	3801e7e0-151b-4724-9906-28f99c8aa212
4a9430bc-1541-49ac-b9ff-1cde6087d429	6fdeb1ec-3148-47e7-b626-4412abb80c71
4a9430bc-1541-49ac-b9ff-1cde6087d429	b7d8eaf8-4e6d-4a8b-82dd-9dbd05de7a59
f6e3a967-5b54-42c7-970c-3b7e411e8112	3801e7e0-151b-4724-9906-28f99c8aa212
010b2992-7932-45cc-9a58-b9cec3ea821a	b7d8eaf8-4e6d-4a8b-82dd-9dbd05de7a59
010b2992-7932-45cc-9a58-b9cec3ea821a	dc5e1017-1068-4341-a67d-bea3f304693a
1122227e-8209-4a2f-ae4d-50845b150a92	2ec4a992-714c-4875-82fd-7fd4bb654574
1122227e-8209-4a2f-ae4d-50845b150a92	4beec3e6-1319-401d-9f34-12d9b7e7a3ea
4beec3e6-1319-401d-9f34-12d9b7e7a3ea	4bd26726-c594-4b02-9509-cca7f101cdf7
e7d61f0b-e177-4391-bdc2-e987fa2a7520	4e6d879b-a24b-462d-9a30-6dd65c738b17
4a9430bc-1541-49ac-b9ff-1cde6087d429	60963ad3-727f-49a6-9063-aa9a9f70f3cf
1122227e-8209-4a2f-ae4d-50845b150a92	9956840c-a772-452e-8302-56028cd98a00
1122227e-8209-4a2f-ae4d-50845b150a92	20e4d8fd-a94d-4915-aac1-94c9773326c4
4a9430bc-1541-49ac-b9ff-1cde6087d429	f38bb80b-8642-4710-a6f2-e56342bfe1fe
4a9430bc-1541-49ac-b9ff-1cde6087d429	b5081994-e722-4932-a6d2-e57db635d496
4a9430bc-1541-49ac-b9ff-1cde6087d429	911fcb4c-3ded-41e8-ba13-bfb6541beaba
4a9430bc-1541-49ac-b9ff-1cde6087d429	5e3d2154-7e09-47d3-bda3-0f3cf4f2fd01
4a9430bc-1541-49ac-b9ff-1cde6087d429	c8889930-5f91-4f8b-b107-9afdc6e1624d
4a9430bc-1541-49ac-b9ff-1cde6087d429	c1baffa8-71ee-49fe-a7be-3107faed192d
4a9430bc-1541-49ac-b9ff-1cde6087d429	0fee8508-38ce-4c37-8cc4-e197150132e0
4a9430bc-1541-49ac-b9ff-1cde6087d429	3f1ef5ed-e99d-475f-b222-fc565f403457
4a9430bc-1541-49ac-b9ff-1cde6087d429	e737b175-f4c6-4fb6-bd20-a116c76a9d6e
4a9430bc-1541-49ac-b9ff-1cde6087d429	a04f0594-4e5a-41aa-986f-78533876b640
4a9430bc-1541-49ac-b9ff-1cde6087d429	2ecd95d9-9e7f-493f-99bb-424f7124430f
4a9430bc-1541-49ac-b9ff-1cde6087d429	a9249ec3-5b65-4b0c-8b05-4c944b00e3f2
4a9430bc-1541-49ac-b9ff-1cde6087d429	83866715-a0a4-401f-b6a5-c47ea65c0280
4a9430bc-1541-49ac-b9ff-1cde6087d429	1a215dc8-c332-4ebb-aad1-8a4cfbbc1bde
4a9430bc-1541-49ac-b9ff-1cde6087d429	1e955022-a530-4a4f-a142-f923f2b82ac5
4a9430bc-1541-49ac-b9ff-1cde6087d429	3a57ab24-ac8e-4dd1-a7b7-adb0019f6e18
4a9430bc-1541-49ac-b9ff-1cde6087d429	6fa76196-ec2a-4811-8b96-03cb781f10dc
5e3d2154-7e09-47d3-bda3-0f3cf4f2fd01	1e955022-a530-4a4f-a142-f923f2b82ac5
911fcb4c-3ded-41e8-ba13-bfb6541beaba	1a215dc8-c332-4ebb-aad1-8a4cfbbc1bde
911fcb4c-3ded-41e8-ba13-bfb6541beaba	6fa76196-ec2a-4811-8b96-03cb781f10dc
780b83c6-426a-4bb4-9fe9-a6dadcb51044	678f24aa-3aba-4eb0-973f-d309185f17e6
780b83c6-426a-4bb4-9fe9-a6dadcb51044	5a7a5750-1efe-45ed-8be0-ccf69665ce84
780b83c6-426a-4bb4-9fe9-a6dadcb51044	ff61c29d-90a7-4999-a1f8-2fa1ecc07a8e
780b83c6-426a-4bb4-9fe9-a6dadcb51044	78c089cd-fe4e-4575-aa38-768840bfe270
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	cb11ce1f-42f1-4468-8fc0-125b1d3b4de1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	f895a986-5615-4bf0-9890-d98245ea9744
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	67853e42-667c-4606-aa17-0420980581c1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	fbbb02e8-b863-46a9-9fe3-b46006b99920
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	8954002e-2513-4071-94f4-dfc01d01abe1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	70154c3d-6dcc-48fa-9e3b-98ca18827c32
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	528a52b1-116a-4d89-b076-940943166b65
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	6c5c69c2-0e29-4c64-81e1-488030cb3fed
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	4c020a6b-f944-47dd-8f39-b52328402a2f
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	deb1b766-7627-4d7a-a317-6cf3f4ee531f
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	518229c2-9cff-45bd-ba10-d9cc6af2f2f6
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	4df1c8c1-5cbd-4977-9141-8cef50417dea
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	1a448561-8d1b-4762-adfa-e5b84fd76eed
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	0401c523-b8a4-48e1-8cf1-456f336c1502
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	9f3df1c2-37d0-47cf-bd79-8190ac978267
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	af549064-4cbc-4041-b90a-b8cfaca6d626
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	9a300a3a-5a09-4535-aae9-90fe34130f53
8954002e-2513-4071-94f4-dfc01d01abe1	6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18
6c5c69c2-0e29-4c64-81e1-488030cb3fed	fbbb02e8-b863-46a9-9fe3-b46006b99920
6c5c69c2-0e29-4c64-81e1-488030cb3fed	0401c523-b8a4-48e1-8cf1-456f336c1502
111a3a46-1254-4e72-847c-b9b8bd5cf74e	0b40ecd4-19b3-43fd-ae93-d052393df4a7
78c089cd-fe4e-4575-aa38-768840bfe270	ad91a252-8374-499e-83b4-cf1f6127067a
4a9430bc-1541-49ac-b9ff-1cde6087d429	bf11b4b4-02f9-4e84-a009-ac653f2335cf
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
82e083fd-b4e6-4588-9832-c0fe6cc10f88	\N	password	e7a99c31-3abb-42e0-95db-f4917dec672f	1669048961205	\N	{"value":"EFVBpQD7/lAAiC6AvRFX+ve5ywpi9PNAvK2ALVvQnYKzoXeN3Xs1Nu05X+XPqNBtV9+I+RZscf1le1CTtF7hOw==","salt":"7g3gJXa018hBk/oUM5jPmw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
69a3b51b-a5fd-45e8-a2dc-6e19e6710be2	\N	password	de9ec862-0ba4-4289-9903-77a3ba2ce25c	1669050221936	My password	{"value":"d4Dml8B53318n4bvi+z5dSjhOSJf54Lal6evTA4fozBQyORD6rOjbu8F4EydR3SiY57G5s4woVGDlyItNMqeOg==","salt":"+AJMRBfYBq4hWlLu52qcYg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
cc95a5e6-3c38-49ed-8e7f-47beb85b1f2e	\N	password	5a62483b-4157-4399-9225-504e354f32e9	1669050255365	My password	{"value":"8QwVjQeE+oKFlAKSiNDQ/9jeIOxAXkzGhOZiXjgl6bix+FsHEAVqRbNJTabQZD/BWkc3fKsrg1PLzbAYGNYOew==","salt":"Wvh/5rGyDrTRywXXr6dIBw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
27c410dc-0f7b-47fa-99a8-a057a04d4ee8	\N	password	a19c4fb4-3afe-4c60-b994-00422f570a6e	1669050283436	My password	{"value":"2V2H3nFTwOBy+a42IXRkZb9rtu051kyQLoWDybIWQ/last+WJUVwAXY8tJuUbb9ZZ2kZmLjBE+jVOv7Ff9Tbcg==","salt":"kSreJJnc7Qhk6qIHhbRteQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
ed462cff-bfc1-4527-a301-8ff0595aadf3	\N	password	aa8cd899-88b2-48f7-a098-dee3718125ef	1669050314270	My password	{"value":"310yP48wUPUstLlqTCnMuGZfmFzED1KyhqEWkXiGMM9OSIAsCvsV9Soh3xB1Y1OprrCiculgfu8Wn/OjB87jvg==","salt":"UtjwyLoDxmH4ZII00xy6VA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
250cae86-8454-46ad-ab38-6e768ace7cff	\N	password	3691c7e2-af12-496c-b4a3-3f8ef953214b	1669050349611	My password	{"value":"+doZ+TPFyd6f33RWPh7pMaa8zhR45ZkiAtfqvFrrgSmvvNTzGA8dLPF0LjdF0ka+63UDU8dt/JyrMai/5m0YMA==","salt":"zKjHVv4xCGvc5lnbcp1Ysg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
2d171330-433b-4130-aed9-526827e4fcdd	\N	password	108df9c1-3c7f-4f88-aea8-36558fd2bf74	1669050674461	My password	{"value":"IksoK6mvtm+TnyeWRIrnSV1PtZz89SirGNqqK6vxkdriRBEcqOcTyYaBtNrwlEJOGEfzu12JGRtKWgrTSJC+5Q==","salt":"onJ8UAEDSoOac3AFDR0+AA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
33781965-e0e5-4eb4-b413-2edf5aab0714	\N	password	c3afe492-873e-40b6-a5e3-137828e8881b	1669052922343	My password	{"value":"31JoB8s+dJDopX8G2MxBYaMp0we5QHUdLmIX0E4JPAjWU6IBLnlk7+B78UOPbUAnyQ8v8DcWWIQeZmHusuVawg==","salt":"okrHfkLZvhF7fRXUq75+8w==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c55e5d9a-9fa6-4098-a1c2-120ac97a3251	\N	password	27b0fa2e-4880-4090-9d7c-82e2918e35e8	1669057735340	My password	{"value":"7ZGQSuw6PAbrsgknd9JKto3WEiZJn7OLuV2r2SSMbPSjXFuM/qnO36yN1FbtZz/Hogh5BuVwZXw7Oqu7jiZr5A==","salt":"M5piOJiid6qb+nMBypF4KQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
aeaef14f-e0cd-4265-9bf1-9ecdc7e175e1	\N	password	ce17443e-b1cc-4b7e-815c-da9c2a43ff55	1669052967190	My password	{"value":"xgUoHushxRFIRsQbl4cuXPBhB6V5OcXQs/3zH2jYt7SMYDOZuWQggLaaRmI9WC1/9kH/4tzfLW5I9tJzyYNV0A==","salt":"lc3umWpf77aNHVN/IBal0g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
86a16afb-88a9-4d57-b84a-2e91704aec19	\N	password	028f6163-95d2-4924-885e-a433b9bf21a5	1669057058139	My password	{"value":"gtY5GgTelGlib2xLjoWmLxaxrghMAKJ3tOWc6sscSGSJqRYss6Vxcn+DIjm2Gza91U0LzERQ4TWYv7VPrCkZfg==","salt":"r6J7KFbjAwUH1TVgg64TRQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
3c88bbad-4868-418a-9d80-decbe34e30f8	\N	password	d7bdd921-bc8b-458f-ba25-76b8fa0ed695	1669057085207	My password	{"value":"JLJPKEdMWO/xekb81vSliCLkeEwdgsSCTbUpeBMiNaqvWiMq77a0utzfnxEx+u8ZUJsSnbZVyIevPLoDXFswbg==","salt":"bdUOfNN+dKlKqZkrWZdwvQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
514093d7-092d-4839-ad0e-42269471d4d2	\N	password	6e241e99-6ff8-4b03-a7cb-72cbad5ce08c	1669057316037	My password	{"value":"Y4/2S7mHx4cjVt/zOWK4xAve7CxnMd6deGqC2PF0OXxcTRbjYGdBR0lhTeBw2NvcjUvHte04s7qQBEacPICPyg==","salt":"t5l+OBJiYXDbPxIVR40YTQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
964f04b5-7113-45b2-8ea5-87b137fe05ee	\N	password	518f113f-6b7f-463e-9566-8b3860ef6410	1669057787633	My password	{"value":"L7fltpyBq5J2mX5Ge/kjhwD3sfv0T/tuLwLZzIIbObycyilnw8FwOXWt8JZysHWoFZLF+MH3q1KpXSR8UFgBBA==","salt":"bq4vVQnOw/VJPG/T2M+i7g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
eec897dc-f87c-40d0-862f-53150c52c237	\N	password	11dbace1-4455-45c3-ac22-0e1a2b17fbd7	1669057819595	My password	{"value":"tweFH/sshKoHvHsqWE99CmWt8wnMP3tGXstrtJSyGJdY9dN2p8T2o7fX6SKX/W8FSQhYCTJpvpLPYgfcTYA5Qw==","salt":"2qilqmu7IwE5t6ZRD8XLIQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
bff9593b-fff8-4652-98ed-81f598f50b10	\N	password	87004960-05fe-4678-8947-d4cfe4fd0491	1669057856707	My password	{"value":"3anC8dPttge9STXm4cjIdAps1IofGiM4vYW7tpjWCJqNU4BtKt+Jx8uGhMy3PMiqCDMNXuz3XpwYFe7doWEGsg==","salt":"Jdif7dayCQXz+LoFBFAltw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1026f870-a69d-40f9-90b7-2be4c2810e2a	\N	password	6aaffa4b-104a-4260-97c0-b37e7e6f6395	1669057887474	My password	{"value":"OpPJb8ioC5afB8YxWtaFt4h5+zh7l4IDFP9YeoXF5MPrjRY9vSiSV6Vf6X6GdrQj4uookOEYk47GZESSHI1hUA==","salt":"iscmVkK3UvOugfVB1uw5AA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c9f1883f-8f69-4edb-b337-df4937fd29b5	\N	password	43c47199-13bf-44d2-9beb-05082ec52399	1669057917349	My password	{"value":"V2jQeYJbdBWcuuh7oeu5Z0YrNkL/sMANHluyQ4J/BfmNDss7vzpbEwMW2jiKX3f18Bn4HWsLsFXoDhO1p2AAZg==","salt":"eQOTHmtfKZ/2oW+7z+fVIg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
b4c1520c-3234-4387-b3fc-329d90b836b0	\N	password	93e954f0-9ee0-499f-b46c-e58868390e3d	1669057952760	My password	{"value":"q+65sSmTV7gIDthgI+UUSlQH4HudMEfOFYmRhZ5NMtHLwxywM4z86cTZeXw8MouotPHm0QQTZeJbb6i6Wq0PLA==","salt":"Dn4x0aERP9ixSPRPPRKOTg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
3e743ac5-df90-4a42-9b6b-01a06eced4d6	\N	password	c2c25e9e-bb77-4adf-b1fc-17c1bd805aa4	1669057981338	My password	{"value":"3XTqNRIwZo2RxWewCiB6FeGZZHq7b7UiPSistkVXVxEpR26lThMPVI0W4Uqd0BYXz2fmKWGRX7JJkM6ZdHwP7g==","salt":"wG8TnmGxANIOTaSJQyoCEQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-11-21 17:42:28.634483	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	9048948072
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-11-21 17:42:28.646061	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	9048948072
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-11-21 17:42:28.725079	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	9048948072
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-11-21 17:42:28.732662	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	9048948072
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-11-21 17:42:28.901888	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	9048948072
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-11-21 17:42:28.905764	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	9048948072
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-11-21 17:42:29.051756	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	9048948072
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-11-21 17:42:29.055477	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	9048948072
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-11-21 17:42:29.062677	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	9048948072
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-11-21 17:42:29.234161	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	9048948072
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-11-21 17:42:29.328791	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9048948072
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-11-21 17:42:29.332642	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9048948072
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-11-21 17:42:29.36716	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	9048948072
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-21 17:42:29.401626	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	9048948072
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-21 17:42:29.406715	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9048948072
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-21 17:42:29.410412	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	9048948072
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-21 17:42:29.413614	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	9048948072
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-11-21 17:42:29.494415	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	9048948072
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-11-21 17:42:29.579082	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	9048948072
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-11-21 17:42:29.586296	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	9048948072
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-21 17:42:31.409222	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	9048948072
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-21 17:42:29.590305	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	9048948072
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-21 17:42:29.594988	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	9048948072
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-11-21 17:42:29.672273	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	9048948072
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-11-21 17:42:29.682746	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	9048948072
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-11-21 17:42:29.686824	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	9048948072
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-11-21 17:42:30.05276	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	9048948072
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-11-21 17:42:30.201975	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	9048948072
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-11-21 17:42:30.206782	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	9048948072
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-11-21 17:42:30.339161	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	9048948072
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-11-21 17:42:30.367084	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	9048948072
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-11-21 17:42:30.399038	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	9048948072
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-11-21 17:42:30.405032	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	9048948072
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-21 17:42:30.413511	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9048948072
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-21 17:42:30.416548	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	9048948072
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-21 17:42:30.466807	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	9048948072
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-11-21 17:42:30.474432	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	9048948072
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-21 17:42:30.484663	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9048948072
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-11-21 17:42:30.497576	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	9048948072
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-11-21 17:42:30.50366	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	9048948072
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-21 17:42:30.506376	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	9048948072
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-21 17:42:30.510524	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	9048948072
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-11-21 17:42:30.516385	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	9048948072
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-21 17:42:31.389491	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	9048948072
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-11-21 17:42:31.399291	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	9048948072
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-21 17:42:31.417097	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	9048948072
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-21 17:42:31.420733	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	9048948072
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-21 17:42:31.526885	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	9048948072
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-21 17:42:31.533163	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	9048948072
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-11-21 17:42:31.614069	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	9048948072
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-11-21 17:42:31.788786	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	9048948072
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-11-21 17:42:31.795911	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9048948072
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-11-21 17:42:31.799755	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	9048948072
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-11-21 17:42:31.804019	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	9048948072
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-21 17:42:31.821174	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	9048948072
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-21 17:42:31.834735	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	9048948072
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-21 17:42:31.883948	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	9048948072
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-21 17:42:32.200627	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	9048948072
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-11-21 17:42:32.246981	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	9048948072
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-11-21 17:42:32.254882	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	9048948072
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-21 17:42:32.266371	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	9048948072
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-21 17:42:32.275947	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	9048948072
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-11-21 17:42:32.281321	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	9048948072
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-11-21 17:42:32.285294	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	9048948072
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-21 17:42:32.288982	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	9048948072
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-11-21 17:42:32.320325	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	9048948072
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-21 17:42:32.340254	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	9048948072
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-11-21 17:42:32.34803	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	9048948072
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-11-21 17:42:32.370383	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	9048948072
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-11-21 17:42:32.377848	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	9048948072
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-11-21 17:42:32.384059	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	9048948072
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-21 17:42:32.395388	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9048948072
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-21 17:42:32.403555	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9048948072
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-21 17:42:32.406799	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	9048948072
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-21 17:42:32.439732	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	9048948072
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-21 17:42:32.46493	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	9048948072
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-21 17:42:32.47221	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	9048948072
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-21 17:42:32.475923	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	9048948072
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-21 17:42:32.514056	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	9048948072
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-21 17:42:32.517557	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	9048948072
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-21 17:42:32.535663	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	9048948072
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-21 17:42:32.539009	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9048948072
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-21 17:42:32.545531	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9048948072
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-21 17:42:32.54839	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	9048948072
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-21 17:42:32.566953	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	9048948072
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-11-21 17:42:32.578416	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	9048948072
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-21 17:42:32.59722	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	9048948072
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-21 17:42:32.614194	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	9048948072
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.623179	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	9048948072
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.638411	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	9048948072
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.658883	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9048948072
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.674851	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	9048948072
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.678024	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	9048948072
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.696758	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	9048948072
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.700318	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	9048948072
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-21 17:42:32.710366	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	9048948072
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.761051	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	9048948072
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.76411	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9048948072
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.776361	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9048948072
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.800017	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9048948072
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.803115	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	9048948072
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.821166	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	9048948072
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-21 17:42:32.827733	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	9048948072
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-11-21 17:42:32.835928	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	9048948072
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-11-21 17:42:32.857868	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	9048948072
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-11-21 17:42:32.880898	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	9048948072
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-11-21 17:42:32.887242	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	9048948072
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
afa54666-f1b9-40de-9536-29bb76f3fd42	fc4e269d-9da9-48fc-bc13-09a788c394cf	f
afa54666-f1b9-40de-9536-29bb76f3fd42	f44d1541-7fca-489c-9d0e-a6d98107dd68	t
afa54666-f1b9-40de-9536-29bb76f3fd42	369932d2-b468-4d87-973c-db2efeac294e	t
afa54666-f1b9-40de-9536-29bb76f3fd42	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3	t
afa54666-f1b9-40de-9536-29bb76f3fd42	91630347-a9f2-4acc-aacf-dc3a46c9982b	f
afa54666-f1b9-40de-9536-29bb76f3fd42	b0ef0719-1ae9-4089-aa46-9c451c5d84fe	f
afa54666-f1b9-40de-9536-29bb76f3fd42	c7d4a324-f5e5-4a21-a9e9-04f7146285e1	t
afa54666-f1b9-40de-9536-29bb76f3fd42	92c4f294-f8b9-4f28-921d-f05a6a1309df	t
afa54666-f1b9-40de-9536-29bb76f3fd42	00e4766f-f244-4410-b5c7-3ac05becf484	f
afa54666-f1b9-40de-9536-29bb76f3fd42	6a39a1c4-d923-4eac-9cd0-56fd5e809733	t
easybackend	12ea9885-c85d-4ab3-bbfb-b9c706495db5	t
easybackend	fb2df94f-824a-4682-baf9-9da7047671d2	t
easybackend	b0df9abe-928c-45ce-847d-12a7251cee9a	t
easybackend	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
easybackend	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
easybackend	476bbd3c-ef76-44cf-971b-f9d61899128a	t
easybackend	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
easybackend	d56a3de7-1416-4106-895d-ee839a2278fd	f
easybackend	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
easybackend	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
1122227e-8209-4a2f-ae4d-50845b150a92	afa54666-f1b9-40de-9536-29bb76f3fd42	f	${role_default-roles}	default-roles-master	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	\N
4a9430bc-1541-49ac-b9ff-1cde6087d429	afa54666-f1b9-40de-9536-29bb76f3fd42	f	${role_admin}	admin	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	\N
96aaaee4-f26f-46c4-8f7c-a198b47eff09	afa54666-f1b9-40de-9536-29bb76f3fd42	f	${role_create-realm}	create-realm	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	\N
cf32da3a-ae72-416c-a338-3abd883108e6	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_create-client}	create-client	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
4f51b7ba-aaf6-42e5-949a-93d7e1865ba3	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-realm}	view-realm	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
010b2992-7932-45cc-9a58-b9cec3ea821a	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-users}	view-users	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
f6e3a967-5b54-42c7-970c-3b7e411e8112	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-clients}	view-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
194627ed-80de-4063-83f2-5870ddb6be01	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-events}	view-events	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
18043834-1719-4984-9e3e-1057ff9a7f3a	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-identity-providers}	view-identity-providers	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
7c83e344-bd7f-4550-b4bb-2dc3a2a1a810	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_view-authorization}	view-authorization	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
2cf12aa0-9932-4042-a001-54b32baaf24c	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-realm}	manage-realm	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
b0e4222a-b505-4015-b4c6-c981b1a2dfc0	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-users}	manage-users	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
d985cbe6-6cb4-4bec-b15f-bb75265c5465	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-clients}	manage-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
7ba5f537-e166-4e72-bde0-48f9c8a181de	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-events}	manage-events	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
15726d39-5885-4acf-b86a-5ba7e67f6e00	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-identity-providers}	manage-identity-providers	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
8ea20c6c-6495-41fa-99d2-47382f6c8425	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_manage-authorization}	manage-authorization	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
dc5e1017-1068-4341-a67d-bea3f304693a	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_query-users}	query-users	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
3801e7e0-151b-4724-9906-28f99c8aa212	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_query-clients}	query-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
6fdeb1ec-3148-47e7-b626-4412abb80c71	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_query-realms}	query-realms	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
b7d8eaf8-4e6d-4a8b-82dd-9dbd05de7a59	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_query-groups}	query-groups	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
2ec4a992-714c-4875-82fd-7fd4bb654574	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_view-profile}	view-profile	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
4beec3e6-1319-401d-9f34-12d9b7e7a3ea	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_manage-account}	manage-account	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
4bd26726-c594-4b02-9509-cca7f101cdf7	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_manage-account-links}	manage-account-links	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
734cc45e-5c72-4c1c-ace4-cecc1406a7b9	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_view-applications}	view-applications	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
4e6d879b-a24b-462d-9a30-6dd65c738b17	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_view-consent}	view-consent	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
e7d61f0b-e177-4391-bdc2-e987fa2a7520	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_manage-consent}	manage-consent	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
7121ffd5-4801-439b-bd9c-55e61f4923c7	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	t	${role_delete-account}	delete-account	afa54666-f1b9-40de-9536-29bb76f3fd42	17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	\N
92296f30-e4c9-4ddf-b370-2e95482e4b6d	7a2eab98-0f24-4b45-937c-e478397bd2b9	t	${role_read-token}	read-token	afa54666-f1b9-40de-9536-29bb76f3fd42	7a2eab98-0f24-4b45-937c-e478397bd2b9	\N
60963ad3-727f-49a6-9063-aa9a9f70f3cf	b70c8f9d-82f3-401a-9005-5a393c1bd232	t	${role_impersonation}	impersonation	afa54666-f1b9-40de-9536-29bb76f3fd42	b70c8f9d-82f3-401a-9005-5a393c1bd232	\N
9956840c-a772-452e-8302-56028cd98a00	afa54666-f1b9-40de-9536-29bb76f3fd42	f	${role_offline-access}	offline_access	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	\N
20e4d8fd-a94d-4915-aac1-94c9773326c4	afa54666-f1b9-40de-9536-29bb76f3fd42	f	${role_uma_authorization}	uma_authorization	afa54666-f1b9-40de-9536-29bb76f3fd42	\N	\N
780b83c6-426a-4bb4-9fe9-a6dadcb51044	easybackend	f	${role_default-roles}	default-roles-easybackend	easybackend	\N	\N
f38bb80b-8642-4710-a6f2-e56342bfe1fe	15b2959b-7590-4380-8b13-409c21e10307	t	${role_create-client}	create-client	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
b5081994-e722-4932-a6d2-e57db635d496	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-realm}	view-realm	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
911fcb4c-3ded-41e8-ba13-bfb6541beaba	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-users}	view-users	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
5e3d2154-7e09-47d3-bda3-0f3cf4f2fd01	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-clients}	view-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
c8889930-5f91-4f8b-b107-9afdc6e1624d	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-events}	view-events	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
c1baffa8-71ee-49fe-a7be-3107faed192d	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-identity-providers}	view-identity-providers	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
0fee8508-38ce-4c37-8cc4-e197150132e0	15b2959b-7590-4380-8b13-409c21e10307	t	${role_view-authorization}	view-authorization	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
3f1ef5ed-e99d-475f-b222-fc565f403457	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-realm}	manage-realm	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
e737b175-f4c6-4fb6-bd20-a116c76a9d6e	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-users}	manage-users	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
a04f0594-4e5a-41aa-986f-78533876b640	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-clients}	manage-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
2ecd95d9-9e7f-493f-99bb-424f7124430f	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-events}	manage-events	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
a9249ec3-5b65-4b0c-8b05-4c944b00e3f2	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-identity-providers}	manage-identity-providers	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
83866715-a0a4-401f-b6a5-c47ea65c0280	15b2959b-7590-4380-8b13-409c21e10307	t	${role_manage-authorization}	manage-authorization	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
1a215dc8-c332-4ebb-aad1-8a4cfbbc1bde	15b2959b-7590-4380-8b13-409c21e10307	t	${role_query-users}	query-users	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
1e955022-a530-4a4f-a142-f923f2b82ac5	15b2959b-7590-4380-8b13-409c21e10307	t	${role_query-clients}	query-clients	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
3a57ab24-ac8e-4dd1-a7b7-adb0019f6e18	15b2959b-7590-4380-8b13-409c21e10307	t	${role_query-realms}	query-realms	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
6fa76196-ec2a-4811-8b96-03cb781f10dc	15b2959b-7590-4380-8b13-409c21e10307	t	${role_query-groups}	query-groups	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	easybackend	f	\N	easybackend_user	easybackend	\N	\N
5a7a5750-1efe-45ed-8be0-ccf69665ce84	easybackend	f	${role_uma_authorization}	uma_authorization	easybackend	\N	\N
4151be0f-2133-4dca-ad72-693b73923c3b	easybackend	f		easybackend_admin	easybackend	\N	\N
678f24aa-3aba-4eb0-973f-d309185f17e6	easybackend	f	${role_offline-access}	offline_access	easybackend	\N	\N
cb11ce1f-42f1-4468-8fc0-125b1d3b4de1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-identity-providers}	view-identity-providers	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
67853e42-667c-4606-aa17-0420980581c1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-authorization}	manage-authorization	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
fbbb02e8-b863-46a9-9fe3-b46006b99920	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-users}	query-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
f895a986-5615-4bf0-9890-d98245ea9744	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-events}	view-events	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_realm-admin}	realm-admin	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
8954002e-2513-4071-94f4-dfc01d01abe1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-clients}	view-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
70154c3d-6dcc-48fa-9e3b-98ca18827c32	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_impersonation}	impersonation	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
528a52b1-116a-4d89-b076-940943166b65	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_create-client}	create-client	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
4c020a6b-f944-47dd-8f39-b52328402a2f	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-identity-providers}	manage-identity-providers	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
6c5c69c2-0e29-4c64-81e1-488030cb3fed	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-users}	view-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
518229c2-9cff-45bd-ba10-d9cc6af2f2f6	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-realm}	manage-realm	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
deb1b766-7627-4d7a-a317-6cf3f4ee531f	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-realm}	view-realm	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
4df1c8c1-5cbd-4977-9141-8cef50417dea	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-events}	manage-events	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
1a448561-8d1b-4762-adfa-e5b84fd76eed	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-realms}	query-realms	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
0401c523-b8a4-48e1-8cf1-456f336c1502	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-groups}	query-groups	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
9f3df1c2-37d0-47cf-bd79-8190ac978267	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-authorization}	view-authorization	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
af549064-4cbc-4041-b90a-b8cfaca6d626	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-clients}	manage-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-clients}	query-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
9a300a3a-5a09-4535-aae9-90fe34130f53	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-users}	manage-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
5582d484-b152-4345-a33e-2a924115075b	2ef67323-2a80-4467-91f7-a5dfc6491cae	t	${role_read-token}	read-token	easybackend	2ef67323-2a80-4467-91f7-a5dfc6491cae	\N
57419e0d-f59e-4d6e-8fd7-5696e67224d0	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-applications}	view-applications	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
c35b8499-4b50-4f07-b3d2-5764e38fbf1a	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_delete-account}	delete-account	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
ad91a252-8374-499e-83b4-cf1f6127067a	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-account-links}	manage-account-links	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
111a3a46-1254-4e72-847c-b9b8bd5cf74e	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-consent}	manage-consent	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
ff61c29d-90a7-4999-a1f8-2fa1ecc07a8e	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-profile}	view-profile	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
0b40ecd4-19b3-43fd-ae93-d052393df4a7	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-consent}	view-consent	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
78c089cd-fe4e-4575-aa38-768840bfe270	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-account}	manage-account	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
bf11b4b4-02f9-4e84-a009-ac653f2335cf	15b2959b-7590-4380-8b13-409c21e10307	t	${role_impersonation}	impersonation	afa54666-f1b9-40de-9536-29bb76f3fd42	15b2959b-7590-4380-8b13-409c21e10307	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
tqsj3	19.0.2	1669048955
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
668f268f-1780-47a4-b388-8fe2dbe52c99	audience resolve	openid-connect	oidc-audience-resolve-mapper	f63eb124-b58b-40ee-819e-453e94b161b4	\N
e81496a1-bb1e-4509-a513-d47797e15d28	locale	openid-connect	oidc-usermodel-attribute-mapper	e37c4dbc-3646-4b26-9ee9-a834d03a3d20	\N
725c7a3e-5e3b-416f-8f92-b8cedafb6fff	role list	saml	saml-role-list-mapper	\N	f44d1541-7fca-489c-9d0e-a6d98107dd68
b749699f-0aaf-456c-b4eb-0a19efaf011b	full name	openid-connect	oidc-full-name-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	family name	openid-connect	oidc-usermodel-property-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	given name	openid-connect	oidc-usermodel-property-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
7ee1e778-e253-4885-be61-d0daa1418cd3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
5aebb30c-a6d6-4388-8443-51d75af2ee58	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
b0a7eaca-d38d-4429-bfce-0daadb00426f	username	openid-connect	oidc-usermodel-property-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
94ab6d4e-48ff-4759-9c04-19ee842450ed	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
170a3205-82e0-4914-b8d1-3f9140246103	website	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
9e885642-8ef7-422a-ba24-4f65b9c0d68a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
3fcaa23d-8e3a-4499-b61c-d1656de68257	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
910adb49-9f84-427b-a983-92a3da12126b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	369932d2-b468-4d87-973c-db2efeac294e
72200f9c-2934-47e4-a271-1f52626c2607	email	openid-connect	oidc-usermodel-property-mapper	\N	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3
525e7d11-172c-4582-87fe-339912c797f8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	aaf5d6e3-4c79-47cb-b9db-f48ae03a60a3
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	address	openid-connect	oidc-address-mapper	\N	91630347-a9f2-4acc-aacf-dc3a46c9982b
4a5511fe-ba17-47c3-a67f-c5a075423b0c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	b0ef0719-1ae9-4089-aa46-9c451c5d84fe
57033ecc-b5bb-409f-9bc7-51c100215231	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	b0ef0719-1ae9-4089-aa46-9c451c5d84fe
f86114ab-166b-4f18-879c-96ba375686b2	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	c7d4a324-f5e5-4a21-a9e9-04f7146285e1
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	c7d4a324-f5e5-4a21-a9e9-04f7146285e1
0c6a79ec-5045-4f10-9b49-311e985bf668	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	c7d4a324-f5e5-4a21-a9e9-04f7146285e1
f56eed72-a771-451a-a6b1-5c33150ce6e2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	92c4f294-f8b9-4f28-921d-f05a6a1309df
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	upn	openid-connect	oidc-usermodel-property-mapper	\N	00e4766f-f244-4410-b5c7-3ac05becf484
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	00e4766f-f244-4410-b5c7-3ac05becf484
610c825f-16a8-4409-8c61-49e1d6d0e1fb	acr loa level	openid-connect	oidc-acr-mapper	\N	6a39a1c4-d923-4eac-9cd0-56fd5e809733
d5cea4e8-acb6-413c-a06d-e9e3ab5ed08f	acr loa level	openid-connect	oidc-acr-mapper	\N	476bbd3c-ef76-44cf-971b-f9d61899128a
b27919bf-df5f-463a-a91b-cfcde4580de7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
efaf397b-9763-4aee-a568-dafc13822e61	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
9f437a33-577a-428e-814b-7b895c67addc	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
96197993-2e17-477a-bced-9971caffbfab	email verified	openid-connect	oidc-usermodel-property-mapper	\N	b0df9abe-928c-45ce-847d-12a7251cee9a
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	openid-connect	oidc-usermodel-property-mapper	\N	b0df9abe-928c-45ce-847d-12a7251cee9a
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7209fb8c-3f21-442e-8c71-aa3336dc2f45
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7209fb8c-3f21-442e-8c71-aa3336dc2f45
28e369c4-0f48-49cf-ac43-86735623e5ed	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	240fc8d7-4ea6-4701-9d56-b9cca566061a
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	upn	openid-connect	oidc-usermodel-property-mapper	\N	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb
6896dbf2-8ded-4933-a98e-6a148a835e96	role list	saml	saml-role-list-mapper	\N	12ea9885-c85d-4ab3-bbfb-b9c706495db5
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	given name	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
700eb412-f80c-42ef-a0a0-350f8578274a	full name	openid-connect	oidc-full-name-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
7c97b048-915e-4742-8879-6e28b457f014	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
79009f2e-12cf-4022-ab87-070d418d6a17	username	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
5268821b-7d20-46ba-8a4f-05793c43269b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	family name	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
d2405431-6415-4547-9cbf-6ad491b4f851	website	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
1be633bc-17d6-44f9-b5d9-161c6277a62e	address	openid-connect	oidc-address-mapper	\N	d56a3de7-1416-4106-895d-ee839a2278fd
c0699a7b-e55a-4c11-bde9-50ff140db1aa	audience resolve	openid-connect	oidc-audience-resolve-mapper	4f8b866a-cccf-4fe0-b2fb-72261ea37634	\N
92d38df7-7473-491e-b132-f78748a23de6	locale	openid-connect	oidc-usermodel-attribute-mapper	0c1072d0-fbe2-4759-9c08-a399a7faa47b	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e81496a1-bb1e-4509-a513-d47797e15d28	true	userinfo.token.claim
e81496a1-bb1e-4509-a513-d47797e15d28	locale	user.attribute
e81496a1-bb1e-4509-a513-d47797e15d28	true	id.token.claim
e81496a1-bb1e-4509-a513-d47797e15d28	true	access.token.claim
e81496a1-bb1e-4509-a513-d47797e15d28	locale	claim.name
e81496a1-bb1e-4509-a513-d47797e15d28	String	jsonType.label
725c7a3e-5e3b-416f-8f92-b8cedafb6fff	false	single
725c7a3e-5e3b-416f-8f92-b8cedafb6fff	Basic	attribute.nameformat
725c7a3e-5e3b-416f-8f92-b8cedafb6fff	Role	attribute.name
b749699f-0aaf-456c-b4eb-0a19efaf011b	true	userinfo.token.claim
b749699f-0aaf-456c-b4eb-0a19efaf011b	true	id.token.claim
b749699f-0aaf-456c-b4eb-0a19efaf011b	true	access.token.claim
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	true	userinfo.token.claim
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	lastName	user.attribute
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	true	id.token.claim
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	true	access.token.claim
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	family_name	claim.name
15f49881-bef4-4bb9-aaa4-2caec3bd42f8	String	jsonType.label
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	true	userinfo.token.claim
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	firstName	user.attribute
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	true	id.token.claim
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	true	access.token.claim
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	given_name	claim.name
c92a57fb-7346-41e1-ab4c-c1d5bc8db2ac	String	jsonType.label
7ee1e778-e253-4885-be61-d0daa1418cd3	true	userinfo.token.claim
7ee1e778-e253-4885-be61-d0daa1418cd3	middleName	user.attribute
7ee1e778-e253-4885-be61-d0daa1418cd3	true	id.token.claim
7ee1e778-e253-4885-be61-d0daa1418cd3	true	access.token.claim
7ee1e778-e253-4885-be61-d0daa1418cd3	middle_name	claim.name
7ee1e778-e253-4885-be61-d0daa1418cd3	String	jsonType.label
5aebb30c-a6d6-4388-8443-51d75af2ee58	true	userinfo.token.claim
5aebb30c-a6d6-4388-8443-51d75af2ee58	nickname	user.attribute
5aebb30c-a6d6-4388-8443-51d75af2ee58	true	id.token.claim
5aebb30c-a6d6-4388-8443-51d75af2ee58	true	access.token.claim
5aebb30c-a6d6-4388-8443-51d75af2ee58	nickname	claim.name
5aebb30c-a6d6-4388-8443-51d75af2ee58	String	jsonType.label
b0a7eaca-d38d-4429-bfce-0daadb00426f	true	userinfo.token.claim
b0a7eaca-d38d-4429-bfce-0daadb00426f	username	user.attribute
b0a7eaca-d38d-4429-bfce-0daadb00426f	true	id.token.claim
b0a7eaca-d38d-4429-bfce-0daadb00426f	true	access.token.claim
b0a7eaca-d38d-4429-bfce-0daadb00426f	preferred_username	claim.name
b0a7eaca-d38d-4429-bfce-0daadb00426f	String	jsonType.label
94ab6d4e-48ff-4759-9c04-19ee842450ed	true	userinfo.token.claim
94ab6d4e-48ff-4759-9c04-19ee842450ed	profile	user.attribute
94ab6d4e-48ff-4759-9c04-19ee842450ed	true	id.token.claim
94ab6d4e-48ff-4759-9c04-19ee842450ed	true	access.token.claim
94ab6d4e-48ff-4759-9c04-19ee842450ed	profile	claim.name
94ab6d4e-48ff-4759-9c04-19ee842450ed	String	jsonType.label
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	true	userinfo.token.claim
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	picture	user.attribute
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	true	id.token.claim
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	true	access.token.claim
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	picture	claim.name
3a33d8ee-1f8b-4edc-a14a-cebd710361c7	String	jsonType.label
170a3205-82e0-4914-b8d1-3f9140246103	true	userinfo.token.claim
170a3205-82e0-4914-b8d1-3f9140246103	website	user.attribute
170a3205-82e0-4914-b8d1-3f9140246103	true	id.token.claim
170a3205-82e0-4914-b8d1-3f9140246103	true	access.token.claim
170a3205-82e0-4914-b8d1-3f9140246103	website	claim.name
170a3205-82e0-4914-b8d1-3f9140246103	String	jsonType.label
9e885642-8ef7-422a-ba24-4f65b9c0d68a	true	userinfo.token.claim
9e885642-8ef7-422a-ba24-4f65b9c0d68a	gender	user.attribute
9e885642-8ef7-422a-ba24-4f65b9c0d68a	true	id.token.claim
9e885642-8ef7-422a-ba24-4f65b9c0d68a	true	access.token.claim
9e885642-8ef7-422a-ba24-4f65b9c0d68a	gender	claim.name
9e885642-8ef7-422a-ba24-4f65b9c0d68a	String	jsonType.label
3fcaa23d-8e3a-4499-b61c-d1656de68257	true	userinfo.token.claim
3fcaa23d-8e3a-4499-b61c-d1656de68257	birthdate	user.attribute
3fcaa23d-8e3a-4499-b61c-d1656de68257	true	id.token.claim
3fcaa23d-8e3a-4499-b61c-d1656de68257	true	access.token.claim
3fcaa23d-8e3a-4499-b61c-d1656de68257	birthdate	claim.name
3fcaa23d-8e3a-4499-b61c-d1656de68257	String	jsonType.label
910adb49-9f84-427b-a983-92a3da12126b	true	userinfo.token.claim
910adb49-9f84-427b-a983-92a3da12126b	zoneinfo	user.attribute
910adb49-9f84-427b-a983-92a3da12126b	true	id.token.claim
910adb49-9f84-427b-a983-92a3da12126b	true	access.token.claim
910adb49-9f84-427b-a983-92a3da12126b	zoneinfo	claim.name
910adb49-9f84-427b-a983-92a3da12126b	String	jsonType.label
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	true	userinfo.token.claim
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	locale	user.attribute
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	true	id.token.claim
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	true	access.token.claim
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	locale	claim.name
dc37ba0d-0919-4f3e-bb03-68f83d5dc547	String	jsonType.label
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	true	userinfo.token.claim
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	updatedAt	user.attribute
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	true	id.token.claim
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	true	access.token.claim
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	updated_at	claim.name
f4f27bfc-cbdd-4ebb-abfc-a385672c0387	long	jsonType.label
72200f9c-2934-47e4-a271-1f52626c2607	true	userinfo.token.claim
72200f9c-2934-47e4-a271-1f52626c2607	email	user.attribute
72200f9c-2934-47e4-a271-1f52626c2607	true	id.token.claim
72200f9c-2934-47e4-a271-1f52626c2607	true	access.token.claim
72200f9c-2934-47e4-a271-1f52626c2607	email	claim.name
72200f9c-2934-47e4-a271-1f52626c2607	String	jsonType.label
525e7d11-172c-4582-87fe-339912c797f8	true	userinfo.token.claim
525e7d11-172c-4582-87fe-339912c797f8	emailVerified	user.attribute
525e7d11-172c-4582-87fe-339912c797f8	true	id.token.claim
525e7d11-172c-4582-87fe-339912c797f8	true	access.token.claim
525e7d11-172c-4582-87fe-339912c797f8	email_verified	claim.name
525e7d11-172c-4582-87fe-339912c797f8	boolean	jsonType.label
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	formatted	user.attribute.formatted
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	country	user.attribute.country
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	postal_code	user.attribute.postal_code
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	true	userinfo.token.claim
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	street	user.attribute.street
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	true	id.token.claim
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	region	user.attribute.region
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	true	access.token.claim
359fb8e6-75ff-4dd3-aea3-abbfa07ae070	locality	user.attribute.locality
4a5511fe-ba17-47c3-a67f-c5a075423b0c	true	userinfo.token.claim
4a5511fe-ba17-47c3-a67f-c5a075423b0c	phoneNumber	user.attribute
4a5511fe-ba17-47c3-a67f-c5a075423b0c	true	id.token.claim
4a5511fe-ba17-47c3-a67f-c5a075423b0c	true	access.token.claim
4a5511fe-ba17-47c3-a67f-c5a075423b0c	phone_number	claim.name
4a5511fe-ba17-47c3-a67f-c5a075423b0c	String	jsonType.label
57033ecc-b5bb-409f-9bc7-51c100215231	true	userinfo.token.claim
57033ecc-b5bb-409f-9bc7-51c100215231	phoneNumberVerified	user.attribute
57033ecc-b5bb-409f-9bc7-51c100215231	true	id.token.claim
57033ecc-b5bb-409f-9bc7-51c100215231	true	access.token.claim
57033ecc-b5bb-409f-9bc7-51c100215231	phone_number_verified	claim.name
57033ecc-b5bb-409f-9bc7-51c100215231	boolean	jsonType.label
f86114ab-166b-4f18-879c-96ba375686b2	true	multivalued
f86114ab-166b-4f18-879c-96ba375686b2	foo	user.attribute
f86114ab-166b-4f18-879c-96ba375686b2	true	access.token.claim
f86114ab-166b-4f18-879c-96ba375686b2	realm_access.roles	claim.name
f86114ab-166b-4f18-879c-96ba375686b2	String	jsonType.label
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	true	multivalued
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	foo	user.attribute
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	true	access.token.claim
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	resource_access.${client_id}.roles	claim.name
968a2f48-8bcb-40ea-9a4c-0c27c702fd4d	String	jsonType.label
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	true	userinfo.token.claim
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	username	user.attribute
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	true	id.token.claim
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	true	access.token.claim
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	upn	claim.name
bc64cf44-b2a4-4374-bad7-e0d39d9b02c1	String	jsonType.label
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	true	multivalued
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	foo	user.attribute
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	true	id.token.claim
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	true	access.token.claim
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	groups	claim.name
4a28eb6b-82f3-4360-a524-cfc9bf77e93c	String	jsonType.label
610c825f-16a8-4409-8c61-49e1d6d0e1fb	true	id.token.claim
610c825f-16a8-4409-8c61-49e1d6d0e1fb	true	access.token.claim
d5cea4e8-acb6-413c-a06d-e9e3ab5ed08f	true	id.token.claim
d5cea4e8-acb6-413c-a06d-e9e3ab5ed08f	true	access.token.claim
d5cea4e8-acb6-413c-a06d-e9e3ab5ed08f	true	userinfo.token.claim
b27919bf-df5f-463a-a91b-cfcde4580de7	foo	user.attribute
b27919bf-df5f-463a-a91b-cfcde4580de7	true	access.token.claim
b27919bf-df5f-463a-a91b-cfcde4580de7	resource_access.${client_id}.roles	claim.name
b27919bf-df5f-463a-a91b-cfcde4580de7	String	jsonType.label
b27919bf-df5f-463a-a91b-cfcde4580de7	true	multivalued
9f437a33-577a-428e-814b-7b895c67addc	foo	user.attribute
9f437a33-577a-428e-814b-7b895c67addc	true	access.token.claim
9f437a33-577a-428e-814b-7b895c67addc	realm_access.roles	claim.name
9f437a33-577a-428e-814b-7b895c67addc	String	jsonType.label
9f437a33-577a-428e-814b-7b895c67addc	true	multivalued
96197993-2e17-477a-bced-9971caffbfab	true	userinfo.token.claim
96197993-2e17-477a-bced-9971caffbfab	emailVerified	user.attribute
96197993-2e17-477a-bced-9971caffbfab	true	id.token.claim
96197993-2e17-477a-bced-9971caffbfab	true	access.token.claim
96197993-2e17-477a-bced-9971caffbfab	email_verified	claim.name
96197993-2e17-477a-bced-9971caffbfab	boolean	jsonType.label
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	userinfo.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	user.attribute
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	id.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	access.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	claim.name
23cba6c0-9ade-4921-92d3-0edb9d671f0f	String	jsonType.label
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	userinfo.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phoneNumber	user.attribute
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	id.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	access.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phone_number	claim.name
28f94d9d-d8cd-4b53-ad7b-308fd186f739	String	jsonType.label
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	userinfo.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phoneNumberVerified	user.attribute
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	id.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	access.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phone_number_verified	claim.name
7d712ea3-b357-4a6b-a8dc-79c6189cf517	boolean	jsonType.label
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	userinfo.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	username	user.attribute
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	id.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	access.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	upn	claim.name
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	String	jsonType.label
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	multivalued
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	userinfo.token.claim
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	foo	user.attribute
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	id.token.claim
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	access.token.claim
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	groups	claim.name
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	String	jsonType.label
6896dbf2-8ded-4933-a98e-6a148a835e96	false	single
6896dbf2-8ded-4933-a98e-6a148a835e96	Basic	attribute.nameformat
6896dbf2-8ded-4933-a98e-6a148a835e96	Role	attribute.name
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	userinfo.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	firstName	user.attribute
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	id.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	access.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	given_name	claim.name
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	String	jsonType.label
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	userinfo.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updatedAt	user.attribute
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	id.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	access.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updated_at	claim.name
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	String	jsonType.label
700eb412-f80c-42ef-a0a0-350f8578274a	true	id.token.claim
700eb412-f80c-42ef-a0a0-350f8578274a	true	access.token.claim
700eb412-f80c-42ef-a0a0-350f8578274a	true	userinfo.token.claim
7c97b048-915e-4742-8879-6e28b457f014	true	userinfo.token.claim
7c97b048-915e-4742-8879-6e28b457f014	profile	user.attribute
7c97b048-915e-4742-8879-6e28b457f014	true	id.token.claim
7c97b048-915e-4742-8879-6e28b457f014	true	access.token.claim
7c97b048-915e-4742-8879-6e28b457f014	profile	claim.name
7c97b048-915e-4742-8879-6e28b457f014	String	jsonType.label
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	userinfo.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	user.attribute
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	id.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	access.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	claim.name
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	String	jsonType.label
79009f2e-12cf-4022-ab87-070d418d6a17	true	userinfo.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	username	user.attribute
79009f2e-12cf-4022-ab87-070d418d6a17	true	id.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	true	access.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	preferred_username	claim.name
79009f2e-12cf-4022-ab87-070d418d6a17	String	jsonType.label
5268821b-7d20-46ba-8a4f-05793c43269b	true	userinfo.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	gender	user.attribute
5268821b-7d20-46ba-8a4f-05793c43269b	true	id.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	true	access.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	gender	claim.name
5268821b-7d20-46ba-8a4f-05793c43269b	String	jsonType.label
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	userinfo.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	lastName	user.attribute
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	id.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	access.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	family_name	claim.name
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	String	jsonType.label
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	userinfo.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	user.attribute
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	id.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	access.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	claim.name
d079a677-f367-4e6a-92e2-d32d2c03ff12	String	jsonType.label
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	userinfo.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	user.attribute
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	id.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	access.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	claim.name
4bbfe834-87d2-4a04-a079-d0e4206cc406	String	jsonType.label
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	userinfo.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	user.attribute
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	id.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	access.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	claim.name
1fbe377f-b45d-43cc-9272-a539bc656e2d	String	jsonType.label
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	userinfo.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middleName	user.attribute
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	id.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	access.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middle_name	claim.name
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	String	jsonType.label
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	userinfo.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	user.attribute
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	id.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	access.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	claim.name
45f4de79-9096-4dbd-bd4a-957d40bbe01f	String	jsonType.label
d2405431-6415-4547-9cbf-6ad491b4f851	true	userinfo.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	website	user.attribute
d2405431-6415-4547-9cbf-6ad491b4f851	true	id.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	true	access.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	website	claim.name
d2405431-6415-4547-9cbf-6ad491b4f851	String	jsonType.label
1be633bc-17d6-44f9-b5d9-161c6277a62e	formatted	user.attribute.formatted
1be633bc-17d6-44f9-b5d9-161c6277a62e	country	user.attribute.country
1be633bc-17d6-44f9-b5d9-161c6277a62e	postal_code	user.attribute.postal_code
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	userinfo.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	street	user.attribute.street
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	id.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	region	user.attribute.region
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	access.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	locality	user.attribute.locality
92d38df7-7473-491e-b132-f78748a23de6	true	userinfo.token.claim
92d38df7-7473-491e-b132-f78748a23de6	locale	user.attribute
92d38df7-7473-491e-b132-f78748a23de6	true	id.token.claim
92d38df7-7473-491e-b132-f78748a23de6	true	access.token.claim
92d38df7-7473-491e-b132-f78748a23de6	locale	claim.name
92d38df7-7473-491e-b132-f78748a23de6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
afa54666-f1b9-40de-9536-29bb76f3fd42	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	b70c8f9d-82f3-401a-9005-5a393c1bd232	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7f229f96-c54a-47fd-8c96-574f5a12d3de	51440119-960a-4a32-b1b7-fee99be36244	20618c14-29d5-4714-a1a4-3a0b48318292	f4e345d6-6b3b-40e9-a520-2ad726d600f7	e271c895-d606-436c-8003-4380af301103	2592000	f	900	t	f	053a930a-5024-4066-8196-b8259c624e8c	0	f	0	0	1122227e-8209-4a2f-ae4d-50845b150a92
easybackend	60	300	300	\N	\N	\N	t	f	0	\N	easybackend	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	15b2959b-7590-4380-8b13-409c21e10307	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	0d9f5e77-0339-4d99-b787-d5264b222719	67912c08-47f9-430e-819d-f68612305d84	9cc13fec-c2fc-4ee9-9cfa-f7a85ac3072e	de1df936-ab14-41af-8798-3e9b7d3ea2fb	f29f34ee-5f8b-456a-8578-fc8a49453277	2592000	f	900	t	f	e4717031-ae75-4679-a227-c2cf38a590a9	0	f	0	0	780b83c6-426a-4bb4-9fe9-a6dadcb51044
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	afa54666-f1b9-40de-9536-29bb76f3fd42	
_browser_header.xContentTypeOptions	afa54666-f1b9-40de-9536-29bb76f3fd42	nosniff
_browser_header.xRobotsTag	afa54666-f1b9-40de-9536-29bb76f3fd42	none
_browser_header.xFrameOptions	afa54666-f1b9-40de-9536-29bb76f3fd42	SAMEORIGIN
_browser_header.contentSecurityPolicy	afa54666-f1b9-40de-9536-29bb76f3fd42	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	afa54666-f1b9-40de-9536-29bb76f3fd42	1; mode=block
_browser_header.strictTransportSecurity	afa54666-f1b9-40de-9536-29bb76f3fd42	max-age=31536000; includeSubDomains
bruteForceProtected	afa54666-f1b9-40de-9536-29bb76f3fd42	false
permanentLockout	afa54666-f1b9-40de-9536-29bb76f3fd42	false
maxFailureWaitSeconds	afa54666-f1b9-40de-9536-29bb76f3fd42	900
minimumQuickLoginWaitSeconds	afa54666-f1b9-40de-9536-29bb76f3fd42	60
waitIncrementSeconds	afa54666-f1b9-40de-9536-29bb76f3fd42	60
quickLoginCheckMilliSeconds	afa54666-f1b9-40de-9536-29bb76f3fd42	1000
maxDeltaTimeSeconds	afa54666-f1b9-40de-9536-29bb76f3fd42	43200
failureFactor	afa54666-f1b9-40de-9536-29bb76f3fd42	30
displayName	afa54666-f1b9-40de-9536-29bb76f3fd42	Keycloak
displayNameHtml	afa54666-f1b9-40de-9536-29bb76f3fd42	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	afa54666-f1b9-40de-9536-29bb76f3fd42	RS256
offlineSessionMaxLifespanEnabled	afa54666-f1b9-40de-9536-29bb76f3fd42	false
offlineSessionMaxLifespan	afa54666-f1b9-40de-9536-29bb76f3fd42	5184000
clientSessionIdleTimeout	easybackend	0
clientSessionMaxLifespan	easybackend	0
clientOfflineSessionIdleTimeout	easybackend	0
clientOfflineSessionMaxLifespan	easybackend	0
oauth2DeviceCodeLifespan	easybackend	600
oauth2DevicePollingInterval	easybackend	5
cibaBackchannelTokenDeliveryMode	easybackend	poll
cibaExpiresIn	easybackend	120
cibaInterval	easybackend	5
cibaAuthRequestedUserHint	easybackend	login_hint
parRequestUriLifespan	easybackend	60
acr.loa.map	easybackend	[]
frontendUrl	easybackend	http://eb-keycloak:8080/auth
displayName	easybackend	
displayNameHtml	easybackend	
bruteForceProtected	easybackend	false
permanentLockout	easybackend	false
maxFailureWaitSeconds	easybackend	900
minimumQuickLoginWaitSeconds	easybackend	60
waitIncrementSeconds	easybackend	60
quickLoginCheckMilliSeconds	easybackend	1000
maxDeltaTimeSeconds	easybackend	43200
failureFactor	easybackend	30
actionTokenGeneratedByAdminLifespan	easybackend	43200
actionTokenGeneratedByUserLifespan	easybackend	300
defaultSignatureAlgorithm	easybackend	RS256
offlineSessionMaxLifespanEnabled	easybackend	false
offlineSessionMaxLifespan	easybackend	5184000
webAuthnPolicyRpEntityName	easybackend	keycloak
webAuthnPolicySignatureAlgorithms	easybackend	ES256
webAuthnPolicyRpId	easybackend	
webAuthnPolicyAttestationConveyancePreference	easybackend	not specified
webAuthnPolicyAuthenticatorAttachment	easybackend	not specified
webAuthnPolicyRequireResidentKey	easybackend	not specified
webAuthnPolicyUserVerificationRequirement	easybackend	not specified
webAuthnPolicyCreateTimeout	easybackend	0
webAuthnPolicyAvoidSameAuthenticatorRegister	easybackend	false
webAuthnPolicyRpEntityNamePasswordless	easybackend	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	easybackend	ES256
webAuthnPolicyRpIdPasswordless	easybackend	
webAuthnPolicyAttestationConveyancePreferencePasswordless	easybackend	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	easybackend	not specified
webAuthnPolicyRequireResidentKeyPasswordless	easybackend	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	easybackend	not specified
webAuthnPolicyCreateTimeoutPasswordless	easybackend	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	easybackend	false
client-policies.profiles	easybackend	{"profiles":[]}
client-policies.policies	easybackend	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	easybackend	
_browser_header.xContentTypeOptions	easybackend	nosniff
_browser_header.xRobotsTag	easybackend	none
_browser_header.xFrameOptions	easybackend	SAMEORIGIN
_browser_header.contentSecurityPolicy	easybackend	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	easybackend	1; mode=block
_browser_header.strictTransportSecurity	easybackend	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
afa54666-f1b9-40de-9536-29bb76f3fd42	jboss-logging
easybackend	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	afa54666-f1b9-40de-9536-29bb76f3fd42
password	password	t	t	easybackend
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
17e0a299-d39e-4df6-ac36-cb0d1ffbbba9	/realms/master/account/*
f63eb124-b58b-40ee-819e-453e94b161b4	/realms/master/account/*
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	/admin/master/console/*
544e5eb0-3d17-4823-a9af-f15e289f63bc	/realms/easybackend/account/*
4f8b866a-cccf-4fe0-b2fb-72261ea37634	/realms/easybackend/account/*
0c1072d0-fbe2-4759-9c08-a399a7faa47b	/admin/easybackend/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
ba9bb339-b9ee-40c4-ae96-f38f1841389e	VERIFY_EMAIL	Verify Email	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	VERIFY_EMAIL	50
fce49aaf-004e-475a-81b2-6cd80c62a38d	UPDATE_PROFILE	Update Profile	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	UPDATE_PROFILE	40
e30dca6d-0523-4f39-8acf-73beef57d8dd	CONFIGURE_TOTP	Configure OTP	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	CONFIGURE_TOTP	10
5ab50398-8305-4b03-a192-c51741cfbb19	UPDATE_PASSWORD	Update Password	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	UPDATE_PASSWORD	30
fd0eace9-978e-4d3f-b2d6-5af040b0ca66	terms_and_conditions	Terms and Conditions	afa54666-f1b9-40de-9536-29bb76f3fd42	f	f	terms_and_conditions	20
0bbcefc7-4162-4e2e-923a-1e40c733dd2a	update_user_locale	Update User Locale	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	update_user_locale	1000
a87c60b0-abb4-4be4-9662-33003a636ff5	delete_account	Delete Account	afa54666-f1b9-40de-9536-29bb76f3fd42	f	f	delete_account	60
bcaa774c-47a5-489c-9776-3832f452a183	webauthn-register	Webauthn Register	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	webauthn-register	70
d69e5e47-a45a-407c-97c0-f56142af100f	webauthn-register-passwordless	Webauthn Register Passwordless	afa54666-f1b9-40de-9536-29bb76f3fd42	t	f	webauthn-register-passwordless	80
b540863e-fdc3-43b9-ae0f-f593c14089eb	CONFIGURE_TOTP	Configure OTP	easybackend	t	f	CONFIGURE_TOTP	10
0171ee6d-db8f-4c1e-963b-a77f9116ab67	terms_and_conditions	Terms and Conditions	easybackend	f	f	terms_and_conditions	20
34509aef-d578-42c0-b1ee-45652c354223	UPDATE_PASSWORD	Update Password	easybackend	t	f	UPDATE_PASSWORD	30
15579868-3fe3-4dc0-a9c8-7473f89fc1a9	UPDATE_PROFILE	Update Profile	easybackend	t	f	UPDATE_PROFILE	40
217d1c2c-d0f3-48b1-a95f-0086eb51007a	VERIFY_EMAIL	Verify Email	easybackend	t	f	VERIFY_EMAIL	50
f834717f-0edd-4466-832e-8d9d33cd97cb	delete_account	Delete Account	easybackend	f	f	delete_account	60
451a38ea-d0a6-4d53-a432-4936118067e0	update_user_locale	Update User Locale	easybackend	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
f63eb124-b58b-40ee-819e-453e94b161b4	4beec3e6-1319-401d-9f34-12d9b7e7a3ea
4f8b866a-cccf-4fe0-b2fb-72261ea37634	78c089cd-fe4e-4575-aa38-768840bfe270
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e7a99c31-3abb-42e0-95db-f4917dec672f	\N	b2e82272-aa3b-42ca-be82-714e94d8026b	f	t	\N	\N	\N	afa54666-f1b9-40de-9536-29bb76f3fd42	admin	1669048961184	\N	0
108df9c1-3c7f-4f88-aea8-36558fd2bf74	easy0@easysmpc.org	easy0@easysmpc.org	t	t	\N			easybackend	easy0	1669049143447	\N	0
de9ec862-0ba4-4289-9903-77a3ba2ce25c	easy1@easysmpc.org	easy1@easysmpc.org	t	t	\N			easybackend	easy1	1669050198851	\N	0
5a62483b-4157-4399-9225-504e354f32e9	easy2@easysmpc.org	easy2@easysmpc.org	t	t	\N			easybackend	easy2	1669050239105	\N	0
a19c4fb4-3afe-4c60-b994-00422f570a6e	easy3@easysmpc.org	easy3@easysmpc.org	t	t	\N			easybackend	easy3	1669050273389	\N	0
aa8cd899-88b2-48f7-a098-dee3718125ef	easy4@easysmpc.org	easy4@easysmpc.org	t	t	\N			easybackend	easy4	1669050304789	\N	0
3691c7e2-af12-496c-b4a3-3f8ef953214b	easy5@easysmpc.org	easy5@easysmpc.org	t	t	\N			easybackend	easy5	1669050339648	\N	0
6e241e99-6ff8-4b03-a7cb-72cbad5ce08c	easy6@easysmpc.org	easy6@easysmpc.org	t	t	\N			easybackend	easy6	1669052610586	\N	0
c3afe492-873e-40b6-a5e3-137828e8881b	easy7@easysmpc.org	easy7@easysmpc.org	t	t	\N			easybackend	easy7	1669052913666	\N	0
ce17443e-b1cc-4b7e-815c-da9c2a43ff55	easy8@easysmpc.org	easy8@easysmpc.org	t	t	\N			easybackend	easy8	1669052956225	\N	0
d7bdd921-bc8b-458f-ba25-76b8fa0ed695	easy10@easysmpc.org	easy10@easysmpc.org	t	t	\N			easybackend	easy10	1669057076705	\N	0
028f6163-95d2-4924-885e-a433b9bf21a5	easy9@easysmpc.org	easy9@easysmpc.org	t	t	\N			easybackend	easy9	1669057049608	\N	0
27b0fa2e-4880-4090-9d7c-82e2918e35e8	easy11@easysmpc.org	easy11@easysmpc.org	t	t	\N			easybackend	easy11	1669057724461	\N	0
3e72a48d-a17d-4bff-a63b-2f34d5b3e296	easy12@easysmpc.org	easy12@easysmpc.org	t	t	\N			easybackend	easy12	1669057754593	\N	0
518f113f-6b7f-463e-9566-8b3860ef6410	easy13@easysmpc.org	easy13@easysmpc.org	t	t	\N			easybackend	easy13	1669057775361	\N	0
11dbace1-4455-45c3-ac22-0e1a2b17fbd7	easy14@easysmpc.org	easy14@easysmpc.org	t	t	\N			easybackend	easy14	1669057805966	\N	0
87004960-05fe-4678-8947-d4cfe4fd0491	easy15@easysmpc.org	easy15@easysmpc.org	t	t	\N			easybackend	easy15	1669057848332	\N	0
6aaffa4b-104a-4260-97c0-b37e7e6f6395	easy16@easysmpc.org	easy16@easysmpc.org	t	t	\N			easybackend	easy16	1669057879721	\N	0
43c47199-13bf-44d2-9beb-05082ec52399	easy17@easysmpc.org	easy17@easysmpc.org	t	t	\N			easybackend	easy17	1669057909690	\N	0
93e954f0-9ee0-499f-b46c-e58868390e3d	easy18@easysmpc.org	easy18@easysmpc.org	t	t	\N			easybackend	easy18	1669057935230	\N	0
c2c25e9e-bb77-4adf-b1fc-17c1bd805aa4	easy19@easysmpc.org	easy19@easysmpc.org	t	t	\N			easybackend	easy19	1669057973337	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
1122227e-8209-4a2f-ae4d-50845b150a92	e7a99c31-3abb-42e0-95db-f4917dec672f
4a9430bc-1541-49ac-b9ff-1cde6087d429	e7a99c31-3abb-42e0-95db-f4917dec672f
780b83c6-426a-4bb4-9fe9-a6dadcb51044	108df9c1-3c7f-4f88-aea8-36558fd2bf74
4151be0f-2133-4dca-ad72-693b73923c3b	108df9c1-3c7f-4f88-aea8-36558fd2bf74
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	108df9c1-3c7f-4f88-aea8-36558fd2bf74
780b83c6-426a-4bb4-9fe9-a6dadcb51044	de9ec862-0ba4-4289-9903-77a3ba2ce25c
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	de9ec862-0ba4-4289-9903-77a3ba2ce25c
780b83c6-426a-4bb4-9fe9-a6dadcb51044	5a62483b-4157-4399-9225-504e354f32e9
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	5a62483b-4157-4399-9225-504e354f32e9
780b83c6-426a-4bb4-9fe9-a6dadcb51044	a19c4fb4-3afe-4c60-b994-00422f570a6e
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	a19c4fb4-3afe-4c60-b994-00422f570a6e
780b83c6-426a-4bb4-9fe9-a6dadcb51044	aa8cd899-88b2-48f7-a098-dee3718125ef
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	aa8cd899-88b2-48f7-a098-dee3718125ef
780b83c6-426a-4bb4-9fe9-a6dadcb51044	3691c7e2-af12-496c-b4a3-3f8ef953214b
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	3691c7e2-af12-496c-b4a3-3f8ef953214b
780b83c6-426a-4bb4-9fe9-a6dadcb51044	6e241e99-6ff8-4b03-a7cb-72cbad5ce08c
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	6e241e99-6ff8-4b03-a7cb-72cbad5ce08c
780b83c6-426a-4bb4-9fe9-a6dadcb51044	c3afe492-873e-40b6-a5e3-137828e8881b
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	c3afe492-873e-40b6-a5e3-137828e8881b
780b83c6-426a-4bb4-9fe9-a6dadcb51044	ce17443e-b1cc-4b7e-815c-da9c2a43ff55
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	ce17443e-b1cc-4b7e-815c-da9c2a43ff55
780b83c6-426a-4bb4-9fe9-a6dadcb51044	028f6163-95d2-4924-885e-a433b9bf21a5
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	028f6163-95d2-4924-885e-a433b9bf21a5
780b83c6-426a-4bb4-9fe9-a6dadcb51044	d7bdd921-bc8b-458f-ba25-76b8fa0ed695
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	d7bdd921-bc8b-458f-ba25-76b8fa0ed695
780b83c6-426a-4bb4-9fe9-a6dadcb51044	27b0fa2e-4880-4090-9d7c-82e2918e35e8
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	27b0fa2e-4880-4090-9d7c-82e2918e35e8
780b83c6-426a-4bb4-9fe9-a6dadcb51044	3e72a48d-a17d-4bff-a63b-2f34d5b3e296
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	3e72a48d-a17d-4bff-a63b-2f34d5b3e296
780b83c6-426a-4bb4-9fe9-a6dadcb51044	518f113f-6b7f-463e-9566-8b3860ef6410
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	518f113f-6b7f-463e-9566-8b3860ef6410
780b83c6-426a-4bb4-9fe9-a6dadcb51044	11dbace1-4455-45c3-ac22-0e1a2b17fbd7
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	11dbace1-4455-45c3-ac22-0e1a2b17fbd7
780b83c6-426a-4bb4-9fe9-a6dadcb51044	87004960-05fe-4678-8947-d4cfe4fd0491
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	87004960-05fe-4678-8947-d4cfe4fd0491
780b83c6-426a-4bb4-9fe9-a6dadcb51044	6aaffa4b-104a-4260-97c0-b37e7e6f6395
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	6aaffa4b-104a-4260-97c0-b37e7e6f6395
780b83c6-426a-4bb4-9fe9-a6dadcb51044	43c47199-13bf-44d2-9beb-05082ec52399
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	43c47199-13bf-44d2-9beb-05082ec52399
780b83c6-426a-4bb4-9fe9-a6dadcb51044	93e954f0-9ee0-499f-b46c-e58868390e3d
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	93e954f0-9ee0-499f-b46c-e58868390e3d
780b83c6-426a-4bb4-9fe9-a6dadcb51044	c2c25e9e-bb77-4adf-b1fc-17c1bd805aa4
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	c2c25e9e-bb77-4adf-b1fc-17c1bd805aa4
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
e37c4dbc-3646-4b26-9ee9-a834d03a3d20	+
0c1072d0-fbe2-4759-9c08-a399a7faa47b	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

