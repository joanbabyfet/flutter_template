import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper_3/flutter_swiper_3.dart';
import 'package:get/get.dart';
import '../../../../utils/toast_util.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/article_item.dart';
import '../../../../widget/grid_item.dart';
import '../../../../widget/image.dart';
import 'index_controller.dart';

class IndexWidget extends StatelessWidget {
  IndexWidget({Key? key}) : super(key: key);

  final controller = Get.put(IndexController());

  //分类
  List<ActionItem> actionList = [
    ActionItem('美食', Color(0xFFEF5362)),
    ActionItem('甜点', Color(0xFFFE6D4B)),
    ActionItem('烧烤', Color(0xFFFFCF47)),
    ActionItem('夜宵', Color(0xFF9FD661)),
    ActionItem('水果', Color(0xFF3FD0AD)),
    ActionItem('药品', Color(0xFF2BBDF3)),
    ActionItem('蔬菜', Color(0xFF5A9AEF)),
    ActionItem('跑腿', Color(0xFFAC8FEF)),
  ];

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      //下拉刷新
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          controller.onRefresh();
        });
      },
      //上拉加载更多
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          controller.loadMore();
        });
      },
      slivers: [
        //轮播图, 将普通Box组件转换为Sliver组件
        SliverToBoxAdapter(child: getAdWidget()),

        //网格菜单
        SliverPadding(
          padding: EdgeInsets.only(top: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
            ),
            //将创建和布局子项，以及布局网格的工作交给了其他对象，从而实现了代码的解耦和复用
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                //创建子widget
                var action = actionList[index];
                return GridItem(
                    title: action.title,
                    color: action.color,
                    onTap: () {
                      ToastUtil.show('点击-->${action.title}');
                    });
              },
              childCount: actionList.length,
            ),
          )
        ),

        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Text(
                  '资讯',
                  style: TextStyle(fontSize: 18),
                )
            )
        ),

        //列表
        Obx(() => SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
              var item = controller.items[index];
              //文章公共组件
              return ArticleListItem(
                  articleUrl: 'http://flutter.io', //文章地址
                  img: item.img!, //图片地址
                  title: item.title!, //标题
                  author: item.author!, //作者
                  info: Utils.stripHtml(item.info!), //摘要
              );
            },
            childCount: controller.items.length,
          ),
        )),
      ],
    );
  }

  //轮播图
  Widget getAdWidget() {
    return SizedBox(
      height: 200,
      child: Obx(() => Swiper(
        autoplay: true,
        duration: 2000,
        autoplayDelay: 8000,
        itemBuilder: (context, index) {
          var item = controller.adItems[index];
          return Container(
            color: Colors.transparent,
            child: ClipRRect( //对子组件进行圆角裁剪
              borderRadius: BorderRadius.circular(0),
              child: imageCached(
                  item.img!
              )
            ),
          );
        },
        onTap: (value) {
          ToastUtil.show('点击-->$value');
        },
        itemCount: controller.adItems.length,
        pagination: SwiperPagination(),
      ),
    ));
  }
}
