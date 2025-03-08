import 'package:dispora/screen/carisektor.dart';
import 'package:flutter/material.dart';
import 'notifikasi.dart'; // Existing import
import 'carisektor.dart'; // New import for CariSektor

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeaderSection(context),
            _buildMainBanner(context),
            _buildCategoriesSection(context),
            _buildEventSection(context),
            _buildSectorsSection(context),
            // Add "Selengkapnya" button after sectors section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CariSektorScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Selengkapnya',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue, size: 20),
                  SizedBox(width: 4),
                  Text(
                    'Kec. Wilangan, Nganjuk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.grey, size: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifikasi()),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBanner(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A8A), Color(0xFF4B5EAA)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EKONOMI KREATIF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              Text(
                'KABUPATEN NGANJUK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Kunjungi situs web kami',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/home_banner_icon.png',
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Wrap(
            spacing: MediaQuery.of(context).size.width * 0.03,
            runSpacing: MediaQuery.of(context).size.height * 0.015,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              _buildCategoryItem('Musik', Icons.music_note, context),
              _buildCategoryItem('Arsitektur', Icons.architecture, context),
              _buildCategoryItem('Kuliner', Icons.fastfood, context),
              _buildCategoryItem('Fotografi', Icons.photo, context),
              _buildCategoryItem('Aplikasi', Icons.apps, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.deepPurple.withOpacity(0.1),
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon, color: Colors.deepPurple),
            iconSize: MediaQuery.of(context).size.width * 0.08,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
        ),
      ],
    );
  }

  Widget _buildEventSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Event',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildEventCard(
            'Mimi on The Street',
            'assets/mimi_event.jpg',
            'KAK YUDHA, BAYI MINE 2023, 20 FEBRUARI 2023, GUDANG ALUN-ALUN NGAJUK',
            context,
          ),
          _buildEventCard(
            'Java Tech',
            'assets/javatech_event.jpg',
            'Seminar Teknologia, Berbagi Ilmu',
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String imagePath, String description, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    onPressed: () {},
                    child: Text(
                      'Selengkapnya',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectorsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '17 Sektor Ekonomi Kreatif',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Wrap(
            spacing: MediaQuery.of(context).size.width * 0.02,
            runSpacing: MediaQuery.of(context).size.height * 0.015,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              _buildSectorItem('Desain komunikasi visual', 'assets/dkv_image.jpg', context),
              _buildSectorItem('Seni kriya', 'assets/seni_kriya_image.jpg', context),
              _buildSectorItem('Periklanan', 'assets/periklanan_image.jpg', context),
              _buildSectorItem('Desain interior', 'assets/desain_interior_image.jpg', context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectorItem(String label, String imagePath, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
            ),
          ],
        ),
      ),
    );
  }
}