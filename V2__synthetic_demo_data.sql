insert into organisms(name, gram_group) values
('Acinetobacter species', 'Gram-negative'),
('E. coli', 'Gram-negative'),
('K. pneumoniae', 'Gram-negative'),
('S. aureus', 'Gram-positive'),
('S. pneumoniae', 'Gram-positive'),
('Salmonella Typhi', 'Gram-negative'),
('Shigella spp.', 'Gram-negative');

insert into antibiotics(name, atc_code, aware_group) values
('Amikacin', 'J01GB06', 'Access'),
('Ciprofloxacin', 'J01MA02', 'Watch'),
('Co-trimoxazole', 'J01EE01', 'Access'),
('Colistin', 'J01XB01', 'Reserve'),
('Gentamicin', 'J01GB03', 'Access'),
('Meropenem', 'J01DH02', 'Watch'),
('Doxycycline', 'J01AA02', 'Access'),
('Benzylpenicillin', 'J01CE01', 'Access'),
('Nitrofurantoin', 'J01XE01', 'Access'),
('Ertapenem', 'J01DH03', 'Watch');

-- 5,000 synthetic laboratory specimens covering approximately three years.
insert into specimens(patient_reference, organism_id, collection_date, ward, specimen_type)
select
    'P-' || lpad(((g - 1) % 4200 + 1)::text, 6, '0'),
    ((g - 1) % 7) + 1,
    current_date - ((g * 17) % 1095),
    (array['ICU','Medical','Surgical','Emergency','Paediatrics'])[((g - 1) % 5) + 1],
    (array['Blood','Urine','Respiratory','Wound','CSF'])[((g * 3 - 1) % 5) + 1]
from generate_series(1, 5000) g;

-- Six susceptibility tests per specimen: 30,000 result rows.
insert into susceptibility_results(specimen_id, antibiotic_id, status, mic)
select
    s.id,
    a.id,
    case
      when ((s.id * 13 + a.id * 19) % 100) <
           case s.organism_id
             when 1 then case when a.id in (4,6,10) then 62 else 34 end
             when 3 then case when a.id in (6,10) then 38 else 25 end
             when 4 then 22
             else 18
           end then 'R'
      when ((s.id * 7 + a.id * 11) % 100) < 12 then 'I'
      else 'S'
    end,
    round((0.125 + ((s.id * a.id) % 64) * 0.125)::numeric, 3)
from specimens s
join antibiotics a on a.id <= 6;

-- Ten years x twelve months x ten antibiotics = 1,200 consumption rows.
insert into consumption_records(antibiotic_id, year, month, ward, ddd_per_100_bed_days, total_ddd)
select
    a.id,
    y,
    m,
    'All hospitals',
    round((1.2 + a.id * 0.38 + (y - 2017) * 0.12 + m * 0.015 + ((a.id * m + y) % 7) * 0.08)::numeric, 3),
    round((65 + a.id * 24 + (y - 2017) * 6 + m * 1.3 + ((a.id + m) % 5) * 9)::numeric, 3)
from antibiotics a
cross join generate_series(2017, 2026) y
cross join generate_series(1, 12) m;

insert into clinical_alerts(title, severity, status, details, created_at) values
('Carbapenem resistance above quarterly threshold', 'CRITICAL', 'INVESTIGATING', 'Acinetobacter species meropenem resistance exceeded the configured 55 percent threshold.', now() - interval '2 hours'),
('ICU aminoglycoside resistance increase', 'HIGH', 'OPEN', 'A sustained increase was detected over two consecutive surveillance windows.', now() - interval '1 day'),
('Consumption data import incomplete', 'MEDIUM', 'OPEN', 'One monthly pharmacy feed contains fewer rows than expected.', now() - interval '3 days'),
('Duplicate specimen identifiers reviewed', 'LOW', 'RESOLVED', 'Potential duplicates were reconciled using laboratory source identifiers.', now() - interval '8 days');

insert into deployments(service_name, environment, version, health, sync_status, last_sync) values
('amr-api', 'production', '1.4.23', 'Healthy', 'Synced', now() - interval '17 minutes'),
('amr-dashboard', 'production', '1.4.23', 'Healthy', 'Synced', now() - interval '17 minutes'),
('notification-service', 'production', '1.8.4', 'Healthy', 'Synced', now() - interval '33 minutes'),
('data-ingestion-worker', 'production', '2.1.0', 'Degraded', 'OutOfSync', now() - interval '2 hours'),
('reporting-service', 'staging', '1.5.0-rc2', 'Healthy', 'Synced', now() - interval '1 hour');

insert into work_items(item_key, title, status, assignee, sprint, story_points) values
('AMR-601','Implement laboratory CSV ingestion validation','DEPLOYMENT','YA','Sprint 24',5),
('AMR-673','Add Kafka notification event for critical alerts','DEPLOYED','TB','Sprint 24',8),
('AMR-731','Replace synchronous portfolio API call','DEPLOYED','TB','Sprint 24',5),
('AMR-757','New susceptibility dashboard interaction model','VALIDATED','GP','Sprint 24',8),
('AMR-711','Improve antimicrobial operations page','VALIDATED','BT','Sprint 24',3),
('AMR-780','Add quarterly resistance trend endpoint','TEST','PO','Sprint 24',5),
('AMR-781','Add configurable alert thresholds','BACKLOG','YA','Sprint 25',8),
('AMR-782','Create data-quality audit export','BACKLOG','GP','Sprint 25',5),
('AMR-783','Document local clinical governance review','BACKLOG','BT','Sprint 25',3),
('AMR-784','Add ward-level consumption filter','TEST','TB','Sprint 24',5),
('AMR-785','Improve keyboard navigation','VALIDATED','PO','Sprint 24',3),
('AMR-786','Add database query metrics','DEPLOYED','YA','Sprint 24',3);
