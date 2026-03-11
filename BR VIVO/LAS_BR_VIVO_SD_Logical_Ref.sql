// Standard Dashboard - BR VIVO Report - Logical

create or replace view LAS_BR_VIVO_SD_Logical_Ref as (

    with LAS_BR_VIVO_SD_Filtering as(
        select
        *
        from LAS_BR_VIVO_STANDARD_DASHBOARD_PMO
        where equal_null("Logico", null)
        and (not equal_null("Unique Site", '-') or not equal_null("Unique Site", ' -') or not equal_null("Unique Site", null))
        and ("Validacao" = 'PRINCIPAL' or "Validacao" = 'PRINCIPAL-IMPL')
    )

    , LAS_BR_VIVO_SD_Unpv as (

    select
        "Tools",
        "Scope",
        "Business Type",
        "Customer",
        "Country",
        "Validacao",
        "RegistroID",
        "OV Number" "Sales Order",
        "Regional",
        "UF",
        "Prolog",
        "FAS ID",
        "Fisico",
        "Fisico2",
        "Logico",
        "Unique Site",
        "ASP",
        "EHS Site Survey - Status",
        "EHS Site Survey - Ofensor",
        "EHS Site Survey - ASP",
        "EHS Pre-Climbing Check - Status",
        "EHS Pre-Climbing Check - Ofensor",
        "EHS Pre-Climbing Check - ASP",
        "Milestones",
        "Milestones_Dates"
        from
        (
            select
            "Tools",
            "Scope",
            "Business Type",
            "Customer",
            "Country",
            "Validacao",
            "RegistroID",
            "Regional",
            "UF",
            "Prolog",
            "FAS ID",
            "Fisico",
            "Fisico2",
            "Logico",
            "OV Number",
            "Unique Site",
            "ASP",
            "EHS Site Survey - Status",
            "EHS Site Survey - Ofensor",
            "EHS Site Survey - ASP",
            "EHS Pre-Climbing Check - Status",
            "EHS Pre-Climbing Check - Ofensor",
            "EHS Pre-Climbing Check - ASP",
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
            "Customer PO Plan",
            "Customer PO Real",
            "Customer RFI Plan",
            "Customer RFI Real",
            "Invoice Plan",
            "Invoice Real",
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
            from LAS_BR_VIVO_SD_Filtering
            
        ) as SD_VIVO_UNPVT
    
    unpivot(
    
        "Milestones_Dates" for "Milestones"
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
            "Customer PO Plan",
            "Customer PO Real",
            "Customer RFI Plan",
            "Customer RFI Real",
            "Invoice Plan",
            "Invoice Real",
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
        ) as LAS_BR_VIVO_SD_PMO_UNPVT
    )

    select

        LAS_Scp."Tools",
        LAS_Scp."Scope",
        LAS_Scp."Business Type",
        LAS_Scp."Customer",
        LAS_Scp."Country",
        LAS_Scp."Validacao",
        LAS_Scp."RegistroID",
        LAS_Scp."Sales Order",
        LAS_Scp."Regional",
        LAS_Scp."UF",
        LAS_Scp."Prolog",
        LAS_Scp."FAS ID",
        LAS_Scp."Fisico",
        LAS_Scp."Fisico2",
        LAS_Scp."Logico",
        LAS_Scp."Unique Site",
        VendorASP.Vendor as "ASP",
        LAS_Scp."EHS Site Survey - Status",
        LAS_Scp."EHS Site Survey - Ofensor",
        LAS_Scp."EHS Site Survey - ASP",
        LAS_Scp."EHS Pre-Climbing Check - Status",
        LAS_Scp."EHS Pre-Climbing Check - Ofensor",
        LAS_Scp."EHS Pre-Climbing Check - ASP",
        LAS_Scp."Milestones",
        LAS_Scp."Milestones_Dates"
        
    from LAS_BR_VIVO_SD_Unpv LAS_Scp
    
    left join(

    select

    EO.Register_ID Registro,
    LeadTimeASPs(Job_source."JobTemplateName") Activity,
    Job_source."JobVendorName" Vendor
    from(
        select 
            "JobId",
            "JobActivity",
            "JobProject" Project_ID,
            "JobTemplateName",
            "JobVendorName" 
        from ID_MELA_DM_USR.JOB_GST_MELA_NATIVE_VIEW
        where "ProjectCustomerIdCrg1" = '911810' and "JobVendorName" <> ''
        
    ) as Job_source
    
    left join (
        select
        "LASProject" Project_Name,
        "LASRegisterId" Register_ID
        from ID_MELA_DM_USR.LAS_PROJECT_EXTENSION_GST_MELA_NATIVE_VIEW
        where "ProjectCustomerIdCrg1" = '911810'
    ) as EO

    on Job_source.Project_ID = EO.Project_Name
) as VendorASP

on LAS_Scp."RegistroID" = VendorASP.Registro and LAS_Scp."Milestones" = VendorASP.Activity

);
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_VIVO_SD_Logical_Ref;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------