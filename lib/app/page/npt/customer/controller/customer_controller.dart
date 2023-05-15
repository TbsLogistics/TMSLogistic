import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:tbs_logistics_tms/app/config/constants/constants.dart';
import 'package:tbs_logistics_tms/app/config/routes/pages.dart';
import 'package:tbs_logistics_tms/app/config/share_preferences/share_preferences.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/customer_register_for_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/customer_create_register/model/list_customer_for_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_driver_for_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_car.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_type_product_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_warehome_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_status_details/model/list_driver_by_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/list_tracking_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/register_customer_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/customer/model/id_driver_model.dart';
import 'package:tbs_logistics_tms/app/page/npt/driver/page/driver_create_register/model/list_customer_for_driver_model.dart';

class CustomerController extends GetxController {}
