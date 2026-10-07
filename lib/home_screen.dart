import 'package:flutter/material.dart';
import 'models.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class LayarAwal extends StatefulWidget {
  const LayarAwal({super.key});

  @override
  State<LayarAwal> createState() => _LayarAwalState();
}

class _LayarAwalState extends State<LayarAwal> {
  final List<Langganan> _daftarLangganan = [
    Langganan('Netflix Premium', 47000, 5, [
      Anggota('Saya', true),
      Anggota('Andi', true),
      Anggota('Budi', false),
      Anggota('Fina', false),
      Anggota('Dina', false),
    ]),
    Langganan('Spotify Family', 29000, 12, [
      Anggota('Saya', true),
      Anggota('Andi', true),
      Anggota('Budi', true),
      Anggota('Fina', true),
    ]),
  ];

  void _tambahLangganan(Langganan baru) {
    setState(() {
      _daftarLangganan.add(baru);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${baru.nama} ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    int totalTagihan = 0;
    int belumLunas = 0;
    for (int i = 0; i < _daftarLangganan.length; i++) {
      totalTagihan = totalTagihan + _daftarLangganan[i].harga;
      if (!_daftarLangganan[i].sudahLunas()) {
        belumLunas = belumLunas + 1;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Patungan Langganan')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Card.filled(
              color: scheme.primaryContainer,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Tagihan',
                      style: text.labelLarge
                          ?.copyWith(color: scheme.onPrimaryContainer),
                    ),
                    Text(
                      'Rp $totalTagihan',
                      style: text.displaySmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$belumLunas langganan belum lunas',
                      style: text.bodyMedium
                          ?.copyWith(color: scheme.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Daftar Patungan Aktif', style: text.titleMedium),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _daftarLangganan.length,
              itemBuilder: (context, index) {
                final item = _daftarLangganan[index];
                final lunas = item.sudahLunas();

                return Card.outlined(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LayarDetail(
                            langganan: item,
                            onUbah: () {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    leading: const Icon(Icons.subscriptions),
                    title: Text(item.nama, style: text.titleMedium),
                    subtitle: Align(
                      alignment: Alignment.centerLeft,
                      child: Chip(
                        label: Text(item.teksStatus()),
                        backgroundColor: lunas
                            ? scheme.secondaryContainer
                            : scheme.errorContainer,
                        side: BorderSide.none,
                      ),
                    ),
                    trailing: Text('Rp ${item.harga}', style: text.titleMedium),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LayarTambah(onSimpan: _tambahLangganan),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}