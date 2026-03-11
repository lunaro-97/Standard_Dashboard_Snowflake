// Standard Dashboard - UY ANTEL Report - Logical

create or replace view LAS_UY_ANTEL_SD_Logical_Ref as (

with LAS_UY_ANTEL_SD_UNPIVOT_NO_Filters as(
    select
        "Tools",
        "Scope",
        "Business Type",
        "Customer",
        "Country",
        "Project ID",
        '' as "Sales Order",
        "Regional",
        "FAS ID",
        "CDID",
        "Unique Site",
        //"ASP",
        //"EHS Site Survey - Status",
        //"EHS Site Survey - Ofensor",
        //"EHS Site Survey - ASP",
        //"EHS Pre-Climbing Check - Status",
        //"EHS Pre-Climbing Check - Ofensor",
        //"EHS Pre-Climbing Check - ASP",
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
            "Regional",
            "Project ID",
            "FAS ID",
            "CDID",
            "Unique Site",
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
            
            from LAS_UY_ANTEL_STANDARD_DASHBOARD_PMO

        ) as SD_UY_ANTEL_UNPVT
    
    unpivot(
    
        "Milestones_Dates" for "Milestones"
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
        ) as LAS_UY_ANTEL_SD_PMO_UNPVT
    )

    select

        LAS_Scp."Tools",
        LAS_Scp."Scope",
        LAS_Scp."Business Type",
        LAS_Scp."Customer",
        LAS_Scp."Country",
        LAS_Scp."Project ID",
        LAS_Scp."FAS ID",
        LAS_Scp."CDID",
        LAS_Scp."Regional",
        LAS_Scp."Unique Site",
        VendorASP.Vendor as "ASP",
        //LAS_Scp."EHS Site Survey - Status",
        //LAS_Scp."EHS Site Survey - Ofensor",
        //LAS_Scp."EHS Site Survey - ASP",
        //LAS_Scp."EHS Pre-Climbing Check - Status",
        //LAS_Scp."EHS Pre-Climbing Check - Ofensor",
        //LAS_Scp."EHS Pre-Climbing Check - ASP",
        LAS_Scp."Milestones",
        LAS_Scp."Milestones_Dates"
        
    from LAS_UY_ANTEL_SD_UNPIVOT_NO_Filters LAS_Scp

    left join(

        select

        Job_source.Project_ID,
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
            where "ProjectCustomerIdCrg1" = '910566' and "JobVendorName" <> ''
            
        ) as Job_source

    ) as VendorASP

    on LAS_Scp."Project ID" = VendorASP.Project_ID and LAS_Scp."Milestones" = VendorASP.Activity
);

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_UY_ANTEL_SD_Logical_Ref;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------