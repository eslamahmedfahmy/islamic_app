import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:islam_app/constant/color.dart';
import 'package:islam_app/pages/prophetic_conversations/prophetic_conversations_screen.dart';

// ignore: must_be_immutable

class PropheticConversations extends StatelessWidget {
  PropheticConversations({super.key});

//  دي الصفحه الرئسيه بتظهر فيه اسماء الاحديث قبل الضغط عليه
  Divider divider = Divider(color: KColorBlack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'الأربعين النووية',
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
          ),
        ),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/alarbaeen_alnawawi.json'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // في حاله الايرور
            return Center(
              child: Text('هناك خطأ ما'),
            );
          }
          if (snapshot.hasData) {
            // في حاله وجود بيانات
            var showData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemCount: showData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      showData[index]["id"].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: KColorPurpleApp,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(
                    showData[index]["name"],
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Quran',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropheticConversationsScreen(
                          //  دي الحاجات الي هتتبعت لما اضغط علي اسم الحديث
                          showData[index]["name"],
                          showData[index]["saying"],
                          showData[index]["saying_nabiun"],
                          showData[index]["narrator_hadith"],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            //  في حاله تحميل البيانات
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
