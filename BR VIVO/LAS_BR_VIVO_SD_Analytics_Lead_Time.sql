// Standard Dashboard - BR VIVO Report - Analytics - Lead Time
create or replace view LAS_BR_VIVO_SD_ANALYTICS_LT as (

    with LAS_BR_VIVO_SD_ANALYTICS_LOGICAL_REF as (
    
        select
            *
        from LAS_BR_VIVO_SD_LOGICAL_REF
        //where "Validacao" = 'PRINCIPAL'
    )
    
    , LAS_BR_VIVO_SD_PMO_ANALYTICS_LOGICAL_PIVOT_MAIN as(
    select 
    
        """Tools""" "Tools",
        """Scope""" "Scope",
        """Business Type""" "Business Type",
        """Customer""" "Customer",
        """Country""" "Country",
        """Validacao""" "Validacao",
        """RegistroID""" "ID",
        """Regional""" "Regional",
        "UF",
        """Prolog""" "Prolog",
        """Fisico2""" "Customer Scope",
        """Unique Site""" "Unique Site",
        "'Preliminary Services Real'" "Preliminary Services Real",
        "'BOQ2 Plan'" "BOQ2 Plan",
        "'BOQ2 Real'" "BOQ2 Real",
        "'Site Survey Plan'" "Site Survey Plan",
        "'Site Survey Real'" "Site Survey Real",
        "'Solution Document Plan'" "Solution Document Plan",
        "'Solution Document Real'" "Solution Document Real",
        "'Solution Document Approved Plan'" "Solution Document Approved Plan",
        "'Solution Document Approved Real'" "Solution Document Approved Real",
        "'BOQ3 Plan'" "BOQ3 Plan",
        "'BOQ3 Real'" "BOQ3 Real",
        "'Customer PO Plan'" "Customer PO Plan",
        "'Customer PO Real'" "Customer PO Real",
        "'Customer RFI Plan'" "Customer RFI Plan",
        "'Customer RFI Real'" "Customer RFI Real",
        "'Invoice Plan'" "Invoice Plan",
        "'Invoice Real'" "Invoice Real",
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
        "'War Room Real'" "War Room Real",
        "'War Room Approved Real'" "War Room Approved Real",
        "'PDI Real'" "PDI Real",
        "'War Room Plan'" "War Room Plan",
        "'PDI Plan'" "PDI Plan",
        "'EHS Site Survey - Plan'" "EHS Site Survey - Plan",
        "'EHS Site Survey - Real'" "EHS Site Survey - Real", 
        "'EHS Pre-Climbing Check - Plan'" "EHS Pre-Climbing Check - Plan",
        "'EHS Pre-Climbing Check - Real'" "EHS Pre-Climbing Check - Real"
            
            
    from LAS_BR_VIVO_SD_ANALYTICS_LOGICAL_REF
        
    pivot (
        max("Milestones_Dates")
        for "Milestones" in (
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
            'Customer PO Plan',
            'Customer PO Real',
            'Customer RFI Plan',
            'Customer RFI Real',
            'Invoice Plan',
            'Invoice Real',
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
        ) as LAS_BR_VIVO_SD_ANALYTICS_PIVOT
        
    )
    , LAS_BR_VIVO_SD_PMO_ANALYTICS_LT_CALC as (
        select

        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "ID",
        "Regional",
        "UF",
        "Prolog",
        "Unique Site",
        // -------------------------Preliminary Services-----------------------------------------------------------------------------
    
        // -------------------------Site Investigation-------------------------------------------------------------------------------
        
        datediff(day, "Preliminary Services Real", "Site Survey Real") "Δ Site Survey - Preliminary Services",
       
        // -------------------------War Room------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "War Room Real") "Δ War Room - Preliminary Services",
        datediff(day, "Site Survey Real", "War Room Real") "Δ War Room - Site Survey",
    
        // -------------------------War Room Approval------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "War Room Approved Real") "Δ War Room Approved - Preliminary Services",
        datediff(day, "Site Survey Real", "War Room Approved Real") "Δ War Room Approved - Site Survey",
        datediff(day, "War Room Real", "War Room Approved Real") "Δ War Room Approved - War Room",
    
        // -------------------------Solution Document------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Solution Document Real") "Δ Solution Document - Preliminary Services",
        datediff(day, "Site Survey Real", "Solution Document Real") "Δ Solution Document - Site Survey",
        datediff(day, "War Room Real", "Solution Document Real") "Δ Solution Document - War Room",
        datediff(day, "War Room Approved Real", "Solution Document Real") "Δ Solution Document - War Room Approved",
    
        // -------------------------Solution Document Approval--------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Solution Document Approved Real") "Δ Solution Document Approved - Preliminary Services",
        datediff(day, "Site Survey Real", "Solution Document Approved Real") "Δ Solution Document Approved - Site Survey",
        datediff(day, "War Room Real", "Solution Document Approved Real") "Δ Solution Document Approved - War Room",
        datediff(day, "War Room Approved Real", "Solution Document Approved Real") "Δ Solution Document Approved - War Room Approved",
        datediff(day, "Solution Document Real", "Solution Document Approved Real") "Δ Solution Document Approved - Solution Document",
        
        // -------------------------BOQ2-------------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "BOQ2 Real") "Δ BOQ2 - Preliminary Services",
        datediff(day, "Site Survey Real", "BOQ2 Real") "Δ BOQ2 - Site Survey",
        datediff(day, "War Room Real", "BOQ2 Real") "Δ BOQ2 - War Room",
        datediff(day, "War Room Approved Real", "BOQ2 Real") "Δ BOQ2 - War Room Approved",
        datediff(day, "Solution Document Real", "BOQ2 Real") "Δ BOQ2 - Solution Document",
        datediff(day, "Solution Document Approved Real", "BOQ2 Real") "Δ BOQ2 - Solution Document Approved",
    
        // -------------------------BOQ3-------------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "BOQ3 Real") "Δ BOQ3 - Preliminary Services",
        datediff(day, "Site Survey Real", "BOQ3 Real") "Δ BOQ3 - Site Survey",
        datediff(day, "War Room Real", "BOQ3 Real") "Δ BOQ3 - War Room",
        datediff(day, "War Room Approved Real", "BOQ3 Real") "Δ BOQ3 - War Room Approved",
        datediff(day, "Solution Document Real", "BOQ3 Real") "Δ BOQ3 - Solution Document",
        datediff(day, "Solution Document Approved Real", "BOQ3 Real") "Δ BOQ3 - Solution Document Approved",
        datediff(day, "BOQ2 Real", "BOQ3 Real") "Δ BOQ3 - BOQ2",
    
        // -------------------------Customer PO-----------------------------------------------------------------------------------------------
        
        datediff(day, "Preliminary Services Real", "Customer PO Real") "Δ Customer PO - Preliminary Services",
        datediff(day, "Site Survey Real", "Customer PO Real") "Δ Customer PO - Site Survey",
        datediff(day, "War Room Real", "Customer PO Real") "Δ Customer PO - War Room",
        datediff(day, "War Room Approved Real", "Customer PO Real") "Δ Customer PO - War Room Approved",
        datediff(day, "Solution Document Real", "Customer PO Real") "Δ Customer PO - Solution Document",
        datediff(day, "Solution Document Approved Real", "Customer PO Real") "Δ Customer PO - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Customer PO Real") "Δ Customer PO - BOQ2",
        datediff(day, "BOQ3 Real", "Customer PO Real") "Δ Customer PO - BOQ3",    
    
        // -------------------------Customer RFI----------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Customer RFI Real") "Δ Customer Ready for Installation - Preliminary Services",
        datediff(day, "Site Survey Real", "Customer RFI Real") "Δ Customer Ready for Installation - Site Survey",
        datediff(day, "War Room Real", "Customer RFI Real") "Δ Customer Ready for Installation - War Room",
        datediff(day, "War Room Approved Real", "Customer RFI Real") "Δ Customer Ready for Installation - War Room Approved",
        datediff(day, "Solution Document Real", "Customer RFI Real") "Δ Customer Ready for Installation - Solution Document",
        datediff(day, "Solution Document Approved Real", "Customer RFI Real") "Δ Customer Ready for Installation - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Customer RFI Real") "Δ Customer Ready for Installation - BOQ2",
        datediff(day, "BOQ3 Real", "Customer RFI Real") "Δ Customer Ready for Installation - BOQ3",
        datediff(day, "Customer PO Real", "Customer RFI Real") "Δ Customer Ready for Installation - Customer PO",
    
        // -------------------------Invoice---------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Invoice Real") "Δ Invoice - Preliminary Services",
        datediff(day, "Site Survey Real", "Invoice Real") "Δ Invoice - Site Survey",
        datediff(day, "War Room Real", "Invoice Real") "Δ Invoice - War Room",
        datediff(day, "War Room Approved Real", "Invoice Real") "Δ Invoice - War Room Approved",
        datediff(day, "Solution Document Real", "Invoice Real") "Δ Invoice - Solution Document",
        datediff(day, "Solution Document Approved Real", "Invoice Real") "Δ Invoice - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Invoice Real") "Δ Invoice - BOQ2",
        datediff(day, "BOQ3 Real", "Invoice Real") "Δ Invoice - BOQ3",
        datediff(day, "Customer PO Real", "Invoice Real") "Δ Invoice - Customer PO",
        datediff(day, "Customer RFI Real", "Invoice Real") "Δ Invoice - Customer Ready for Installation",    
    
        // -------------------------MoS-------------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "MoS Real") "Δ Material on Site - Preliminary Services",
        datediff(day, "Site Survey Real", "MoS Real") "Δ Material on Site - Site Survey",
        datediff(day, "War Room Real", "MoS Real") "Δ Material on Site - War Room",
        datediff(day, "War Room Approved Real", "MoS Real") "Δ Material on Site - War Room Approved",
        datediff(day, "Solution Document Real", "MoS Real") "Δ Material on Site - Solution Document",
        datediff(day, "Solution Document Approved Real", "MoS Real") "Δ Material on Site - Solution Document Approved",
        datediff(day, "BOQ2 Real", "MoS Real") "Δ Material on Site - BOQ2",
        datediff(day, "BOQ3 Real", "MoS Real") "Δ Material on Site - BOQ3",
        datediff(day, "Customer PO Real", "MoS Real") "Δ Material on Site - Customer PO",
        datediff(day, "Customer RFI Real", "MoS Real") "Δ Material on Site - Customer Ready for Installation",
        datediff(day, "Invoice Real", "MoS Real") "Δ Material on Site - Invoice",   
    
        // -------------------------Installation----------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Installation Real") "Δ Installation - Preliminary Services",
        datediff(day, "Site Survey Real", "Installation Real") "Δ Installation - Site Survey",
        datediff(day, "War Room Real", "Installation Real") "Δ Installation - War Room",
        datediff(day, "War Room Approved Real", "Installation Real") "Δ Installation - War Room Approved",
        datediff(day, "Solution Document Real", "Installation Real") "Δ Installation - Solution Document",
        datediff(day, "Solution Document Approved Real", "Installation Real") "Δ Installation - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Installation Real") "Δ Installation - BOQ2",
        datediff(day, "BOQ3 Real", "Installation Real") "Δ Installation - BOQ3",
        datediff(day, "Customer PO Real", "Installation Real") "Δ Installation - Customer PO",
        datediff(day, "Customer RFI Real", "Installation Real") "Δ Installation - Customer Ready for Installation",
        datediff(day, "Invoice Real", "Installation Real") "Δ Installation - Invoice",
        datediff(day, "MoS Real", "Installation Real") "Δ Installation - Material on Site",    
    
        // -------------------------Integration-----------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Integration Real") "Δ Integration - Preliminary Services",
        datediff(day, "Site Survey Real", "Integration Real") "Δ Integration - Site Survey",
        datediff(day, "War Room Real", "Integration Real") "Δ Integration - War Room",
        datediff(day, "War Room Approved Real", "Integration Real") "Δ Integration - War Room Approved",
        datediff(day, "Solution Document Real", "Integration Real") "Δ Integration - Solution Document",
        datediff(day, "Solution Document Approved Real", "Integration Real") "Δ Integration - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Integration Real") "Δ Integration - BOQ2",
        datediff(day, "BOQ3 Real", "Integration Real") "Δ Integration - BOQ3",
        datediff(day, "Customer PO Real", "Integration Real") "Δ Integration - Customer PO",
        datediff(day, "Customer RFI Real", "Integration Real") "Δ Integration - Customer Ready for Installation",
        datediff(day, "Invoice Real", "Integration Real") "Δ Integration - Invoice",
        datediff(day, "MoS Real", "Integration Real") "Δ Integration - Material on Site",
        datediff(day, "Installation Real", "Integration Real") "Δ Integration - Installation",    
    
        // -------------------------On Air----------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "On Air Real") "Δ On Air - Preliminary Services",
        datediff(day, "Site Survey Real", "On Air Real") "Δ On Air - Site Survey",
        datediff(day, "War Room Real", "On Air Real") "Δ On Air - War Room",
        datediff(day, "War Room Approved Real", "On Air Real") "Δ On Air - War Room Approved",
        datediff(day, "Solution Document Real", "On Air Real") "Δ On Air - Solution Document",
        datediff(day, "Solution Document Approved Real", "On Air Real") "Δ On Air - Solution Document Approved",
        datediff(day, "BOQ2 Real", "On Air Real") "Δ On Air - BOQ2",
        datediff(day, "BOQ3 Real", "On Air Real") "Δ On Air - BOQ3",
        datediff(day, "Customer PO Real", "On Air Real") "Δ On Air - Customer PO",
        datediff(day, "Customer RFI Real", "On Air Real") "Δ On Air - Customer Ready for Installation",
        datediff(day, "Invoice Real", "On Air Real") "Δ On Air - Invoice",
        datediff(day, "MoS Real", "On Air Real") "Δ On Air - Material on Site",
        datediff(day, "Installation Real", "On Air Real") "Δ On Air - Installation",
        datediff(day, "Integration Real", "On Air Real") "Δ On Air - Integration",
    
        // -------------------------Acceptance------------------------------------------------------------------------------------------------
    
        datediff(day, "Preliminary Services Real", "Accepted Real") "Δ Accepted - Preliminary Services",
        datediff(day, "Site Survey Real", "Accepted Real") "Δ Accepted - Site Survey",
        datediff(day, "War Room Real", "Accepted Real") "Δ Accepted - War Room",
        datediff(day, "War Room Approved Real", "Accepted Real") "Δ Accepted - War Room Approved",
        datediff(day, "Solution Document Real", "Accepted Real") "Δ Accepted - Solution Document",
        datediff(day, "Solution Document Approved Real", "Accepted Real") "Δ Accepted - Solution Document Approved",
        datediff(day, "BOQ2 Real", "Accepted Real") "Δ Accepted - BOQ2",
        datediff(day, "BOQ3 Real", "Accepted Real") "Δ Accepted - BOQ3",
        datediff(day, "Customer PO Real", "Accepted Real") "Δ Accepted - Customer PO",
        datediff(day, "Customer RFI Real", "Accepted Real") "Δ Accepted - Customer Ready for Installation",
        datediff(day, "Invoice Real", "Accepted Real") "Δ Accepted - Invoice",
        datediff(day, "MoS Real", "Accepted Real") "Δ Accepted - Material on Site",
        datediff(day, "Installation Real", "Accepted Real") "Δ Accepted - Installation",
        datediff(day, "Integration Real", "Accepted Real") "Δ Accepted - Integration",
        datediff(day, "On Air Real", "Accepted Real") "Δ Accepted - On Air"
        
        // -----------------------------------------------------------------------------------------------------------------------------------
        
        from LAS_BR_VIVO_SD_PMO_ANALYTICS_LOGICAL_PIVOT_MAIN
    )

    , LAS_BR_VIVO_SD_PMO_ANALYTICS_LT_PIVOT as(
        select
        "Tools",
        "Scope",
        "Business Type",
        "Country",
        "Customer",
        "ID",
        "Regional",
        "UF",
        "Prolog",
        "Unique Site",
        "LT Categories",
        "LT"
        from LAS_BR_VIVO_SD_PMO_ANALYTICS_LT_CALC
        
        unpivot(
        
            "LT" for "LT Categories" in(
        
            "Δ Site Survey - Preliminary Services",
            "Δ War Room - Preliminary Services",
            "Δ War Room - Site Survey",
            "Δ War Room Approved - Preliminary Services",
            "Δ War Room Approved - Site Survey",
            "Δ War Room Approved - War Room",
            "Δ Solution Document - Preliminary Services",
            "Δ Solution Document - Site Survey",
            "Δ Solution Document - War Room",
            "Δ Solution Document - War Room Approved",
            "Δ Solution Document Approved - Preliminary Services",
            "Δ Solution Document Approved - Site Survey",
            "Δ Solution Document Approved - War Room",
            "Δ Solution Document Approved - War Room Approved",
            "Δ Solution Document Approved - Solution Document",
            "Δ BOQ2 - Preliminary Services",
            "Δ BOQ2 - Site Survey",
            "Δ BOQ2 - War Room",
            "Δ BOQ2 - War Room Approved",
            "Δ BOQ2 - Solution Document",
            "Δ BOQ2 - Solution Document Approved",
            "Δ BOQ3 - Preliminary Services",
            "Δ BOQ3 - Site Survey",
            "Δ BOQ3 - War Room",
            "Δ BOQ3 - War Room Approved",
            "Δ BOQ3 - Solution Document",
            "Δ BOQ3 - Solution Document Approved",
            "Δ BOQ3 - BOQ2",
            "Δ Customer PO - Preliminary Services",
            "Δ Customer PO - Site Survey",
            "Δ Customer PO - War Room",
            "Δ Customer PO - War Room Approved",
            "Δ Customer PO - Solution Document",
            "Δ Customer PO - Solution Document Approved",
            "Δ Customer PO - BOQ2",
            "Δ Customer PO - BOQ3",    
            "Δ Customer Ready for Installation - Preliminary Services",
            "Δ Customer Ready for Installation - Site Survey",
            "Δ Customer Ready for Installation - War Room",
            "Δ Customer Ready for Installation - War Room Approved",
            "Δ Customer Ready for Installation - Solution Document",
            "Δ Customer Ready for Installation - Solution Document Approved",
            "Δ Customer Ready for Installation - BOQ2",
            "Δ Customer Ready for Installation - BOQ3",
            "Δ Customer Ready for Installation - Customer PO",
            "Δ Invoice - Preliminary Services",
            "Δ Invoice - Site Survey",
            "Δ Invoice - War Room",
            "Δ Invoice - War Room Approved",
            "Δ Invoice - Solution Document",
            "Δ Invoice - Solution Document Approved",
            "Δ Invoice - BOQ2",
            "Δ Invoice - BOQ3",
            "Δ Invoice - Customer PO",
            "Δ Invoice - Customer Ready for Installation",    
            "Δ Material on Site - Preliminary Services",
            "Δ Material on Site - Site Survey",
            "Δ Material on Site - War Room",
            "Δ Material on Site - War Room Approved",
            "Δ Material on Site - Solution Document",
            "Δ Material on Site - Solution Document Approved",
            "Δ Material on Site - BOQ2",
            "Δ Material on Site - BOQ3",
            "Δ Material on Site - Customer PO",
            "Δ Material on Site - Customer Ready for Installation",
            "Δ Material on Site - Invoice",   
            "Δ Installation - Preliminary Services",
            "Δ Installation - Site Survey",
            "Δ Installation - War Room",
            "Δ Installation - War Room Approved",
            "Δ Installation - Solution Document",
            "Δ Installation - Solution Document Approved",
            "Δ Installation - BOQ2",
            "Δ Installation - BOQ3",
            "Δ Installation - Customer PO",
            "Δ Installation - Customer Ready for Installation",
            "Δ Installation - Invoice",
            "Δ Installation - Material on Site",    
            "Δ Integration - Preliminary Services",
            "Δ Integration - Site Survey",
            "Δ Integration - War Room",
            "Δ Integration - War Room Approved",
            "Δ Integration - Solution Document",
            "Δ Integration - Solution Document Approved",
            "Δ Integration - BOQ2",
            "Δ Integration - BOQ3",
            "Δ Integration - Customer PO",
            "Δ Integration - Customer Ready for Installation",
            "Δ Integration - Invoice",
            "Δ Integration - Material on Site",
            "Δ Integration - Installation",    
            "Δ On Air - Preliminary Services",
            "Δ On Air - Site Survey",
            "Δ On Air - War Room",
            "Δ On Air - War Room Approved",
            "Δ On Air - Solution Document",
            "Δ On Air - Solution Document Approved",
            "Δ On Air - BOQ2",
            "Δ On Air - BOQ3",
            "Δ On Air - Customer PO",
            "Δ On Air - Customer Ready for Installation",
            "Δ On Air - Invoice",
            "Δ On Air - Material on Site",
            "Δ On Air - Installation",
            "Δ On Air - Integration",
            "Δ Accepted - Preliminary Services",
            "Δ Accepted - Site Survey",
            "Δ Accepted - War Room",
            "Δ Accepted - War Room Approved",
            "Δ Accepted - Solution Document",
            "Δ Accepted - Solution Document Approved",
            "Δ Accepted - BOQ2",
            "Δ Accepted - BOQ3",
            "Δ Accepted - Customer PO",
            "Δ Accepted - Customer Ready for Installation",
            "Δ Accepted - Invoice",
            "Δ Accepted - Material on Site",
            "Δ Accepted - Installation",
            "Δ Accepted - Integration",
            "Δ Accepted - On Air"
            )
        
        ) as LAS_BR_VIVO_SD_PMO_ANALYTICS_LT_UNPIVOT
    )

    select
        LT_PVT."Tools",
        LT_PVT."Scope",
        LT_PVT."Business Type",
        LT_PVT."Country",
        LT_PVT."Customer",
        LT_PVT."ID",
        LT_PVT."Regional",
        LT_PVT."UF",
        LT_PVT."Prolog" "FAS ID/Prolog",
        LT_PVT."Unique Site",
        LT_PVT."LT Categories",
        LT_PVT."LT",
        concat(split_part("LT Categories", ' - ', 2), ' Real') as "LT Category 1",
        concat(split_part(split_part("LT Categories", 'Δ ', 2), ' - ', 1), ' Real') as "LT Category 2",
        LOG_T."Milestones_Dates" "Activity 1 - Date",
        LOG_T."ASP" "Activity 1 - ASP",
        dateadd(day, "LT", "Activity 1 - Date") as "Activity 2 - Date",
        ASP02RREF."ASP" "Activity 2 - ASP"
    from LAS_BR_VIVO_SD_PMO_ANALYTICS_LT_PIVOT LT_PVT
    left join LAS_BR_VIVO_SD_LOGICAL_REF LOG_T
    on LT_PVT."ID" = LOG_T."RegistroID" and "LT Category 1" = LOG_T."Milestones"
    left join LAS_BR_CLARO_SD_LOGICAL_REF ASP02RREF
    on LT_PVT."ID" = ASP02RREF."RegistroID" and "LT Category 2" = ASP02RREF."Milestones"

);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_VIVO_SD_ANALYTICS_LT;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------