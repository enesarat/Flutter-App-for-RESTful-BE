
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/state/base_state.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/test_view_model.dart';


class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  TestViewModel viewModel = TestViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<TestViewModel>(
        viewModel: TestViewModel(),
        onModelReady: (model){
          viewModel=model;
        },
        onPageBuilder: (context,value) => scaffoldBody,
        onDispose: (){}
    );
        //onDispose: (){});
  }

  Widget get scaffoldBody=>Scaffold(
      appBar: AppBar(title: Text("welcome")),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>viewModel.increment(),
        child: Icon(Icons.add),
      ),
      body: textNumber
  );

  Widget get textNumber {
    return Observer(
      builder: (BuildContext context) => Center(
        child: Text(
            viewModel.value.toString()
        ),
      ),
    );
  }
}

