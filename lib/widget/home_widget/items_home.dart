import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islam_app/controller/bottom_navigation_bar_controller.dart';
import 'package:islam_app/data/list/home/image_and_text.dart';
import 'package:islam_app/pages/duas/remembrance_duas_group.dart';
import 'package:islam_app/pages/prophetic_conversations/prophetic_conversations.dart';
import 'package:islam_app/pages/sounds/sounds_group.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:islam_app/widget/home_widget/arabic_date_time_day.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ItemsHome extends StatelessWidget {
  ItemsHome({super.key});
// body دي العناصر الي موجوده في الصفحه الرائسيه في

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.4.h),
      child: ListView(
        children: [
          // اضافه التاريخ واليوم و الساعه
          ArabicDateTime(),
          SizedBox(height: 3),
          Row(
            children: [
              Text(
                'الأقسام الرئيسية',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(height: 1.3.h),
          GestureDetector(
            onTap: () => homeController.index.value = 0,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 1.7.h, left: 1.7.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 11.8.h,
                      // width: 5,
                      child: Image(
                        image: AssetImage(themeProvider.isDarkModeEnabled
                            ? quranDatk.image
                            : quran.image),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
                      child: Text(
                        'القرآن الكريم',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 0.2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.push(context, Duas(GroupRemembranceDuas())),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 11.h,
                        child: Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? duasDark.image
                              : adeia.image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.h, top: 7.h),
                      child: Text(
                        'أدعية',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => homeController.index.value = 2,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 11.h,
                        child: Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? remembranceDark.image
                              : remembrance.image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 3.5.h, top: 6.5.h),
                      child: Text(
                        'أذكار',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, Sounds(SoundsGroup())),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 11.h,
                        child: Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? votesDark.image
                              : votes.image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 3.5.h, top: 6.h),
                      child: Text(
                        'الأصوات',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(PropheticConversations()),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 11.h,
                        child: Image(
                          image: AssetImage(themeProvider.isDarkModeEnabled
                              ? nabawiaDark.image
                              : propheticConversations.image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 3.5.h, top: 6.6.h),
                      child: Text(
                        'أحاديث نبوية',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
