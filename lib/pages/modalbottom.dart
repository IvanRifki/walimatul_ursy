import 'package:dotted_border/dotted_border.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:knight_confetti/knight_confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:WalimatulUrsy/pages/static.dart';
import 'package:delayed_display/delayed_display.dart';

const String mapsUrl = 'https://maps.app.goo.gl/opSoVsW2TGiraoMS7';

var Statusnya = {};

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
  Statusnya.clear();
  Statusnya = await fetchSheetDataPlain(guestCode);
  // print('ini statusnya bang ${Statusnya['Souvenir']}');

  String SouvenirStatus = Statusnya['Souvenir'];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white.withOpacity(0.90), // Transparansi di sini
    barrierColor:
        Colors.black.withOpacity(0.3), // Latar belakang gelap transparan
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      int lebarLayar = MediaQuery.of(context).size.width.toInt();

      return DefaultTabController(
        initialIndex: tabInitial,
        length: 4,
        child: Stack(children: [
          SnowConfetti(
            totalParticles: 100, // Total number of particles
            // color: Colors.white.withOpacity(0.9),
            color: Colors.amber[100]!.withOpacity(0.9),
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                              //outline leaf gold top right
                              Positioned(
                                bottom: lebarLayar < 350
                                    ? 250
                                    : lebarLayar < 414
                                        ? 360
                                        : 480,
                                right: 0,
                                child: FadeInRight(
                                  child: TiltParallax(
                                    size: Offset(10, 15),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: Image.asset(
                                        scale: lebarLayar /
                                            (lebarLayar < 350
                                                ? 60
                                                : lebarLayar < 414
                                                    ? 80
                                                    : 100),
                                        'assets/weddingassets/outline_leaf_gold.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //outline leaf gold bottom left
                              Positioned(
                                top: lebarLayar < 350
                                    ? 250
                                    : lebarLayar < 414
                                        ? 360
                                        : 460,
                                left: 0,
                                child: FadeInLeft(
                                  child: TiltParallax(
                                    size: Offset(10, 15),
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 60
                                              : lebarLayar < 414
                                                  ? 80
                                                  : 100),
                                      'assets/weddingassets/outline_leaf_gold.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              //splash gold bottom left
                              Positioned(
                                top: lebarLayar < 350
                                    ? 170
                                    : lebarLayar < 414
                                        ? 260
                                        : 360,
                                left: 0,
                                child: FadeInLeft(
                                  child: TiltParallax(
                                    size: Offset(20, 20),
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 90
                                              : lebarLayar < 414
                                                  ? 150
                                                  : 200),
                                      'assets/weddingassets/splash_gold_bottomleft.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              //splash gold top right
                              Positioned(
                                bottom: lebarLayar < 350
                                    ? 200
                                    : lebarLayar < 414
                                        ? 290
                                        : 390,
                                right: 0,
                                child: FadeInRight(
                                  child: TiltParallax(
                                    size: Offset(20, 20),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: Image.asset(
                                        scale: lebarLayar /
                                            (lebarLayar < 350
                                                ? 90
                                                : lebarLayar < 414
                                                    ? 110
                                                    : 160),
                                        'assets/weddingassets/splash_gold_topleft.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //flower bottom left
                              Positioned(
                                top: lebarLayar < 350
                                    ? 150
                                    : lebarLayar < 414
                                        ? 260
                                        : 350,
                                left: 0,
                                child: FadeInLeft(
                                  child: TiltParallax(
                                    size: Offset(5, 20),
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 50
                                              : lebarLayar < 414
                                                  ? 70
                                                  : 90),
                                      'assets/weddingassets/flower_bottomleft.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              //flower top right
                              Positioned(
                                bottom: lebarLayar < 350
                                    ? 150
                                    : lebarLayar < 414
                                        ? 260
                                        : 350,
                                right: 0,
                                child: FadeInRight(
                                  child: TiltParallax(
                                    size: Offset(5, 20),
                                    child: Transform.flip(
                                      flipX: true,
                                      flipY: true,
                                      child: Image.asset(
                                        scale:
                                            // lebarLayar / 60,
                                            lebarLayar /
                                                (lebarLayar < 350
                                                    ? 50
                                                    : lebarLayar < 414
                                                        ? 70
                                                        : 90),
                                        // (lebarLayar < 414
                                        //     ? 110
                                        //     : 150),
                                        'assets/weddingassets/flower_bottomleft.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ], outer: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20),
                                    DelayedDisplay(
                                        slidingCurve: Curves.linear,
                                        delay: Duration(milliseconds: 300),
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
                                    // FadeInDown(
                                    //   child: TiltParallax(
                                    //     size: const Offset(15, 20),
                                    //     child: TeksBiasa(
                                    //         'Insyaallah akan diselenggarakan pada:',
                                    //         context),
                                    //   ),
                                    // ),
                                    // FadeInDown(
                                    //   child: TiltParallax(
                                    //     size: const Offset(15, 20),
                                    //     child: TeksWaktuBold(
                                    //         'Sabtu, 27 Desember 2025', context),
                                    //   ),
                                    // ),
                                    SizedBox(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height
                                                .toInt() *
                                            0.02),
                                    DelayedDisplay(
                                      slidingCurve: Curves.linear,
                                      delay: Duration(milliseconds: 300),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              //akad
                                              FadeInUp(
                                                child: TiltParallax(
                                                  size: const Offset(15, 20),
                                                  child: TeksBiasa(
                                                      'Akad', context),
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
                                                      'Walimatul Ursy',
                                                      context),
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
                            ]),
                            child: Container())),

                    //Lokasi
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        // _openMaps();
                        _openMaps();
                      },
                      child: Tilt(
                          shadowConfig: const ShadowConfig(disable: true),
                          childLayout: ChildLayout(behind: [
                            //outline leaf gold top right
                            Positioned(
                              bottom: lebarLayar < 350
                                  ? 250
                                  : lebarLayar < 414
                                      ? 360
                                      : 480,
                              right: 0,
                              child: FadeInRight(
                                child: TiltParallax(
                                  size: Offset(10, 15),
                                  child: Transform.flip(
                                    flipX: true,
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 60
                                              : lebarLayar < 414
                                                  ? 80
                                                  : 100),
                                      'assets/weddingassets/outline_leaf_gold.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //outline leaf gold bottom left
                            Positioned(
                              top: lebarLayar < 350
                                  ? 250
                                  : lebarLayar < 414
                                      ? 360
                                      : 460,
                              left: 0,
                              child: FadeInLeft(
                                child: TiltParallax(
                                  size: Offset(10, 15),
                                  child: Image.asset(
                                    scale: lebarLayar /
                                        (lebarLayar < 350
                                            ? 60
                                            : lebarLayar < 414
                                                ? 80
                                                : 100),
                                    'assets/weddingassets/outline_leaf_gold.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            //splash gold bottom left
                            Positioned(
                              top: lebarLayar < 350
                                  ? 170
                                  : lebarLayar < 414
                                      ? 260
                                      : 360,
                              left: 0,
                              child: FadeInLeft(
                                child: TiltParallax(
                                  size: Offset(20, 20),
                                  child: Image.asset(
                                    scale: lebarLayar /
                                        (lebarLayar < 350
                                            ? 90
                                            : lebarLayar < 414
                                                ? 150
                                                : 200),
                                    'assets/weddingassets/splash_gold_bottomleft.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            //splash gold top right
                            Positioned(
                              bottom: lebarLayar < 350
                                  ? 200
                                  : lebarLayar < 414
                                      ? 290
                                      : 390,
                              right: 0,
                              child: FadeInRight(
                                child: TiltParallax(
                                  size: Offset(20, 20),
                                  child: Transform.flip(
                                    flipX: true,
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 90
                                              : lebarLayar < 414
                                                  ? 110
                                                  : 160),
                                      'assets/weddingassets/splash_gold_topleft.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //flower bottom left
                            Positioned(
                              top: lebarLayar < 350
                                  ? 150
                                  : lebarLayar < 414
                                      ? 260
                                      : 350,
                              left: 0,
                              child: FadeInLeft(
                                child: TiltParallax(
                                  size: Offset(5, 20),
                                  child: Image.asset(
                                    scale: lebarLayar /
                                        (lebarLayar < 350
                                            ? 50
                                            : lebarLayar < 414
                                                ? 70
                                                : 90),
                                    'assets/weddingassets/flower_bottomleft.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            //flower top right
                            Positioned(
                              bottom: lebarLayar < 350
                                  ? 150
                                  : lebarLayar < 414
                                      ? 260
                                      : 350,
                              right: 0,
                              child: FadeInRight(
                                child: TiltParallax(
                                  size: Offset(5, 20),
                                  child: Transform.flip(
                                    flipX: true,
                                    flipY: true,
                                    child: Image.asset(
                                      scale: lebarLayar /
                                          (lebarLayar < 350
                                              ? 50
                                              : lebarLayar < 414
                                                  ? 70
                                                  : 90),
                                      'assets/weddingassets/flower_bottomleft.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ], outer: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          // wkwkwk
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
                              child: SouvenirStatus.contains('Belum')
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //card QR
                                          Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // const SizedBox(height: 20),
                                                  TeksNamaPengantin(
                                                      'Novia & Ivan', context),
                                                  // const SizedBox(height: 20),
                                                  Text(
                                                    'Tukarkan barcode dengan souvenir yang tersedia.',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.brown[900],
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Tilt(
                                                        shadowConfig:
                                                            ShadowConfig(
                                                                disable: true),
                                                        childLayout:
                                                            ChildLayout(outer: [
                                                          TiltParallax(
                                                            size: const Offset(
                                                                15, 20),
                                                            child: PrettyQrView
                                                                .data(
                                                              data: guestCode,
                                                              decoration:
                                                                  const PrettyQrDecoration(
                                                                quietZone:
                                                                    PrettyQrQuietZone
                                                                        .zero,
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                        child: TiltParallax(
                                                          size: const Offset(
                                                              15, 20),
                                                          child:
                                                              PrettyQrView.data(
                                                            data: guestCode,
                                                            decoration:
                                                                const PrettyQrDecoration(
                                                              quietZone:
                                                                  PrettyQrQuietZone
                                                                      .zero,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  TeksBiasaBold(
                                                      guestCode, context),
                                                  TeksBiasa(guestName, context),
                                                  const SizedBox(height: 20),
                                                  DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius:
                                                        const Radius.circular(
                                                            10),
                                                    dashPattern: const [5, 5],
                                                    color: Colors.brown[900]!,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Souvenir: ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .brown[900],
                                                            )),
                                                        const Icon(
                                                          Icons.info,
                                                          color: Colors.brown,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(SouvenirStatus,
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 2,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .brown[900],
                                                              // fontWeight: FontWeight.bold
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  // const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                          ),

                                          //card info pengambilan & ucapan terima kasih
                                          Card(
                                            color: Colors.amber[50],
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius:
                                                    const Radius.circular(10),
                                                dashPattern: const [10, 5],
                                                color: Colors.amber,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.circle,
                                                              size: 12,
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              // Tambahkan ini
                                                              child: Text(
                                                                'Tunjukan QR Code ini kepada petugas souvenir',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                          .brown[
                                                                      900],
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.circle,
                                                              size: 12,
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              child: Text(
                                                                '1 (satu) Souvenir untuk 1 (satu) tamu undangan',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                            .brown[
                                                                        900],
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic
                                                                    // fontWeight: FontWeight.bold
                                                                    ),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //card QR
                                          Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // const SizedBox(height: 20),
                                                  TeksNamaPengantin(
                                                      'Novia & Ivan', context),
                                                  // const SizedBox(height: 20),
                                                  Text(
                                                    'Terima Kasih Atas Kehadirannya.',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.brown[900],
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Tilt(
                                                        shadowConfig:
                                                            ShadowConfig(
                                                                disable: true),
                                                        childLayout:
                                                            ChildLayout(outer: [
                                                          TiltParallax(
                                                            size: const Offset(
                                                                15, 20),
                                                            child: PrettyQrView
                                                                .data(
                                                              data: guestCode,
                                                              decoration:
                                                                  const PrettyQrDecoration(
                                                                quietZone:
                                                                    PrettyQrQuietZone
                                                                        .zero,
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                        child: TiltParallax(
                                                          size: const Offset(
                                                              15, 20),
                                                          child:
                                                              PrettyQrView.data(
                                                            data: guestCode,
                                                            decoration:
                                                                const PrettyQrDecoration(
                                                              quietZone:
                                                                  PrettyQrQuietZone
                                                                      .zero,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  TeksBiasaBold(
                                                      guestCode, context),
                                                  TeksBiasa(guestName, context),
                                                  const SizedBox(height: 20),
                                                  DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius:
                                                        const Radius.circular(
                                                            10),
                                                    dashPattern: const [5, 5],
                                                    color:
                                                        SouvenirStatus.contains(
                                                                'Sudah')
                                                            ? Colors.green
                                                            : Colors.brown,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Souvenir : ',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 2,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              // color: Colors.brown,
                                                            )),
                                                        SouvenirStatus.contains(
                                                                'Sudah')
                                                            ? const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 16,
                                                              )
                                                            : const Icon(
                                                                Icons.info,
                                                                color: Colors
                                                                    .brown,
                                                                size: 16,
                                                              ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(SouvenirStatus,
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 2,
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color: SouvenirStatus
                                                                        .contains(
                                                                            'Sudah')
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .brown,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                  // const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                          ),

                                          //card info pengambilan & ucapan terima kasih
                                          Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius:
                                                    const Radius.circular(10),
                                                dashPattern: const [10, 5],
                                                color: Colors.pink,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.circle,
                                                              size: 10,
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              // Tambahkan ini
                                                              child: Text(
                                                                'Tunjukan QR Code ini kepada petugas souvenir',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                          .brown[
                                                                      900],
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.circle,
                                                              size: 10,
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              child: Text(
                                                                '1 (satu) Souvenir untuk 1 (satu) tamu undangan',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                            .brown[
                                                                        900],
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic
                                                                    // fontWeight: FontWeight.bold
                                                                    ),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                    ),

                    //Lainnya
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/weddingassets/ni_logo.png',
                                fit: BoxFit.fitWidth,
                                scale: 1.5,
                              ),
                              TeksBiasaBold(
                                  "Di antara kita dan semua yang berpasangan,",
                                  context),
                              TeksBiasa(
                                  "ada takdir yang pelan-pelan menyulam harapan.",
                                  context),
                              const SizedBox(height: 20),
                              TeksBiasaBold(
                                  "Jalan di utara, tenang dalam langkah,",
                                  context),
                              TeksBiasa(
                                  "dan tujuan yang berdampingan,", context),
                              TeksBiasa(
                                  "tak lagi sendiri menafsir arah.", context),
                              SizedBox(height: 20),
                              // TeksBiasa("Fotonya kalau ada.", context),
                              FanCarouselImageSlider.sliderType1(
                                imagesLink: sampleImages,
                                isAssets: true,
                                autoPlay: true,
                                sliderHeight: 400,
                                showIndicator: true,
                              ),
                              SizedBox(height: 20),
                              TeksBiasa("Deskripsi akhir.", context),
                              SizedBox(height: 20),
                              TeksBiasa("Doa-doa.", context),
                              SizedBox(height: 20),
                              TeksBiasa("Kirim Hadiah ke pengantin.", context),
                              SizedBox(height: 20),
                              Container(
                                width: 100,
                                height: 600,
                                decoration: BoxDecoration(
                                  color: Colors.brown[900],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 100,
                                height: 600,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                ),
                              ),
                              TeksBiasa("Penutup", context),
                              SizedBox(height: 20),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              TabBar(
                // isScrollable: true,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                dividerColor: Colors.transparent,
                tabs: [
                  //Tab Waktu
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          // color: Colors.brown[900],
                        ),
                        SizedBox(width: 5),
                        TeksBiasa("Waktu", context),
                      ],
                    ),
                  ),

                  //Tab Lokasi
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          // color: Colors.brown[900],
                        ),
                        SizedBox(width: 5),
                        TeksBiasa("Lokasi", context),
                      ],
                    ),
                  ),

                  //Tab Kupon
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cake,
                          // color: Colors.brown[900],
                        ),
                        SizedBox(width: 5),
                        TeksBiasa("Souvenir", context),
                      ],
                    ),
                  ),

                  //Tab Kupon
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          // color: Colors.brown[900],
                        ),
                        SizedBox(width: 5),
                        TeksBiasa("Lainnya", context),
                      ],
                    ),
                  ),
                ],
                labelColor: Colors.pink,
                unselectedLabelColor: Colors.grey,
                // indicatorColor: Colors.pink,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.pink,
                      width: 2,
                    ),
                  ),
                ),
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
                    padding: const EdgeInsets.all(6.0),
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
              SizedBox(height: 20),
            ],
          ),
        ]),
      );
    },
  );
}
