data "template_file" "templatized_workbook_json" {
  for_each = {
    "storage_account_workbook" = {
      display_name       = "storage account workbook"
      workbook_data_json = "storage_account_workbook"
    }
    "workspace_workbook" = {
      display_name       = "workspace workbook"
      workbook_data_json = "workspace_workbook"
    }
  }

  template = file("./workbook_files/${each.key}.json")
}

module "datta_user_identity" {
  source = "./services/modules/user_assigned_managed_identity/"

  rg_name = var.rg_name

}

module "azure_terraform_workbook" {
  source = "./services/modules/workbook/"
  for_each = {
    "storage_account_workbook" = {
      display_name       = "storage account workbook"
      workbook_data_json = "storage_account_workbook"
    }
    "workspace_workbook" = {
      display_name       = "workspace workbook"
      workbook_data_json = "workspace_workbook"
    }
  }
  depends_on = [ 
    module.datta_user_identity
  ]
  rg_name = var.rg_name
  uai_principal_id = module.datta_user_identity.uai_id
  display_name        = format("%s-%s", each.value.display_name, var.name_suffix)
  workbook_data_json  = data.template_file.templatized_workbook_json["${each.key}"].rendered
}
