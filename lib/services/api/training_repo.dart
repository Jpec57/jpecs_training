import 'package:jpec_training/Services/API/rest.dart';
import 'package:jpec_training/models/user.dart';

Future<User?> createUserRequest() async {
  Map map = new Map();
  map.putIfAbsent("fullname", () => "jpec");
  print("start");
  var res = await getLocalePostRequestResponse("/fitness/api/users", map);
  print("Coucou");
  if (res != null){
    var json = await getJsonFromHttpResponse(res);
    if (!isRequestValid(res.statusCode)) {
      print(json);
      return null;
    }
    print(json);
  }

  return null;
}
