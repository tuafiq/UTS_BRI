import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
runApp(const BrimoApp());
}

class BrimoApp extends StatelessWidget {
  const BrimoApp({Key? key}) : super(key: key );
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
      primaryColor: const Color(0xFF005EAA),
    ),
    home: const BrimoHomeScreen(),
  );
}
}

class BrimoHomeScreen extends StatefulWidget {
  const BrimoHomeScreen({Key? key}) : super(key: key);
  @override
  State<BrimoHomeScreen> createState() => _BrimoHomeScreenState();
}

class _BrimoHomeScreenState extends State<BrimoHomeScreen> {
 bool _isVisible = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Stack(
        children: [
          _buildBg(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(),
                  _balance(),
                  const SizedBox(height: 30),
                  _menuGrid(),
                  _sectionTitle("Dompet Digital"),
                  _digitalWallet(),
                  _sectionTitle("Catatan Keuangan", action: "Lihat Detail"),
                  _financialRecord(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNav(),
    );
  }

  // ---REFACToring COMPONENTS---

  Widget _buildBg() => ClipPath(
    clipper: BottomCurveClipper(),
    child: Container(
      height: 380,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00A2E9), Color(0xFF005EAA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ),
  );

  Widget _header() => Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dot(),
        const Text(
          "BRI\nmo",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            height: 0.8,
          ),
        ),
        _notif(),
      ],
    ),
  );
  
  Widget _balance() => Column(
    children: [
      const Text('Saldo Rekening Utama', style: TextStyle(color: Colors.white)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Rp ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          _isVisible
          ? Text('1.234.567', style: _style(18, Colors.white, true))
          :const Text(
            '•••••••',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          IconButton(
            onPressed: () => setState(() => _isVisible = !_isVisible),
            icon: Icon(
              _isVisible ? Icons.visibility : Icons.visibility_off
              color: Colors.white,
              size: 20,
            ),
           ),
         ],
        ),
        _btnOutline("Rekening Lain"),
    ],
  );

  Widget _menuGrid() {
    final menu = [
      ["Tarik Tunai", Icons.payments, const Color(0xFFF47920)],
      ["Transfer", Icons.swap_horiz, const Color(0xFF005EAA)],
      ["BRIZZI", Icons.payment, const Color(0xFF005EAA)],
      [
        "Dompet\nDigital",
        Icons.account_balance_wallet,
        const Color(0xFFF47920),
      ],
      ["Pulsa/Data", Icons.phone_android, const Color(0xFFF47920)],
      ["BRIVA", Icons.credit_card, const Color(0xFF005EAA)],
      ["Listrik", Icons.bolt, const Color(0xFF005EAA)],
      ["Lainnya", Icons.more_horiz, const Color(0xFF005EAA)],
    ];
    return _card(
      child:GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.75,
          ),
          itemCount: menu.length,
          itemBuilder: (_, i) => Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFEAF2FA),
                child: Icon(menu[i][1] as IconData, color: menu[i][2] as Color),
              ),
              const SizedBox(height: 8,),
              Text(
                menu[i][0] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      );
    }

    Widget _digitalWallet() => SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _walletItem("GoPay", "Hubungan", Colors.blue),
          _walletItem("LinkAja", "Segera Hadir", Colors.orange),
        ],
      ),
    );
}