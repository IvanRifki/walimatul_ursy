import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MaterialApp(
    home: SouvenirUpdaterApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class SouvenirUpdaterApp extends StatefulWidget {
  // const SouvenirUpdaterApp({Key? key}) : super(key: key);
  const SouvenirUpdaterApp({super.key});

  @override
  _SouvenirUpdaterAppState createState() => _SouvenirUpdaterAppState();
}

class _SouvenirUpdaterAppState extends State<SouvenirUpdaterApp> {
  late final _kodeController = TextEditingController();
  String? _statusTerpilih;
  bool _isLoading = false;
  int? _foundRow;
  Map<String, dynamic>? _foundGuestData;

  final List<String> _statusList = ["Belum diambil", "Sudah Diambil", "-"];

  // URL endpoint ambil semua data (ini link Google Apps Script)
  final _fetchUrl = "https://souvenir-updater.vercel.app/api/guests";

  final _updateUrl = "https://souvenir-updater.vercel.app/api/update-souvenir";

  List<List<dynamic>> _spreadsheetData = [];

  // Future<void> _fetchSpreadsheetData() async {
  //   setState(() => _isLoading = true);
  //   final response = await http.get(Uri.parse(_fetchUrl));
  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     setState(() {
  //       _spreadsheetData = List<List<dynamic>>.from(
  //         jsonData.map((row) => List<dynamic>.from(row)),
  //       );
  //     });
  //   } else {
  //     print("Gagal ambil data");
  //   }
  //   setState(() => _isLoading = false);
  // }

  Future<void> _fetchSpreadsheetData() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('https://souvenir-updater.vercel.app/api/guests'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        setState(() {
          _spreadsheetData = jsonData
              .map((guest) => [
                    guest['No ']?.toString() ?? '',
                    guest['Kode Undangan']?.toString() ?? '',
                    guest['Title']?.toString() ?? '',
                    guest['Nama Undangan']?.toString() ?? '',
                    guest['Alamat']?.toString() ?? '',
                    guest['Relasi']?.toString() ?? '',
                    guest['Link Undangan (Using Kode Undangan)']?.toString() ??
                        '',
                    guest['Souvenir']?.toString() ??
                        '-', // Default value jika null
                  ])
              .toList();
        });
      } else {
        print('Gagal ambil data: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Tambahkan handling error ke user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _cariBarisKodeUndangan(String kode) async {
    await _fetchSpreadsheetData();

    final rowIndex = _spreadsheetData.indexWhere(
        (row) => row.length > 1 && row[1].toString().trim() == kode.trim());

    if (rowIndex != -1) {
      final row = _spreadsheetData[rowIndex];
      setState(() {
        _foundRow = rowIndex + 1; // Tambah 1 karena header + index 0
        _foundGuestData = {
          'Kode': row[1],
          'Title': row[2],
          'Nama': row[3],
          'Souvenir': row[7],
        };
      });
    } else {
      setState(() {
        _foundRow = null;
        _foundGuestData = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kode undangan tidak ditemukan")),
      );
    }
  }

  Future<void> updateSouvenirStatus(int row, String status) async {
    try {
      final url = Uri.parse(_updateUrl);

      final response = await http.post(
        url,
        // headers: {"Content-Type": "application/json"},
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },

        body: jsonEncode({"row": row, "status": status}),
      );

      if (response.statusCode == 200) {
        _cariBarisKodeUndangan(_kodeController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Sukses update souvenir")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "❌ Gagal update: ${response.statusCode} - ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  Barcode? _barcode;

  Widget _barcodePreview(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  // void _handleBarcode(BarcodeCapture barcodes) {
  //   if (mounted) {
  //     setState(() {
  //       _barcode = barcodes.barcodes.firstOrNull;
  //     });
  //   }
  // }
  void _handleBarcode(BarcodeCapture barcodes) {
    if (barcodes.barcodes.isNotEmpty) {
      final scannedValue = barcodes.barcodes.first.displayValue;
      if (scannedValue != null && mounted) {
        setState(() {
          _barcode = barcodes.barcodes.first;
          _kodeController.text = scannedValue; // Auto-fill ke text field
        });
        _cariBarisKodeUndangan(scannedValue); // Auto-cari langsung
      }
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _kodeController.dispose();
    super.dispose();
  }

  Widget _buildScanner() {
    return MobileScanner(onDetect: _handleBarcode);
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Update Souvenir")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildScanner(),
//             TextField(
//               controller: _kodeController,
//               decoration: InputDecoration(
//                 labelText: "Kode Undangan",
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _cariBarisKodeUndangan(_kodeController.text);
//               },
//               child: Text("Cari"),
//             ),
//             SizedBox(height: 20),
//             if (_foundRow != null) ...[
//               Text("✅ Kode ditemukan di baris $_foundRow"),
//               if (_foundGuestData != null) ...[
//                 Text("Kode: ${_foundGuestData!['Kode']}"),
//                 Text("Title: ${_foundGuestData!['Title']}"),
//                 Text("Nama: ${_foundGuestData!['Nama']}"),
//                 Text("Souvenir: ${_foundGuestData!['Souvenir']}"),
//               ],
//               // DropdownButtonFormField<String>(
//               //   value: _statusTerpilih,
//               //   items: _statusList
//               //       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//               //       .toList(),
//               //   onChanged: (val) {
//               //     setState(() {
//               //       _statusTerpilih = val;
//               //     });
//               //   },
//               //   decoration: InputDecoration(
//               //     labelText: "Pilih Status Souvenir",
//               //     border: OutlineInputBorder(),
//               //   ),
//               // ),
//               // SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // ElevatedButton.icon(
//                   //   icon: Icon(Icons.save),
//                   //   label: Text("Update Status"),
//                   //   onPressed: _statusTerpilih != null
//                   //       ? () => updateSouvenirStatus(_foundRow!, _statusTerpilih!)
//                   //       : null,
//                   // ),
//                   ElevatedButton.icon(
//                     icon: _isLoading
//                         ? CircularProgressIndicator(strokeWidth: 2)
//                         : Icon(Icons.check_circle),
//                     label: Text("Ambil Souvenir"),
//                     onPressed: (_foundRow != null)
//                         ? () =>
//                             updateSouvenirStatus(_foundRow!, 'Sudah Diambil')
//                         : null,

//                     // onPressed: () =>
//                     //     updateSouvenirStatus(_foundRow!, 'Sudah Diambil'),
//                   ),
//                   ElevatedButton.icon(
//                     icon: _isLoading
//                         ? CircularProgressIndicator(strokeWidth: 2)
//                         : Icon(Icons.cancel),
//                     label: const Text("Batal"),
//                     onPressed: (_foundRow != null)
//                         ? () =>
//                             updateSouvenirStatus(_foundRow!, 'Belum Diambil')
//                         : null,

//                     // onPressed: () =>
//                     //     updateSouvenirStatus(_foundRow!, 'Belum Diambil'),
//                   )
//                 ],
//               ),
//             ],
//             if (_isLoading) CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }

  final MobileScannerController _cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Scan Kode Undangan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TAMPILKAN KAMERA DI SINI
            AspectRatio(
              aspectRatio: 1, // Kotak (1:1)
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MobileScanner(
                    controller: _cameraController,
                    onDetect: _handleBarcode,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TEXTFIELD INPUT MANUAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _kodeController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelText: 'Kode Undangan',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TOMBOL CARI & AMBIL SOUVENIR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _cariBarisKodeUndangan(_kodeController.text);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Cari"),
                ),
                ElevatedButton.icon(
                  onPressed: (_foundRow != null && !_isLoading)
                      ? () => updateSouvenirStatus(_foundRow!, 'Sudah Diambil')
                      : null,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.card_giftcard),
                  label: const Text("Ambil Souvenir"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // INFO TAMPILAN
            if (_foundGuestData != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: ListTile(
                    title: Text(_foundGuestData!['Nama'] ?? 'Tidak ada nama'),
                    subtitle: Text("Status: ${_foundGuestData!['Souvenir']}"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
