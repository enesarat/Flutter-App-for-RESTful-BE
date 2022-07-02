import 'package:mobx/mobx.dart';
import '../core/init/network/network_manager.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {

  @observable
  NetworkManager? service;

  @action
  void initService() {
    service=NetworkManager.instance;
  }
}