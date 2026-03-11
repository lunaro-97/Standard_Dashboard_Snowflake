// Standard Dashboard - BR CLARO Report - Analytics - Gap Analysis Logical
create or replace view LAS_BR_CLARO_SD_ANALYTICS_LOGICAL_GAP as (
    select
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "Validacao" "Validacao do Registro",
        "RegistroID" "ID",
        "Regional",
        "FAS ID",
        "UF",
        "Unique Site",
        "Fisico2" "Customer Scope",
        "Milestones",
        "Milestones_Dates" "Dates"
        
    from LAS_BR_CLARO_SD_LOGICAL_REF
    where "Validacao do Registro" = 'PRINCIPAL'
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_CLARO_SD_ANALYTICS_LOGICAL_GAP;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------