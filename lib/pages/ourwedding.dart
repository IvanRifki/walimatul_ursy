import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:walimatul_ursy/pages/modalbottom.dart';
import 'package:walimatul_ursy/pages/static.dart';
import 'package:knight_confetti/knight_confetti.dart';

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

class _InvitationPageState extends State<InvitationPage>
    with TickerProviderStateMixin {
  String guestNameAfterDecode = '';
  String guestCode = '';
  bool isLoading = true;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late AnimationController _controller;

  String souvenirStatus = 'Belum diambil';

  Future<void> fetchSheetData() async {
    try {
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

        if (foundGuest.isEmpty) {
          if (mounted) {
            // Gunakan go_router redirect
            GoRouter.of(context).go('/');
          }
          return;
        }

        if (mounted) {
          setState(() {
            guestCode = foundGuest['Kode Undangan'];
            guestNameAfterDecode =
                '${foundGuest['Title']} ${foundGuest['Nama Undangan']}';
            souvenirStatus =
                foundGuest['Souvenir'] ?? 'Belum diambil'; // Add this line
            isLoading = false;
          });
        }
      } else {
        // Gagal fetch data
        if (mounted) {
          setState(() {
            guestNameAfterDecode = '';
            souvenirStatus = 'Belum diambil'; // Default value if fetch fails
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        setState(() {
          guestNameAfterDecode = '';
          souvenirStatus = 'Belum diambil'; // Default value on error
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // <-- warna status bar
      statusBarIconBrightness:
          Brightness.dark, // <-- warna ikon status bar (dark = ikon hitam)
    ));

    fetchSheetData();
  }

  void toggleAudio() async {
    if (isPlaying) {
      _controller.stop();
      await _audioPlayer.stop();
    } else {
      _controller.repeat();
      await _audioPlayer.play(AssetSource('weddingassets/kekal.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
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
      home: Stack(children: [
        // Background color
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
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
        SnowConfetti(
          totalParticles: 100, // Total number of particles
          // color: Colors.white.withOpacity(0.9),
          color: Colors.amber[100]!.withOpacity(0.9),
        ),

        //konten utama
        Scaffold(
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: lebarLayar < 350 ? 0 : 50),
            // 30
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Audio button
                FloatingActionButton(
                  backgroundColor: Colors.white70,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                          angle: isPlaying ? _controller.value * 2 * pi : 0,
                          child: child);
                    },
                    child: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.pink,
                    ),
                  ),
                  // Icon(
                  //   isPlaying ? Icons.stop : Icons.play_arrow,
                  //   color: Colors.pink,
                  // ),
                  onPressed: () {
                    // showTabModal(context, guestNameAfterDecode, guestCode);
                    toggleAudio();
                  },
                ),
                const SizedBox(width: 40),
                // //Audio button
                // FloatingActionButton(
                //   backgroundColor: Colors.white70,
                //   elevation: 0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(100.0),
                //   ),
                //   child: Icon(
                //     isPlaying ? Icons.stop : Icons.play_arrow,
                //     color: Colors.pink,
                //   ),
                //   onPressed: () {
                //     // showTabModal(context, guestNameAfterDecode, guestCode);
                //     toggleAudio();
                //   },
                // ),

                //Love button
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
                  onPressed: () async {
                    showTabModal(context, guestNameAfterDecode, guestCode, 0);
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          backgroundColor:
              Colors.transparent, // biar background image kelihatan
          // appBar: AppBar(title: Text('Halo')),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  // child: deviceType == "HP"
                  child: deviceType != ""
                      ?
                      //Teks ulang start
                      Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tilt(
                              shadowConfig: const ShadowConfig(disable: true),
                              childLayout: ChildLayout(
                                  outer: [
                                    //flower_topright
                                    Positioned(
                                      top: lebarLayar < 350 ? -60 : -130,
                                      right: lebarLayar < 350 ? 40 : 80,
                                      // right: 80,
                                      // top: -140,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(5, 20),
                                          child: Transform.rotate(
                                            angle: pi / 2,
                                            child: Transform.flip(
                                              flipY: true,
                                              child: Image.asset(
                                                scale: lebarLayar /
                                                    (lebarLayar < 350
                                                        ? 50
                                                        : lebarLayar < 414
                                                            ? 110
                                                            : 150),
                                                // (lebarLayar < 414
                                                //     ? 110
                                                //     : 150),
                                                // scale: lebarLayar / 150,
                                                'assets/weddingassets/flower_bottomleft.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //flower_bottomleft
                                    Positioned(
                                      bottom: lebarLayar < 350
                                          ? -60
                                          : lebarLayar < 414
                                              ? -120
                                              : -150,
                                      left: lebarLayar < 350
                                          ? 40
                                          : lebarLayar < 414
                                              ? 80
                                              : 100,
                                      // bottom: lebarLayar < 414 ? -120 : -150,
                                      // left: lebarLayar < 414 ? 80 : 100,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: const Offset(5, 20),
                                          child: Transform.rotate(
                                            angle: pi / 2,
                                            child: Transform.flip(
                                              flipY: true,
                                              child: Image.asset(
                                                scale: lebarLayar /
                                                    (lebarLayar < 350
                                                        ? 50
                                                        : lebarLayar < 414
                                                            ? 110
                                                            : 150),
                                                'assets/weddingassets/flower_topright.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],

                                  //Ornament Start

                                  behind: [
                                    //outline_leaf_gold topright
                                    Positioned(
                                      top: lebarLayar < 350 ? 40 : 50,
                                      right: lebarLayar < 350 ? -100 : -120,
                                      // top: 50,
                                      // right: -120,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(20, 20),
                                          child: Transform.rotate(
                                            angle: pi / 2,
                                            child: Transform.flip(
                                              flipY: true,
                                              child: Image.asset(
                                                scale: lebarLayar /
                                                    (lebarLayar < 350
                                                        ? 90
                                                        : lebarLayar < 414
                                                            ? 130
                                                            : 150),
                                                // (lebarLayar < 414
                                                //     ? 130
                                                //     : 150),
                                                'assets/weddingassets/outline_leaf_gold.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //splash_gold_topright
                                    Positioned(
                                      top: lebarLayar < 350 ? 15 : 25,
                                      right: lebarLayar < 350 ? -20 : -50,
                                      // top: 25,
                                      // right: -50,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(10, 10),
                                          child: Transform.flip(
                                            flipX: true,
                                            child: Image.asset(
                                              scale: lebarLayar /
                                                  (lebarLayar < 350
                                                      ? 100
                                                      : lebarLayar < 414
                                                          ? 150
                                                          : 200),
                                              // (lebarLayar < 414
                                              //     ? 150
                                              //     : 200),

                                              'assets/weddingassets/splash_gold_topleft.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //outline_leaf_gold Bottom Left
                                    Positioned(
                                      bottom: lebarLayar < 350 ? 40 : 50,
                                      left: lebarLayar < 350 ? -100 : -120,
                                      // bottom: 50,
                                      // left: -120,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(5, 20),
                                          child: Transform.rotate(
                                            angle: pi / 2,
                                            child: Transform.flip(
                                              flipX: true,
                                              child: Image.asset(
                                                scale: lebarLayar /
                                                    (lebarLayar < 350
                                                        ? 90
                                                        : lebarLayar < 414
                                                            ? 130
                                                            : 150),
                                                // (lebarLayar < 414
                                                //     ? 130
                                                //     : 150),
                                                'assets/weddingassets/outline_leaf_gold.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //splash_gold_topleft
                                    Positioned(
                                      top: -10,
                                      left: -50,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: const Offset(30, 10),
                                          child: Image.asset(
                                            scale: lebarLayar < 350
                                                ? 3
                                                : lebarLayar < 414
                                                    ? 2.5
                                                    : 2,
                                            // scale: lebarLayar < 414 ? 2.5 : 2,
                                            // scale: 2,
                                            'assets/weddingassets/splash_gold_topleft.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //splash_gold_bottomleft
                                    Positioned(
                                      bottom: -10,
                                      left: -20,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(10, 10),
                                          child: Image.asset(
                                            scale: lebarLayar /
                                                (lebarLayar < 350
                                                    ? 100
                                                    : lebarLayar < 414
                                                        ? 150
                                                        : 200),
                                            // scale: lebarLayar /
                                            //     (lebarLayar < 414 ? 150 : 200),
                                            'assets/weddingassets/splash_gold_bottomleft.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //splash_gold_bottomright
                                    Positioned(
                                      bottom: -20,
                                      right: -60,
                                      child: FadeInDown(
                                        child: TiltParallax(
                                          size: Offset(30, 10),
                                          child: Transform.flip(
                                            flipX: true,
                                            child: Image.asset(
                                              scale: lebarLayar /
                                                  (lebarLayar < 350
                                                      ? 100
                                                      : lebarLayar < 414
                                                          ? 150
                                                          : 200),
                                              'assets/weddingassets/splash_gold_topleft.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  //Ornament End
                                  inner: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Stack(children: [
                                          Column(
                                            children: [
                                              //Bismillah
                                              FadeInDown(
                                                child: TiltParallax(
                                                  size: const Offset(15, 15),
                                                  child: Image.asset(
                                                    scale: lebarLayar *
                                                        (lebarLayar < 350
                                                            ? 0.03
                                                            : lebarLayar < 414
                                                                ? 0.02
                                                                : 0.016),
                                                    // (lebarLayar < 350
                                                    //     ? 0.03
                                                    //     : 0.016),
                                                    'assets/weddingassets/bismillah.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: tinggiLayar * 0.01),

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
                                                    child: TeksBiasa(
                                                        'Allah Azza Wa Jalla',
                                                        context)),
                                              ),

                                              SizedBox(
                                                  height: tinggiLayar * 0.01),

                                              FadeInDown(
                                                child: TiltParallax(
                                                    size: const Offset(15, 20),
                                                    child: TeksBiasa(
                                                        'kami mengundang Bapak/Ibu/Saudara/i sekalian',
                                                        context)),
                                              ),
                                              FadeInDown(
                                                child: TiltParallax(
                                                    size: const Offset(15, 20),
                                                    child: TeksBiasa(
                                                        'untuk menghadiri acara walimatul urs:',
                                                        context)),
                                              ),
                                              SizedBox(
                                                  height: tinggiLayar * 0.01),

                                              //Pengantin Wanita
                                              FadeInLeft(
                                                child: TiltParallax(
                                                  size: const Offset(20, 30),
                                                  child: TeksNamaPengantin(
                                                      'Novia Andhara', context),
                                                ),
                                              ),
                                              FadeInLeft(
                                                child: TiltParallax(
                                                  size: const Offset(15, 20),
                                                  child: TeksBiasa(
                                                      'Putri pertama dari',
                                                      context),
                                                ),
                                              ),
                                              FadeInLeft(
                                                child: TiltParallax(
                                                  size: const Offset(15, 20),
                                                  child: TeksBiasaBold(
                                                      'Bpk. Agus Suwarno & Ibu Sarmanah',
                                                      context),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: tinggiLayar * 0.02),
                                              FadeIn(
                                                child: TiltParallax(
                                                  size: const Offset(20, 20),
                                                  child: TeksNamaPengantin(
                                                      '&', context),
                                                ),
                                              ),

                                              //Pengantin Pria
                                              FadeInRight(
                                                child: TiltParallax(
                                                  size: const Offset(20, 30),
                                                  child: TeksNamaPengantin(
                                                      'Ivan Rifki Nur Alif',
                                                      context),
                                                ),
                                              ),
                                              FadeInRight(
                                                child: TiltParallax(
                                                  size: const Offset(15, 20),
                                                  child: TeksBiasa(
                                                      'Putra pertama dari',
                                                      context),
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
                                              SizedBox(
                                                  height: tinggiLayar * 0.03),
                                              FadeInUp(
                                                child: TiltParallax(
                                                    size: const Offset(15, 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Text(
                                                        //     'Info lebih lanjut ketuk tombol ❤︎ ya..',
                                                        //     style:
                                                        //         GoogleFonts.poppins(
                                                        //       textStyle:
                                                        //           const TextStyle(
                                                        //               fontStyle:
                                                        //                   FontStyle
                                                        //                       .italic),
                                                        //       fontSize: MediaQuery.of(
                                                        //                   context)
                                                        //               .size
                                                        //               .width *
                                                        //           0.03,
                                                        //       color:
                                                        //           Colors.brown[900],
                                                        //     )),

                                                        Text(
                                                            'Info lebih lanjut ketuk tombol ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle: const TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                              color: Colors
                                                                  .brown[900],
                                                            )),
                                                        const Icon(
                                                          Icons.favorite,
                                                          color: Colors.brown,
                                                          size: 14,
                                                        ),
                                                        Text(' yaa..',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle: const TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                              color: Colors
                                                                  .brown[900],
                                                            )),
                                                      ],
                                                    )),
                                              ),

                                              // SizedBox(
                                              //     height: tinggiLayar * 0.1),

                                              SizedBox(
                                                  height: tinggiLayar * 0.1),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ]),
                              child: Container(
                                width: lebarLayar.toDouble(),
                                height: tinggiLayar.toDouble(),
                              ),
                              //
                            ),
                          ],
                        )

                      //Teks ulang end
                      : Center(
                          child: Text('Masih kosong ya bang 👍',
                              style: GoogleFonts.msMadi(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700],
                              ))),
                ),
        ),
      ]),
    );
  }
}
