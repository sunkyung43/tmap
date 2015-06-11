package com.tmap.sitemanagement;

public enum TABLE_NAME {

	  app_info("app_info")
	, app_model_info("app_model_info")
	, app_version_info("app_version_info")
	, upgrade_ph_model_info("upgrade_ph_model_info")
	, upgrade_app_info("upgrade_app_info")
	, phone_model_info("phone_model_info")
	, os_ver_info("os_ver_info")
	, phone_info("phone_info")
	, templet_model_info("templet_model_info")
	, templet_model_list_info("templet_model_list_info")
	, data_file_info("data_file_info")
	, data_file_list_info("data_file_list_info")
	, data_storage_info("data_storage_info")
	, data_type_info("data_type_info")
	, file_version_info("file_version_info")
	, app_mapping_info("app_mapping_info")
	, app_mapping_detail_info("app_mapping_detail_info")
	, app_file_detail_info("app_file_detail_info")
	, app_service_info("app_service_info")
	, data_file_service_info("data_file_service_info")
	, file_service_info("file_service_info")
	, file_service_detail_info("file_service_detail_info")
	, com_type_info("com_type_info")
	, ds_com_state("ds_com_state")
	, server_type_info("server_type_info")
	, ip_filter_info("ip_filter_info")
	, ds_bandwidth_set("ds_bandwidth_set")
	, system_info("system_info")
	, mapdown_manage_info("mapdown_manage_info")
	, com_set_info("com_set_info")
	, authority_info("authority_info")
	, authority_menu_info("authority_menu_info")
	, company_info("company_info")
	//, history_info("history_info")
	, menu_info("menu_info")
	, notices_info("notices_info")
	, user_info("user_info")
	, certtime_info("certtime_info")
	, security_code_info("security_code_info")
	, comcode_info("comcode_info")
	, message_info("message_info")
	, rmversion_info("rmversion_info")
	, test_phone_info("test_phone_info")
	, rs_interface_info("rs_interface_info")
	, app_mapping_service_info("app_mapping_service_info")
	;

	private String tableName;
	private TABLE_NAME(String tableName) {this.tableName = tableName;}
	public String getTableName() {return tableName;}

	@Override
	public String toString(){return tableName;}
}
