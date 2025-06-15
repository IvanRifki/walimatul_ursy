import 'dart:math';
import 'package:WalimatulUrsy/pages/modalbottom/modalbottom.dart';
import 'package:WalimatulUrsy/pages/mainmenu/ourwedding_helper.dart';
import 'package:WalimatulUrsy/pages/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingPageMobile extends StatefulWidget {
  final double lebarLayar;
  final double tinggiLayar;
  final String guestName;
  final String guestCode;
  final String deviceType;

  const WeddingPageMobile({
    super.key,
    required this.lebarLayar,
    required this.tinggiLayar,
    required this.guestName,
    required this.guestCode,
    required this.deviceType,
  });

  @override
  State<WeddingPageMobile> createState() => _WeddingPageMobileState();
}

class _WeddingPageMobileState extends State<WeddingPageMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = false;
  bool isLoading = false;
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _audioService.stopAudio();
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
  Widget build(BuildContext context) {
    final lebarLayar = widget.lebarLayar;
    final tinggiLayar = widget.tinggiLayar;
    final guestNameAfterDecode = widget.guestName;
    final guestCode = widget.guestCode;
    final deviceType = widget.deviceType;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: lebarLayar < 350 ? 0 : 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tombol audio
            FloatingActionButton(
              backgroundColor: Colors.white70,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              onPressed: handleAudio,
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
            ),
            const SizedBox(width: 40),
            // tombol love
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.transparent,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: deviceType != ""
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Tilt(
                          shadowConfig: const ShadowConfig(disable: true),
                          childLayout: ChildLayout(
                              outer: [
                                ...buildFlowerDecorationsOuter(
                                    lebarLayar.toDouble())
                              ],
                              //Ornament Start
                              behind: [
                                ...buildDecorationElementsBehind(
                                    lebarLayar.toDouble())
                              ],
                              //Ornament End
                              inner: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Column(
                                      children: [
                                        // Bismillah
                                        fadeTilt(
                                          Image.asset(
                                            'assets/weddingassets/bismillah.png',
                                            scale: lebarLayar *
                                                (lebarLayar < 350
                                                    ? 0.03
                                                    : lebarLayar < 414
                                                        ? 0.02
                                                        : 0.016),
                                            fit: BoxFit.cover,
                                          ),
                                          animation: fadeInDown,
                                          offset: const Offset(15, 15),
                                        ),
                                        SizedBox(height: tinggiLayar * 0.01),

                                        // Kalimat Pembuka
                                        ...[
                                          'Dengan memohon rahmat dan ridho',
                                          'Allah Azza Wa Jalla',
                                          'kami mengundang Bapak/Ibu/Saudara/i sekalian',
                                          'untuk menghadiri acara walimatul urs:',
                                        ].map((text) => fadeTilt(
                                            TeksBiasa(text, context),
                                            animation: fadeInDown)),

                                        SizedBox(height: tinggiLayar * 0.01),

                                        // Pengantin Wanita
                                        fadeTilt(
                                            TeksNamaPengantin(
                                                'Novia Andhara', context),
                                            offset: const Offset(20, 30),
                                            animation: fadeInLeft),
                                        fadeTilt(
                                            TeksBiasa(
                                                'Putri pertama dari', context),
                                            animation: fadeInLeft),
                                        fadeTilt(
                                            TeksBiasaBold(
                                                'Bpk. Agus Suwarno & Ibu Sarmanah',
                                                context),
                                            animation: fadeInLeft),

                                        SizedBox(height: tinggiLayar * 0.02),

                                        // Tanda "&"
                                        fadeTilt(
                                            TeksNamaPengantin('&', context),
                                            offset: const Offset(20, 20),
                                            animation: fadeIn),

                                        // Pengantin Pria
                                        fadeTilt(
                                            TeksNamaPengantin(
                                                'Ivan Rifki Nur Alif', context),
                                            offset: const Offset(20, 30),
                                            animation: fadeInRight),
                                        fadeTilt(
                                            TeksBiasa(
                                                'Putra pertama dari', context),
                                            animation: fadeInRight),
                                        fadeTilt(
                                            TeksBiasaBold(
                                                'Bpk. Nurdin Maryanto (Rahimahullah) & Ibu Suwarti',
                                                context),
                                            animation: fadeInRight),

                                        SizedBox(height: tinggiLayar * 0.03),

                                        // Info Ketuk Tombol
                                        fadeTilt(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Info lebih lanjut ketuk tombol ',
                                                style: GoogleFonts.poppins(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: lebarLayar * 0.03,
                                                  color: Colors.brown[900],
                                                ),
                                              ),
                                              const Icon(Icons.favorite,
                                                  color: Colors.brown,
                                                  size: 14),
                                              Text(
                                                ' yaa..',
                                                style: GoogleFonts.poppins(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: lebarLayar * 0.03,
                                                  color: Colors.brown[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                          animation: fadeInUp,
                                        ),

                                        SizedBox(height: tinggiLayar * 0.1),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                          child: SizedBox(
                            width: lebarLayar.toDouble(),
                            height: tinggiLayar.toDouble(),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'Masih kosong ya bang 👍',
                        style: GoogleFonts.msMadi(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700],
                        ),
                      ),
                    ),
            ),
    );
  }
}
