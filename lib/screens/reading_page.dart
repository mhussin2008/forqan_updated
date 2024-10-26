import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forqan_app/models/surah.dart';
import 'NewWidgetSpan.dart';
import 'WidgetSpanWrapper.dart';
import 'package:quran/quran.dart' as quran;
import 'GClassFunction.dart';


class SurahPage extends StatefulWidget {
  final Surah surah;
  const SurahPage({super.key, required this.surah});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.surah.versesCount;
    int index = widget.surah.id;



    final keys = <GlobalKey<WidgetSpanWrapperState>>[];

    GlobalKey<WidgetSpanWrapperState> nextKey() {
      GlobalKey<WidgetSpanWrapperState> key = GlobalKey<WidgetSpanWrapperState>();
      keys.add(key);
      return key;
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      List<GlobalKey<WidgetSpanWrapperState>>? sameRow;
      GlobalKey<WidgetSpanWrapperState> prev = keys.removeAt(0);
      keys.forEach((key) {
        if (getYOffsetOf(key) == getYOffsetOf(prev)) {
          sameRow ??= [prev];
          sameRow!.add(key);
        } else if (sameRow != null) {
          resolveSameRow(sameRow!);
          sameRow = null;
        }
        prev = key;
      });
      if (sameRow != null) {
        resolveSameRow(sameRow!);
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:    AppBar(
        //   leading: ElevatedButton(
        //   onPressed: (){
        //     setState(() {
        //     });
        //   },
        //   child: const Text('refresh'),
        // ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: header(),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              text: TextSpan(
                children: [
                  for (var i = 1; i <= count; i++)...{

                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {
                        print('surah : ${widget.surah.id} $i tapped');
                      },
                      text: ' ${quran.getVerse(index, i, verseEndSymbol: false)} ',
                      style: const TextStyle(
                        fontFamily: 'Kitab',
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),

                    WidgetSpan(
                      child: GestureDetector(
                        onTap: (){
                          print('surah : ${widget.surah.id} $i tapped');
                        },
                        child: WidgetSpanWrapper(
                          key: nextKey(),
                          child: NewWidgetSpan(color: Colors.lightGreen, order: i),
                        ),
                      ),
                    ),

                    //////////////////////////////
                  }
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.surah.arabicName,
          style: const TextStyle(
            fontFamily: 'Aldhabi',
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' ${quran.basmala} ',
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontFamily: 'NotoNastaliqUrdu',
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}