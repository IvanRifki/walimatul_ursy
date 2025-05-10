import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

// void showTabModal(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (context) {
//       return DefaultTabController(
//         length: 2, // jumlah tab
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const TabBar(
//               tabs: [
//                 Tab(text: "Tab 1"),
//                 Tab(text: "Tab 2"),
//               ],
//             ),
//             SizedBox(
//               height: 300, // tinggi konten tab
//               child: TabBarView(
//                 children: [
//                   Center(child: Text("Isi Tab 1")),
//                   Center(child: Text("Isi Tab 2")),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

final String mapsUrl = 'https://maps.app.goo.gl/opSoVsW2TGiraoMS7';

Future<void> _openMaps() async {
  final Uri url = Uri.parse(mapsUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Gagal membuka Peta';
  }
}

void showTabModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white.withOpacity(0.95), // Transparansi di sini
    barrierColor:
        Colors.black.withOpacity(0.3), // Latar belakang gelap transparan
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  Center(
                      child: Tilt(
                          shadowConfig: const ShadowConfig(disable: true),
                          childLayout: ChildLayout(behind: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  FadeInDown(
                                    child: TiltParallax(
                                      size: const Offset(15, 20),
                                      child: TeksBiasa(
                                          'Insyaallah akan diselenggarakan pada:',
                                          context),
                                    ),
                                  ),
                                  FadeInDown(
                                    child: TiltParallax(
                                      size: const Offset(15, 20),
                                      child: TeksWaktuBold(
                                          'Sabtu, 27 Desember 2025', context),
                                    ),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height
                                              .toInt() *
                                          0.02),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            //akad
                                            FadeInUp(
                                              child: TiltParallax(
                                                size: const Offset(15, 20),
                                                child:
                                                    TeksBiasa('Akad', context),
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
                                      ]),
                                ]),
                          ]),
                          child: Container())),

                  Center(
                      child: GestureDetector(
                    onTap: () {
                      _openMaps();
                    },
                    child: Tilt(
                        shadowConfig: const ShadowConfig(disable: true),
                        childLayout: ChildLayout(behind: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                FadeInUp(
                                  child: TiltParallax(
                                    size: const Offset(15, 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 5),
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
                                SizedBox(height: 20),
                                FadeInUp(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.map,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 5),
                                      TeksBiasa('Lihat di Maps', context),
                                    ],
                                  ),
                                ),
                              ]),
                        ]),
                        child: Container()),
                  )),

                  // Center(child: Text("Isi Tab 1")),
                ],
              ),
            ),
            TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.brown[900],
                      ),
                      SizedBox(width: 5),
                      TeksBiasa("Waktu", context),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.brown[900],
                      ),
                      SizedBox(width: 5),
                      TeksBiasa("Lokasi", context),
                    ],
                  ),
                ),
              ],
              labelColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.brown,
            ),
            SizedBox(height: 30),
          ],
        ),
      );
    },
  );
}

Text TeksBiasa(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      color: Colors.brown[900],
    ),
  );
}

Text TeksBiasaBold(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      fontWeight: FontWeight.bold,
      color: Colors.brown[900],
    ),
  );
}

Text TeksWaktuBold(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.bold,
      color: Colors.brown[900],
    ),
  );
}

Text TeksNamaPengantin(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.msMadi(
      fontSize: MediaQuery.of(context).size.width * 0.1,
      fontWeight: FontWeight.bold,
      color: Colors.brown[700],
    ),
  );
}
