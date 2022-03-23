
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
    dio = Dio(
        BaseOptions(
          baseUrl:baseUrl,
        )
    );
    initInterceptors();
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

  Future<Response> getRequest<T extends BaseModel>(String path)async{
    final response;
    String language = "en";
    int _timeOut = 60*1000;

    Map<String,String> headers = {
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION:"Constant.token",
      DEFAULT_LANGUAGE:language
    };

    var options = BaseOptions(
        baseUrl:baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers:headers
    );

    try{
      response = await Dio(options).get(path);
    }on DioError catch (e){
      throw Exception(e.message);
    }
    print("path is : "+path.toString());
    return response;
  }
}