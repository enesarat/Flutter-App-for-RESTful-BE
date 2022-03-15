import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  final Widget Function(BuildContext context,T value) onPageBuilder;
  final T viewModel;
  final Function(T model) onModelReady; // Callback for init state
  final VoidCallback? onDispose;
  const BaseView({Key? key,required this.onPageBuilder,required this.viewModel,required this.onModelReady,this.onDispose}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  late T model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //if(widget.onModelReady!=null) widget.onModelReady(widget.viewModel);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //if(widget.onDispose!=null) widget.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context,widget.viewModel);
  }
}
