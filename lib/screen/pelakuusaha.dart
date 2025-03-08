import 'package:flutter/material.dart';

class PelakuUsahaScreen extends StatelessWidget {
  const PelakuUsahaScreen({super.key});

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
        title: Text('PELAKU USAHA', style: TextStyle(color: Colors.black)),
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
                'Pelaku Usaha',
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
                  _buildTab('Desain', false),
                  _buildTab('Produk', false),
                  _buildTab('Kuliner', true),
                  _buildTab('seni', false),
                  _buildTab('Fes', false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  PelakuUsahaItem(
                    name: 'Persegi art',
                    description: 'Senri kriya berbahan dasar kayu',
                    subName: 'Yona Persegi',
                    location: 'Bagor, Nganjuk',
                    id: '0897855342464',
                  ),
                  PelakuUsahaItem(
                    name: 'Persegi art',
                    description: 'Senri kriya berbahan dasar kayu',
                    subName: 'Yona Persegi',
                    location: 'Bagor, Nganjuk',
                    id: '0897855342464',
                  ),
                  PelakuUsahaItem(
                    name: 'Persegi art',
                    description: 'Senri kriya berbahan dasar kayu',
                    subName: 'Yona Persegi',
                    location: 'Bagor, Nganjuk',
                    id: '0897855342464',
                  ),
                  PelakuUsahaItem(
                    name: 'Persegi art',
                    description: 'Senri kriya berbahan dasar kayu',
                    subName: 'Yona Persegi',
                    location: 'Bagor, Nganjuk',
                    id: '0897855342464',
                  ),
                  PelakuUsahaItem(
                    name: 'Persegi art',
                    description: 'Senri kriya berbahan dasar kayu',
                    subName: 'Yona Persegi',
                    location: 'Bagor, Nganjuk',
                    id: '0897855342464',
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

class PelakuUsahaItem extends StatelessWidget {
  final String name;
  final String description;
  final String subName;
  final String location;
  final String id;

  const PelakuUsahaItem({super.key, 
    required this.name,
    required this.description,
    required this.subName,
    required this.location,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Handle tap on pelaku usaha
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person_pin,
                size: 40,
                color: Colors.orange[700],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subName,
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            id,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          SizedBox(width: 8),
                          Text(
                            location,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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