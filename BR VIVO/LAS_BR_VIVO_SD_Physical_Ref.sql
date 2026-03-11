// Standard Dashboard - BR VIVO Report - Physical
create or replace view LAS_BR_VIVO_SD_Physical_Ref as (
    with LAS_BR_VIVO_SD_MaxDates as (
        select
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        -- "Validacao",
        -- "RegistroID",
        -- "Regional",
        -- "Prolog",
        //ConcatTwoColumns("Fisico", "Unique Site") as "Fisico1",
        "Unique Site",
        -- "Fisico2",
        -- "Logico",
        max(ReplaceDates("Preliminary Services Real", '+')) "Max Preliminary Services Real",
        max(ReplaceDates("Site Survey Plan", '+')) "Max Site Survey Plan",
        max(ReplaceDates("Site Survey Real", '+')) "Max Site Survey Real",
        max(ReplaceDates("Solution Document Plan", '+')) "Max Solution Document Plan",
        max(ReplaceDates("Solution Document Real", '+')) "Max Solution Document Real",
        max(ReplaceDates("Solution Document Approved Plan", '+')) "Max Solution Document Approved Plan",
        max(ReplaceDates("Solution Document Approved Real", '+')) "Max Solution Document Approved Real",
        max(ReplaceDates("BOQ2 Plan", '+')) "Max BOQ2 Plan",
        max(ReplaceDates("BOQ2 Real", '+')) "Max BOQ2 Real",
        max(ReplaceDates("BOQ3 Plan", '+')) "Max BOQ3 Plan",
        max(ReplaceDates("BOQ3 Real", '+')) "Max BOQ3 Real",
        max(ReplaceDates("PV Real", '+')) "Max PV Real",
        max(ReplaceDates("Customer PO Plan", '+')) "Max Customer PO Plan",
        max(ReplaceDates("Customer PO Real", '+')) "Max Customer PO Real",
        max(ReplaceDates("Customer RFI Plan", '+')) "Max Customer RFI Plan",
        max(ReplaceDates("Customer RFI Real", '+')) "Max Customer RFI Real",
        max(ReplaceDates("Invoice Plan", '+')) "Max Invoice Plan",
        max(ReplaceDates("Invoice Real", '+')) "Max Invoice Real",
        max(ReplaceDates("OV Real", '+')) "Max OV Real",
        max(ReplaceDates("ACK Real", '+')) "Max ACK Real",
        max(ReplaceDates("TX Plan", '+')) "Max TX Plan",
        max(ReplaceDates("TX Real", '+')) "Max TX Real",
        max(ReplaceDates("MoS Plan", '+')) "Max MoS Plan",
        max(ReplaceDates("MoS Real", '+')) "Max MoS Real",
        max(ReplaceDates("Installation Plan", '+')) "Max Installation Plan",
        max(ReplaceDates("Installation Real", '+')) "Max Installation Real",
        max(ReplaceDates("Integration Plan", '+')) "Max Integration Plan",
        max(ReplaceDates("Integration Real", '+')) "Max Integration Real",
        max(ReplaceDates("On Air Plan", '+')) "Max On Air Plan",
        max(ReplaceDates("On Air Real", '+')) "Max On Air Real",
        max(ReplaceDates("Accepted Plan", '+')) "Max Accepted Plan",
        max(ReplaceDates("Accepted Real", '+')) "Max Accepted Real",
        max(ReplaceDates("War Room Plan", '+')) "Max War Room Plan",
        max(ReplaceDates("War Room Real", '+')) "Max War Room Real",
        max(ReplaceDates("PDI Plan", '+')) "Max PDI Plan",
        max(ReplaceDates("PDI Real", '+')) "Max PDI Real",
        max(ReplaceDates("EHS Site Survey - Plan", '+')) "Max EHS Site Survey - Plan",
        max(ReplaceDates("EHS Site Survey - Real", '+')) "Max EHS Site Survey - Real",
        max(ReplaceDates("EHS Pre-Climbing Check - Plan", '+')) "Max EHS Pre-Climbing Check - Plan",
        max(ReplaceDates("EHS Pre-Climbing Check - Real", '+')) "Max EHS Pre-Climbing Check - Real"
    
        from LAS_BR_VIVO_STANDARD_DASHBOARD_PMO
        where equal_null("Logico", null)
        and (not equal_null("Unique Site", '-') or not equal_null("Unique Site", ' -') or not equal_null("Unique Site", null))
        and ("Validacao" = 'PRINCIPAL' or "Validacao" = 'PRINCIPAL-IMPL')
        group by "Tools", "Scope", "Business Type", "Country", "Customer", "Unique Site"
    )

    , LAS_BR_VIVO_SD_MaxDates_Final as(
        select 
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "Unique Site",
        ReplaceDates(max("Max Preliminary Services Real"), '-') "Preliminary Services Real",
        ReplaceDates(max("Max Site Survey Plan"), '-') "Site Survey Plan",
        ReplaceDates(max("Max Site Survey Real"), '-') "Site Survey Real",
        ReplaceDates(max("Max Solution Document Plan"), '-') "Solution Document Plan",
        ReplaceDates(max("Max Solution Document Real"), '-') "Solution Document Real",
        ReplaceDates(max("Max Solution Document Approved Plan"), '-') "Solution Document Approved Plan",
        ReplaceDates(max("Max Solution Document Approved Real"), '-') "Solution Document Approved Real",
        ReplaceDates(max("Max BOQ2 Plan"), '-') "BOQ2 Plan",
        ReplaceDates(max("Max BOQ2 Real"), '-') "BOQ2 Real",
        ReplaceDates(max("Max BOQ3 Plan"), '-') "BOQ3 Plan",
        ReplaceDates(max("Max BOQ3 Real"), '-') "BOQ3 Real",
        ReplaceDates(max("Max PV Real"), '-') "PV Real",
        ReplaceDates(max("Max Customer PO Plan"), '-') "Customer PO Plan",
        ReplaceDates(max("Max Customer PO Real"), '-') "Customer PO Real",
        ReplaceDates(max("Max Customer RFI Plan"), '-') "Customer RFI Plan",
        ReplaceDates(max("Max Customer RFI Real"), '-') "Customer RFI Real",
        ReplaceDates(max("Max Invoice Plan"), '-') "Invoice Plan",
        ReplaceDates(max("Max Invoice Real"), '-') "Invoice Real",
        ReplaceDates(max("Max OV Real"), '-') "OV Real",
        ReplaceDates(max("Max ACK Real"), '-') "ACK Real",
        ReplaceDates(max("Max TX Plan"), '-') "TX Plan",
        ReplaceDates(max("Max TX Real"), '-') "TX Real",
        ReplaceDates(max("Max MoS Plan"), '-') "MoS Plan",
        ReplaceDates(max("Max MoS Real"), '-') "MoS Real",
        ReplaceDates(max("Max Installation Plan"), '-') "Installation Plan",
        ReplaceDates(max("Max Installation Real"), '-') "Installation Real",
        ReplaceDates(max("Max Integration Plan"), '-') "Integration Plan",
        ReplaceDates(max("Max Integration Real"), '-') "Integration Real",
        ReplaceDates(max("Max On Air Plan"), '-') "On Air Plan",
        ReplaceDates(max("Max On Air Real"), '-') "On Air Real",
        ReplaceDates(max("Max Accepted Plan"), '-') "Accepted Plan",
        ReplaceDates(max("Max Accepted Real"), '-') "Accepted Real",
        ReplaceDates(max("Max War Room Plan"), '-') "War Room Plan",
        ReplaceDates(max("Max War Room Real"), '-') "War Room Real",
        ReplaceDates(max("Max PDI Plan"), '-') "PDI Plan",
        ReplaceDates(max("Max PDI Real"), '-') "PDI Real",
        ReplaceDates(max("Max EHS Site Survey - Plan"), '-') "EHS Site Survey - Plan",
        ReplaceDates(max("Max EHS Site Survey - Real"), '-') "EHS Site Survey - Real",
        ReplaceDates(max("Max EHS Pre-Climbing Check - Plan"), '-') "EHS Pre-Climbing Check - Plan",
        ReplaceDates(max("Max EHS Pre-Climbing Check - Real"), '-') "EHS Pre-Climbing Check - Real"
        from LAS_BR_VIVO_SD_MaxDates
        group by "Tools", "Scope", "Business Type", "Country", "Customer", "Unique Site"
    )
    
    //, LAS_BR_VIVO_SD_MaxDates_Final_Unpvt as (
    select 
    "Tools",
    "Scope",
    "Business Type",
    "Country",
    "Customer",
    "Unique Site",
    "Max Milestones",
    "Max Date"
    from LAS_BR_VIVO_SD_MaxDates_Final

    unpivot(
    
        "Max Date" for "Max Milestones"
        in
        (
            "Preliminary Services Real",
            "BOQ2 Plan",
            "BOQ2 Real",
            "Site Survey Plan",
            "Site Survey Real",
            "Solution Document Plan",
            "Solution Document Real",
            "Solution Document Approved Plan",
            "Solution Document Approved Real",
            "BOQ3 Plan",
            "BOQ3 Real",
            "PV Real",
            "Customer PO Plan",
            "Customer PO Real",
            "Customer RFI Plan",
            "Customer RFI Real",
            "Invoice Plan",
            "Invoice Real",
            "OV Real",
            "ACK Real",
            "TX Plan",
            "TX Real",
            "MoS Plan",
            "MoS Real",
            "Installation Plan",
            "Installation Real",
            "Integration Plan",
            "Integration Real",
            "On Air Plan",
            "On Air Real",
            "Accepted Plan",
            "Accepted Real",
            "War Room Real",
            "PDI Real",
            "War Room Plan",
            "PDI Plan",
            "EHS Site Survey - Plan",
            "EHS Site Survey - Real", 
            "EHS Pre-Climbing Check - Plan",
            "EHS Pre-Climbing Check - Real"
            )        
        ) as LAS_BR_VIVO_SD_MaxDates_unpivot

);
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_VIVO_SD_Physical_Ref;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------