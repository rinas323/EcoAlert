import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('could_not_launch_dialer'.tr(args: [phoneNumber]))),
        );
      }
    }
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
            hintText: 'search_hint'.tr(),
            onChanged: (v) => setState(() => _query = v),
            trailing: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() => _query = '');
                },
              ),
            ],
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
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
                    child: Text(m.name[0], style: TextStyle(color: Colors.primaries[index % Colors.primaries.length].shade800, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${m.district} • ${m.category}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () => _makeCall(m.phone),
                    tooltip: 'call_phone'.tr(args: [m.phone]),
                  ),
                  onTap: () {
                    // TODO: Implement municipality details screen
                  },
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
  MunicipalityInfo('Thrissur Corporation', 'Thrissur', 'Municipal Corporation', '+91-487-1234567'),
  MunicipalityInfo('Kollam Corporation', 'Kollam', 'Municipal Corporation', '+91-474-1234567'),
  MunicipalityInfo('Kannur Corporation', 'Kannur', 'Municipal Corporation', '+91-497-1234567'),
  MunicipalityInfo('Palakkad Municipality', 'Palakkad', 'Municipality', '+91-491-1234567'),
  MunicipalityInfo('Malappuram Municipality', 'Malappuram', 'Municipality', '+91-483-1234567'),
  MunicipalityInfo('Pathanamthitta Municipality', 'Pathanamthitta', 'Municipality', '+91-468-1234567'),
  MunicipalityInfo('Kottayam Municipality', 'Kottayam', 'Municipality', '+91-481-1234567'),
  MunicipalityInfo('Idukki Municipality', 'Idukki', 'Municipality', '+91-486-1234567'),
  MunicipalityInfo('Wayanad Municipality', 'Wayanad', 'Municipality', '+91-493-1234567'),
  MunicipalityInfo('Kasargod Municipality', 'Kasargod', 'Municipality', '+91-499-1234567'),
];