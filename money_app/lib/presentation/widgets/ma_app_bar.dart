import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MaAppBar {
  AppBar buildAppBarWithTitle(String title) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  AppBar buildAppBarWithBackIcon(String title) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      leading: const BackButton(color: Colors.white),
    );
  }

  AppBar buildAppBarWithCloseIcon(String title) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/ic_close.svg"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
