import 'package:flutter/material.dart';
import 'package:dispora/screen/subsektor.dart';
import 'notifikasi.dart';

class CariSektorScreen extends StatelessWidget {
  const CariSektorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Sektor', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifikasi()),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sektor',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: Icon(Icons.tune, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab('Produk', true),
                  _buildTab('Digital', false),
                  _buildTab('Seni', false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  // Sectors with specific images
                  SectorCard(
                    imagePath: 'assets/kriya.jpg',
                    title: 'Kriya',
                    description: 'Kriya kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '6 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Kriya'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/film_animasi.jpg',
                    title: 'Film, Animasi dan Video',
                    description: 'Industri kreatif dalam produksi film dan animasi...',
                    subSectorCount: '2 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Film, Animasi dan Video'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/kuliner.jpg',
                    title: 'Kuliner',
                    description: 'Bisnis makanan dan minuman khas dari berbagai daerah...',
                    subSectorCount: '2 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Kuliner'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/pengembangan_permainan_image.jpg',
                    title: 'Pengembangan Permainan',
                    description: 'Industri game dan pengembangan aplikasi permainan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Pengembangan Permainan'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/arsitektur.jpg',
                    title: 'Arsitektur',
                    description: 'Perancangan dan pembangunan struktur serta ruang...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Arsitektur'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/desain_interior_image.jpg',
                    title: 'Desain Interior',
                    description: 'Desain interior memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Desain Interior'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/dkv_image.jpg',
                    title: 'Desain Komunikasi Visual',
                    description: 'Desain komunikasi visual memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Desain Komunikasi Visual'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/periklanan_image.jpg',
                    title: 'Periklanan',
                    description: 'Periklanan kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Periklanan'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/seni_kriya_image.jpg',
                    title: 'Seni Kriya',
                    description: 'Seni kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Seni Kriya'),
                        ),
                      );
                    },
                  ),
                  // Use tugu.jpg as fallback for remaining sectors
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Musik',
                    description: 'Musik kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Musik'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Seni Rupa',
                    description: 'Seni rupa memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Seni Rupa'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Desain Produk',
                    description: 'Desain produk memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Desain Produk'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Fashion',
                    description: 'Fashion kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Fashion'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Fotografi',
                    description: 'Fotografi kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Fotografi'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Televisi dan Radio',
                    description: 'Televisi dan radio memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Televisi dan Radio'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Seni Pertunjukan',
                    description: 'Seni pertunjukan memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Seni Pertunjukan'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Penerbitan',
                    description: 'Penerbitan kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Penerbitan'),
                        ),
                      );
                    },
                  ),
                  SectorCard(
                    imagePath: 'assets/tugu.jpg',
                    title: 'Aplikasi',
                    description: 'Aplikasi kriya memiliki berbagai kerajinan tangan...',
                    subSectorCount: '0 Subsektor',
                    onMoreDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubSektorScreen(sectorName: 'Aplikasi'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle tab switch (implement logic if needed)
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class SectorCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String subSectorCount;
  final VoidCallback onMoreDetails;

  const SectorCard({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
    required this.subSectorCount,
    required this.onMoreDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onMoreDetails,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subSectorCount,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          OutlinedButton(
                            onPressed: onMoreDetails,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Selengkapnya"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}