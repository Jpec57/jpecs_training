import 'package:jpec_training/Models/User.dart';
import 'package:jpec_training/Services/API/rest.dart';

Future<User> createUserRequest() async{
  Map map = new Map();
  map.putIfAbsent("fullname", () => "jpec");
  print("start");
  var res = await getLocalePostRequestResponse("/fitness/api/users", map);
  print("Coucou");
  var json = await getJsonFromHttpResponse(res);
  if (!isRequestValid(res.statusCode)){
    print(json);
    return null;
  }
  print(json);
  return null;
}