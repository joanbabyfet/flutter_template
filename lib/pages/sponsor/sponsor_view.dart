import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share/share.dart';
import '../../utils/permission_util.dart';
import '../../utils/toast_util.dart';
import '../../utils/utils.dart';
import 'sponsor_controller.dart';

class SponsorPage extends StatelessWidget {
  SponsorPage({Key? key}) : super(key: key);

  final controller = Get.put(SponsorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sponsor'.tr)),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text('sponsorDescription'.tr, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
            SizedBox(height: 15),
            _loadImage(context, 'https://placehold.co/300x450/png'),
          ]
        )
      )
    );
  }

  Widget _loadImage(context, String url, {String linkUrl = ''}) => SizedBox(
    width: 166,
    height: 249,
    child: Center(
      child: GestureDetector(
        child: ExtendedImage.network(
          url,
        ),
        onLongPress: () {
          showMenuDialog(context, url, linkUrl);
        },
      )
    ),
  );

  //显示操作菜单弹窗
  void showMenuDialog(context, String url, String linkUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          title: Text('操作'),
          children: [
            linkUrl.isNotEmpty
                ? SimpleDialogOption(
              child: Text('打开应用'),
              onPressed: () {
                //打开浏览器
                Utils.launch(linkUrl);
                Get.back();
              },
            )
                : SizedBox(),
            SimpleDialogOption(
              child: Text('保存到本地'),
              onPressed: () {
                saveImage(url);
                Get.back(); //关闭对话框
              },
            ),
            SimpleDialogOption(
              child: Text('分享给好友'),
              onPressed: () {
                shareImage(url);
                Get.back(); //关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  //保存网络图片
  void saveImage(String url) async {
    late dynamic result;
    //申请访问照片权限, ios要在Info.plist加提示语否则会闪退
    if (await PermissionUtil.requestPermissionStorage()) {
      var cacheData = await getNetworkImageData(url, useCache: true); //获取网路图片, 这里使用缓存
      String fileName = DateTime.fromMillisecondsSinceEpoch(int.parse(Utils.timestamp())).toString();
      //如果图片已缓存
      if (cacheData != null) {
        result = await ImageGallerySaver.saveImage(cacheData, quality: 100, name: fileName);
      } else {
        var res = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
        result = await ImageGallerySaver.saveImage(Uint8List.fromList(res.data), quality: 100, name: fileName);
      }
      if(result['isSuccess']) {
        ToastUtil.show('保存成功');
      } else {
        ToastUtil.show('保存失败');
      }
    }
  }

  void shareImage(String url) {
    Share.share(url);
  }
}
