
import 'package:dio/dio.dart';

import '../../base/model/base_model.dart';

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
  late Dio dio;
  final baseUrl="http://10.0.2.2:5000/";


  NetworkManager._init(){
    print("NM INIT");

    dio = Dio(
        BaseOptions(
          baseUrl:baseUrl,
        )
    );
    print(baseUrl.toString());
    initInterceptors();
  }
  
  initInterceptors(){
    print("INT INITIALIZER");
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

  /*
  Future<Response> getRequest/*<T extends BaseModel>*/(String path/*,T model*/)async{
    Response response;
    print("getrequest income");

    try{
      response = await _dio.get(path);
      print("getrequest try");
    }on DioError catch (e){
      print("haydaaa getrequest error");
      throw Exception(e.message);
    }
    print("path is : "+path.toString());
    return response;
  }
   */
  Future/*<Response>*/ getRequest<T extends BaseModel>(String path,T model)async{
    print("getrequest entry");
    final response;
    final finalResponse;
    String language = "en";
    int _timeOut = 60*1000;

    Map<String,String> headers = {
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:"Constant.token",
      DEFAULT_LANGUAGE:language
    };

    response = await Dio(BaseOptions(
      baseUrl:baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers:headers
    )).get(path);
    print("getrequest entry 2");


    try{
      finalResponse=model.fromJson(response.data);
      print("getrequest try");
    }on DioError catch (e){
      print("oops getrequest error");
      throw Exception(e.message);
    }
    print("path is : "+path.toString());
    print(finalResponse);
    return finalResponse;
  }
}