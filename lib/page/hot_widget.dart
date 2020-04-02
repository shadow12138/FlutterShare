import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/utils.dart';

class HotWidget extends StatelessWidget {
  Map<String, dynamic> subject;
  double horizontalMargin = 40;
  double itemPadding = 20;
  int columns = 3;

  HotWidget(Map<String, dynamic> data) {
    subject = data['subject_collection_boards'][0];
  }

  Widget _getItem(Map<String, dynamic> item) {
    double width = (ScreenUtil.screenWidth -
            horizontalMargin * 2 -
            (columns - 1) * itemPadding) /
        columns;
    double height = width * 1.2;
    Widget _image = Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
              image: NetworkImage(item['cover']['url']), fit: BoxFit.cover)),
    );

    Widget _title = Container(
      margin: EdgeInsets.only(top: 6.w),
      child: Text(
        item['title'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    List<Widget> stars = [];
    double value = item['rating']['value'];
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        Icons.star,
        color: Utils.getColorFromHex(i < value / 2 ? '#F2AA42' : '#CCC9B9'),
        size: 36.w,
      ));
    }
    stars.add(Container(
      margin: EdgeInsets.only(left: 6.w),
      child: Text(
        value.toString(),
        style: TextStyle(color: Colors.black38, fontSize: 12),
      ),
    ));

    Widget _rating = Container(
      child: Row(
        children: stars,
      ),
    );

    return Container(
      width: width.w,
      margin: EdgeInsets.only(top: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_image, _title, _rating],
      ),
    );
  }

  Widget _getList() {
    List<dynamic> items = subject['items'];
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Wrap(
        runSpacing: itemPadding.w,
        spacing: itemPadding.w,
        children: items.sublist(0, 6).map((item) {
          return _getItem(item);
        }).toList(),
      ),
    );
  }

  Widget _getTitle() {
    Map<String, dynamic> titleSubject = subject['subject_collection'];
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              titleSubject['name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          Text(
            '全部${titleSubject['subject_count']}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 30.w,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }
}
