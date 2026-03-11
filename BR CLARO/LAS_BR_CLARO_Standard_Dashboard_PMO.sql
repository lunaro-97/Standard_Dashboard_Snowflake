create or replace view LAS_BR_CLARO_Standard_Dashboard_PMO as

select

    'ID' "Tools",
    'RAN' "Scope",
    'E2E' "Business Type",
    //ReplaceBlankNoDatesField(Program_Source.Program_ID) "Project Id",
    ReplaceBlankNoDatesField(Program_Source.Program_Name) "Program",
    ReplaceBlankNoDatesField(UpperCaseValues(Project_Source.Country)) "Country",
    CustomerNameRplc(ReplaceBlankNoDatesField(Project_Source.Customer_Name)) "Customer",
    ReplaceBlankNoDatesField(Project_Source.Project) "Project ID",
    ReplaceBlankNoDatesField(Project_Source.FAS_ID) "FAS ID",
    ReplaceBlankNoDatesField(Project_Source.CDID) "CDID",
    ReplaceBlankNoDatesField(Site_Source.Regional) "Regional",
    ReplaceBlankNoDatesField(ExtensionObject_Source.Register_ID) "RegistroID",
    ReplaceBlankNoDatesField(Convert_BRCLARO_Validacao(ExtensionObject_Source.Validacao_do_Registro)) "Validacao",
    ReplaceBlankNoDatesField(ExtensionObject_Source.Prolog) "Prolog",
    ReplaceBlankNoDatesField(UpperCaseValues(Form_Items_Source.Projeto)) "Projeto",
    ReplaceBlankNoDatesField(Form_Items_Source.Gap) "Gap",
    ReplaceBlankNoDatesField(Form_Items_Source.Prioridade) "Prioridade",
    ReplaceBlankNoDatesField(Form_Items_Source.Ofensor) "Ofensor",
    ReplaceBlankNoDatesField(Form_Items_Source.Fisico) "Fisico",
    ReplaceBlankNoDatesField(Form_Items_Source.Fisico2) "Fisico2",
    ReplaceBlankNoDatesField(ExtensionObject_Source.Unique_Site) "Unique Site",  
    cast(Activity_Source.Preliminary_Services_Real as date) as "Preliminary Services Real",
    cast(Activity_Source.Site_Survey_Plan as date) as "Site Survey Plan",
    cast(Activity_Source.Site_Survey_Real as date) as "Site Survey Real",
    cast(Activity_Source.War_Room_Plan as date) as "War Room Plan",
    cast(Activity_Source.War_Room_Real as date) as "War Room Real",
    cast(Activity_Source.War_Room_Approved_Real as date) as "War Room Approved Real",
    cast(Activity_Source.Solution_Document_Plan as date) as "Solution Document Plan",
    cast(Activity_Source.Solution_Document_Real as date) as "Solution Document Real",
    cast(Activity_Source.Solution_Document_Approved_Plan as date) as "Solution Document Approved Plan",
    cast(Activity_Source.Solution_Document_Approved_Real as date) as "Solution Document Approved Real",
    cast(Activity_Source.BOQ2_Plan as date) as "BOQ2 Plan",
    cast(Activity_Source.BOQ2_Real as date) as "BOQ2 Real",
    cast(Activity_Source.BOQ3_Plan as date) as "BOQ3 Plan",
    cast(Activity_Source.BOQ3_Real as date) as "BOQ3 Real",
    cast(Activity_Source.PV_Real as date) as "PV Real",
    cast(Activity_Source.Customer_PO_Plan as date) as "Customer PO Plan",
    cast(Activity_Source.Customer_PO_Real as date) as "Customer PO Real",
    ReplaceBlankNoDatesField(Form_Items_Source.SO_Desc) "OV Number",
    cast(Form_Items_Source.Sales_Order_R as date) as "OV Real",
    cast(Activity_Source.ACK_Real as date) as "ACK Real",
    cast(Activity_Source.TX_Real as date) as "TX Real",
    cast(Activity_Source.Customer_RFI_Plan as date) as "Customer RFI Plan",
    cast(Activity_Source.Customer_RFI_Real as date) as "Customer RFI Real",
    cast(Activity_Source.Invoice_Plan as date) as "Invoice Plan",
    cast(Activity_Source.Invoice_Real as date) as "Invoice Real",
    cast(Activity_Source.MoS_Plan as date) as "MoS Plan",
    cast(Activity_Source.MoS_Real as date) as "MoS Real",
    cast(Activity_Source.Installation_Plan as date) as "Installation Plan",
    cast(Activity_Source.Installation_Real as date) as "Installation Real",
    cast(Activity_Source.Integration_Plan as date) as "Integration Plan",
    cast(Activity_Source.Integration_Real as date) as "Integration Real",
    cast(Activity_Source.On_Air_Plan as date) as "On Air Plan",
    cast(Activity_Source.On_Air_Real as date) as "On Air Real",
    cast(Activity_Source.Acceptance_Plan as date) as "Accepted Plan",
    cast(Activity_Source.Acceptance_Real as date) as "Accepted Real",
    cast(Activity_Source.PDI_Plan as date) as "PDI Plan",
    cast(Activity_Source.PDI_Real as date) as "PDI Real",
    ReplaceBlankNoDatesField(Job_Source.ASP) "ASP",
    cast(Form_Items_Source.EHS_SS_P as date) as "EHS Site Survey - Plan",
    cast(Form_Items_Source.EHS_SS_R as date) as "EHS Site Survey - Real",
    ReplaceBlankNoDatesField(Form_Items_Source.EHS_SS_Status) "EHS Site Survey - Status",
    ReplaceBlankNoDatesField(Form_Items_Source.EHS_SS_Ofensor) "EHS Site Survey - Ofensor",
    ReplaceBlankNoDatesField(Job_Source.EHS_Site_Survey_ASP) "EHS Site Survey - ASP",
    cast(Activity_Source.EHS_Pre_Climbing_Check_Plan as date) as "EHS Pre-Climbing Check - Plan",
    cast(Activity_Source.EHS_Pre_Climbing_Check_Real as date) as "EHS Pre-Climbing Check - Real",
    ReplaceBlankNoDatesField(Form_Items_Source.EHS_PC_Status) "EHS Pre-Climbing Check - Status",
    ReplaceBlankNoDatesField(Form_Items_Source.EHS_PC_Ofensor) "EHS Pre-Climbing Check - Ofensor",
    ReplaceBlankNoDatesField(Job_Source.EHS_Pre_Climbing_Check_ASP) "EHS Pre-Climbing Check - ASP"
    
    from(
    
        select 
            "ProjectCountry" Country,
            "ProjectProgram2" Program_ID, -- Foreign Key
            "ProjectCustomerIdCrg1",
            "ProjectCustomerName" Customer_Name,
            "ProjectId" Project_ID, -- Primary Key
            "ProjectName" Project, -- Primary Key
            "ProjectSite" Site_ID,-- Foreign Key
            "ProjectVpoFas" "FAS_ID",
            "ProjectVpoCdid" CDID, -- Foreign Key
        from ID_MELA_DM_USR.PROJECT_GST_MELA_NATIVE_VIEW
        //where "ProjectCustomerIdCrg1" = '912728'
        where "ProjectCustomerName" = 'Claro Brasil'
        ) as Project_Source
        
    left join(
    
        select 
            "ProgramId" Program_ID, -- Primary Key
            "ProgramCountry",
            "ProgramName" Program_Name,
            "ProjectCustomerIdCrg1"
        from ID_MELA_DM_USR.PROGRAM_GST_MELA_NATIVE_VIEW
        where "ProjectCustomerIdCrg1" = '912728'
    ) as Program_Source
    
    on Project_Source.Program_ID = Program_Source.Program_ID

    left join(
    
        select
            "SiteId" Site_ID, -- Primary Key
            "SiteName",
            "SiteRegion" Regional,
            "SiteSubRegion" UF
        from ID_MELA_DM_USR.SITE_GST_MELA_NATIVE_VIEW
        where "SiteCountry" = 'Brazil' and "ProjectCustomerIdCrg1" = '912728'
    ) as Site_Source
    
    on Project_Source.Site_ID = Site_Source.Site_ID

    left join(

        select
            "ProjectCustomerIdCrg1",
            "JobProject" Project_ID, -- Primary Key
            EHS_SS_ASP EHS_Site_Survey_ASP,
            EHS_PCC_ASP EHS_Pre_Climbing_Check_ASP,
            ASP
            from
            (
                select
                    "ProjectCustomerIdCrg1",
                    //"JobCustomerIdCrg1",
                    "JobProject",
                    //"JobNumber",
                    //"JobJobTemplateName",
                    //"JobVendorName",
        
                    max(case when "JobTemplateName" = 'BR - TSSR Received - SIR' then "JobVendorName" end) as EHS_SS_ASP,
                    max(case when "JobTemplateName" = 'BR - MOS (Material On site (ESR)' then "JobVendorName" end) as EHS_PCC_ASP,
                    max(case when "JobTemplateName" = 'BR - MOS (Material On site (ESR)' then "JobVendorName" end) as ASP
                   
                    
                from ID_MELA_DM_USR.JOB_GST_MELA_NATIVE_VIEW
                where "ProjectCustomerIdCrg1" = '912728'
                and ("JobTemplateName" = 'BR - TSSR Received - SIR' or "JobTemplateName" = 'BR - MOS (Material On site (ESR)')
                and ("JobProject" <> '' or "JobProject" <> null)
                group by "ProjectCustomerIdCrg1", "JobProject"
            ) as Vendor_Source
        ) as Job_Source

        on Project_Source.Project_ID = Job_Source.Project_ID

        left join(

            select
                "ProjectCustomerIdCrg1" Customer_ID,
                "ActivityProject" Project_ID, -- Primary Key
                PS_A Preliminary_Services_Real,
                SS_F Site_Survey_Plan,
                SS_A Site_Survey_Real,
                WRE_F War_Room_Plan,
                WRE_A War_Room_Real,
                WRA_A War_Room_Approved_Real,
                SDE_F Solution_Document_Plan,
                SDE_A Solution_Document_Real,
                SDA_F Solution_Document_Approved_Plan,
                SDA_A Solution_Document_Approved_Real,
                BOQ2_F BOQ2_Plan,
                BOQ2_A BOQ2_Real,
                BOQ3_F BOQ3_Plan,
                BOQ3_A BOQ3_Real,
                PV_A PV_Real,
                CPO_F Customer_PO_Plan,
                CPO_A Customer_PO_Real,
                ACK_A ACK_Real,
                TX_A TX_Real,
                RFI_F Customer_RFI_Plan,
                RFI_A Customer_RFI_Real,
                INV_F Invoice_Plan,
                INV_A Invoice_Real,
                MOS_F MoS_Plan,
                MOS_A MoS_Real,
                INST_F Installation_Plan,
                INST_A Installation_Real,
                INTEG_F Integration_Plan,
                INTEG_A Integration_Real,
                ONAIR_F On_Air_Plan,
                ONAIR_A On_Air_Real,
                ACC_F Acceptance_Plan,
                ACC_A Acceptance_Real,
                PDI_F PDI_Plan,
                PDI_A PDI_Real,
                EHS_PC_F EHS_Pre_Climbing_Check_Plan,
                EHS_PC_A EHS_Pre_Climbing_Check_Real
                
                from(
            
                    select
                        "ActivityProject",
                        "ProjectCustomerIdCrg1",
                        
                        max(case when "ActivityName" = 'ACK' then FixDBDates("ActivityActualDate") end) as ACK_A,
                        max(case when "ActivityName" = 'Approved Solution from Customer' then FixDBDates("ActivityActualDate") end) as WRA_A,
                        max(case when "ActivityName" = 'As-Built (PDI)' then FixDBDates("ActivityActualDate") end) as PDI_A,
                        max(case when "ActivityName" = 'As-Built (PDI)' then FixDBDates("ActivityForecastActual") end) as PDI_F,
                        max(case when "ActivityName" = 'BoM2' then FixDBDates("ActivityActualDate") end) as BOQ2_A,
                        max(case when "ActivityName" = 'BoM2' then FixDBDates("ActivityForecastActual") end) as BOQ2_F,
                        max(case when "ActivityName" = 'BoM3' then FixDBDates("ActivityActualDate") end) as BOQ3_A,
                        max(case when "ActivityName" = 'BoM3' then FixDBDates("ActivityForecastActual") end) as BOQ3_F,
                        max(case when "ActivityName" = 'Customer Site Acceptance' then FixDBDates("ActivityActualDate") end) as ACC_A,
                        max(case when "ActivityName" = 'Customer Site Acceptance' then FixDBDates("ActivityForecastActual") end) as ACC_F,
                        max(case when "ActivityName" = 'Faturamento OV' then FixDBDates("ActivityActualDate") end) as INV_A,
                        max(case when "ActivityName" = 'Faturamento OV' then FixDBDates("ActivityForecastActual") end) as INV_F,
                        max(case when "ActivityName" = 'Installation' then FixDBDates("ActivityActualDate") end) as INST_A,
                        max(case when "ActivityName" = 'Installation' then FixDBDates("ActivityForecastActual") end) as INST_F,
                        max(case when "ActivityName" = 'Integration' then FixDBDates("ActivityActualDate") end) as INTEG_A,
                        max(case when "ActivityName" = 'Integration' then FixDBDates("ActivityForecastActual") end) as INTEG_F,
                        max(case when "ActivityName" = 'Material on Site' then FixDBDates("ActivityActualDate") end) as MOS_A,
                        max(case when "ActivityName" = 'Material on Site' then FixDBDates("ActivityForecastActual") end) as MOS_F,
                        max(case when "ActivityName" = 'On Air [Net Sale]' then FixDBDates("ActivityActualDate") end) as ONAIR_A,
                        max(case when "ActivityName" = 'On Air [Net Sale]' then FixDBDates("ActivityForecastActual") end) as ONAIR_F,
                        max(case when "ActivityName" = 'PV Preliminary Services' then FixDBDates("ActivityActualDate") end) as PS_A,
                        max(case when "ActivityName" = 'Ready for Installation (RFI)' then FixDBDates("ActivityActualDate") end) as RFI_A,
                        max(case when "ActivityName" = 'Ready for Installation (RFI)'  then FixDBDates("ActivityForecastActual") end) as RFI_F,
                        max(case when "ActivityName" = 'Site Design Engineering (SDE)' then FixDBDates("ActivityActualDate") end) as WRE_A,
                        max(case when "ActivityName" = 'Site Design Engineering (SDE)' then FixDBDates("ActivityForecastActual") end) as WRE_F,
                        max(case when "ActivityName" = 'Site Installation Documentation (SID) Approved [Billing]' then FixDBDates("ActivityActualDate") end) as SDA_A,
                        max(case when "ActivityName" = 'Site Installation Documentation (SID) Approved [Billing]' then FixDBDates("ActivityForecastActual") end) as SDA_F,
                        max(case when "ActivityName" = 'Site Installation Documentation (SID) Executed' then FixDBDates("ActivityActualDate") end) as SDE_A,
                        max(case when "ActivityName" = 'Site Installation Documentation (SID) Executed' then FixDBDates("ActivityForecastActual") end) as SDE_F,
                        max(case when "ActivityName" = 'Site Investigation (SI)' then FixDBDates("ActivityActualDate") end) as SS_A,
                        max(case when "ActivityName" = 'Site Investigation (SI)' then FixDBDates("ActivityForecastActual") end) as SS_F,
                        max(case when "ActivityName" = 'Solution CPO' then FixDBDates("ActivityActualDate") end) as CPO_A,
                        max(case when "ActivityName" = 'Solution CPO' then FixDBDates("ActivityForecastActual") end) as CPO_F,
                        max(case when "ActivityName" = 'Solution PV' then FixDBDates("ActivityActualDate") end) as PV_A,
                        max(case when "ActivityName" = 'TX Availability' then FixDBDates("ActivityActualDate") end) as TX_A,
                        max(case when "ActivityName" = 'Material on Site' then FixDBDates("ActivityActualDate") end) as EHS_PC_A,
                        max(case when "ActivityName" = 'Material on Site' then FixDBDates("ActivityForecastActual") end) as EHS_PC_F
            
                    from ID_MELA_DM_USR.ACTIVITY_GST_MELA_NATIVE_VIEW
                    where "ProjectCustomerIdCrg1" = '912728'
                    and ("ActivityProject" <> '' or "ActivityProject" <> null)
                    group by "ProjectCustomerIdCrg1", "ActivityProject"
                ) as Milestone_Source
        ) as Activity_Source

        on Project_Source.Project_ID = Activity_Source.Project_ID
        
        left join(

            select
                "LASProject" Project_Name, -- Primary Key
                "LASRegisterId" Register_ID,
                "LASUniqueSite" Unique_Site,
                "LASProlog" Prolog,
                "LASValidaODoRegistro" Validacao_do_Registro
            from ID_MELA_DM_USR.LAS_PROJECT_EXTENSION_GST_MELA_NATIVE_VIEW
            where "ProjectCustomerIdCrg1" = '912728'
        ) as ExtensionObject_Source

        on Project_Source.Project_ID = ExtensionObject_Source.Project_Name

        left join(

            select
            "ProjectCustomerIdCrg1",
            "ChecklistItemParentProject" Project_ID, -- Primary Key,
            Fisico,
            Fisico2,
            Projeto,
            Prioridade,
            Ofensor,
            Gap,
            EHS_SS_P,
            EHS_SS_R,
            EHS_SS_Status,
            EHS_SS_Ofensor,
            EHS_PC_Status,
            EHS_PC_Ofensor,
            Sales_Order_R,
            SO_Desc
            
            from(
        
                select
                "ProjectCustomerIdCrg1",
                "ChecklistItemParentProject",
                max(case when "ChecklistItemDescription" = 'Criticos' then "ChecklistItemValue" end) as Fisico2,
                max(case when "ChecklistItemDescription" = 'Divisao Escopo PN' then "ChecklistItemValue" end) as Fisico,
                max(case when "ChecklistItemDescription" = 'Ofensores' then "ChecklistItemValue" end) as Ofensor,
                max(case when "ChecklistItemDescription" = 'Prioridade Rollout' then "ChecklistItemValue" end) as Prioridade,
                max(case when "ChecklistItemDescription" = 'Plano' then "ChecklistItemValue" end) as Projeto,
                max(case when "ChecklistItemDescription" = 'Status GAP' then "ChecklistItemValue" end) as Gap,
                max(case when "ChecklistItemDescription" = 'EHS Site Survey - Plan' then FixDBDates("ChecklistItemValue") end) as EHS_SS_P,
                max(case when "ChecklistItemDescription" = 'EHS Site Survey - Real' then FixDBDates("ChecklistItemValue") end) as EHS_SS_R,
                max(case when "ChecklistItemDescription" = 'EHS Site Survey - Status' then "ChecklistItemValue" end) as EHS_SS_Status,
                max(case when "ChecklistItemDescription" = 'EHS Site Survey - Ofensor' then "ChecklistItemValue" end) as EHS_SS_Ofensor,
                max(case when "ChecklistItemDescription" = 'EHS Pre-Climbing Check - Status' then "ChecklistItemValue" end) as EHS_PC_Status,
                max(case when "ChecklistItemDescription" = 'EHS Pre-Climbing Check - Ofensor' then "ChecklistItemValue" end) as EHS_PC_Ofensor,
                max(case when "ChecklistItemDescription" = 'OV 01 - Creation Date' then FixDBDates("ChecklistItemValue") end) as Sales_Order_R,
                max(case when "ChecklistItemDescription" = 'OV 01 - Comment' then "ChecklistItemValue" end) as SO_Desc

        
                from ID_MELA_DM_USR.CHECKLIST_ITEM_GST_MELA_NATIVE_VIEW
                where "ProjectCustomerIdCrg1" = '912728'
                and "ChecklistItemDescription" in
                (
                    'Criticos',
                    'Divisao Escopo PN',
                    'Ofensores',
                    'Prioridade Rollout',
                    'Plano',
                    'Status GAP',
                    'EHS Site Survey - Plan',
                    'EHS Site Survey - Real',
                    'EHS Site Survey - Status',
                    'EHS Site Survey - Ofensor',
                    'EHS Pre-Climbing Check - Status',
                    'EHS Pre-Climbing Check - Ofensor',
                    'OV 01 - Creation Date',
                    'OV 01 - Comment'
                )
                group by "ProjectCustomerIdCrg1", "ChecklistItemParentProject"
            ) as Checklistitem_Source
        ) as Form_Items_Source

        on Project_Source.Project_ID = Form_Items_Source.Project_ID
    order by Project_Source.Project;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from LAS_BR_CLARO_STANDARD_DASHBOARD_PMO;

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------