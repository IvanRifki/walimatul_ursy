import 'dart:async';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
// import 'package:ivnrfk/pages/ourwedding/page414up.dart';
// import 'package:ivnrfk/pages/ourwedding/page414up.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

void main() {
  final uri = Uri.base;
  final segments = uri.pathSegments;
  final guestName = segments.isNotEmpty ? segments.last : 'Tamu';

  runApp(
    MyApp(guestName: guestName),
  );
}

List<Map<String, dynamic>> sheetDataTamu = [];
String guestNameAfterDecode = '';
double fontSizeHP = 12.0;
double fontSizePC = 13.0;

class MyApp extends StatelessWidget {
  final String guestName;
  const MyApp({super.key, required this.guestName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novia & Ivan',
      debugShowCheckedModeBanner: false,
      home: InvitationPage(guestName: guestName),
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
    String DeviceBrandType = "Unknown";

    int lebarLayar = MediaQuery.of(context).size.width.toInt();
    int tinggiLayar = MediaQuery.of(context).size.height.toInt();

    print('ini width ${MediaQuery.of(context).size.width}');

    if (userAgent.contains("mobile") ||
        userAgent.contains("android") ||
        userAgent.contains("iphone")) {
      deviceType = "HP";
      mobileOS = userAgent.contains("android") ? "Android" : "iOS";

      if (lebarLayar == 414 && tinggiLayar >= 725) {
        DeviceBrandType = "IP: XR, 11, 11 PRO MAX";
        ukuranLayar = "414 x 725";
      } else if (lebarLayar == 375 && tinggiLayar >= 641) {
        DeviceBrandType = "IP: X, 11 PRO, 13 Mini";
        ukuranLayar = "375 x 641";
      } else if (lebarLayar == 360 && tinggiLayar >= 609) {
        DeviceBrandType = "IP: 12 Mini";
        ukuranLayar = "360 x 609";
      } else if (lebarLayar == 390 && tinggiLayar >= 673) {
        DeviceBrandType = "IP: 12, 12 PRO, 13, 13 PRO";
        ukuranLayar = "390 x 673";
      }
    } else {
      deviceType = "Laptop/PC";
    }
    return MaterialApp(
      title: 'Novia & Ivan',
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        // Background color
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white
                // Color.fromARGB(255, 255, 255, 255),
                // Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
        ),

        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/weddingassets/bg_flower.png',
            fit: BoxFit.cover,
          ),
        ),

        //konten utama
        Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                  backgroundColor: Colors.white70,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                    showAboutDialog(context: context, children: [
                      Column(
                        children: [
                          Text('ini perangkat ${deviceType}'),
                          Text('OS yang digunakan ${mobileOS}'),
                          Text(ukuranLayar),
                        ],
                      )
                    ]);
                  }),
            ],
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          backgroundColor:
              Colors.transparent, // biar background image kelihatan
          // appBar: AppBar(title: Text('Halo')),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: deviceType == "HP"
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Tilt(
                                shadowConfig: const ShadowConfig(disable: true),
                                childLayout: ChildLayout(
                                  outer: [
                                    /// Leaf gold bottom left
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: -40,
                                            left: -7,
                                            child: FadeInDown(
                                              child: Image.asset(
                                                scale: 3,
                                                'assets/weddingassets/outline_leaf_gold.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: -40,
                                            left: -7,
                                            child: FadeInDown(
                                              child: Image.asset(
                                                scale: 2.3,
                                                'assets/weddingassets/outline_leaf_gold.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                    /// Leaf gold top right
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: -40,
                                            right: -6,
                                            child: FadeInDown(
                                              child: Transform.flip(
                                                flipY: true,
                                                flipX: true,
                                                child: Image.asset(
                                                  scale: 3.5,
                                                  'assets/weddingassets/outline_leaf_gold.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: -40,
                                            right: -6,
                                            child: FadeInDown(
                                              child: Transform.flip(
                                                flipY: true,
                                                flipX: true,
                                                child: Image.asset(
                                                  scale: 2.3,
                                                  'assets/weddingassets/outline_leaf_gold.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Splash gold bottom left
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: -50,
                                            left: 30,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2.5,
                                                  'assets/weddingassets/splash_gold_bottomleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: -50,
                                            left: 30,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2,
                                                  'assets/weddingassets/splash_gold_bottomleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Splash gold top left
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 0,
                                            left: -80,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2.5,
                                                  'assets/weddingassets/splash_gold_topleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 0,
                                            left: -80,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 1.5,
                                                  'assets/weddingassets/splash_gold_topleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Splash gold middle right
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 200,
                                            right: -60,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2,
                                                  'assets/weddingassets/splash_gold_middleright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 360,
                                            right: -60,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 1.5,
                                                  'assets/weddingassets/splash_gold_middleright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Splash gold bottom right
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: -50,
                                            right: -60,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 3.3,
                                                  'assets/weddingassets/splash_gold_bottomright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: -50,
                                            right: -60,
                                            child: TiltParallax(
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 3,
                                                  'assets/weddingassets/splash_gold_bottomright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    //Lokasi
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: 60,
                                            child: TiltParallax(
                                                size: Offset(10, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'Bertempat di',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Icon(
                                                    Icons.location_pin,
                                                    size: 15,
                                                    color: Colors.red,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Perum. BTN Cicadas Mas Permai',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .brown[900],
                                                            ),
                                                          ),
                                                          Text(
                                                            'Blok D3 No.13, Rt/Rw. 004/014',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .brown[900],
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ds. Cicadas, Kec. Gunung Putri - Kab.Bogor',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              color: Colors
                                                                  .brown[900],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ])),
                                          )
                                        : Positioned(
                                            bottom: 190,
                                            child: TiltParallax(
                                                size: Offset(10, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'Bertempat di',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_pin,
                                                        size: 15,
                                                        color: Colors.red,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        'Nama Tempatnya',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ])),
                                          ),

                                    /// Akad
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: 170,
                                            child: TiltParallax(
                                                size: Offset(15, 20),
                                                child: Row(
                                                  children: [
                                                    Column(children: [
                                                      Text(
                                                        'Akad',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: fontSizeHP,
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                      Text(
                                                        '09.00 WIB',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                    ]),
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    Column(children: [
                                                      Text(
                                                        'Walimatul Urs',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                      Text(
                                                        '10.00 WIB',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                )),
                                          )
                                        : Positioned(
                                            bottom: 240,
                                            child: TiltParallax(
                                                size: Offset(15, 20),
                                                child: Row(
                                                  children: [
                                                    Column(children: [
                                                      Text(
                                                        'Akad',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: fontSizePC,
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                      Text(
                                                        '09.00 WIB',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                    ]),
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    Column(children: [
                                                      Text(
                                                        'Walimatul Urs',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                      Text(
                                                        '10.00 WIB',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                )),
                                          ),

                                    //Waktu pelaksanaan
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: 230,
                                            child: TiltParallax(
                                                size: Offset(15, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'Yang Insyaallah akan diselenggarakan pada:',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sabtu, 27 Desember 2025',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ])),
                                          )
                                        : Positioned(
                                            bottom: 330,
                                            child: TiltParallax(
                                                size: Offset(15, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'Yang Insyaallah akan diselenggarakan pada:',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sabtu, 27 Desember 2025',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ])),
                                          ),

                                    /// Pengantin Pria
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 335,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Ivan Rifki Nur Alif',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Putra pertama dari',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 430,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Ivan Rifki Nur Alif',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Putra pertama dari',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    //&
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 290,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '&',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 385,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '&',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    /// Pengantin Wanita
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 185,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Novia Andhara',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Putri pertama dari',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bpk. Agus Suwarno & Ibu Sarmanah',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 260,
                                            child: TiltParallax(
                                              size: Offset(10, 30),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Novia Andhara',
                                                    style: GoogleFonts.msMadi(
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Putri pertama dari',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bpk. Agus Suwarno & Ibu Sarmanah',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    //Kami Mengundang
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 140,
                                            child: TiltParallax(
                                                size: Offset(10, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'kami mengundang Bapak/Ibu/Saudara/i',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'untuk menghadiri acara walimatul urs:',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ])),
                                          )
                                        : Positioned(
                                            top: 200,
                                            child: TiltParallax(
                                                size: Offset(10, 15),
                                                child: Column(children: [
                                                  Text(
                                                    'kami mengundang Bapak/Ibu/Saudara/i sekalian',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'untuk menghadiri acara walimatul urs:',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ])),
                                          ),

                                    //Dengan memohon rahmat
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 100,
                                            child: TiltParallax(
                                              size: Offset(10, 20),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Dengan memohon rahmat dan ridho',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Allah Azza Wa Jalla',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizeHP,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 150,
                                            child: TiltParallax(
                                              size: Offset(10, 20),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Dengan memohon rahmat dan ridho',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Allah Azza Wa Jalla',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: fontSizePC,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.brown[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    /// Bismillah
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 30,
                                            child: TiltParallax(
                                              size: const Offset(30, 30),
                                              child: Image.asset(
                                                scale: 7,
                                                'assets/weddingassets/bismillah.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 80,
                                            child: TiltParallax(
                                              size: const Offset(30, 30),
                                              child: Image.asset(
                                                scale: 6,
                                                'assets/weddingassets/bismillah.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                    /// Flower bottom left
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: 0,
                                            left: -40,
                                            child: TiltParallax(
                                              size: Offset(20, 20),
                                              child: FadeInLeft(
                                                child: Image.asset(
                                                  scale: 3.5,
                                                  'assets/weddingassets/flower_bottomleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: 0,
                                            left: -30,
                                            child: TiltParallax(
                                              size: Offset(20, 20),
                                              child: FadeInLeft(
                                                child: Image.asset(
                                                  scale: 2,
                                                  'assets/weddingassets/flower_bottomleft.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Flower top right
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: -40,
                                            right: -40,
                                            child: TiltParallax(
                                              size: Offset(15, 15),
                                              child: FadeInRight(
                                                child: Image.asset(
                                                  scale: 3.3,
                                                  'assets/weddingassets/flower_topright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 0,
                                            right: -30,
                                            child: TiltParallax(
                                              size: Offset(15, 15),
                                              child: FadeInRight(
                                                child: Image.asset(
                                                  scale: 2.5,
                                                  'assets/weddingassets/flower_topright.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Feather bottom
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            bottom: 0,
                                            left: 50,
                                            child: TiltParallax(
                                              size: Offset(30, 30),
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 3.3,
                                                  'assets/weddingassets/feather_bottom.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            bottom: 0,
                                            left: 60,
                                            child: TiltParallax(
                                              size: Offset(30, 30),
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2,
                                                  'assets/weddingassets/feather_bottom.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                    /// Feather top
                                    ukuranLayar.contains(
                                            "414") //IP: XR, 11, 11 PRO MAX
                                        ? Positioned(
                                            top: 0,
                                            right: 35,
                                            child: TiltParallax(
                                              size: Offset(30, 30),
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 3.5,
                                                  'assets/weddingassets/feather_top.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Positioned(
                                            top: 0,
                                            right: 50,
                                            child: TiltParallax(
                                              size: Offset(30, 30),
                                              child: FadeInDown(
                                                child: Image.asset(
                                                  scale: 2,
                                                  'assets/weddingassets/feather_top.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  // color: Colors.brown,
                                ),
                              ),
                              SizedBox(height: 100),
                            ],
                          )
                        : Column(children: [
                            // ini isi kalau dibuka bukan dari HP
                            Text('Masih kosong ya bang 👍',
                                style: GoogleFonts.msMadi(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[700],
                                ))
                          ]),
                  ),
                ),
        ),
      ]),
    );
  }
}



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_tilt/flutter_tilt.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:universal_html/html.dart' as html;

// void main() {
//   final uri = Uri.base;
//   final segments = uri.pathSegments;
//   final guestName = segments.isNotEmpty ? segments.last : 'Tamu';
//   runApp(
//     MyApp(guestName: guestName),
//   );
// }

// List<Map<String, dynamic>> sheetDataTamu = [];
// String guestNameAfterDecode = '';
// double fontSizeHP = 12.0;
// double fontSizePC = 13.0;

// class MyApp extends StatelessWidget {
//   final String guestName;
//   const MyApp({super.key, required this.guestName});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Novia & Ivan',
//       debugShowCheckedModeBanner: false,
//       home: InvitationPage(guestName: guestName),
//     );
//   }
// }

// class InvitationPage extends StatefulWidget {
//   final String guestName;
//   // String guestName = 'nvBM78v6';
//   const InvitationPage({super.key, required this.guestName});

//   @override
//   State<InvitationPage> createState() => _InvitationPageState();
// }

// class _InvitationPageState extends State<InvitationPage> {
//   String guestNameAfterDecode = '';
//   bool isLoading = true;

//   Future<void> fetchSheetData() async {
//     final response = await http.get(
//       Uri.parse(
//         'https://opensheet.elk.sh/1IFycFK3i-AzaZepz0C03dpkoMxemwrBQ45WjwKYVmEU/TamuUndanganwithCode',
//       ),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       final List<Map<String, dynamic>> sheetDataTamu =
//           data.cast<Map<String, dynamic>>();

//       final foundGuest = sheetDataTamu.firstWhere(
//         (item) => item['Kode Undangan'].toString() == widget.guestName,
//         orElse: () => {},
//       );

//       setState(() {
//         guestNameAfterDecode = foundGuest.isNotEmpty
//             ? '${foundGuest['Title']} ${foundGuest['Nama Undangan']}'
//             : '';
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         guestNameAfterDecode = '';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchSheetData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String userAgent = html.window.navigator.userAgent.toLowerCase();
//     String deviceType = "Unknown";
//     if (userAgent.contains("mobile") ||
//         userAgent.contains("android") ||
//         userAgent.contains("iphone")) {
//       deviceType = "HP";
//     } else {
//       deviceType = "Laptop/PC";
//     }
//     return MaterialApp(
//       title: 'Novia & Ivan',
//       debugShowCheckedModeBanner: false,
//       home: Stack(children: [
//         // Background color
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.white,
//                 Colors.white
//                 // Color.fromARGB(255, 255, 255, 255),
//                 // Color.fromARGB(255, 255, 255, 255),
//               ],
//             ),
//           ),
//         ),

//         // Background image
//         Positioned.fill(
//           child: Image.asset(
//             'assets/weddingassets/bg_flower.png',
//             fit: BoxFit.cover,
//           ),
//         ),

//         //konten utama
//         Scaffold(
//           backgroundColor:
//               Colors.transparent, // biar background image kelihatan
//           // appBar: AppBar(title: Text('Halo')),
//           body: isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Tilt(
//                           shadowConfig: const ShadowConfig(disable: true),
//                           childLayout: ChildLayout(
//                             outer: [
//                               /// Leaf gold bottom left
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: -40,
//                                       left: -7,
//                                       child: FadeInDown(
//                                         child: Image.asset(
//                                           scale: 3,
//                                           'assets/weddingassets/outline_leaf_gold.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       bottom: -40,
//                                       left: -7,
//                                       child: FadeInDown(
//                                         child: Image.asset(
//                                           scale: 2.3,
//                                           'assets/weddingassets/outline_leaf_gold.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),

//                               /// Leaf gold top right
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: -40,
//                                       right: -6,
//                                       child: FadeInDown(
//                                         child: Transform.flip(
//                                           flipY: true,
//                                           flipX: true,
//                                           child: Image.asset(
//                                             scale: 3.5,
//                                             'assets/weddingassets/outline_leaf_gold.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: -40,
//                                       right: -6,
//                                       child: FadeInDown(
//                                         child: Transform.flip(
//                                           flipY: true,
//                                           flipX: true,
//                                           child: Image.asset(
//                                             scale: 2.3,
//                                             'assets/weddingassets/outline_leaf_gold.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Splash gold bottom left
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: -50,
//                                       left: 30,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2.5,
//                                             'assets/weddingassets/splash_gold_bottomleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       bottom: -50,
//                                       left: 30,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2,
//                                             'assets/weddingassets/splash_gold_bottomleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Splash gold top left
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 0,
//                                       left: -80,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2.5,
//                                             'assets/weddingassets/splash_gold_topleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 0,
//                                       left: -80,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 1.5,
//                                             'assets/weddingassets/splash_gold_topleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Splash gold middle right
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 200,
//                                       right: -60,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2,
//                                             'assets/weddingassets/splash_gold_middleright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 360,
//                                       right: -60,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 1.5,
//                                             'assets/weddingassets/splash_gold_middleright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Splash gold bottom right
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: -50,
//                                       right: -60,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 3.3,
//                                             'assets/weddingassets/splash_gold_bottomright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       bottom: -50,
//                                       right: -60,
//                                       child: TiltParallax(
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 3,
//                                             'assets/weddingassets/splash_gold_bottomright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               //Merupakan Kehormatan
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 900,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Merupakan suatu kehormatan apabila',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak/Ibu berkenan hadir dan memberikan',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'doa restu untuk kami yang berbahagia.',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     )
//                                   : Positioned(
//                                       bottom: 120,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Merupakan suatu kehormatan apabila',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak/Ibu berkenan hadir dan memberikan',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'doa restu untuk kami yang berbahagia.',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     ),

//                               //Lokasi
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 100,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Bertempat di',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.location_pin,
//                                                   size: 15,
//                                                   color: Colors.red,
//                                                 ),
//                                                 const SizedBox(width: 5),
//                                                 Text(
//                                                   'Nama Tempatnya',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ])),
//                                     )
//                                   : Positioned(
//                                       bottom: 190,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Bertempat di',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.location_pin,
//                                                   size: 15,
//                                                   color: Colors.red,
//                                                 ),
//                                                 const SizedBox(width: 5),
//                                                 Text(
//                                                   'Nama Tempatnya',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ])),
//                                     ),

//                               /// Akad
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 150,
//                                       child: TiltParallax(
//                                           size: Offset(15, 20),
//                                           child: Row(
//                                             children: [
//                                               Column(children: [
//                                                 Text(
//                                                   'Akad',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: fontSizeHP,
//                                                     // fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '09.00 WIB',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ]),
//                                               const SizedBox(
//                                                 width: 50,
//                                               ),
//                                               Column(children: [
//                                                 Text(
//                                                   'Walimatul Urs',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 13,
//                                                     // fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '10.00 WIB',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ],
//                                           )),
//                                     )
//                                   : Positioned(
//                                       bottom: 240,
//                                       child: TiltParallax(
//                                           size: Offset(15, 20),
//                                           child: Row(
//                                             children: [
//                                               Column(children: [
//                                                 Text(
//                                                   'Akad',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: fontSizePC,
//                                                     // fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '09.00 WIB',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ]),
//                                               const SizedBox(
//                                                 width: 50,
//                                               ),
//                                               Column(children: [
//                                                 Text(
//                                                   'Walimatul Urs',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 13,
//                                                     // fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '10.00 WIB',
//                                                   style: GoogleFonts.poppins(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.brown[900],
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ],
//                                           )),
//                                     ),

//                               //Waktu pelaksanaan
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 200,
//                                       child: TiltParallax(
//                                           size: Offset(15, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Yang Insyaallah akan diselenggarakan pada:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Sabtu, 27 Desember 2025',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     )
//                                   : Positioned(
//                                       bottom: 330,
//                                       child: TiltParallax(
//                                           size: Offset(15, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'Yang Insyaallah akan diselenggarakan pada:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Sabtu, 27 Desember 2025',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     ),

//                               /// Pengantin Pria
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 345,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               'Ivan Rifki Nur Alif',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 40,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Putra pertama dari',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 430,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               'Ivan Rifki Nur Alif',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 50,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Putra pertama dari',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),

//                               //&
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 300,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               '&',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 35,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 385,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               '&',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 40,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),

//                               /// Pengantin Wanita
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 180,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               'Novia Andhara',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 40,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Putri pertama dari',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak Agus Suwarno & Ibu Sarmanah',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 260,
//                                       child: TiltParallax(
//                                         size: Offset(10, 30),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               'Novia Andhara',
//                                               style: GoogleFonts.msMadi(
//                                                 fontSize: 50,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[700],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Putri pertama dari',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Bapak Agus Suwarno & Ibu Sarmanah',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),

//                               //Kami Mengundang
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 130,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'kami mengundang Bapak/Ibu/Saudara/i sekalian',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'untuk menghadiri acara walimatul urs:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     )
//                                   : Positioned(
//                                       top: 200,
//                                       child: TiltParallax(
//                                           size: Offset(10, 15),
//                                           child: Column(children: [
//                                             Text(
//                                               'kami mengundang Bapak/Ibu/Saudara/i sekalian',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'untuk menghadiri acara walimatul urs:',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     ),

//                               /// Pembukaan undangan
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 85,
//                                       child: TiltParallax(
//                                           size: Offset(10, 20),
//                                           child: Column(children: [
//                                             Text(
//                                               'Dengan memohon rahmat dan ridho',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Allah Azza Wa Jalla',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizeHP,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     )
//                                   : Positioned(
//                                       top: 150,
//                                       child: TiltParallax(
//                                           size: Offset(10, 20),
//                                           child: Column(children: [
//                                             Text(
//                                               'Dengan memohon rahmat dan ridho',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                             Text(
//                                               'Allah Azza Wa Jalla',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: fontSizePC,
//                                                 // fontWeight: FontWeight.bold,
//                                                 color: Colors.brown[900],
//                                               ),
//                                             ),
//                                           ])),
//                                     ),

//                               /// Bismillah
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 20,
//                                       child: TiltParallax(
//                                         size: const Offset(30, 30),
//                                         child: Image.asset(
//                                           scale: 7,
//                                           'assets/weddingassets/bismillah.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 80,
//                                       child: TiltParallax(
//                                         size: const Offset(30, 30),
//                                         child: Image.asset(
//                                           scale: 6,
//                                           'assets/weddingassets/bismillah.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),

//                               /// Flower bottom left
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 0,
//                                       left: -40,
//                                       child: TiltParallax(
//                                         size: Offset(20, 20),
//                                         child: FadeInLeft(
//                                           child: Image.asset(
//                                             scale: 3.5,
//                                             'assets/weddingassets/flower_bottomleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       bottom: 0,
//                                       left: -30,
//                                       child: TiltParallax(
//                                         size: Offset(20, 20),
//                                         child: FadeInLeft(
//                                           child: Image.asset(
//                                             scale: 2,
//                                             'assets/weddingassets/flower_bottomleft.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Flower top right
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: -40,
//                                       right: -40,
//                                       child: TiltParallax(
//                                         size: Offset(15, 15),
//                                         child: FadeInRight(
//                                           child: Image.asset(
//                                             scale: 3.3,
//                                             'assets/weddingassets/flower_topright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 0,
//                                       right: -30,
//                                       child: TiltParallax(
//                                         size: Offset(15, 15),
//                                         child: FadeInRight(
//                                           child: Image.asset(
//                                             scale: 2.5,
//                                             'assets/weddingassets/flower_topright.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Feather bottom
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       bottom: 0,
//                                       left: 50,
//                                       child: TiltParallax(
//                                         size: Offset(30, 30),
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 3.3,
//                                             'assets/weddingassets/feather_bottom.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       bottom: 0,
//                                       left: 60,
//                                       child: TiltParallax(
//                                         size: Offset(30, 30),
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2,
//                                             'assets/weddingassets/feather_bottom.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),

//                               /// Feather top
//                               deviceType == "HP"
//                                   ? Positioned(
//                                       top: 0,
//                                       right: 35,
//                                       child: TiltParallax(
//                                         size: Offset(30, 30),
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 3.5,
//                                             'assets/weddingassets/feather_top.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Positioned(
//                                       top: 0,
//                                       right: 50,
//                                       child: TiltParallax(
//                                         size: Offset(30, 30),
//                                         child: FadeInDown(
//                                           child: Image.asset(
//                                             scale: 2,
//                                             'assets/weddingassets/feather_top.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height,
//                             // color: Colors.brown,
//                           ),
//                         ),
//                         SizedBox(height: 100),
//                         Text(
//                           'Konten Selanjutnya',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange[900],
//                           ),
//                         ),
//                         Text(
//                           'Konten Selanjutnya',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange[900],
//                           ),
//                         ),
//                         Text(
//                           'Konten Selanjutnya',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange[900],
//                           ),
//                         ),
//                         Text(
//                           'Konten Selanjutnya',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange[900],
//                           ),
//                         ),
//                         Text(
//                           'Konten Selanjutnya',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange[900],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ]),
//     );
//   }
// }
