import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
runApp(const BrimoApp());
}

class BrimoApp extends StatelessWidget {
  const BrimoApp({Key? key}) : super(key: key);
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
              _isVisible ? Icons.visibility : Icons.visibility_off,
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

    // bagian yang di perbarui sesuai gambar
    Widget _financialRecord() => _card(
      child: Column(
      children: [
      IntrinsicHeight(
        child: Row(
          children: [
            _stat("Pemasukan", "Rp0", Icons.arrow_downward, Colors.green),
            const VerticalDivider(thickness: 1, color: Color(0xFFEEEEEE)),
            _stat(
              "Pengeluaran",
              "Rp302.500",
              Icons.arrow_upward,
              const Color(0xFFE57373),
            ),
          ],
        ),
      ),
    const SizedBox(height: 16),
    const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
    const SizedBox(height: 12),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Selisih ",
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
        ),
        Text(
          "-Rp302.500",
          style: const TextStyle(
            color: Color(0xFFE57373),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            ),
          ),
         ],
        ),
      ],
    ),
  );

// Helper _stat yang diperbarui
Widget _stat(String l, String v, IconData i, Color c) => Expanded(
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(i, color: c, size: 14),
          const SizedBox(width: 4),
          Text(l, style: TextStyle(color: Colors.grey[500],fontSize: 13))
        ],
      ),
      const SizedBox(height: 4),
      Text(
        v,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    ],
  ),
);

//---HELPERS---

TextStyle _style(double s, Color c, bool b) => TextStyle(
  fontSize: s,
  color: c,
  fontWeight: b ? FontWeight.bold : FontWeight.normal,
);

Widget _sectionTitle(String t, {String? action}) => Padding(
  padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(t, style: _style(16, const Color(0xFF004987), true)),
      if (action != null) Text(action, style: _style(12, Colors.blue, true)),
    ],
  ),
);

Widget _card({required Widget child}) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2)),
    ],
  ),
  child: child,
);

Widget _walletItem(String n, String s, Color c) => Container(
  width: 180,
  margin: const EdgeInsets.only(right: 12),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.black12),
),
child: ListTile(
  leading: CircleAvatar(child: Icon(Icons.wallet, color: c)),
  title: Text(n, style: TextStyle(color: c, fontSize: 12)),
  subtitle: Text(s, style: TextStyle(color: c, fontSize: 12)),
 ),
);

Widget _dot() => Container(
  width: 12,
  height: 12,
  decoration: const BoxDecoration(
    color: Colors.green,
    shape: BoxShape.circle,
    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
  ),
);

Widget _notif() => const Badge(
  label: Text("17"),
  child: Icon(Icons.notifications_none, color: Colors.white),
);

Widget _btnOutline(String t) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 12)),
);

Widget _fab() => FloatingActionButton(
  onPressed: () {},
  backgroundColor: const Color(0xFF005EAA),
  shape: const CircleBorder(),
  child: const Icon(Icons.qr_code_scanner, color: Colors.white),
);

Widget _bottomNav() => BottomAppBar(
  shape: const CircularNotchedRectangle(),
  notchMargin: 8,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _nav(Icons.home, "Home", true),
      _nav(Icons.receipt, "Mutasi", false),
      const SizedBox(width: 40),
      _nav(Icons.mail, "Aktivasi", false),
      _nav(Icons.person, "Akun", false),
    ],
  ),
);

Widget _nav(IconData i, String l, bool a) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(i, color: a ? Colors.blue : Colors.grey),
    Text(
      l,
      style: TextStyle(fontSize: 10, color: a ? Colors.blue : Colors.grey),
    ),
  ],
);
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 25,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    return path..close();
  }

  @override
  bool shouldReclip(oldClipper) => false;
}