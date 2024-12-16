import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muslim_uz/tasbeh.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String currentPrayer = "...";
  String currentPrayerTime = "...";

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(
          Uri.parse('https://islomapi.uz/api/present/day?region=qo%27qon'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // API'dan olingan namoz vaqtlarini
        final timings = {
          "Tong": data['times']['tong_saharlik'],
          "Bomdod": data['times']['quyosh'],
          "Peshin": data['times']['peshin'],
          "Asr": data['times']['asr'],
          "Shom": data['times']['shom_iftor'],
          "Hufton": data['times']['hufton']
        };

        // Hozirgi vaqtni hisoblash
        final now = DateTime.now();
        String? nextPrayer;
        String? nextPrayerTime;

        timings.forEach((prayer, time) {
          final prayerTime = DateTime.parse(
              "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$time:00");
          if (now.isBefore(prayerTime) && nextPrayer == null) {
            nextPrayer = prayer;
            nextPrayerTime = time;
          }
        });

        setState(() {
          currentPrayer = nextPrayer ?? "Kun tugadi";
          currentPrayerTime = nextPrayerTime ?? "00:00";
        });
      } else {
        throw Exception("Ma'lumotlarni yuklashda xatolik yuz berdi");
      }
    } catch (e) {
      setState(() {
        currentPrayer = "Xatolik";
        currentPrayerTime = "Xatolik";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Assalomu alaykum",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/boy.jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.av_timer_outlined,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          currentPrayer,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      currentPrayerTime,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Qo'qon",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Uzbekistan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          "assets/mosque.png",
                                        ),
                                      ),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2, color: Colors.green)),
                                    ),
                                    Text(
                                      "Mosque",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          "assets/quran.png",
                                        ),
                                      ),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2, color: Colors.green)),
                                    ),
                                    Text(
                                      "Al-Qur`an",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],  
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TasbehScreen()));
                                      },
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.asset('assets/tasbih.png'),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 2, color: Colors.green)),
                                      ),
                                    ),
                                    Text(
                                      "Tasbeeh",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                            'assets/kaaba-mecca.png'),
                                      ),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2, color: Colors.green)),
                                    ),
                                    Text(
                                      "Kaaba",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: 210,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 5,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/islam.png"),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "The last surah you read.",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Al-Maaida",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                color: Colors.black,
                                offset: Offset(2, 2))
                          ],
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "MAKKAH LIVE",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        const url =
                            'https://www.youtube.com/watch?v=o3CcwwVYyKE';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text("usbu urlni ochib bolmadi!"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/ims.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: double.infinity,
                        height: 200,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
