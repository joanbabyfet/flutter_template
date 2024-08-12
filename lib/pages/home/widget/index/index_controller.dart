import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../api/ad.dart';
import '../../../../api/article.dart';
import '../../../../entity/ad.dart';
import '../../../../entity/article.dart';
import '../../../../utils/logger_util.dart';
import '../../../../utils/utils.dart';

class IndexController extends GetxController {
  final items = <ArticleItem>[].obs;
  final adItems = <AdItem>[].obs;
  int page = 1; //第几页
  int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    debugPrint('初始化');

    //获取文章列表
    getData();
    //获取轮播图
    getAd();
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('控制器被释放');
  }

  //下拉刷新
  void onRefresh() async {
    page = 1;
    getData();
  }

  //上拉加载更多
  void loadMore() async {
    page++;
    getData();
  }

  //获取新闻列表
  void getData() async {
    try {
      List<ArticleItem>? list = [];
      var articleList = await ArticleAPI.articlePageList(page, pageSize);
      list = articleList.data?.list; //!为空检查操作符
      if (page > 1) {
        items.addAll(list!);
      } else {
        items.value = list!;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  //获取轮播图
  void getAd() async {
    int limit = 5; //前几条

    try {
      var list = await AdAPI.adList(limit);
      adItems.value = list.data!.list!; //!为空检查操作符
    } catch (e) {
      logger.e(e);
    }
  }
}
