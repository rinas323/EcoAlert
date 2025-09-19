import 'package:flutter/material.dart';

class MunicipalityScreen extends StatefulWidget {
  const MunicipalityScreen({super.key});

  @override
  State<MunicipalityScreen> createState() => _MunicipalityScreenState();
}

class _MunicipalityScreenState extends State<MunicipalityScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _mockMunicipalities
        .where((m) => m.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SearchBar(
            controller: _controller,
            leading: const Icon(Icons.search),
            hintText: 'Search municipality, panchayat, or ward',
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final m = items[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  title: Text(m.name),
                  subtitle: Text('${m.district} • ${m.category}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {},
                    tooltip: 'Call ${m.phone}',
                  ),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MunicipalityInfo {
  final String name;
  final String district;
  final String category;
  final String phone;

  const MunicipalityInfo(this.name, this.district, this.category, this.phone);
}

const List<MunicipalityInfo> _mockMunicipalities = [
  MunicipalityInfo('Thiruvananthapuram Corporation', 'Thiruvananthapuram', 'Municipal Corporation', '+91-471-1234567'),
  MunicipalityInfo('Kochi Municipal Corporation', 'Ernakulam', 'Municipal Corporation', '+91-484-1234567'),
  MunicipalityInfo('Alappuzha Municipality', 'Alappuzha', 'Municipality', '+91-477-1234567'),
  MunicipalityInfo('Kozhikode Corporation', 'Kozhikode', 'Municipal Corporation', '+91-495-1234567'),
];
