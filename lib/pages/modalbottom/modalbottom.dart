import 'package:WalimatulUrsy/pages/modalbottom/tab_decoration.dart';
import 'package:WalimatulUrsy/pages/modalbottom/tab_lainnya.dart';
import 'package:WalimatulUrsy/pages/modalbottom/tab_souvenir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:animate_do/animate_do.dart';
import 'package:knight_confetti/knight_confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:WalimatulUrsy/pages/static.dart';
import 'package:delayed_display/delayed_display.dart';

const String mapsUrl = 'https://maps.app.goo.gl/opSoVsW2TGiraoMS7';
var statusnya = {};

Future<void> _openMaps() async {
  final Uri url = Uri.parse(mapsUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Gagal membuka Peta';
  }
}

void showTabModal(BuildContext context, String guestName, String guestCode,
    int tabInitial) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  statusnya.clear();
  statusnya = await fetchSheetDataPlain(guestCode);

  String SouvenirStatus = statusnya['Souvenir'];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white.withOpacity(0.90),
    barrierColor: Colors.black.withOpacity(0.3),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      int lebarLayar = MediaQuery.of(context).size.width.toInt();

      return Scaffold(
        backgroundColor: Colors.transparent,
        body: DefaultTabController(
          initialIndex: tabInitial,
          length: 4,
          child: Stack(children: [
            SnowConfetti(
              totalParticles: 100, // Total number of particles
              color: Colors.amber[100]!.withOpacity(0.9),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      //Waktu
                      WeddingDecorationOverlay(
                        lebarLayar: lebarLayar.toDouble(),
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                //insyaallah akan diselenggarakan pada sabtu, 27 desember 2025
                                DelayedDisplay(
                                    slidingCurve: Curves.linear,
                                    delay: const Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        TiltParallax(
                                          size: const Offset(15, 20),
                                          child: TeksBiasa(
                                              'Insyaallah akan diselenggarakan pada:',
                                              context),
                                        ),
                                        FadeInDown(
                                          child: TiltParallax(
                                            size: const Offset(15, 20),
                                            child: TeksWaktuBold(
                                                'Sabtu, 27 Desember 2025',
                                                context),
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                            .size
                                            .height
                                            .toInt() *
                                        0.02),
                                //akad & pukul
                                DelayedDisplay(
                                  slidingCurve: Curves.linear,
                                  delay: const Duration(milliseconds: 300),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          //akad
                                          FadeInUp(
                                            child: TiltParallax(
                                              size: const Offset(15, 20),
                                              child: TeksBiasa('Akad', context),
                                            ),
                                          ),
                                          //pukul
                                          FadeInUp(
                                            child: TiltParallax(
                                              size: const Offset(15, 20),
                                              child: TeksWaktuBold(
                                                  '09.00 WIB', context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width
                                                .toInt() *
                                            0.05,
                                      ),
                                      Column(
                                        children: [
                                          //walimatul ursy
                                          FadeInUp(
                                            child: TiltParallax(
                                              size: const Offset(15, 20),
                                              child: TeksBiasa(
                                                  'Walimatul Ursy', context),
                                            ),
                                          ),
                                          //pukul
                                          FadeInUp(
                                            child: TiltParallax(
                                              size: const Offset(15, 20),
                                              child: TeksWaktuBold(
                                                  '10.00 WIB', context),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      ),

                      //Lokasi
                      WeddingDecorationOverlay(
                        lebarLayar: lebarLayar.toDouble(),
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                FadeInUp(
                                  child: TiltParallax(
                                    size: const Offset(15, 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 5),
                                        TeksBiasa('Bertempat di', context),
                                      ],
                                    ),
                                  ),
                                ),
                                FadeInUp(
                                  child: TiltParallax(
                                    size: const Offset(15, 20),
                                    child: TeksBiasaBold(
                                        'Perum. BTN Cicadas Mas Permai',
                                        context),
                                  ),
                                ),
                                FadeInUp(
                                  child: TiltParallax(
                                    size: const Offset(15, 20),
                                    child: TeksBiasaBold(
                                        'Blok D3 No.13, Rt/Rw. 004/014',
                                        context),
                                  ),
                                ),
                                FadeInUp(
                                  child: TiltParallax(
                                    size: const Offset(15, 20),
                                    child: TeksBiasaBold(
                                        'Ds. Cicadas, Kec. Gunung Putri - Kab.Bogor',
                                        context),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    _openMaps();
                                  },
                                  child: FadeInUp(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.map,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 5),
                                        TeksBiasa('Lihat di Maps', context),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),

                      //Kupon Souvenir
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            prefs.clear();
                            SouvenirStatus = '';
                            fetchSheetDataPlain(guestCode).then((value) {
                              SouvenirStatus = value['Souvenir'];
                              Navigator.pop(context);
                              showTabModal(context, guestName, guestCode, 2);
                            });
                          },
                          child: SingleChildScrollView(
                            child: FadeInUp(
                              child: buildSouvenirCard(context, SouvenirStatus,
                                  guestCode, guestName),
                            ),
                          ),
                        ),
                      ),

                      //Lainnya
                      const ContentTabLainnya(),
                    ],
                  ),
                ),
                TabBar(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerColor: Colors.transparent,
                  tabs: [
                    //Tab Waktu
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                          ),
                          TeksBiasa("Waktu", context),
                        ],
                      ),
                    ),

                    //Tab Lokasi
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                          ),
                          TeksBiasa("Lokasi", context),
                        ],
                      ),
                    ),

                    //Tab Kupon
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cake,
                          ),
                          TeksBiasa("Souvenir", context),
                        ],
                      ),
                    ),

                    //Tab Kupon
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                          ),
                          TeksBiasa("Lainnya", context),
                        ],
                      ),
                    ),
                  ],
                  labelColor: Colors.pink,
                  unselectedLabelColor: Colors.grey,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.pink,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    style: TextButton.styleFrom(
                      // elevation: 3
                      foregroundColor: Colors.brown[100],
                      backgroundColor: Colors.brown[900],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Tutup slide',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ]),
        ),
      );
    },
  );
}
