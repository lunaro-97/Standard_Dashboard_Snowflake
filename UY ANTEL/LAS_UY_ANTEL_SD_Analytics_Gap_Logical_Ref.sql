// Standard Dashboard - UY ANTEL Report - Analytics - Gap Analysis Logical

create or replace view LAS_UY_ANTEL_SD_ANALYTICS_LOGICAL_GAP as (
    select
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        null as "Validacao do Registro",
        "Project ID" "ID",
        "Regional",
        "FAS ID",
        null as "UF",
        "Unique Site",
        null as "Customer Scope",
        "Milestones",
        "Milestones_Dates" "Dates"
        
    from LAS_UY_ANTEL_SD_LOGICAL_REF
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_UY_ANTEL_SD_ANALYTICS_LOGICAL_GAP;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------