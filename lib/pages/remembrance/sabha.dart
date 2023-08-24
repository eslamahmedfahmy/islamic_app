import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/shared/dark_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sabha extends StatefulWidget {
  const Sabha({super.key});

  @override
  State<Sabha> createState() => _SabhaState();
}

//  صفحه السبحه
class _SabhaState extends State<Sabha> {
  int numbers = 0;
  int totalNumbers = 0;

  saveDataPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      numbers++;
      totalNumbers++;
      sp.setInt('numbers', numbers);
      sp.setInt('totalNumbers', totalNumbers);
    });
  }

  getDataPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    setState(() {
      numbers = sp.getInt('numbers') ?? 0;
      totalNumbers = sp.getInt('totalNumbers') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataPrefs();
  }

  void clearSharedPrefs(String keyItem) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(keyItem, 0);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        title: Text(
          'سبحة',
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
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                child: Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkModeEnabled
                            ? KColorAmber
                            : KColorSabha,
                        width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$numbers",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 50,
                        color: themeProvider.isDarkModeEnabled
                            ? KColorAmber
                            : KColorSabha,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 110,
                    width: 70,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: themeProvider.isDarkModeEnabled
                          ? KColorblue
                          : KColorSabha,
                      onPrimary: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(18),
                    ),
                    onPressed: () {
                      clearSharedPrefs('numbers');
                      setState(() {
                        numbers = 0;
                      });
                    },
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 170,
                      // width: 400,
                    ),
                    SizedBox(
                      height: 275.0,
                      width: 300.0,
                      child: FloatingActionButton(
                        backgroundColor: themeProvider.isDarkModeEnabled
                            ? KColorblue
                            : KColorSabha,
                        heroTag: "btn2",
                        onPressed: () async {
                          await saveDataPrefs();
                        },
                        mini: false,
                        child: Icon(
                          Icons.add,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'إلغاء',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    clearSharedPrefs('totalNumbers');
                                    setState(() {
                                      totalNumbers = 0;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text(
                                    'تأكيد',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.warning,
                                  color: Color.fromARGB(255, 165, 159, 159),
                                  size: 35,
                                ),
                                Text("تصفير العداد الإجمالي"),
                              ],
                            ),
                            content: const Text("سوف يتم تصفير العداد"),
                          );
                        });
                  },
                  backgroundColor: themeProvider.isDarkModeEnabled
                      ? KColorblue
                      : KColorSabha,
                  child: const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    ),
                  ),
                  mini: true,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeProvider.isDarkModeEnabled
                            ? KColorAmber
                            : KColorSabha,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'العدد الإجمالي : $totalNumbers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.isDarkModeEnabled
                              ? KColorAmber
                              : KColorSabha,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
