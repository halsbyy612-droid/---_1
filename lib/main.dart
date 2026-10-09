
import 'package:flutter/material.dart';

void main() {
  runApp(const SpeedConverterApp());
}

class SpeedConverterApp extends StatelessWidget {
  const SpeedConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'محوّل السرعة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        colorScheme: const ColorScheme.dark(
          primary: const Color(0xFF6C5CE7),
          surface: const Color(0xFF181824),
        ),
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedFps = 60;
  bool _enableMotionBlur = true;
  double _speedValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181824),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Speed Converter',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة اختيار / معاينة الفيديو
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF181824),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF6C5CE7).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: InkWell(
                onTap: () {
                  // فتح مستعرض الملفات
                },
                borderRadius: BorderRadius.circular(20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF262636),
                      child: Icon(Icons.video_call_rounded, size: 35, color: Color(0xFF6C5CE7)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'اختر فيديو لمعالجته',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'يدعم MP4, MOV حتى 4K',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // إعدادات معدل الإطارات (FPS)
            const Text(
              'معدل الإطارات (FPS)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [30, 60, 120].map((fps) {
                final isSelected = _selectedFps == fps;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '$fps FPS',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF6C5CE7),
                      backgroundColor: const Color(0xFF181824),
                      onSelected: (val) {
                        if (val) setState(() => _selectedFps = fps);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // التحكم في السرعة (Speed)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'سرعة التشغيل',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_speedValue.toStringAsFixed(1)}x',
                  style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Slider(
              value: _speedValue,
              min: 0.25,
              max: 2.0,
              divisions: 7,
              activeColor: const Color(0xFF6C5CE7),
              inactiveColor: const Color(0xFF262636),
              onChanged: (val) => setState(() => _speedValue = val),
            ),
            const SizedBox(height: 16),

            // خيار ضبابية الحركة (Motion Blur)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF181824),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SwitchListTile(
                title: const Text('ضبابية الحركة (Motion Blur)'),
                subtitle: const Text('تنعيم الحركات السريعة بأسلوب احترافي', style: TextStyle(fontSize: 12)),
                value: _enableMotionBlur,
                activeColor: const Color(0xFF6C5CE7),
                onChanged: (val) => setState(() => _enableMotionBlur = val),
              ),
            ),
            const SizedBox(height: 32),

            // زر البدء بالمعالجة
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProcessingScreen(fps: _selectedFps)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'بدء التصدير والمعالجة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// شاشة المعالجة والحفظ
class ProcessingScreen extends StatelessWidget {
  final int fps;
  const ProcessingScreen({super.key, required this.fps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('جاري المعالجة...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: 10,
                    color: Color(0xFF6C5CE7),
                    backgroundColor: Color(0xFF181824),
                  ),
                ),
                Text(
                  '65%',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'جاري تحويل الفيديو إلى $fps FPS...',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'يرجى عدم إغلاق التطبيق أثناء التصدير',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 60),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إلغاء العملية'),
            ),
          ],
        ),
      ),
    );
  }
}

