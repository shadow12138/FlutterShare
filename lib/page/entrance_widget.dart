import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/const.dart';

class EntranceWidget extends StatelessWidget {
  Map<String, dynamic> subject;

  EntranceWidget(this.subject);

  int columns = 4;

  Widget _getItem(Map<String, dynamic> item) {
    double iconSize = Const.screenWidth / (4 * 2);
    Widget _image = Image.network(
      item['icon'],
      width: iconSize.w,
      height: iconSize.w,
    );
    Widget _title = Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Text(item['title'], style: TextStyle(color: Colors.black54, fontSize: 12),),
    );

    return Container(
      child: Column(
        children: <Widget>[_image, _title],
      ),
    );
  }

  Widget _getList() {
    List<dynamic> items = subject['subject_entraces'];
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      children: items.map((item) {
        return _getItem(item);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.w),
      child: _getList(),
    );
  }
}