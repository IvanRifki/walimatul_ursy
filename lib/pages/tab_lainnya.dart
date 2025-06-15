import 'package:WalimatulUrsy/pages/static.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTabLainnya extends StatelessWidget {
  const ContentTabLainnya({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: DelayedDisplay(
          delay: const Duration(milliseconds: 50),
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
                  "Di antara kita dan semua yang berpasangan,", context),
              TeksBiasa(
                  "ada takdir yang pelan-pelan menyulam harapan.", context),
              const SizedBox(height: 20),
              TeksBiasaBold("Jalan di utara, tenang dalam langkah,", context),
              TeksBiasa("dan tujuan yang berdampingan,", context),
              TeksBiasa("tak lagi sendiri menafsir arah.", context),
              const SizedBox(height: 20),
              TeksBiasaBold("10 tahun hilang arah,", context),
              TeksBiasa("tanpa gambaran akan ke mana", context),
              const SizedBox(height: 20),
              TeksBiasa("Doa-doa meramu harapan,", context),
              TeksBiasaBold("menuntun arah untuk saling menemukan", context),
              const SizedBox(height: 20),
              FanCarouselImageSlider.sliderType1(
                imagesLink: sampleImages,
                isAssets: true,
                autoPlay: true,
                sliderHeight: 400,
                showIndicator: true,
              ),
              const SizedBox(height: 20),
              TeksBiasa("Di kekalanmu dan aku telah kusaksikan,", context),
              TeksBiasaBold(
                  "Yang telah hancur pelan-pelan kau kembalikan", context),
              const SizedBox(height: 20),
              TeksBiasaBold(
                  "Diperjumpakan dengan akhir dan kerampungan,", context),
              TeksBiasa("mengakhiri perjalanan dan pencarian", context),
              const SizedBox(height: 20),
              TeksBiasa(
                  "Kita akan usai dengan segala tanya dan keraguan,", context),
              TeksBiasa(
                  "menyambut garis selesai dari lamanya penantian", context),
              const SizedBox(height: 20),
              TeksBiasa("Bagaikan tawa yang tak pernah usai,", context),
              TeksBiasa("Semoga kelak dirasakan juga bagi mereka", context),
              TeksBiasaBold(
                  "yang sedang berusaha menuju garis selesai.", context),
              const SizedBox(height: 20),
              TeksBiasa("Semoga lelahmu hari ini", context),
              TeksBiasaBold(
                  "adalah pijakan menuju halal mu esok hari.", context),
              const SizedBox(height: 20),
              TeksBiasa("Semoga yang kau jaga dalam diam,", context),
              TeksBiasaBold(
                  "suatu saat kembali padamu dengan tenang.", context),
              const SizedBox(height: 20),
              TeksBiasa(
                  "Karena cinta yang diperjuangkan dengan sabar,", context),
              TeksBiasa("tak akan hilang..", context),
              TeksBiasaBold(
                  "hanya sedang mencari waktu yang tepat untuk pulang.",
                  context),
              const SizedBox(height: 40),
              TeksBiasa("Kami yang berbahagia", context),
              TeksNamaPengantin("Novia & Ivan", context),
              const SizedBox(height: 40),
              TeksBiasa("Kirim Hadiah ke pengantin.", context),
              const SizedBox(height: 20),
              _bankWidget(context, 'assets/weddingassets/muamalat.png',
                  'Bank Muamalat an IVAN RIFKI NUR ALIF', bankMuamalat),
              _bankWidget(context, 'assets/weddingassets/bsi.png',
                  'Bank BSI an IVAN RIFKI NUR ALIF', bankBSI),
              _bankWidget(context, 'assets/weddingassets/bri.png',
                  'Bank BRI an IVAN RIFKI NUR ALIF', bankBRI),
              const SizedBox(height: 20),
              TeksBiasa("Alamat", context),
              Text(
                "Ini alamat tempat tinggal kita nanti kalau ada yang mau kirim kado 🎁 yaa..",
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.brown[900],
                ),
              ),
              const SizedBox(height: 20),
              TeksBiasa("Penutup", context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankWidget(
      BuildContext context, String assetPath, String bankName, String bankNo) {
    return Builder(
      builder: (BuildContext innerContext) {
        return Column(
          children: [
            Image.asset(
              assetPath,
              fit: BoxFit.contain,
              height: 80,
            ),
            const SizedBox(height: 10),
            TeksBiasa(bankName, context),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(innerContext);
                await Clipboard.setData(ClipboardData(text: bankNo));
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.brown[900],
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                            'Nomor rekening ${bankName.replaceFirst(' an IVAN RIFKI NUR ALIF', '')} berhasil disalin'),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.copy, size: 10),
              label: TeksBiasaBold(bankNo, context),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
