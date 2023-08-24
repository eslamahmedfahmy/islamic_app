import 'package:flutter/material.dart';
import 'package:islam_app/constant/color.dart';

class PropheticConversationsScreen extends StatelessWidget {
  String name;
  String saying;
  String sayingNabiun;
  String narratorHadith;
//  دي الصفحه الي بتظهر بعد ما اضغط علي اسم الحديث

  PropheticConversationsScreen(
      this.name, this.saying, this.sayingNabiun, this.narratorHadith);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          name,
          style: TextStyle(
              color: KColorPurpleApp, fontFamily: 'Quran', fontSize: 25),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القول',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quran',
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    saying,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quran',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'حديث الرسول',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quran',
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    sayingNabiun,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quran',
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'الراوي',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quran',
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    narratorHadith,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quran',
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
