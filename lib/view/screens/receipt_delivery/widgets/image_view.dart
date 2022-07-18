import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget{
  String image  ;

  ImageView(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Scaffold(
    // backgroundColor: Colors.white,
     body:  Container(
         child: PhotoView(
           imageProvider:                CachedNetworkImageProvider(image),



         )

   ));
  }
}