
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';

import '../../base/model/base_model.dart';
import '../security/asymmetric_cryptography.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class NetworkManager{
  static NetworkManager? _instance;
  static NetworkManager get instance{
    if(_instance==null) _instance =NetworkManager._init();
    return _instance!;
  }
  late final Dio dio;
  final baseUrl="http://10.0.2.2:5000/";


  NetworkManager._init(){
    String language = "en";
    int _timeOut = 60*1000;
    Map<String,String> headers = {
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:"Constant.token",
      DEFAULT_LANGUAGE:language
    };
    dio = Dio(
        BaseOptions(
          baseUrl:baseUrl,
          connectTimeout: _timeOut,
          receiveTimeout: _timeOut,
          headers:headers
        )
    );
    //initInterceptors();
  }
  
  initInterceptors(){
    dio.interceptors.add(InterceptorsWrapper(
      onError:(DioError,handler){
        print(DioError.message);
      },
      onRequest:(request,handler){
        print("${request.method} ${request.path}");
      },
      onResponse:(response,handler){
        print(response.data);
      }
    ));
  }

  Future<Response> getRequest(String path)async{
    final response;

    try{
      response = await dio.get(path);
    }on DioError catch (e){
      throw Exception(e.message);
    }
    print("path is : "+path.toString());
    return response;
  }

  Future<Response?> postRequestToLogIn(String username,String password)async{
    Response response;

    //***************************************** Password Encryption
    var e = new Encrypt();
    var encrypted = await e.textEncryptor(password) as Encrypted;
    print("main=>encrypted=> "+encrypted.base64);
    print("main=>decrypted=> "+e.textDecryptor(encrypted));
    String passwordX=encrypted.base64;
    //*****************************************

    Map<String, String> body = {
      'UserName': username,
      'Password': passwordX,
    };
    try{
      response = await dio.post("/api/${_apiControllerPath.user.name}/${_postPaths.authenticate.name}",data:body);
      //response = await dio.post("/api/${_apiControllerPath.user.name}/${_postPaths.login.name}",data:body);
    }on DioError catch (e){
      throw Exception(e.message);
    }

    if(response.statusCode == 200) return response;
    return null;
  }

  Future<Response?> checkAuthorization(Map<String,dynamic> payload,String jwt) async {
    Response response;

    try{

      dio.options.headers["Authorization"] = "Bearer $jwt";
      switch(payload['role']) {
        case "Expert": {
          response = await dio.get("/api/${_apiControllerPath.user.name}/${_authPaths.expert.name}");
        }
        break;

        case "Manager": {
          response = await dio.get("/api/${_apiControllerPath.user.name}/${_authPaths.manager.name}");
        }
        break;

        default: {
          response = await dio.get("/api/${_apiControllerPath.user.name}/${_authPaths.admin.name}");
        }
        break;
      }
    }on DioError catch (e){
      throw Exception(e.message);
    }

    if(response.statusCode == 200) return response;
    return null;
  }

}

enum _apiControllerPath{ user,agent}
enum _authPaths { expert,manager,admin }
enum _postPaths { authenticate,login }