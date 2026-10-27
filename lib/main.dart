import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const CarScanProApp());
}

class CarScanProApp extends StatelessWidget {
  const CarScanProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Scan Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFD700), // لون ذهبي 3D فاخر
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFFD700),
          secondary: const Color(0xFFFFA500),
          surface: const Color(0xFF1E1E1E),
        ),
        fontFamily: 'Cairo',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // العربية
        Locale('fr', ''), // الفرنسية
        Locale('en', ''), // الإنجليزية
      ],
      locale: const Locale('ar', ''),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const DiagnosticsTab(),
    const RenaultMasterTab(), // ميزة خاصة لـ رونو ماستار
    const ConnectionTab(),    // قسم البلوتوث والواي فاي
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.directions_car, color: Color(0xFFFFD700)),
            SizedBox(width: 10),
            Text(
              'Car Scan Pro - Pro',
              style: TextStyle(
                color: Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 10.0, color: Colors.amber, offset: Offset(0, 0))
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 4,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'اللوحة'),
          BottomNavigationBarItem(icon: Icon(Icons.healing), label: 'فحص عام'),
          BottomNavigationBarItem(icon: Icon(Icons.car_repair), label: 'رونو ماستار'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_input_antenna), label: 'الاتصال'),
        ],
      ),
    );
  }
}

// 1. لوحة القيادة الحية
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: const [
          DashboardCard(title: 'السرعة', value: '0 كم/س', icon: Icons.speed, color: Colors.blue),
          DashboardCard(title: 'حرارة المحرك', value: '90°C', icon: Icons.thermostat, color: Colors.orange),
          DashboardCard(title: 'جهد البطارية', value: '12.6V (تشحن)', icon: Icons.battery_charging_full, color: Colors.green),
          DashboardCard(title: 'مستوى الوقود', value: '75%', icon: Icons.local_gas_station, color: Colors.amber),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 2. فحص الأخطاء العام مع الأكواد المميزة
class DiagnosticsTab extends StatelessWidget {
  const DiagnosticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.search),
            label: const Text('بدء الفحص الشامل للأخطاء وإزالة الرمز', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: const [
                ErrorCard(code: 'P0300', title: 'خطأ في احتراق الاسطوانة', cause: 'تلف في شمعات الاحتراق (Bujies) أو بخاخات الوقود.'),
                ErrorCard(code: 'P0113', title: 'حساس حرارة الهواء الداخل مرتفع', cause: 'قطع في أسلاك الحساس أو تلف الحساس نفسه.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String code;
  final String title;
  final String cause;

  const ErrorCard({super.key, required this.code, required this.title, required this.cause});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              MainAxisAlignment.spaceBetween
              children: [
                Text(code, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.orange), onPressed: () {}),
              ],
            ),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('السبب المتوقع: $cause', style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// 3. قسم خاص لسيارة رونو ماستار (Renault Master)
class RenaultMasterTab extends StatelessWidget {
  const RenaultMasterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          Text('فحص تخصّصي: Renault Master (الدناصيت / ديزل dCi)', style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          ErrorCard(code: 'DF053', title: 'ضغط الوقود في مسار الحقن (Common Rail)', cause: 'مشكلة في مضخة الوقود عالية الضغط أو تسريب في البخاخات.'),
          ErrorCard(code: 'DF025', title: 'شمعات التسخين (Preheating Plugs)', cause: 'تلف إحدى شمعات التسخين الخاصة بمحركات الديزل الباردة.'),
        ],
      ),
    );
  }
}

// 4. تبويب الاتصال بالبلوتوث والواي فاي (Bluetooth & Wi-Fi OBD2)
class ConnectionTab extends StatelessWidget {
  const ConnectionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.bluetooth, color: Color(0xFFFFD700), size: 30),
            title: Text('اتصال البلوتوث (Bluetooth OBD2)', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('للإصدارات القياسية ELM327 Bluetooth'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
            onPressed: () {},
            child: const Text('بحث والاتصال عبر البلوتوث'),
          ),
          const Divider(height: 40, color: Colors.grey),
          const ListTile(
            leading: Icon(Icons.wifi, color: Color(0xFFFFD700), size: 30),
            title: Text('اتصال الواي فاي (Wi-Fi OBD2)', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('أجهزة OBD2 التي تعمل عبر شبكة الـ Wi-Fi المحلية'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
            onPressed: () {},
            child: const Text('اتصال عبر شبكة الواي فاي (Wi-Fi)'),
          ),
        ],
      ),
    );
  }
}
