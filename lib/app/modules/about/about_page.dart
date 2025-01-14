import 'package:adb_tool/app/controller/config_controller.dart';
import 'package:adb_tool/app/modules/overview/pages/overview_page.dart';
import 'package:adb_tool/config/config.dart';
import 'package:adb_tool/global/widget/menu_button.dart';
import 'package:adb_tool/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:global_repository/global_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar;
    if (Responsive.of(context).screenType == ScreenType.phone) {
      appBar = AppBar(
        title: const Text('关于'),
        leading: Menubutton(
          scaffoldContext: context,
        ),
      );
    }
    return Column(
      children: [
        if (appBar != null) appBar,
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 48.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 24.w),
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Icon(
                      Icons.adb,
                      color: Colors.white,
                      size: 72.w,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    'ADB TOOL',
                    style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.w),
                  CardItem(
                    child: Column(
                      children: [
                        SettingItem(
                          title: '当前版本',
                          suffix: Text(
                            '${Config.versionName}(${Config.versionCode})',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .color
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        SettingItem(
                          title: '版本分支',
                          suffix: Text(
                            'Master',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .color
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        SettingItem(
                          title: '其他版本下载',
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                          onTap: () async {
                            const String url =
                                'http://nightmare.fun/YanTool/resources/ADBTool/?C=N;O=A';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.w),
                  CardItem(
                    child: Column(
                      children: [
                        SettingItem(
                          title: '服务条款',
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                        ),
                        SettingItem(
                          title: '用户协议',
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                        ),
                        SettingItem(
                          title: '开源许可',
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                          onTap: () {
                            Get.to(LicensePage(
                              applicationName: 'ADB工具箱',
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.w),
                  CardItem(
                    child: Column(
                      children: [
                        SettingItem(
                          title: 'github.com/mengyanshou',
                          subTitle: '关注开发者Github',
                          prefix: ClipOval(
                            child: Image.network(
                              'http://nightmare.fun/YanTool/image/hong.jpg',
                              width: 44.w,
                            ),
                          ),
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                          onTap: () async {
                            const String url = 'https://github.com/mengyanshou';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        SizedBox(height: 8.w),
                        SettingItem(
                          title: '梦魇兽',
                          subTitle: '关注开发者酷安',
                          prefix: ClipOval(
                            child: Image.network(
                              'http://nightmare.fun/YanTool/image/hong.jpg',
                              width: 44.w,
                            ),
                          ),
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                          onTap: () async {
                            const String url =
                                'http://www.coolapk.com/u/1345256';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        SizedBox(height: 8.w),
                        SettingItem(
                          title: '其他相关软件下载',
                          subTitle: '“无界”、“魇·工具箱”、“速享”、“Code FA”等相关作品下载',
                          prefix: ClipOval(
                            child: Image.network(
                              'http://nightmare.fun/YanTool/image/hong.jpg',
                              width: 44.w,
                            ),
                          ),
                          suffix: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                          ),
                          onTap: () async {
                            const String url = 'http://nightmare.fun';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.w),
                  CardItem(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            '''BSD 3-Clause License

Copyright (c) 2021,  Nightmare
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.''',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .color
                                  .withOpacity(0.6),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingItem extends StatefulWidget {
  const SettingItem({
    Key key,
    this.title,
    this.onTap,
    this.subTitle = '',
    this.suffix = const SizedBox(),
    this.prefix,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final void Function() onTap;
  final Widget suffix;
  final Widget prefix;
  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      // highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.w,
          horizontal: 10.w,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 48.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: widget.prefix,
                  ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.title ?? '',
                              style: TextStyle(
                                // color: Theme.of(context).colorScheme.primaryVariant,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.w,
                                // height: 1.0,
                              ),
                            ),
                            if (widget.subTitle.isNotEmpty)
                              Builder(builder: (_) {
                                final String content = widget.subTitle;
                                if (content == null) {
                                  return const SizedBox();
                                }
                                return Column(
                                  children: [
                                    SizedBox(height: 4.w),
                                    Text(
                                      content,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                        // height: 1.0,
                                        fontSize: 12.w,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          ],
                        ),
                      ),
                      widget.suffix,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
