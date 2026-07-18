create table organisms (
    id bigserial primary key,
    name varchar(120) not null unique,
    gram_group varchar(32) not null
);

create table antibiotics (
    id bigserial primary key,
    name varchar(120) not null unique,
    atc_code varchar(16),
    aware_group varchar(16) not null
);

create table specimens (
    id bigserial primary key,
    patient_reference varchar(32) not null,
    organism_id bigint not null references organisms(id),
    collection_date date not null,
    ward varchar(64) not null,
    specimen_type varchar(64) not null
);
create index idx_specimens_date on specimens(collection_date);
create index idx_specimens_organism on specimens(organism_id);
create index idx_specimens_patient on specimens(patient_reference);

create table susceptibility_results (
    id bigserial primary key,
    specimen_id bigint not null references specimens(id) on delete cascade,
    antibiotic_id bigint not null references antibiotics(id),
    status varchar(16) not null check (status in ('S','I','R','NOT_TESTED')),
    mic numeric(8,3),
    constraint uk_specimen_antibiotic unique(specimen_id, antibiotic_id)
);
create index idx_susceptibility_status on susceptibility_results(status);
create index idx_susceptibility_antibiotic on susceptibility_results(antibiotic_id);

create table consumption_records (
    id bigserial primary key,
    antibiotic_id bigint not null references antibiotics(id),
    year integer not null check (year between 2000 and 2100),
    month integer not null check (month between 1 and 12),
    ward varchar(64) not null,
    ddd_per_100_bed_days numeric(10,3) not null,
    total_ddd numeric(12,3) not null
);
create index idx_consumption_period on consumption_records(year, month);

create table clinical_alerts (
    id bigserial primary key,
    title varchar(180) not null,
    severity varchar(16) not null check (severity in ('LOW','MEDIUM','HIGH','CRITICAL')),
    status varchar(24) not null check (status in ('OPEN','INVESTIGATING','RESOLVED','DISMISSED')),
    details text not null,
    created_at timestamptz not null
);

create table deployments (
    id bigserial primary key,
    service_name varchar(100) not null,
    environment varchar(40) not null,
    version varchar(40) not null,
    health varchar(24) not null,
    sync_status varchar(24) not null,
    last_sync timestamptz not null
);

create table work_items (
    id bigserial primary key,
    item_key varchar(20) not null unique,
    title varchar(220) not null,
    status varchar(32) not null,
    assignee varchar(100),
    sprint varchar(80),
    story_points integer
);
