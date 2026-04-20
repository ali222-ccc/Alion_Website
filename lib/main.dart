// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unnecessary_import
import 'dart:ui';

void main() {
  runApp(const AlionTechWebsite());
}

class AlionTechWebsite extends StatelessWidget {
  const AlionTechWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF04060F),
        primaryColor: const Color(0xFF19B2FF),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFFB740FF),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFFAAB4C8),
            height: 1.6,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainAlionPage(),
        '/apps': (context) => const MyAppsPage(),
      },
    );
  }
}

class MainAlionPage extends StatefulWidget {
  const MainAlionPage({super.key});

  @override
  State<MainAlionPage> createState() => _MainAlionPageState();
}

class _MainAlionPageState extends State<MainAlionPage> {
  final GlobalKey _storyKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        title: const Text(
          'ALION',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        actions: [
          if (!isMobile) ...[
            _buildNavLink('Story', () => _scrollToSection(_storyKey)),
            _buildNavLink('Approach', () => _scrollToSection(_contactKey)),
            _buildNavLink('Apps', () => Navigator.pushNamed(context, '/apps')),
          ],
          if (isMobile)
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (value) {
                if (value == 'apps') Navigator.pushNamed(context, '/apps');
                if (value == 'story') _scrollToSection(_storyKey);
                if (value == 'contact') _scrollToSection(_contactKey);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'story', child: Text('Story')),
                const PopupMenuItem(value: 'contact', child: Text('Approach')),
                const PopupMenuItem(value: 'apps', child: Text('Apps')),
              ],
            ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            CompanyStorySection(key: _storyKey),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF19B2FF), width: 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/apps'),
                  child: Text(
                    'EXPLORE OUR MOBILE ECOSYSTEM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ContactSection(key: _contactKey),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [Color(0xFF151D33), Color(0xFF04060F)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/6666666.png',
            height: isMobile ? 250 : 400,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 15),
          Text(
            'Alion',
            style: TextStyle(
              fontSize: isMobile ? 60 : 90,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'REDESIGNING DIGITAL INTERACTION',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: isMobile ? 2 : 6,
                color: Colors.white54,
                fontSize: isMobile ? 12 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyStorySection extends StatelessWidget {
  const CompanyStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        children: [
          _buildResponsiveRow(
            context,
            'Our Unified Purpose',
            'We create digital ecosystems that feel natural and intuitive.',
            true,
            'images/33333333.jpeg',
            isMobile,
          ),
          const SizedBox(height: 100),
          _buildResponsiveRow(
            context,
            'Engineering Excellence',
            'Beyond the interface lies a core of robust, secure, and lightning-fast engineering.',
            false,
            'images/222222.jpeg',
            isMobile,
          ),
          const SizedBox(height: 100),
          _buildResponsiveRow(
            context,
            'Minimalist Aesthetic',
            'We believe that beauty lies in simplicity. Our dark-themed interfaces reduce cognitive load.',
            true,
            'images/11111.jpeg',
            isMobile,
          ),
          const SizedBox(height: 100),
          _buildResponsiveRow(
            context,
            'Global Connectivity',
            'Alion is more than a tech house; it\'s a bridge between your needs and the digital future.',
            false,
            'images/44444.jpeg',
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveRow(
    BuildContext context,
    String title,
    String desc,
    bool imgRight,
    String imgUrl,
    bool isMobile,
  ) {
    var textWidget = Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            color: const Color(0xFFB740FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          desc,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            color: Colors.white70,
            height: 1.6,
          ),
        ),
      ],
    );

    var imgWidget = Container(
      width: isMobile ? double.infinity : 500,
      height: isMobile ? 250 : 300,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.cover),
      ),
    );

    if (isMobile) {
      return Column(
        children: [imgWidget, const SizedBox(height: 30), textWidget],
      );
    }

    return Row(
      children: imgRight
          ? [Expanded(child: textWidget), const SizedBox(width: 60), imgWidget]
          : [imgWidget, const SizedBox(width: 60), Expanded(child: textWidget)],
    );
  }
}

class MyAppsPage extends StatelessWidget {
  const MyAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF04060F), Color(0xFF0A0E21), Color(0xFF04060F)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              backgroundColor: const Color(0xFF04060F).withOpacity(0.8),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'ALION ECOSYSTEM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 40,
                horizontal: isMobile ? 15 : 50,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildModernAppCard(
                    context,
                    isMobile: isMobile,
                    name: 'Cary',
                    subtitle: 'SMART CAR MANAGEMENT',
                    desc:
                        'The ultimate digital companion for car owners. Track expenses, maintenance, and vehicle health score.',
                    imagePath: 'images/image5.png',
                    accentColor: const Color(0xFF19B2FF),
                    playStoreUrl:
                        'https://play.google.com/store/apps/details?id=com.cary.apps',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernAppCard(
    BuildContext context, {
    required bool isMobile,
    required String name,
    required String subtitle,
    required String desc,
    required String imagePath,
    required Color accentColor,
    required String playStoreUrl,
  }) {
    final content = [
      // جانب الصورة
      Expanded(
        flex: isMobile ? 0 : 4,
        child: Container(
          height: isMobile ? 300 : double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor.withOpacity(0.2), Colors.transparent],
              begin: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Container(
              width: isMobile ? 180 : 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.2),
                    blurRadius: 30,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      // جانب البيانات
      Expanded(
        flex: isMobile ? 0 : 6,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 30 : 50),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accentColor,
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontSize: isMobile ? 40 : 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                desc,
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(playStoreUrl)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
                child: const Text(
                  'GET IT NOW',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Container(
      height: isMobile ? null : 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.03),
      ),
      clipBehavior: Clip.antiAlias,
      child: isMobile ? Column(children: content) : Row(children: content),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      color: const Color(0xFF0A0A14),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Connect With Alion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 32 : 45,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Let\'s build the future together',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(
                Icons.facebook,
                'https://www.facebook.com/share/181hNZhcEd/',
              ),
              const SizedBox(width: 30),
              _socialIcon(Icons.mail, 'mailto:alion3919@gmail.com'),
            ],
          ),
          const SizedBox(height: 60),
          Text(
            '© 2026 Alion Tech Solutions.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async => await launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF19B2FF), width: 2),
        ),
        child: Icon(icon, size: 30, color: const Color(0xFF19B2FF)),
      ),
    );
  }
}
