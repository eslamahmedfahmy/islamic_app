import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islam_app/components/menu/list_tile_menu_app_bar.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/constant/urlApp.dart';
import 'package:islam_app/notifications/local_notifications_service.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
// الي بيتعرض في الجمب في الصفحه الرئيسيه menu دي صفحه
  Divider divider = Divider(color: Colors.black12);

  SizedBox sizedBox = SizedBox(height: 5);

  NotificationsServices notificationsServices =
      NotificationsServices(); // خاصه بالاشعارات داخل التطبيق
  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotifications();
    getDataPrefs();

    // دي خاصه بزر التنقل بتعت التلفون لي تغير اللون حسب حاله التطبيق
    SystemChrome.setSystemUIOverlayStyle(dayOverlayStyle);
    _brightness.addListener(() {
      SystemChrome.setSystemUIOverlayStyle(
        _brightness.value == Brightness.light
            ? dayOverlayStyle
            : nightOverlayStyle,
      );
    });
  }

  bool notifications = false;
  bool isDarkThem = false;

  getDataPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    setState(() {
      notifications = sp.getBool('notifications') ?? false;
      isDarkThem = sp.getBool('isDarkThem') ?? false;
    });
  }

// menu الجزء الي تحت ده خاص بفتح الروابط في صفحه
// دي بتفتح الموقع الخاص بيا علي جوجل
  Future<void> Website() async {
    if (!await launchUrl(urlWebsiteDeveloper,
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlWebsiteDeveloper';
    }
  }

//  دي بتفتح الصفحه الفيس بوك
  Future<void> Facebook() async {
    if (!await launchUrl(urlFacebook, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlFacebook';
    }
  }

// دي خاصه بالتقيم التطبيق
  Future<void> Assess() async {
    if (!await launchUrl(urlWebsiteDeveloper,
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlWebsiteDeveloper';
    }
  }

  // دي خاصه بشريط التنقل الي بيكون موجود في الهاتف تحت خالص الي هيا الازرار التنقل
// بيستخدم علشان يشوف حاله التطبيق ايه مظلم ام نهار
  ValueNotifier<Brightness> _brightness = ValueNotifier(Brightness.light);
// الوضع النهار
  static const SystemUiOverlayStyle dayOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xfff7f7f7),
    systemNavigationBarColor: Color(0xfff7f7f7),
    systemNavigationBarIconBrightness: Brightness.dark,
  );
//  الوضع الليلي
  static const SystemUiOverlayStyle nightOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Color(0xff081D57),
    systemNavigationBarColor: Color(0xff081D57),
    systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  void dispose() {
    _brightness.dispose();
    super.dispose();
  }
// ......................

  List<String> messages = [
    'Message 1',
    'Message 2',
    'Message 3',
    'Message 4',
    'Message 5'
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: KColorWhite,
        elevation: 0,
        title: Text(
          'القائمة',
          style: TextStyle(
            color: KColorPurpleApp,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35,
            // color: KColorBlack,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTileMenuAppBar(
                onTap: () {
                  Assess();
                },
                title: 'تقييم التطبيق ',
                rightIcon: Icons.auto_awesome,
                subtitle: Text('قم بدعم التطبيق وتقييمه ب 5 نجوم'),
                leftIcon: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: KColorAmber,
                  size: 20,
                ),
              ),
              SizedBox(height: 10),
              divider, // color black12

              // .....................
              ListTileMenuAppBar(
                // onTap: () {},
                title: 'تفعيل إشعارات الأذكار',
                rightIcon: Icons.notifications_none_outlined,
                subtitle: Text('عند التفعيل ستتلقي أذكار كل ساعة'),
                leftIcon: Switch(
                  value: notifications,
                  onChanged: (val) async {
                    // خاصه بالاشعارات داخل التطبيق
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    setState(() {
                      notifications = val;
                      sp.setBool('notifications', notifications);
                    });
                    if (notifications = val) {
                      notificationsServices.sendNotification(
                        '',
                        '',
                      );
                      print('تم تشغيل الاشعارات');
                    } else {
                      notificationsServices.stoptNotifications();
                      print('تم الايقاف');
                    }
                  },
                  activeColor: KColorPurpleApp,
                ),
              ),
              divider, // color black12
              ListTileMenuAppBar(
                // دالة تتحكم في تبديل حالة الوضع الليلي وحالة Switch عند الضغط على القائمة
                onTap: () {
                  setState(() {
                    themeProvider.toggleTheme();
                    isDarkThem = !isDarkThem;
                    SharedPreferences.getInstance()
                        .then((sp) => sp.setBool('isDarkThem', isDarkThem));
                    // خاص زر التنقل بتع الهاتف تغير اللون بتاعه حسب حاله التطبيق
                    SystemChrome.setSystemUIOverlayStyle(
                        themeProvider.isDarkModeEnabled
                            ? nightOverlayStyle
                            : dayOverlayStyle);
                  });
                },
                title: 'الوضع الليلي',
                rightIcon: Icons.dark_mode_outlined,
                subtitle: Text(themeProvider.isDarkModeEnabled
                    ? 'الوضع المظلم مفعل قم بالضغط لإيقاف التشغيل'
                    : 'قم بالضغط لتفعيل الوضع المظلم'),
              ),
              divider, // color black12
              Container(
                // color: Color(0xffF3EBF8),
                child: ListTileMenuAppBar(
                  onTap: () async {
                    final urlApp =
                        'https://mahmoud29hany.blogspot.com/2022/11/app-islam.html';
                    await Share.share(
                        'تحميل تطبيق الإسلام - المصحف كامل , أدعية وأذكار ومواقيت صلاة  شاركنا الثواب , واجعله صدقه جاريه لك. \n ${urlApp}');
                  },
                  title: 'مشاركة التطبيق',
                  rightIcon: Icons.share_outlined,
                  subtitle: Text(
                    'شارك التطبيق مع أصدقائك حتي تكون صدقة جارية لك',
                    style: TextStyle(fontSize: 13),
                  ),
                  leftIcon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: KColorAmber,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              //  'معلومات عن التطبيق',
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'معلومات عن التطبيق',
                    style: TextStyle(
                      color: KColorPurpleApp,
                      fontFamily: 'Cairo',
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              divider, // color black12
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'عن التطبيق :',
                          style: TextStyle(
                            color: KColorAmber,
                            fontFamily: 'Cairo',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'تطبيق مجاني وغير ربحي (يعمل بدون إنترنت) \n ويحتوي علي أغلب ما يحتاجه المسلم من القرآن \n والأذكار والأدعية والمزيد...',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    divider, // color black12
                    sizedBox, // height 5
                    Row(
                      children: [
                        Text(
                          'عن المطور :',
                          style: TextStyle(
                            color: KColorAmber,
                            fontFamily: 'Cairo',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 300,
                          height: 30,
                          child: Text(
                            'تم التصميم والتطوير بواسطة محمود هاني',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'شارك التطبيق مع أصدقائك حتي تشاركنا الثواب وحتي  \n يكون صدقة جارية لك',
                          style: TextStyle(
                            color: Color(0xffB0B0B0),
                            fontFamily: 'Cairo',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    divider, // color black12
                    sizedBox, // height 5
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Website();
                },
                title: Text(
                  'موقع المطور',
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: Icon(
                  Icons.language_outlined,
                  color: KColorAmber,
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: KColorAmber,
                  size: 20,
                ),
              ),
              divider, // color black12
              sizedBox, // height 5
              ListTile(
                onTap: () {
                  Facebook();
                },
                title: Text(
                  'فيس بوك',
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: Icon(
                  Icons.facebook_outlined,
                  color: KColorAmber,
                  size: 35,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: KColorAmber,
                  size: 20,
                ),
              ),
              divider, // color black12
              sizedBox, // height 5
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'All rights reserved © 2022',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mahmoud Hany',
                    style: TextStyle(
                      color: KColorAmber,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

// الي لما اضفط عليه يفتح صفحه بجمب menu دي خاصه بالانمشن الي موجود في الصفحه الرائسيه الي هو علامه
class SlideTransitionMenu extends PageRouteBuilder {
  final Widget page;

  SlideTransitionMenu(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return SlideTransition(
              position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(animation),
              child: page,
            );
          },
        );
}
