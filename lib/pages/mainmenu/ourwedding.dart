import 'dart:async';
// import 'dart:math';
// import 'package:WalimatulUrsy/pages/ourwedding_helper.dart';
import 'package:WalimatulUrsy/pages/mainmenu/ourwedding_Mobile.dart';
import 'package:WalimatulUrsy/pages/mainmenu/ourwedding_pc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
// import 'package:WalimatulUrsy/pages/modalbottom.dart';
import 'package:WalimatulUrsy/pages/static.dart';
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
  const InvitationPage({super.key, required this.guestName});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage>
    with TickerProviderStateMixin {
  String guestNameAfterDecode = '';
  String guestCode = '';
  bool isLoading = true;
  final AudioService _audioService = AudioService();
  bool isPlaying = false;
  late AnimationController _controller;
  String souvenirStatus = 'Belum diambil';

  Future<void> loadGuestData() async {
    final guest = await fetchGuestByCode(widget.guestName);

    if (!mounted) return;

    if (guest == null) {
      GoRouter.of(context).go('/');
    } else {
      setState(() {
        guestCode = guest['Kode Undangan'];
        guestNameAfterDecode = '${guest['Title']} ${guest['Nama Undangan']}';
        souvenirStatus = guest['Souvenir'] ?? 'Belum diambil';
        isLoading = false;
      });
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
    loadGuestData();
  }

  void handleAudio() async {
    await _audioService.toggleAudio();
    setState(() {
      isPlaying = _audioService.isPlaying;
    });

    if (isPlaying) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioService.stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userAgent = html.window.navigator.userAgent.toLowerCase();
    String deviceType = "Unknown";
    // String mobileOS = "Unknown";

    // String ukuranLayar = "Unknown";

    // int getLebar = MediaQuery.of(context).size.width.toInt();
    // int lebarLayar = getLebar > 800 ? 800 : getLebar;
    int lebarLayar = MediaQuery.of(context).size.width.toInt();
    int tinggiLayar = MediaQuery.of(context).size.height.toInt();

    if (userAgent.contains("mobile") ||
        userAgent.contains("android") ||
        userAgent.contains("iphone")) {
      deviceType = "HP";
      // mobileOS = userAgent.contains("android") ? "Android" : "iOS";
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

        // deviceType == 'HP'
        lebarLayar < 600
            ? WeddingPageMobile(
                lebarLayar: lebarLayar.toDouble(),
                tinggiLayar: tinggiLayar.toDouble(),
                guestName: guestNameAfterDecode,
                guestCode: guestCode,
                deviceType: deviceType)
            : WeddingPagePC(
                lebarLayar: lebarLayar.toDouble(),
                tinggiLayar: tinggiLayar.toDouble(),
                guestName: guestNameAfterDecode,
                guestCode: guestCode,
                deviceType: deviceType),

        //konten utama

        // Scaffold(
        //   floatingActionButton: Padding(
        //     padding: EdgeInsets.only(bottom: lebarLayar < 350 ? 0 : 50),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         //Audio button
        //         FloatingActionButton(
        //           backgroundColor: Colors.white70,
        //           elevation: 0,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(100.0),
        //           ),
        //           child: AnimatedBuilder(
        //             animation: _controller,
        //             builder: (_, child) {
        //               return Transform.rotate(
        //                   angle: isPlaying ? _controller.value * 2 * pi : 0,
        //                   child: child);
        //             },
        //             child: Icon(
        //               isPlaying ? Icons.stop : Icons.play_arrow,
        //               color: Colors.pink,
        //             ),
        //           ),
        //           onPressed: () {
        //             handleAudio();
        //           },
        //         ),
        //         const SizedBox(width: 40),

        //         //Love button
        //         FloatingActionButton(
        //           backgroundColor: Colors.white70,
        //           elevation: 0,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(100.0),
        //           ),
        //           child: const Icon(
        //             Icons.favorite,
        //             color: Colors.pink,
        //           ),
        //           onPressed: () async {
        //             showTabModal(context, guestNameAfterDecode, guestCode, 0);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        //   floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        //   floatingActionButtonLocation:
        //       FloatingActionButtonLocation.centerFloat,
        //   backgroundColor:
        //       Colors.transparent, // biar background image kelihatan
        //   body: isLoading
        //       ? const Center(child: CircularProgressIndicator())
        //       : SingleChildScrollView(
        //           child: deviceType != ""
        //               ?
        //               //Teks ulang start
        //               Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     Tilt(
        //                       shadowConfig: const ShadowConfig(disable: true),
        //                       childLayout: ChildLayout(
        //                           outer: [
        //                             ...buildFlowerDecorationsOuter(
        //                                 lebarLayar.toDouble())
        //                           ],
        //                           //Ornament Start
        //                           behind: [
        //                             ...buildDecorationElementsBehind(
        //                                 lebarLayar.toDouble())
        //                           ],
        //                           //Ornament End
        //                           inner: [
        //                             Center(
        //                               child: Padding(
        //                                 padding: EdgeInsets.zero,
        //                                 child: Column(
        //                                   children: [
        //                                     // Bismillah
        //                                     fadeTilt(
        //                                       Image.asset(
        //                                         'assets/weddingassets/bismillah.png',
        //                                         scale: lebarLayar *
        //                                             (lebarLayar < 350
        //                                                 ? 0.03
        //                                                 : lebarLayar < 414
        //                                                     ? 0.02
        //                                                     : 0.016),
        //                                         fit: BoxFit.cover,
        //                                       ),
        //                                       animation: fadeInDown,
        //                                       offset: const Offset(15, 15),
        //                                     ),
        //                                     SizedBox(
        //                                         height: tinggiLayar * 0.01),

        //                                     // Kalimat Pembuka
        //                                     ...[
        //                                       'Dengan memohon rahmat dan ridho',
        //                                       'Allah Azza Wa Jalla',
        //                                       'kami mengundang Bapak/Ibu/Saudara/i sekalian',
        //                                       'untuk menghadiri acara walimatul urs:',
        //                                     ].map((text) => fadeTilt(
        //                                         TeksBiasa(text, context),
        //                                         animation: fadeInDown)),

        //                                     SizedBox(
        //                                         height: tinggiLayar * 0.01),

        //                                     // Pengantin Wanita
        //                                     fadeTilt(
        //                                         TeksNamaPengantin(
        //                                             'Novia Andhara', context),
        //                                         offset: const Offset(20, 30),
        //                                         animation: fadeInLeft),
        //                                     fadeTilt(
        //                                         TeksBiasa('Putri pertama dari',
        //                                             context),
        //                                         animation: fadeInLeft),
        //                                     fadeTilt(
        //                                         TeksBiasaBold(
        //                                             'Bpk. Agus Suwarno & Ibu Sarmanah',
        //                                             context),
        //                                         animation: fadeInLeft),

        //                                     SizedBox(
        //                                         height: tinggiLayar * 0.02),

        //                                     // Tanda "&"
        //                                     fadeTilt(
        //                                         TeksNamaPengantin('&', context),
        //                                         offset: const Offset(20, 20),
        //                                         animation: fadeIn),

        //                                     // Pengantin Pria
        //                                     fadeTilt(
        //                                         TeksNamaPengantin(
        //                                             'Ivan Rifki Nur Alif',
        //                                             context),
        //                                         offset: const Offset(20, 30),
        //                                         animation: fadeInRight),
        //                                     fadeTilt(
        //                                         TeksBiasa('Putra pertama dari',
        //                                             context),
        //                                         animation: fadeInRight),
        //                                     fadeTilt(
        //                                         TeksBiasaBold(
        //                                             'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
        //                                             context),
        //                                         animation: fadeInRight),

        //                                     SizedBox(
        //                                         height: tinggiLayar * 0.03),

        //                                     // Info Ketuk Tombol
        //                                     fadeTilt(
        //                                       Row(
        //                                         mainAxisAlignment:
        //                                             MainAxisAlignment.center,
        //                                         children: [
        //                                           Text(
        //                                             'Info lebih lanjut ketuk tombol ',
        //                                             style: GoogleFonts.poppins(
        //                                               fontStyle:
        //                                                   FontStyle.italic,
        //                                               fontSize:
        //                                                   lebarLayar * 0.03,
        //                                               color: Colors.brown[900],
        //                                             ),
        //                                           ),
        //                                           const Icon(Icons.favorite,
        //                                               color: Colors.brown,
        //                                               size: 14),
        //                                           Text(
        //                                             ' yaa..',
        //                                             style: GoogleFonts.poppins(
        //                                               fontStyle:
        //                                                   FontStyle.italic,
        //                                               fontSize:
        //                                                   lebarLayar * 0.03,
        //                                               color: Colors.brown[900],
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                       animation: fadeInUp,
        //                                     ),

        //                                     SizedBox(height: tinggiLayar * 0.1),
        //                                   ],
        //                                 ),
        //                               ),
        //                             )
        //                           ]),
        //                       child: SizedBox(
        //                         width: lebarLayar.toDouble(),
        //                         height: tinggiLayar.toDouble(),
        //                       ),
        //                     ),
        //                   ],
        //                 )

        //               //Teks ulang end
        //               : Center(
        //                   child: Text('Masih kosong ya bang 👍',
        //                       style: GoogleFonts.msMadi(
        //                         fontSize: 50,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.brown[700],
        //                       ))),
        //         ),
        // ),
      ]),
    );
  }
}
