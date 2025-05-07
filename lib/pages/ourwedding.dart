import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:walimatul_ursy/static.dart';

void main() {
  final uri = Uri.base;
  final segments = uri.pathSegments;
  // final guestName = 'gMaDDdgz';
  final guestName = segments.isNotEmpty ? segments.last : 'Tamu';

  runApp(
    MyApp(guestName: guestName),
  );
}

List<Map<String, dynamic>> sheetDataTamu = [];
String guestNameAfterDecode = '';
double fontSizeHP = 12.0;
double fontSizePC = 13.0;
bool isScroll = false;

class MyApp extends StatefulWidget {
  final String guestName;
  const MyApp({super.key, required this.guestName});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novia & Ivan',
      debugShowCheckedModeBanner: false,
      home: InvitationPage(guestName: widget.guestName),
    );
  }
}

class InvitationPage extends StatefulWidget {
  final String guestName;
  // String guestName = 'nvBM78v6';
  const InvitationPage({super.key, required this.guestName});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  String guestNameAfterDecode = '';
  bool isLoading = true;

  Future<void> fetchSheetData() async {
    final response = await http.get(
      Uri.parse(
        'https://opensheet.elk.sh/1IFycFK3i-AzaZepz0C03dpkoMxemwrBQ45WjwKYVmEU/TamuUndanganwithCode',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> sheetDataTamu =
          data.cast<Map<String, dynamic>>();

      final foundGuest = sheetDataTamu.firstWhere(
        (item) => item['Kode Undangan'].toString() == widget.guestName,
        orElse: () => {},
      );

      setState(() {
        guestNameAfterDecode = foundGuest.isNotEmpty
            ? '${foundGuest['Title']} ${foundGuest['Nama Undangan']}'
            : '';
        isLoading = false;
      });
    } else {
      setState(() {
        guestNameAfterDecode = '';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // <-- warna status bar
      statusBarIconBrightness:
          Brightness.dark, // <-- warna ikon status bar (dark = ikon hitam)
    ));

    fetchSheetData();
  }

  @override
  Widget build(BuildContext context) {
    String userAgent = html.window.navigator.userAgent.toLowerCase();
    String deviceType = "Unknown";
    String mobileOS = "Unknown";

    String ukuranLayar = "Unknown";
    // String DeviceBrandType = "Unknown";

    int lebarLayar = MediaQuery.of(context).size.width.toInt();
    int tinggiLayar = MediaQuery.of(context).size.height.toInt();

    // print('ini width ${MediaQuery.of(context).size.width}');

    if (userAgent.contains("mobile") ||
        userAgent.contains("android") ||
        userAgent.contains("iphone")) {
      deviceType = "HP";
      mobileOS = userAgent.contains("android") ? "Android" : "iOS";
    } else {
      deviceType = "Laptop/PC";
    }
    return MaterialApp(
      title: 'Novia & Ivan',
      debugShowCheckedModeBanner: false,
      home: deviceType != ""
          ? NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  // nonaktifkan tilt saat scroll dimulai
                  // tiltStreamController.add(TiltStreamModel(gestureUse: false));
                  TiltStreamModel(position: Offset(0, 0), gestureUse: false);
                } else if (notification is ScrollEndNotification) {
                  // aktifkan lagi setelah scroll selesai
                  TiltStreamModel(position: Offset(0, 0), gestureUse: true);
                  // tiltStreamController.add(TiltStreamModel(gestureUse: true));
                }
                return false;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: //Teks ulang start
                      Tilt(
                    // disable: isScroll,
                    // onGestureMove: (tiltDataModel, gesturesType) => setState(() {
                    //   isScroll;
                    // }),
                    // disable: false,
                    lightConfig: const LightConfig(
                      disable: true,
                    ),
                    shadowConfig: const ShadowConfig(disable: true),
                    childLayout: ChildLayout(behind: [
                      Column(
                        children: [
                          //Bismillah
                          FadeInDown(
                            child: TiltParallax(
                              size: const Offset(15, 15),
                              child: Image.asset(
                                scale:
                                    MediaQuery.of(context).size.width * 0.016,
                                'assets/weddingassets/bismillah.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(height: tinggiLayar * 0.01),

                          //Dengan memohon
                          FadeInDown(
                            child: TiltParallax(
                                size: const Offset(15, 20),
                                child: TeksBiasa(
                                    'Dengan memohon rahmat dan ridho',
                                    context)),
                          ),

                          //Allah Azza Wa Jalla
                          FadeInDown(
                            child: TiltParallax(
                                size: const Offset(15, 20),
                                child:
                                    TeksBiasa('Allah Azza Wa Jalla', context)),
                          ),

                          SizedBox(height: tinggiLayar * 0.01),

                          //Kami mengundang
                          FadeInDown(
                            child: TiltParallax(
                                size: const Offset(15, 20),
                                child: TeksBiasa(
                                    'kami mengundang Bapak/Ibu/Saudara/i',
                                    context)),
                          ),
                          FadeInDown(
                            child: TiltParallax(
                                size: const Offset(15, 20),
                                child: TeksBiasa(
                                    'untuk menghadiri acara walimatul urs:',
                                    context)),
                          ),

                          SizedBox(height: tinggiLayar * 0.01),

                          //Pengantin Wanita
                          FadeInLeft(
                            child: TiltParallax(
                              size: const Offset(20, 30),
                              child:
                                  TeksNamaPengantin('Novia Andhara', context),
                            ),
                          ),
                          FadeInLeft(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasa('Putri pertama dari', context),
                            ),
                          ),
                          FadeInLeft(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasaBold(
                                  'Bpk. Agus Suwarno & Ibu Sarmanah', context),
                            ),
                          ),

                          SizedBox(height: tinggiLayar * 0.02),

                          //&
                          FadeIn(
                            child: TiltParallax(
                              size: const Offset(20, 20),
                              child: TeksNamaPengantin('&', context),
                            ),
                          ),
                          // SizedBox(height: tinggiLayar * 0.01),

                          //Pengantin Pria
                          FadeInRight(
                            child: TiltParallax(
                              size: const Offset(20, 30),
                              child: TeksNamaPengantin(
                                  'Ivan Rifki Nur Alif', context),
                            ),
                          ),
                          FadeInRight(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasa('Putra pertama dari', context),
                            ),
                          ),
                          FadeInRight(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasaBold(
                                  'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
                                  context),
                            ),
                          ),

                          SizedBox(height: tinggiLayar * 0.02),

                          //yg insyallah
                          FadeInUp(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasa(
                                  'Yang Insyaallah akan diselenggarakan pada:',
                                  context),
                            ),
                          ),
                          FadeInUp(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksWaktuBold(
                                  'Sabtu, 27 Desember 2025', context),
                            ),
                          ),

                          SizedBox(height: tinggiLayar * 0.02),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //akad pukul
                                Column(
                                  children: [
                                    //akad
                                    FadeInLeft(
                                      child: TiltParallax(
                                        size: const Offset(15, 20),
                                        child: TeksBiasa('Akad', context),
                                      ),
                                    ),
                                    //pukul
                                    FadeInLeft(
                                      child: TiltParallax(
                                        size: const Offset(15, 20),
                                        child:
                                            TeksWaktuBold('09.00 WIB', context),
                                      ),
                                    ),
                                  ],
                                ),

                                //walimatul urs
                                Column(
                                  children: [
                                    //walimatul ursy
                                    FadeInRight(
                                      child: TiltParallax(
                                        size: const Offset(15, 20),
                                        child: TeksBiasa(
                                            'Walimatul Ursy', context),
                                      ),
                                    ),
                                    //pukul
                                    FadeInRight(
                                      child: TiltParallax(
                                        size: const Offset(15, 20),
                                        child:
                                            TeksWaktuBold('10.00 WIB', context),
                                      ),
                                    ),
                                  ],
                                )
                              ]),

                          SizedBox(height: tinggiLayar * 0.02),

                          //bertempat di
                          FadeInUp(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasa('Bertempat di', context),
                            ),
                          ),
                          FadeInUp(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasaBold(
                                  'Perum. BTN Cicadas Mas Permai', context),
                            ),
                          ),
                          FadeInUp(
                            child: TiltParallax(
                              size: const Offset(15, 20),
                              child: TeksBiasaBold(
                                  'Blok D3 No.13, Rt/Rw. 004/014', context),
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: tinggiLayar * 0.2,
                            width: lebarLayar * 0.2,
                            child: Text('awkawkakw'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: tinggiLayar * 0.2,
                            width: lebarLayar * 0.2,
                            child: Text('awkawkakw2'),
                          )
                        ],
                      ),
                    ]),
                    child: SizedBox(
                      width: lebarLayar.toDouble(),
                      height: tinggiLayar.toDouble(),
                    ),
                    //
                  ),

                  //Teks ulang end
                ),
              ),
            )
          : Center(
              child: Text('Masih kosong ya bang 👍',
                  style: GoogleFonts.msMadi(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700],
                  ))),

      // Stack(children: [
      //   // Background color
      //   Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [
      //           Colors.white,
      //         ],
      //       ),
      //     ),
      //   ),

      //   // Background image
      //   Positioned.fill(
      //     child: Image.asset(
      //       'assets/weddingassets/bg_flower.png',
      //       fit: BoxFit.cover,
      //     ),
      //   ),

      //   //konten utama
      //   Scaffold(
      //     floatingActionButton: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         FloatingActionButton(
      //             backgroundColor: Colors.white70,
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(100.0),
      //             ),
      //             child: const Icon(
      //               Icons.favorite,
      //               color: Colors.pink,
      //             ),
      //             onPressed: () {
      //               showAboutDialog(context: context, children: [
      //                 Column(
      //                   children: [
      //                     Text('ini perangkat ${deviceType}'),
      //                     Text('OS yang digunakan ${mobileOS}'),
      //                     Text(ukuranLayar),
      //                     Text(
      //                         'ukurannya read: ${lebarLayar} x ${tinggiLayar}'),
      //                   ],
      //                 )
      //               ]);
      //             }),
      //       ],
      //     ),
      //     floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      //     floatingActionButtonLocation:
      //         FloatingActionButtonLocation.centerFloat,
      //     backgroundColor:
      //         Colors.transparent, // biar background image kelihatan
      //     // appBar: AppBar(title: Text('Halo')),
      //     body: isLoading
      //         ? const Center(child: CircularProgressIndicator())
      //         : SingleChildScrollView(
      //             dragStartBehavior: DragStartBehavior.start,
      //             // child: deviceType == "HP"
      //             child:

      //             deviceType != ""
      //                 ? Padding(
      //                     padding: const EdgeInsets.all(0.0),
      //                     child: //Teks ulang start
      //                         Tilt(
      //                       disable: isScroll,
      //                       lightConfig: const LightConfig(
      //                         disable: true,
      //                       ),
      //                       shadowConfig: const ShadowConfig(disable: true),
      //                       childLayout: ChildLayout(behind: [
      //                         Column(
      //                           children: [
      //                             //Bismillah
      //                             FadeInDown(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 15),
      //                                 child: Image.asset(
      //                                   scale:
      //                                       MediaQuery.of(context).size.width *
      //                                           0.016,
      //                                   'assets/weddingassets/bismillah.png',
      //                                   fit: BoxFit.cover,
      //                                 ),
      //                               ),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.01),

      //                             //Dengan memohon
      //                             FadeInDown(
      //                               child: TiltParallax(
      //                                   size: const Offset(15, 20),
      //                                   child: TeksBiasa(
      //                                       'Dengan memohon rahmat dan ridho',
      //                                       context)),
      //                             ),

      //                             //Allah Azza Wa Jalla
      //                             FadeInDown(
      //                               child: TiltParallax(
      //                                   size: const Offset(15, 20),
      //                                   child: TeksBiasa(
      //                                       'Allah Azza Wa Jalla', context)),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.01),

      //                             //Kami mengundang
      //                             FadeInDown(
      //                               child: TiltParallax(
      //                                   size: const Offset(15, 20),
      //                                   child: TeksBiasa(
      //                                       'kami mengundang Bapak/Ibu/Saudara/i',
      //                                       context)),
      //                             ),
      //                             FadeInDown(
      //                               child: TiltParallax(
      //                                   size: const Offset(15, 20),
      //                                   child: TeksBiasa(
      //                                       'untuk menghadiri acara walimatul urs:',
      //                                       context)),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.01),

      //                             //Pengantin Wanita
      //                             FadeInLeft(
      //                               child: TiltParallax(
      //                                 size: const Offset(20, 30),
      //                                 child: TeksNamaPengantin(
      //                                     'Novia Andhara', context),
      //                               ),
      //                             ),
      //                             FadeInLeft(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasa(
      //                                     'Putri pertama dari', context),
      //                               ),
      //                             ),
      //                             FadeInLeft(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasaBold(
      //                                     'Bpk. Agus Suwarno & Ibu Sarmanah',
      //                                     context),
      //                               ),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.02),

      //                             //&
      //                             FadeIn(
      //                               child: TiltParallax(
      //                                 size: const Offset(20, 20),
      //                                 child: TeksNamaPengantin('&', context),
      //                               ),
      //                             ),
      //                             // SizedBox(height: tinggiLayar * 0.01),

      //                             //Pengantin Pria
      //                             FadeInRight(
      //                               child: TiltParallax(
      //                                 size: const Offset(20, 30),
      //                                 child: TeksNamaPengantin(
      //                                     'Ivan Rifki Nur Alif', context),
      //                               ),
      //                             ),
      //                             FadeInRight(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasa(
      //                                     'Putra pertama dari', context),
      //                               ),
      //                             ),
      //                             FadeInRight(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasaBold(
      //                                     'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
      //                                     context),
      //                               ),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.02),

      //                             //yg insyallah
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasa(
      //                                     'Yang Insyaallah akan diselenggarakan pada:',
      //                                     context),
      //                               ),
      //                             ),
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksWaktuBold(
      //                                     'Sabtu, 27 Desember 2025', context),
      //                               ),
      //                             ),

      //                             SizedBox(height: tinggiLayar * 0.02),

      //                             Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.spaceEvenly,
      //                                 children: [
      //                                   //akad pukul
      //                                   Column(
      //                                     children: [
      //                                       //akad
      //                                       FadeInLeft(
      //                                         child: TiltParallax(
      //                                           size: const Offset(15, 20),
      //                                           child:
      //                                               TeksBiasa('Akad', context),
      //                                         ),
      //                                       ),
      //                                       //pukul
      //                                       FadeInLeft(
      //                                         child: TiltParallax(
      //                                           size: const Offset(15, 20),
      //                                           child: TeksWaktuBold(
      //                                               '09.00 WIB', context),
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),

      //                                   //walimatul urs
      //                                   Column(
      //                                     children: [
      //                                       //walimatul ursy
      //                                       FadeInRight(
      //                                         child: TiltParallax(
      //                                           size: const Offset(15, 20),
      //                                           child: TeksBiasa(
      //                                               'Walimatul Ursy', context),
      //                                         ),
      //                                       ),
      //                                       //pukul
      //                                       FadeInRight(
      //                                         child: TiltParallax(
      //                                           size: const Offset(15, 20),
      //                                           child: TeksWaktuBold(
      //                                               '10.00 WIB', context),
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   )
      //                                 ]),

      //                             SizedBox(height: tinggiLayar * 0.02),

      //                             //bertempat di
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasa('Bertempat di', context),
      //                               ),
      //                             ),
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasaBold(
      //                                     'Perum. BTN Cicadas Mas Permai',
      //                                     context),
      //                               ),
      //                             ),
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasaBold(
      //                                     'Blok D3 No.13, Rt/Rw. 004/014',
      //                                     context),
      //                               ),
      //                             ),
      //                             FadeInUp(
      //                               child: TiltParallax(
      //                                 size: const Offset(15, 20),
      //                                 child: TeksBiasaBold(
      //                                     'Ds. Cicadas, Kec. Gunung Putri - Kab.Bogor',
      //                                     context),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ]),
      //                       child: SizedBox(
      //                         width: lebarLayar.toDouble(),
      //                         height: tinggiLayar.toDouble(),
      //                       ),
      //                       //
      //                     ),

      //                     //Teks ulang end
      //                   )
      //                 : Center(
      //                     child: Text('Masih kosong ya bang 👍',
      //                         style: GoogleFonts.msMadi(
      //                           fontSize: 50,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.brown[700],
      //                         ))),

      //           ),
      //   ),
      // ]),
    );
  }
}
