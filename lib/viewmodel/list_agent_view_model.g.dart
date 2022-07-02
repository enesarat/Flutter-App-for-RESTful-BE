// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_agent_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListAgentScreenViewModel on _ListAgentScreenViewModelBase, Store {
  late final _$serviceAtom =
      Atom(name: '_ListAgentScreenViewModelBase.service', context: context);

  @override
  NetworkManager? get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(NetworkManager? value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$singleAgentAtom =
      Atom(name: '_ListAgentScreenViewModelBase.singleAgent', context: context);

  @override
  AgentModel? get singleAgent {
    _$singleAgentAtom.reportRead();
    return super.singleAgent;
  }

  @override
  set singleAgent(AgentModel? value) {
    _$singleAgentAtom.reportWrite(value, super.singleAgent, () {
      super.singleAgent = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ListAgentScreenViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$agentsAtom =
      Atom(name: '_ListAgentScreenViewModelBase.agents', context: context);

  @override
  List<dynamic> get agents {
    _$agentsAtom.reportRead();
    return super.agents;
  }

  @override
  set agents(List<dynamic> value) {
    _$agentsAtom.reportWrite(value, super.agents, () {
      super.agents = value;
    });
  }

  late final _$getAgentListAsyncAction = AsyncAction(
      '_ListAgentScreenViewModelBase.getAgentList',
      context: context);

  @override
  Future<dynamic> getAgentList() {
    return _$getAgentListAsyncAction.run(() => super.getAgentList());
  }

  late final _$_ListAgentScreenViewModelBaseActionController =
      ActionController(name: '_ListAgentScreenViewModelBase', context: context);

  @override
  void initService() {
    final _$actionInfo = _$_ListAgentScreenViewModelBaseActionController
        .startAction(name: '_ListAgentScreenViewModelBase.initService');
    try {
      return super.initService();
    } finally {
      _$_ListAgentScreenViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshAgents(dynamic responseBody) {
    final _$actionInfo = _$_ListAgentScreenViewModelBaseActionController
        .startAction(name: '_ListAgentScreenViewModelBase.refreshAgents');
    try {
      return super.refreshAgents(responseBody);
    } finally {
      _$_ListAgentScreenViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
service: ${service},
singleAgent: ${singleAgent},
isLoading: ${isLoading},
agents: ${agents}
    ''';
  }
}
