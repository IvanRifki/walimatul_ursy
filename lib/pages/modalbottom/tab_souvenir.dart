import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:WalimatulUrsy/pages/static.dart';

Widget buildSouvenirCard(BuildContext context, String souvenirStatus,
    String guestCode, String guestName) {
  final isBelum = souvenirStatus.contains('Belum');
  final isSudah = souvenirStatus.contains('Sudah');
  // final guestcode = guestCode;
  // final Souvenirstatus = SouvenirStatus;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.white,
          shadowColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TeksNamaPengantin('Novia & Ivan', context),
                _buildMessageText(isBelum, context),
                const SizedBox(height: 20),
                _buildQrCode(context, guestCode),
                const SizedBox(height: 20),
                TeksBiasaBold(guestCode, context),
                TeksBiasa(guestName, context),
                const SizedBox(height: 20),
                _buildSouvenirStatus(isBelum, isSudah, souvenirStatus),
              ],
            ),
          ),
        ),
        _buildInfoCard(context, isBelum),
      ],
    ),
  );
}

Widget _buildMessageText(bool isBelum, BuildContext context) {
  return isBelum
      ? TeksBiasa('Tukarkan barcode dengan souvenir yang tersedia.', context)
      : TeksBiasa('Terima Kasih Atas Kehadirannya.', context);
}

Widget _buildQrCode(BuildContext context, String guestCode) {
  return SizedBox(
    width: MediaQuery.of(context).size.width > 600
        ? 300
        : MediaQuery.of(context).size.width * 0.5,
    child: Tilt(
      shadowConfig: const ShadowConfig(disable: true),
      childLayout: ChildLayout(outer: [
        TiltParallax(
          size: const Offset(15, 20),
          child: PrettyQrView.data(
            data: guestCode,
            decoration:
                const PrettyQrDecoration(quietZone: PrettyQrQuietZone.zero),
          ),
        )
      ]),
      child: TiltParallax(
        size: const Offset(15, 20),
        child: PrettyQrView.data(
          data: guestCode,
          decoration:
              const PrettyQrDecoration(quietZone: PrettyQrQuietZone.zero),
        ),
      ),
    ),
  );
}

Widget _buildSouvenirStatus(bool isBelum, bool isSudah, String souvenirStatus) {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: const Radius.circular(10),
    dashPattern: const [5, 5],
    color: isSudah ? Colors.green : Colors.brown[900]!,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Souvenir${isBelum ? ': ' : ' : '}',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSudah ? Colors.green : Colors.brown[900],
            )),
        isSudah
            ? const Icon(Icons.check_circle, color: Colors.green, size: 16)
            : const Icon(Icons.info, color: Colors.brown, size: 16),
        const SizedBox(width: 5),
        Text(souvenirStatus,
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: 2,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSudah ? Colors.green : Colors.brown[900],
              fontWeight: isSudah ? FontWeight.bold : null,
            )),
      ],
    ),
  );
}

Widget _buildInfoCard(BuildContext context, bool isBelum) {
  return Card(
    shadowColor: Colors.transparent,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 5],
        color: Colors.pink,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoRow('Tunjukan QR Code ini kepada petugas souvenir'),
                const SizedBox(height: 10),
                _buildInfoRow('1 (satu) Souvenir untuk 1 (satu) tamu undangan'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildInfoRow(String text) {
  return Row(
    children: [
      const Icon(Icons.circle, size: 12, color: Colors.pink),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.brown[900],
            fontStyle: FontStyle.italic,
          ),
          softWrap: true,
        ),
      ),
    ],
  );
}
