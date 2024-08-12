import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'image.dart';

// 资讯列表详情
class ArticleListItem extends StatelessWidget {
  //文章地址
  final String articleUrl; //组件属性

  //图片地址
  final String img;

  //文章标题
  final String title;

  //文章作者
  final String author;

  //文章摘要
  final String info;

  ArticleListItem(
      {Key? key,
        this.articleUrl = '',
        this.img = '',
        this.title = '',
        this.author = '',
        this.info = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( //给Widget添加点击事件
      onTap: () {
        Utils.goWeb(articleUrl, title);
      },
      child: Card(
        clipBehavior: Clip.antiAlias, //裁剪且抗锯齿
        elevation: 4, //阴影
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), //设置圆角
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 5),
                width: 100.0, // 限定一下宽度
                child: AspectRatio(
                  aspectRatio: 1.2, //设置宽高比为1.2
                  child: imageCached(
                      img
                  )
                ),
              ),
              Expanded(
                flex: 1, //当前Expanded宽度占比
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), //horizontal左右
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(title,
                                      overflow: TextOverflow.ellipsis, //将多余文本截断后以省略符...表示
                                      style: TextStyle(color: Colors.black, fontSize: 15)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2.0),
                                  child: Text(author,
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        info,
                        maxLines: 3,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}