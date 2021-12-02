import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_complete/model/models.dart';

part 'daily_service.dart';
part 'weekly_service.dart';
part 'monthly_service.dart';
part 'user_service.dart';

String baseUrl = "http://192.168.1.111/api/";
String baseStorage = "http://192.168.1.111/storage";
