import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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

void showTabModal(BuildContext context, String guestName, String guestCode) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white.withOpacity(0.90), // Transparansi di sini
    barrierColor:
        Colors.black.withOpacity(0.3), // Latar belakang gelap transparan
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              // SizedBox(
              // height: 300,
              child: TabBarView(
                children: [
                  //Waktu
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

                  //Lokasi
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

                  //Kupon Souvenir
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      // _openMaps();
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            child: PrettyQrView.data(
                                              data: guestCode,
                                              decoration:
                                                  const PrettyQrDecoration(
                                                image: PrettyQrDecorationImage(
                                                  image: AssetImage(
                                                      'images/flutter.png'),
                                                ),
                                                quietZone:
                                                    PrettyQrQuietZone.zero,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          TeksBiasa('Tamu undangan', context),
                                          TeksBiasaBold(
                                              '${guestName}', context),
                                          SizedBox(height: 20),
                                          Container(
                                            color: Colors.pink[50],
                                            child: DottedBorder(
                                              color: Colors.pink,
                                              strokeWidth: 1,
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(5),
                                              dashPattern: [
                                                6,
                                                3
                                              ], // 6px garis, 3px spasi
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Tukarkan kode barcode ini dengan souvenir yg tersedia.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.brown[900],
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    Text(
                                                      '1 Souvenir untuk 1 tamu undangan.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.brown[900],
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                        child: Container()),
                  )),
                ],
              ),
            ),
            TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              tabs: [
                //Tab Waktu
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

                //Tab Lokasi
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

                //Tab Kupon
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cake,
                        color: Colors.brown[900],
                      ),
                      SizedBox(width: 5),
                      TeksBiasa("Souvenir", context),
                    ],
                  ),
                ),
              ],
              labelColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.brown,
            ),
            SizedBox(height: 20),
            TextButton(
                style: TextButton.styleFrom(
                  // elevation: 3
                  // shadowColor: Colors.brown[900],
                  foregroundColor: Colors.brown[100],
                  backgroundColor: Colors.brown[900],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Tutup slide',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 50),
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
