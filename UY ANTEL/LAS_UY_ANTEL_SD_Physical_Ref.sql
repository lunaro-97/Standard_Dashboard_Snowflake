// Standard Dashboard - UY ANTEL Report - Physical

create or replace view LAS_UY_ANTEL_SD_Physical_Ref as (

    with LAS_UY_ANTEL_SD_MaxDates as (
        select
        
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "Unique Site",
        max(ReplaceDates("Site Survey Plan", '+')) "Max Site Survey Plan",
        max(ReplaceDates("Site Survey Real", '+')) "Max Site Survey Real",
        max(ReplaceDates("Customer RFI Plan", '+')) "Max Customer RFI Plan",
        max(ReplaceDates("Customer RFI Real", '+')) "Max Customer RFI Real",
        max(ReplaceDates("MoS Plan", '+')) "Max MoS Plan",
        max(ReplaceDates("MoS Real", '+')) "Max MoS Real",
        max(ReplaceDates("Installation Plan", '+')) "Max Installation Plan",
        max(ReplaceDates("Installation Real", '+')) "Max Installation Real",
        max(ReplaceDates("Integration Plan", '+')) "Max Integration Plan",
        max(ReplaceDates("Integration Real", '+')) "Max Integration Real",
        max(ReplaceDates("On Air Plan", '+')) "Max On Air Plan",
        max(ReplaceDates("On Air Real", '+')) "Max On Air Real",
        max(ReplaceDates("Accepted Plan", '+')) "Max Accepted Plan",
        max(ReplaceDates("Accepted Real", '+')) "Max Accepted Real"
    
        from LAS_UY_ANTEL_STANDARD_DASHBOARD_PMO
        group by "Tools", "Scope", "Business Type", "Country", "Customer", "Unique Site"
    )
    
    , LAS_UY_ANTEL_SD_MaxDates_Final as(
        select 
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "Unique Site",
        ReplaceDates(max("Max Site Survey Plan"), '-') "Site Survey Plan",
        ReplaceDates(max("Max Site Survey Real"), '-') "Site Survey Real",
        ReplaceDates(max("Max Customer RFI Plan"), '-') "Customer RFI Plan",
        ReplaceDates(max("Max Customer RFI Real"), '-') "Customer RFI Real",
        ReplaceDates(max("Max MoS Plan"), '-') "MoS Plan",
        ReplaceDates(max("Max MoS Real"), '-') "MoS Real",
        ReplaceDates(max("Max Installation Plan"), '-') "Installation Plan",
        ReplaceDates(max("Max Installation Real"), '-') "Installation Real",
        ReplaceDates(max("Max Integration Plan"), '-') "Integration Plan",
        ReplaceDates(max("Max Integration Real"), '-') "Integration Real",
        ReplaceDates(max("Max On Air Plan"), '-') "On Air Plan",
        ReplaceDates(max("Max On Air Real"), '-') "On Air Real",
        ReplaceDates(max("Max Accepted Plan"), '-') "Accepted Plan",
        ReplaceDates(max("Max Accepted Real"), '-') "Accepted Real"

        from LAS_UY_ANTEL_SD_MaxDates
        group by "Tools", "Scope", "Business Type", "Country", "Customer", "Unique Site"
    )
    
    select 
    "Tools",
    "Scope",
    "Business Type",
    "Country",
    "Customer",
    "Unique Site",
    "Max Milestones",
    "Max Date"
    from LAS_UY_ANTEL_SD_MaxDates_Final
    
    unpivot(
    
        "Max Date" for "Max Milestones"
        in
        (
            "Site Survey Plan",
            "Site Survey Real",
            "Customer RFI Plan",
            "Customer RFI Real",
            "MoS Plan",
            "MoS Real",
            "Installation Plan",
            "Installation Real",
            "Integration Plan",
            "Integration Real",
            "On Air Plan",
            "On Air Real",
            "Accepted Plan",
            "Accepted Real"
        )        
    ) as LAS_UY_ANTEL_SD_MaxDates_unpivot
);

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_UY_ANTEL_SD_Physical_Ref;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------