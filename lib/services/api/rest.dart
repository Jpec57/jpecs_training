import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const IS_LOCALE = true;
const BASE_REMOTE_URL = 'https://jpec.be';

Future<HttpClientResponse> handleGenericErrors(
    HttpClientResponse response) async {
  int statusCode = response.statusCode;
  //Token expired
  if (statusCode == 401) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get('apiToken') != null) {
      sharedPreferences.remove('apiToken');
      Get.snackbar(
          'API Token expired', 'Your token has expired. Please log in again.',
          snackPosition: SnackPosition.BOTTOM);
    }
    print("You are not connected.");
  }
  return response;
}

bool isRequestValid(int statusCode) {
  if (statusCode == 401) {
    Get.snackbar(
        'API Token expired', 'Your token has expired. Please log in again.',
        snackPosition: SnackPosition.BOTTOM);
    print("You are not connected.");
  }
  return (statusCode >= 200 && statusCode < 300);
}

getJsonFromHttpResponse(HttpClientResponse response) async {
  String reply = await response.transform(utf8.decoder).join();
  return json.decode(reply);
}

Future<http.Response> getFileRequestResponse(String uri,
    {canHandleGenericErrors = true}) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url;
  if (IS_LOCALE) {
    url = 'https://10.0.2.2:8000$uri';
  } else {
    url = BASE_REMOTE_URL + uri;
  }
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String apiToken = sharedPreferences.get('apiToken');
  Map<String, String> headers = new Map();
  headers.putIfAbsent(
      HttpHeaders.authorizationHeader, () => 'Bearer $apiToken');
  headers.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  return http.get(Uri.parse(url), headers: headers);
}

Future<HttpClientResponse> getLocaleGetRequestResponse(String uri,
    {canHandleGenericErrors = true}) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  Uri url;
  if (IS_LOCALE) {
    url = new Uri.http("localhost:8000", uri);
  } else {
    url = Uri.parse(BASE_REMOTE_URL + uri);
  }
  HttpClientRequest request = await client.getUrl(url);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String apiToken = sharedPreferences.get('apiToken');
  if (apiToken != null) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $apiToken');
  }
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
  HttpClientResponse response = await request.close();
  if (!isRequestValid(response.statusCode)) {
    print(getJsonFromHttpResponse(response));
    return null;
  }
  return response;
}

Future<HttpClientResponse> getLocalePostRequestResponse(String uri, Map body,
    {canHandleGenericErrors = true}) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  Uri url;
  if (IS_LOCALE) {
    url = new Uri.http("localhost:8000", uri);
  } else {
    url = Uri.parse(BASE_REMOTE_URL + uri);
  }
  HttpClientRequest request = await client.postUrl(url);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String apiToken = sharedPreferences.get('apiToken');
  if (apiToken != null) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $apiToken');
  }
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
  List<int> parsedBody = utf8.encode(json.encode(body));
  request.headers.set(HttpHeaders.contentLengthHeader, parsedBody.length);
  request.add(parsedBody);
  HttpClientResponse response = await request.close();
  if (!isRequestValid(response.statusCode)) {
    print(getJsonFromHttpResponse(response));
    return null;
  }
  return response;
}

Future<HttpClientResponse> getLocaleDeleteRequestResponse(String uri,
    {canHandleGenericErrors = true}) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  Uri url;
  if (IS_LOCALE) {
    url = new Uri.http("localhost:8000", uri);
  } else {
    url = Uri.parse(BASE_REMOTE_URL + uri);
  }
  HttpClientRequest request = await client.deleteUrl(url);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String apiToken = sharedPreferences.get('apiToken');
  if (apiToken != null) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $apiToken');
  }
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
  HttpClientResponse response = await request.close();
  if (!isRequestValid(response.statusCode)) {
    print(getJsonFromHttpResponse(response));
    return null;
  }
  return response;
}
