import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/screen_util.dart';

Widget imageCached(String url, {
      double width = 100,
      double height = 100,
      //EdgeInsetsGeometry margin,
    }) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover, //充满容器，可能会被截断
    height: setHeight(height),
    width: setWidth(width),
    //占位图
    placeholder: (context, url) =>
        Container(alignment: Alignment.center, child: CircularProgressIndicator()),
    //报错占位图
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}