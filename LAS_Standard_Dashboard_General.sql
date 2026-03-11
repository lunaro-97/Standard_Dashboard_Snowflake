// ------------------------------------------------------------------------------- CUSTOMER --------------------------------------------------------------------------------------------

// CustomerCRG1CLARO = '912728';
// CustomerCRG1VIVO = '911810';
// CustomerCRG1UYANTEL = '910566';

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------- FUNCTIONS -------------------------------------------------------------------------------------------

// Upper Case Function

create or replace function UpperCaseValues(col varchar(2000))
returns varchar(2000)
language sql
comment = 'UpperCase some filter columns values'
as
$$
    upper(col)
$$;

// Function to Replace Null dates/Future dates

create or replace function ReplaceDates(col date, par varchar(1))
returns date
language sql
comment = 'Replace max date values depending on input'
as
$$
    case
        when col is null and par = '+' then '2100-01-01'
        when col = '2100-01-01' and par = '-' then null
        else col
    end
$$;

// Fix Database Dates
create or replace function FixDBDates(ms varchar(100))
returns date
language sql
comment = 'Fixing wrong format for Milestone Dates from database. Also replacing '' values and N/A'
as
$$

    case
        when ms = '' then null
        when ms = 'N/A' then null
        when contains(ms, '/') then to_date(replace(ms, '/', '-'), 'DD-MM-YYYY')
        else to_date(ms)
    end
$$;

create or replace function Convert_BRCLARO_Validacao(val varchar(100))
returns varchar(100)
language sql
comment = 'Replacing Validação ATIVADO to PRINCIPAL'
as
$$
    case
        when val = 'ATIVADO' then 'PRINCIPAL'
        else val
    end
$$;

create or replace function CustomerNameRplc(cus varchar(1000))
returns varchar(1000)
language sql
comment = 'Convert customer name to fit in Standard Dashboard'
as
$$
    case
        when cus = 'Claro Brasil' then 'BR_CLARO'
        when cus = 'Vivo Brasil' then 'BR_VIVO'
        when cus = 'RLAM_UY_ANTEL' then 'UY_ANTEL'
    end
$$;

create or replace function RemoveWrongRealDates(col date)
returns date
language sql
comment = 'Correct real dates for lead time'
as
$$
    case 
        when col > current_date() then null
    end
$$;

create or replace function ReplaceBlankNoDatesField(element varchar(10000))
returns varchar(10000)
language sql
comment = 'Remove '' from non-date fields'
as
$$
    case
        when element = '' then null
        else element
    end
$$;

create or replace function ConcatTwoColumns(element1 varchar(10000), element2 varchar(10000))
returns varchar(10000)
language sql
comment = 'Concatenate two fields'
as
$$
    concat(element1,'-', element2)
$$;

create or replace function LeadTimeASPs (act varchar(10000))
returns varchar(10000)
language sql
comment = 'Used to change job template names to specific milestones reffered'
as
$$
    case
        when act = 'BR - Site Installation Completed' then 'Installation Real'
        when act = 'BR - SID (ESR)' then 'Solution Document Real'
        when act = 'BR - BoM 3' then 'BOQ3 Real'
        when act = 'BR - Site Final Acceptance Completed (ESR)' then 'Accepted Real'
        when act = 'BR - Site Survey' then 'Site Survey Real'
        when act = 'BR - Integration Completed' then 'Integration Real'
        when act = 'BR - MOS (Material On site (ESR)' then 'MoS'
        when act = 'BR -  Site Design Engineering (ESR)' then 'War Room Real'
        when act = 'BR - Site On Air (ESR)' then 'On Air Real'
        when act = 'UY Antel - Site Ready for Installation' then 'Customer RFI Real'
        else '-'
    end
$$;

create or replace function AntelUQ(UK varchar(100))
returns varchar(100)
language sql
comment = 'Function to segment properly the Unique Site for UY ANTEL'
as
$$
    case
        when position('-' in right(UK, position('-' in UK) + 1)) = 3 then split_part(right(UK, position('-' in UK) + 1), '-', 2)
        else split_part(right(UK, position('-' in UK) + 1), '-', 1)
    end
$$;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------- VIEWS -----------------------------------------------------------------------------------------------


//Standard Dashboard - Logical Activities

create or replace view LAS_SD_LOGICAL_ACTIVITIES as (
    select
    
        "Tools",
        "Country",
        "Customer",
        "Validacao" "Validação do Registro",
        "RegistroID" "ID",
        "Sales Order",
        "Regional",
        "UF",
        ConcatTwoColumns("FAS ID","Prolog") as "FAS ID/Prolog",
        "Unique Site",
        "ASP",
        "EHS Site Survey - Status",
        "EHS Site Survey - Ofensor",
        "EHS Site Survey - ASP",
        "EHS Pre-Climbing Check - Status",
        "EHS Pre-Climbing Check - Ofensor",
        "EHS Pre-Climbing Check - ASP",
        "Milestones",
        "Milestones_Dates" "MS Dates"    
        
    from LAS_BR_CLARO_SD_Logical_Ref
    
    union
    
    select
    
        "Tools",
        "Country",
        "Customer",
        "Validacao" "Validação do Registro",
        "RegistroID" "ID",
        "Sales Order",
        "Regional",
        "UF",
        ConcatTwoColumns("FAS ID","Prolog") as "FAS ID/Prolog",
        "Unique Site",
        "ASP",
        "EHS Site Survey - Status",
        "EHS Site Survey - Ofensor",
        "EHS Site Survey - ASP",
        "EHS Pre-Climbing Check - Status",
        "EHS Pre-Climbing Check - Ofensor",
        "EHS Pre-Climbing Check - ASP",
        "Milestones",
        "Milestones_Dates" "MS Dates"
        
    from LAS_BR_VIVO_SD_Logical_Ref

    union

    select
    
        "Tools",
        "Country",
        "Customer",
        null as "Validação do Registro",
        "Project ID" "ID",
        null as "Sales Order",
        "Regional",
        null as "UF",
        "FAS ID" "FAS ID/Prolog",
        "Unique Site",
        "ASP",
        null as "EHS Site Survey - Status",
        null as "EHS Site Survey - Ofensor",
        null as "EHS Site Survey - ASP",
        null as "EHS Pre-Climbing Check - Status",
        null as "EHS Pre-Climbing Check - Ofensor",
        null as "EHS Pre-Climbing Check - ASP",
        "Milestones",
        "Milestones_Dates" "MS Dates"
        
    from LAS_UY_ANTEL_SD_Logical_Ref
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_SD_LOGICAL_ACTIVITIES;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Standard Dashboard - Physical Activities

create or replace view LAS_SD_PHYSICAL_ACTIVITIES as (
    select 
        "Tools",
        "Country",
        "Customer",
        "Unique Site",
        "Max Milestones",
        "Max Date"
    from LAS_BR_CLARO_SD_Physical_Ref

    union

    select 
        "Tools",
        "Country",
        "Customer",
        "Unique Site",
        "Max Milestones",
        "Max Date"
    from LAS_BR_VIVO_SD_Physical_Ref

    union

    select 
        "Tools",
        "Country",
        "Customer",
        "Unique Site",
        "Max Milestones",
        "Max Date"
    from LAS_UY_ANTEL_SD_Physical_Ref
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_SD_PHYSICAL_ACTIVITIES;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Standard Dashboard Analytics - Lead Time

create or replace view LAS_SD_ANALYTICS_LT as (
    select
        *
    from LAS_BR_CLARO_SD_ANALYTICS_LT

    union

    select
        *
    from LAS_BR_VIVO_SD_ANALYTICS_LT

    union

    select
        *
    from LAS_UY_ANTEL_SD_ANALYTICS_LT
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_SD_ANALYTICS_LT;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Standard Dashboard Analytics - Logical Gap Analysis

create or replace view LAS_SD_ANALYTICS_LOGICAL_GAP_ANALYSIS as (
    select
        *
    from LAS_BR_CLARO_SD_ANALYTICS_LOGICAL_GAP

    union

    select
        *
    from LAS_BR_VIVO_SD_ANALYTICS_LOGICAL_GAP

    union

    select
        *
    from LAS_UY_ANTEL_SD_ANALYTICS_LOGICAL_GAP
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_SD_ANALYTICS_LOGICAL_GAP_ANALYSIS;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Standard Dashboard Analytics - Physical Gap Analysis

create or replace view LAS_SD_ANALYTICS_PHYSICAL_GAP_ANALYSIS as (
    select
        *
    from LAS_BR_CLARO_SD_ANALYTICS_PHYSICAL_GAP

    union

    select
        *
    from LAS_BR_VIVO_SD_ANALYTICS_PHYSICAL_GAP

    union

    select
        *
    from LAS_UY_ANTEL_SD_ANALYTICS_PHYSICAL_GAP
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_SD_ANALYTICS_PHYSICAL_GAP_ANALYSIS;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------