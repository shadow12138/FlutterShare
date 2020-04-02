import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntranceWidget extends StatelessWidget {
  Map<String, dynamic> subject;

  EntranceWidget(this.subject);

  Widget _getItem(Map<String, dynamic> item) {
    double iconSize = 140.w;
    Widget _image = Image.network(
      item['icon'],
      width: iconSize,
      height: iconSize,
    );
    Widget _title = Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Text(item['title'], style: TextStyle(color: Colors.black54),),
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
      crossAxisCount: 4,
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
