import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_complete/model/models.dart';

part 'daily_service.dart';
part 'weekly_service.dart';
part 'monthly_service.dart';
part 'user_service.dart';

String baseUrl = "http://192.168.0.104:8000/api/";
String baseStorage = "http://192.168.0.104:8000/storage";
String token = 'Bearer 1|m7uuNpHZzJEZqLCIqe9O5djsIBA3r9muUJy5edZj';

// firman 1|m7uuNpHZzJEZqLCIqe9O5djsIBA3r9muUJy5edZj
// arik 2|dZ8poGmaYq1rT236NSZ2yoH1KQCNfC66q7ZtWdwq
// csa1.completeselular.com:3388