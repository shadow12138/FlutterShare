import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/page/entrance_widget.dart';
import 'package:myapp/page/hot_widget.dart';
import 'package:myapp/page/rank_widget.dart';
import 'package:myapp/utils/http_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> subject;

  Widget _getContent() {
    if (subject == null) return Container();

    List<Widget> widgets = [];

    for (Map<String, dynamic> module in subject['modules']) {
      String name = module['module_name'];
      if (name == 'movie_subject_entrances') {
        widgets.add(EntranceWidget(module['data']));
      } else if(name == 'movie_hot_gaia'){
        widgets.add(HotWidget(module['data']));
      } else if(name == 'movie_selected_collections'){
        widgets.add(RankWidget(module['data']));
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: 40.w),
      child: Column(
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: _getContent(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getHttp(HttpUtils.homeUrl).then((val) {
      setState(() {
        subject = val;
      });
    });
  }
}
