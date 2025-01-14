import 'package:adb_tool/app/controller/config_controller.dart';
import 'package:adb_tool/app/modules/overview/pages/overview_page.dart';
import 'package:adb_tool/global/widget/item_header.dart';
import 'package:adb_tool/global/widget/menu_button.dart';
import 'package:adb_tool/themes/app_colors.dart';
import 'package:adbutil/adbutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:global_repository/global_repository.dart';

class RemoteDebugPage extends StatefulWidget {
  const RemoteDebugPage({Key key}) : super(key: key);

  @override
  _RemoteDebugPageState createState() => _RemoteDebugPageState();
}

class _RemoteDebugPageState extends State<RemoteDebugPage> {
  ConfigController configController = Get.find();
  bool adbDebugOpen = false;
  List<String> address = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final String ipRoute = await execCmd('ip route');
    for (String ip in ipRoute.split('\n')) {
      ip = ip.trim().replaceAll(RegExp('.* '), '');
      Log.v(ip);
      address.add(ip);
    }
    Log.v('address->$address');
    setState(() {});
    final String result = await execCmd('getprop service.adb.tcp.port');
    if (result == '5555') {
      adbDebugOpen = true;
      setState(() {});
    }
  }

  Future<void> changeState() async {
    adbDebugOpen = !adbDebugOpen;
    setState(() {});
    final int value = adbDebugOpen ? 5555 : -1;
    await execCmd2([
      'su',
      '-c',
      'setprop service.adb.tcp.port $value&&stop adbd&&start adbd'
    ]);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar;
    if (Responsive.of(context).screenType == ScreenType.phone) {
      appBar = AppBar(
        title: const Text('网络ADB调试'),
        titleSpacing: 0,
        leadingWidth: 48.w,
        leading: Menubutton(
          scaffoldContext: context,
        ),
      );
    }
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '打开网络ADB调试',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.w,
                        ),
                      ),
                      Switch(
                        value: adbDebugOpen,
                        onChanged: (_) async {
                          changeState();
                        },
                      ),
                    ],
                  ),
                ),
                CardItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ItemHeader(
                            color: CandyColors.candyPurpleAccent,
                          ),
                          Text(
                            '本机IP',
                            style: TextStyle(
                              fontSize: Dimens.font_sp20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                            text: address.join('\n'),
                          ));
                          showToast('IP已复制');
                        },
                        borderRadius: BorderRadius.circular(12.w),
                        child: Text(
                          address.join('\n'),
                          style: TextStyle(
                            fontSize: Dimens.font_sp16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.w,
                ),
                CardItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ItemHeader(color: CandyColors.candyBlue),
                          Text(
                            '连接方法',
                            style: TextStyle(
                              fontSize: Dimens.font_sp20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            // Container(
                            //   width: 24.w,
                            //   height: 24.w,
                            //   decoration: BoxDecoration(
                            //     color: AppColors.accent.withOpacity(0.1),
                            //     borderRadius: BorderRadius.circular(12.w),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       '1',
                            //       style: TextStyle(
                            //         fontSize: 12.w,
                            //         fontWeight: FontWeight.w500,
                            //         height: 1.0,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Text(
                              '1.设备与PC处于于一个局域网',
                              style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp4),
                        child: Text(
                          '2.打开PC的终端模拟器，执行连接',
                          style: TextStyle(
                            fontSize: Dimens.font_sp14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp8,
                          vertical: Dimens.gap_dp8,
                        ),
                        decoration: BoxDecoration(
                          color: configController.theme.grey.shade100,
                          borderRadius: BorderRadius.circular(Dimens.gap_dp8),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'adb connect \$IP',
                                style: TextStyle(
                                  color: configController.theme.fontColor
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '    \$IP代表的是本机IP',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp4),
                        child: Text(
                          '3.执行adb devices查看设备列表是有新增',
                          style: TextStyle(
                            fontSize: Dimens.font_sp14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: configController.theme.grey.shade100,
                          borderRadius: BorderRadius.circular(Dimens.gap_dp8),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'adb devices',
                                style: TextStyle(
                                  color: configController.theme.fontColor
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimens.gap_dp8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
