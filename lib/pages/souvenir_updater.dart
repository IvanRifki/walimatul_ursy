import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final _kodeController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Souvenir")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kodeController,
              decoration: InputDecoration(
                labelText: "Kode Undangan",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _cariBarisKodeUndangan(_kodeController.text);
              },
              child: Text("Cari"),
            ),
            SizedBox(height: 20),
            if (_foundRow != null) ...[
              Text("✅ Kode ditemukan di baris $_foundRow"),
              if (_foundGuestData != null) ...[
                Text("Kode: ${_foundGuestData!['Kode']}"),
                Text("Title: ${_foundGuestData!['Title']}"),
                Text("Nama: ${_foundGuestData!['Nama']}"),
                Text("Souvenir: ${_foundGuestData!['Souvenir']}"),
              ],
              // DropdownButtonFormField<String>(
              //   value: _statusTerpilih,
              //   items: _statusList
              //       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              //       .toList(),
              //   onChanged: (val) {
              //     setState(() {
              //       _statusTerpilih = val;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     labelText: "Pilih Status Souvenir",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ElevatedButton.icon(
                  //   icon: Icon(Icons.save),
                  //   label: Text("Update Status"),
                  //   onPressed: _statusTerpilih != null
                  //       ? () => updateSouvenirStatus(_foundRow!, _statusTerpilih!)
                  //       : null,
                  // ),
                  ElevatedButton.icon(
                      icon: Icon(Icons.check_circle),
                      label: Text("Ambil Souvenir"),
                      onPressed: () =>
                          updateSouvenirStatus(_foundRow!, 'Sudah Diambil')),
                  ElevatedButton.icon(
                    icon: Icon(Icons.cancel),
                    label: Text("Batal"),
                    onPressed: () =>
                        updateSouvenirStatus(_foundRow!, 'Belum Diambil'),
                  )
                ],
              ),
            ],
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
