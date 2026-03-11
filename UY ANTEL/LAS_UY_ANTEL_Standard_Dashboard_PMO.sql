create or replace view LAS_UY_ANTEL_Standard_Dashboard_PMO as

    select 
        'ID' as "Tools",
        'RAN' "Scope",
        'E2E' "Business Type",
        Program_View.Program_Name "Project Name",
        UpperCaseValues(Project_View.Country) "Country",
        //"ProjectProgram2" Program_ID, -- Foreign Key
        //Project_View."ProjectCustomerIdCrg1",
        ReplaceBlankNoDatesField(Project_View.Customer_Name) "Customer",
        //"ProjectId" Project_ID, -- Primary Key
        Project_View.Project "Project ID", -- Primary Key
        Site_View.Site_Name "Site Name",
        Site_View.Regional "Regional",
        //Site_View.UF,
        //"ProjectSite" Site_ID,-- Foreign Key
        Project_View."FAS ID",
        Project_View.CDID "CDID",
        //array_to_string(array_slice(split("ProjectVpoCdid", '-'), 2, 4), '-') as "Unique Key"
        AntelUQ(Project_View.CDID) "Unique Site",
        cast(Activity_View.SS_F as date) as "Site Survey Plan",
        cast(Activity_View.SS_A as date) as "Site Survey Real",
        cast(Activity_View.RFI_F as date) as "Customer RFI Plan",
        cast(Activity_View.RFI_A as date) as "Customer RFI Real",
        cast(Activity_View.MOS_A as date) as "MoS Plan",
        cast(Activity_View.MOS_A as date) as "MoS Real",
        cast(Activity_View.INST_A as date) as "Installation Plan",
        cast(Activity_View.INST_A as date) as "Installation Real",
        cast(Activity_View.INTEG_F as date) as "Integration Plan",
        cast(Activity_View.INTEG_A as date) as "Integration Real",
        cast(Activity_View.ONAIR_F as date) as "On Air Plan",
        cast(Activity_View.ONAIR_A as date) as "On Air Real",
        cast(Activity_View.ACC_F as date) as "Accepted Plan",
        cast(Activity_View.ACC_A as date) as "Accepted Real"
        
        // 
        from(
        select 
            "ProjectCountry" Country,
            "ProjectProgram2" Program_ID, -- Foreign Key
            "ProjectCustomerIdCrg1",
            "ProjectCustomerName" Customer_Name,
            "ProjectId" Project_ID, -- Primary Key
            "ProjectName" Project, -- Primary Key
            "ProjectSite" Site_ID,-- Foreign Key
            "ProjectVpoFas" "FAS ID",
            "ProjectVpoCdid" CDID,
            //array_to_string(array_slice(split("ProjectVpoCdid", '-'), 2, 4), '-') as "Unique Key"
            right("ProjectVpoCdid", 10) as "Unique Key"
            // 
        from ID_MELA_DM_USR.PROJECT_GST_MELA_NATIVE_VIEW
        where "ProjectCustomerIdCrg1" = '910566'
        ) as Project_View
    
        left join(
        
            select
                "SiteId" Site_ID, -- Primary Key
                "SiteName" Site_Name,
                "SiteRegion" Regional,
                "SiteSubRegion" UF,
                "ProjectCustomerIdCrg1"
        
            from ID_MELA_DM_USR.SITE_GST_MELA_NATIVE_VIEW
            where "ProjectCustomerIdCrg1" = '910566'
        
        ) as Site_View
    
        on Project_View.Site_ID = Site_View.Site_ID
        
        left join(
    
            select 
                "ProgramId" Program_ID, -- Primary Key
                "ProgramCountry",
                "ProgramName" Program_Name,
                "ProjectCustomerIdCrg1"
            from ID_MELA_DM_USR.PROGRAM_GST_MELA_NATIVE_VIEW
            where "ProjectCustomerIdCrg1" = '910566'
        ) as Program_View
    
        on Project_View.Program_ID = Program_View.Program_ID
    
        left join(
    
            select
    
                Activity_Pivot."ActivityProject" Project_ID,
                Activity_Pivot.SS_F,
                Activity_Pivot.SS_A,
                Activity_Pivot.RFI_F,
                Activity_Pivot.RFI_A,
                Activity_Pivot.MOS_F,
                Activity_Pivot.MOS_A,
                Activity_Pivot.INST_F,
                Activity_Pivot.INST_A,
                Activity_Pivot.INTEG_F,
                Activity_Pivot.INTEG_A,
                Activity_Pivot.ONAIR_F,
                Activity_Pivot.ONAIR_A,
                Activity_Pivot.ACC_F,
                Activity_Pivot.ACC_A
                
                from(
                    select
                        "ActivityProject",
                        "ProjectCustomerIdCrg1",
                        
                        max(case when "ActivityName" = 'Site Survey for Installation Completed' then FixDBDates("ActivityForecastActual") end) as SS_F,
                        max(case when "ActivityName" = 'Site Survey for Installation Completed' then FixDBDates("ActivityActualDate") end) as SS_A,
                        max(case when "ActivityName" = 'Site Ready for Installation' then FixDBDates("ActivityForecastActual") end) as RFI_F,
                        max(case when "ActivityName" = 'Site Ready for Installation' then FixDBDates("ActivityActualDate") end) as RFI_A,
                        max(case when "ActivityName" = 'Site Installation Material Delivered on Site' then FixDBDates("ActivityForecastActual") end) as MOS_F,
                        max(case when "ActivityName" = 'Site Installation Material Delivered on Site' then FixDBDates("ActivityActualDate") end) as MOS_A,
                        max(case when "ActivityName" = 'Site Installation Complete' then FixDBDates("ActivityForecastActual") end) as INST_F,
                        max(case when "ActivityName" = 'Site Installation Complete' then FixDBDates("ActivityActualDate") end) as INST_A,
                        max(case when "ActivityName" = 'Integration Complete' then FixDBDates("ActivityForecastActual") end) as INTEG_F,
                        max(case when "ActivityName" = 'Integration Complete' then FixDBDates("ActivityActualDate") end) as INTEG_A,
                        max(case when "ActivityName" = 'Site On Air' then FixDBDates("ActivityForecastActual") end) as ONAIR_F,
                        max(case when "ActivityName" = 'Site On Air' then FixDBDates("ActivityActualDate") end) as ONAIR_A,
                        max(case when "ActivityName" = 'Site Acceptance Final Report Approved' then FixDBDates("ActivityForecastActual") end) as ACC_F,
                        max(case when "ActivityName" = 'Site Acceptance Final Report Approved' then FixDBDates("ActivityActualDate") end) as ACC_A
                    
                    from ID_MELA_DM_USR.ACTIVITY_GST_MELA_NATIVE_VIEW
                    where "ProjectCustomerIdCrg1" = '910566'
                    group by "ProjectCustomerIdCrg1", "ActivityProject"
                    ) as Activity_Pivot
                ) as Activity_View
                
        on Project_View.Project_ID = Activity_View.Project_ID
    order by Project_View.Project_ID;
    
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_UY_ANTEL_STANDARD_DASHBOARD_PMO;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------