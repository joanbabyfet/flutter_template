import 'package:flutter/material.dart';

// 列表项
class ListItem extends StatelessWidget {
  // 点击事件
  final VoidCallback? onPressed;

  // 图标
  final Widget? icon;

  // 标题
  final String? title;
  final Color titleColor;

  // 描述
  final String? describe;
  final double? describeSpace;
  final Color describeColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  ListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.titleColor = Colors.black,
    this.describe,
    this.describeSpace = 3.0,
    this.describeColor = Colors.grey,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        //height: 60.0, //这里设置高度会报错
        width: double.infinity,
        child: Row(
          children: [
            icon != null
                ? Container(
              padding: EdgeInsets.all(14.0),
              child: SizedBox(
                height: 32.0,
                width: 32.0,
                child: icon,
              ),
            )
                : Container(
              width: 14.0,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title != null
                      ? Text(
                    title!,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : Container(),
                  describe != null
                      ? Padding(
                      padding: EdgeInsets.only(top: describeSpace!),
                      child: Text(
                        describe!,
                        maxLines: 2,
                        style: TextStyle(
                            color: describeColor, fontSize: 12.0),
                      ))
                      : Container(),
                ],
              ),
            ),
            rightWidget == null ? Container() : rightWidget!,
            Container(
              width: 14.0,
            ),
          ],
        )
      ),
    );
  }
}