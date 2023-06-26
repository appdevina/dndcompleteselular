import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_complete/model/models.dart';
import 'package:todolist_complete/api/api_service.dart';
import 'package:todolist_complete/api/api_url.dart';

part 'daily_service.dart';
part 'weekly_service.dart';
part 'monthly_service.dart';
part 'user_service.dart';
part 'result_services.dart';
part 'request_service.dart';

String baseUrl = "http://dnd.completeselular.com/api/";
String baseStorage = "http://dnd.completeselular.com/storage/";
