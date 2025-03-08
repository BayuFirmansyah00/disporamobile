import 'package:flutter/material.dart';

class SubSektorScreen extends StatelessWidget {
  final String sectorName;

  const SubSektorScreen({super.key, required this.sectorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Sub Sektor', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button tap
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                sectorName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab('Produk', true),
                  _buildTab('Digital', false),
                  _buildTab('seni', false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  SubSectorItem(
                    title: 'Bahan Dasar Kayu',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '11 Pengusaha',
                  ),
                  SubSectorItem(
                    title: 'Bahan Dasar Logam',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '4 Pengusaha',
                  ),
                  SubSectorItem(
                    title: 'Bahan Dasar Kaca',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '1 Pengusaha',
                  ),
                  SubSectorItem(
                    title: 'Bahan Dasar Keramik',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '0 Pengusaha',
                  ),
                  SubSectorItem(
                    title: 'Bahan Dasar Kulit',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '3 Pengusaha',
                  ),
                  SubSectorItem(
                    title: 'Bahan Dasar Tekstil',
                    description: 'Seniman kriya memiliki banyak berbagaiberbagaikerajinan tangan...',
                    entrepreneurCount: '12 Pengusaha',
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
        // Handle tab switch
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

class SubSectorItem extends StatelessWidget {
  final String title;
  final String description;
  final String entrepreneurCount;

  const SubSectorItem({super.key, 
    required this.title,
    required this.description,
    required this.entrepreneurCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Handle tap on sub-sector
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[300], // Placeholder untuk gambar
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
                      Text(
                        entrepreneurCount,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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