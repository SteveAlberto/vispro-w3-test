import 'package:flutter/material.dart';
import 'models.dart';

class LayarDetail extends StatefulWidget {
  final Langganan langganan;
  final Function() onUbah;

  const LayarDetail({super.key, required this.langganan, required this.onUbah});

  @override
  State<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends State<LayarDetail> {
  @override
  Widget build(BuildContext context) {
    final l = widget.langganan;

    return Scaffold(
      appBar: AppBar(title: Text(l.nama)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Pembayaran: ${l.hitungSudahBayar()} dari ${l.anggota.length} sudah bayar'),
          Text('Iuran Rp ${l.hitungIuran()} / orang'),
          Text('Tagihan tiap tanggal ${l.tanggalTagihan}'),
          const SizedBox(height: 16),
          const Text('Status Anggota'),
          for (int i = 0; i < l.anggota.length; i++)
            CheckboxListTile(
              value: l.anggota[i].sudahBayar,
              title: Text(l.anggota[i].nama),
              onChanged: (nilai) {
                setState(() {
                  l.anggota[i].sudahBayar = nilai!;
                });
                widget.onUbah();
              },
            ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pengingat dikirim!')),
              );
            },
            child: const Text('Ingatkan yang belum bayar'),
          ),
        ],
      ),
    );
  }
}