// Standard Dashboard - BR CLARO Report - Analytics - Gap Analysis Physical
create or replace view LAS_BR_CLARO_SD_ANALYTICS_PHYSICAL_GAP as (
    select
    
    """Tools""" "Tools",
    """Scope""" "Scope",
    """Business Type""" "Business Type",
    """Country""" "Country",
    """Customer""" "Customer",
    """Unique Site""" "Unique Site",
    "'Preliminary Services Real'" "Preliminary Services Real",
    "'Site Survey Plan'" "Site Survey Plan",
    "'Site Survey Real'" "Site Survey Real",
    "'War Room Plan'" "War Room Plan",
    "'War Room Real'" "War Room Real",
    "'War Room Approved Real'" "War Room Approved Real",
    "'Solution Document Plan'" "Solution Document Plan",
    "'Solution Document Real'" "Solution Document Real",
    "'Solution Document Approved Plan'" "Solution Document Approved Plan",
    "'Solution Document Approved Real'" "Solution Document Approved Real",
    "'BOQ2 Plan'" "BOQ2 Plan",
    "'BOQ2 Real'" "BOQ2 Real",
    "'BOQ3 Plan'" "BOQ3 Plan",
    "'BOQ3 Real'" "BOQ3 Real",
    "'PV Real'" "PV Real",
    "'Customer PO Plan'" "Customer PO Plan",
    "'Customer PO Real'" "Customer PO Real",
    "'Customer RFI Plan'" "Customer RFI Plan",
    "'Customer RFI Real'" "Customer RFI Real",
    "'Invoice Plan'" "Invoice Plan",
    "'Invoice Real'" "Invoice Real",
    "'OV Real'" "OV Real",
    "'ACK Real'" "ACK Real",
    null "TX Plan",
    "'TX Real'" "TX Real",
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
    "'PDI Plan'" "PDI Plan",
    "'PDI Real'" "PDI Real",
    "'EHS Site Survey - Plan'" "EHS Site Survey - Plan",
    "'EHS Site Survey - Real'" "EHS Site Survey - Real", 
    "'EHS Pre-Climbing Check - Plan'" "EHS Pre-Climbing Check - Plan",
    "'EHS Pre-Climbing Check - Real'" "EHS Pre-Climbing Check - Real"

    from LAS_BR_CLARO_SD_Physical_Ref
    
    pivot (
        max("Max Date")
        for "Max Milestones" in (
            'Preliminary Services Real',
            'BOQ2 Plan',
            'BOQ2 Real',
            'Site Survey Plan',
            'Site Survey Real',
            'Solution Document Plan',
            'Solution Document Real',
            'Solution Document Approved Plan',
            'Solution Document Approved Real',
            'BOQ3 Plan',
            'BOQ3 Real',
            'PV Real',
            'Customer PO Plan',
            'Customer PO Real',
            'Customer RFI Plan',
            'Customer RFI Real',
            'Invoice Plan',
            'Invoice Real',
            'OV Real',
            'ACK Real',
            'TX Real',
            'MoS Plan',
            'MoS Real',
            'Installation Plan',
            'Installation Real',
            'Integration Plan',
            'Integration Real',
            'On Air Plan',
            'On Air Real',
            'Accepted Plan',
            'Accepted Real',
            'War Room Real',
            'War Room Approved Real',
            'PDI Real',
            'War Room Plan',
            'PDI Plan',
            'EHS Site Survey - Plan',
            'EHS Site Survey - Real', 
            'EHS Pre-Climbing Check - Plan',
            'EHS Pre-Climbing Check - Real'
        )
    ) as LAS_BR_CLARO_SD_ANALYTICS_PHYSICAL_PIVOT
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_CLARO_SD_ANALYTICS_PHYSICAL_GAP;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------