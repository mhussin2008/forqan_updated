import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forqan_app/models/surah.dart';
import 'package:forqan_app/screens/reading_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MainIndex extends StatefulWidget {
  const MainIndex({super.key});

  @override
  _MainIndexState createState() => _MainIndexState();
}



class _MainIndexState extends State<MainIndex>  {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {

    readJson();

    super.initState();
  }


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    await Future.delayed(const Duration(seconds: 5));
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }


    debugPrint(surahList.length.toString());
    setState(() {});


  }

  @override
  Widget build(BuildContext context) {
    final padding=MediaQuery
      .of(context).viewPadding;
    print(padding);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: surahList.isNotEmpty?
        const Center(child: Text ('إهداء من الأستاذ فيصل', style: TextStyle(color:  Colors.blue,)))
            :
            const SizedBox(width: 40,),
        actions: [
          IconButton(onPressed: () async {
            await _launchPrivacyUrl();
          }
          ,tooltip: "Privacy Policy",
              icon: Icon(Icons.privacy_tip)
          )
        ],
          ),
      body: surahList.isEmpty
          ?  Center(child: CircularProgressIndicatorModified())
          :

      chaptersList(isReverse ? surahList.reversed.toList() : surahList),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text(chapters[index].id.toString()),
        ),
        title: Text(chapters[index].name),
        subtitle: Text(chapters[index].versesCount.toString()),
        trailing: Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: chapters.length,
    );
  }

 Widget CircularProgressIndicatorModified() {
    return Image.asset('assets/splash.jpg');
  }


  Future<void> _launchPrivacyUrl() async {
    Uri myPrivacyUri=Uri.parse("https://www.freeprivacypolicy.com/live/bc32b9fb-cc58-4ac5-92fd-9557e03da4b6");
    print('Privacy Policy');
    if (!await launchUrl(myPrivacyUri)) {
      throw Exception('Could not launch $myPrivacyUri');
    }

  }

}
