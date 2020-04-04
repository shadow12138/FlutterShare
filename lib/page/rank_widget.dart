import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/const.dart';
import 'package:myapp/utils/utils.dart';

class RankWidget extends StatelessWidget {
  Map<String, dynamic> subject;

  RankWidget(this.subject);

  Widget _getItem(Map<String, dynamic> item, bool isFirst, bool isLast) {
    double width = Const.screenWidth / 3 * 2;
    double height = width * 0.4;

    Widget _image = Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          image: DecorationImage(
              image: NetworkImage(item['header_bg_image']), fit: BoxFit.cover)),
    );

    Widget _mask = Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: Color.fromARGB(80, 0, 0, 0)),
    );

    print('RankWidget: ${item.toString()}');
    Widget _subtitle = Container(
      margin: EdgeInsets.only(right: 20.w, top: 20.w),
      width: width.w,
      alignment: Alignment.topRight,
      child: Text(
        item['subtitle'],
        style: TextStyle(color: Colors.white),
      ),
    );

    Widget _title = Container(
      height: height.w,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(40.w),
      child: Text(
        item['name'],
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );

    Widget _top = Container(
      width: width.w,
      height: height.w,
      child: Stack(
        children: <Widget>[_image, _mask, _subtitle, _title],
      ),
    );

    List<dynamic> rankItems = item['items'];
    Widget _bottom = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          color: Utils.getColorFromHex(
              item['background_color_scheme']['primary_color_dark'])),
      width: width.w,
      padding: EdgeInsets.all(40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rankItems.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> rankItem = entry.value;
          return Container(
            margin: EdgeInsets.only(top: index == 0 ? 0 : 20.w),
            child: Text(
              '${index + 1}. ${rankItem['title']}',
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );

    return Container(
      margin: EdgeInsets.only(
          left: isFirst ? 40.w : 20.w, right: isLast ? 40.w : 0),
      child: Column(
        children: <Widget>[_top, _bottom],
      ),
    );
  }

  Widget _getList() {
    List<dynamic> items = subject['selected_collections'];

    return Container(
      margin: EdgeInsets.only(top: 40.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.asMap().entries.map((entry) {
            int index = entry.key;
            return _getItem(entry.value, index == 0, index == items.length - 1);
          }).toList(),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              subject['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          Text('全部${subject['total']}'),
          Container(
            margin: EdgeInsets.only(top: 4.h, left: 8.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 30.w,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80.w),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }
}