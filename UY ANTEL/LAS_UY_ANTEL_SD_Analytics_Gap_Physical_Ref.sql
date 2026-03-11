// Standard Dashboard - UY ANTEL Report - Analytics - Gap Analysis Physical
create or replace view LAS_UY_ANTEL_SD_ANALYTICS_PHYSICAL_GAP as (
    select 

    """Tools""" "Tools",
    """Scope""" "Scope",
    """Business Type""" "Business Type",
    """Country""" "Country",
    """Customer""" "Customer",
    """Unique Site""" "Unique Site",
    null as "Preliminary Services Real",
    "'Site Survey Plan'" "Site Survey Plan",
    "'Site Survey Real'" "Site Survey Real",
    null as "War Room Plan",
    null as "War Room Real",
    null as "War Room Approved Real",
    null as "Solution Document Plan",
    null as "Solution Document Real",
    null as "Solution Document Approved Plan",
    null as "Solution Document Approved Real",
    null as "BOQ2 Plan",
    null as "BOQ2 Real",
    null as "BOQ3 Plan",
    null as "BOQ3 Real",
    null as "PV Real",
    null as "Customer PO Plan",
    null as "Customer PO Real",
    "'Customer RFI Plan'" "Customer RFI Plan",
    "'Customer RFI Real'" "Customer RFI Real",
    null as "Invoice Plan",
    null as "Invoice Real",
    null as "OV Real",
    null as "ACK Real",
    null as "TX Plan",
    null as "TX Real",
    "'MoS Plan'" "MoS Plan",
    "'MoS Real'" "MoS Real",
    "'Installation Plan'" "Installation Plan",
    "'Installation Real'" "Installation Real",
    "'Integration Plan'" "Integration Plan",
    "'Integration Real'" "Integration Real",
    "'On Air Plan'" "On Air Plan",
    "'On Air Real'" "On Air Real",
    "'Accepted Plan'" "Accepted Plan",
    "'Accepted Real'" "Accepted Real",
    null as "PDI Plan",
    null as "PDI Real",
    null as "EHS Site Survey - Plan",
    null as "EHS Site Survey - Real", 
    null as "EHS Pre-Climbing Check - Plan",
    null as "EHS Pre-Climbing Check - Real"

    from LAS_UY_ANTEL_SD_Physical_Ref
    
    pivot (
        max("Max Date")
        for "Max Milestones" in (
            -- 'Preliminary Services Real',
            -- 'BOQ2 Plan',
            -- 'BOQ2 Real',
            'Site Survey Plan',
            'Site Survey Real',
            -- 'Solution Document Plan',
            -- 'Solution Document Real',
            -- 'Solution Document Approved Plan',
            -- 'Solution Document Approved Real',
            -- 'BOQ3 Plan',
            -- 'BOQ3 Real',
            -- 'PV Real',
            -- 'Customer PO Plan',
            -- 'Customer PO Real',
            'Customer RFI Plan',
            'Customer RFI Real',
            -- 'Invoice Plan',
            -- 'Invoice Real',
            -- 'OV Real',
            -- 'ACK Real',
            -- 'TX Real',
            'MoS Plan',
            'MoS Real',
            'Installation Plan',
            'Installation Real',
            'Integration Plan',
            'Integration Real',
            'On Air Plan',
            'On Air Real',
            'Accepted Plan',
            'Accepted Real' //,
            -- 'War Room Real',
            -- 'War Room Approved Real',
            -- 'PDI Real',
            -- 'War Room Plan',
            -- 'PDI Plan',
            -- 'EHS Site Survey - Plan',
            -- 'EHS Site Survey - Real', 
            -- 'EHS Pre-Climbing Check - Plan',
            -- 'EHS Pre-Climbing Check - Real'
        )
    ) as LAS_UY_ANTEL_SD_ANALYTICS_PHYSICAL_PIVOT
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_UY_ANTEL_SD_ANALYTICS_PHYSICAL_GAP;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------