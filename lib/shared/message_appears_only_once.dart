import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageAppearsOnlyOnce extends StatefulWidget {
  @override
  _MessageAppearsOnlyOnceState createState() => _MessageAppearsOnlyOnceState();
}

//  صفحه تظهر رساله للمستخدم مره واحده فقط اول ما يضغط علي علامه الغلط الرساله معدتشي هتظهر تاني غير ما يمسح التطبيق ويننزله من الاول
class _MessageAppearsOnlyOnceState extends State<MessageAppearsOnlyOnce> {
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
    _checkIfFirstTimeOpen();
  }

  Future<void> _checkIfFirstTimeOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showMessage = prefs.getBool('showMessage') ?? true;

    if (showMessage) {
      setState(() {
        _showMessage = true;
      });
      await prefs.setBool('showMessage', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      child: _showMessage
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: themeProvider.isDarkModeEnabled
                    ? KColorblue
                    : Color(0xffEDEDED),
                child: ListTile(
                  title: Text(
                    'تنبيه',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    'يرجى العلم أن أي صوت داخل التطبيق يعمل المرة الأولى فقط  بالاتصال بالإنترنت، وفي المرة التالية لا يحتاج الاتصال بالإنترنت، يرجى الانتظار عند تشغيل الصوت ليتم التحميل لأول مرة فقط ',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _showMessage = false;
                      });
                    },
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
