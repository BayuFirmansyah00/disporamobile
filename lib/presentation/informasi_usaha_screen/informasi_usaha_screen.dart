import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/app_export.dart';
import 'widgets/informasi_usaha_item_widget.dart';
import '../../models/BusinessModel.dart';
import '../../models/ProdukModel.dart';
import '../../config/Config.dart';
import '../ConversationScreen.dart/ConversationScreen.dart';

class InformasiUsahaScreen extends StatefulWidget {
  final BusinessModel dataUsaha;
  const InformasiUsahaScreen({Key? key, required this.dataUsaha}) : super(key: key);

  @override
  _InformasiUsahaScreenState createState() => _InformasiUsahaScreenState();
}

class _InformasiUsahaScreenState extends State<InformasiUsahaScreen> {
  List<ProdukModel> daftarProduk = [];
  bool isLoading = true;
  String? userRole;
  int? userId;

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _initializeData();
  }

  void _initializeData() {
    setState(() {
      daftarProduk = widget.dataUsaha.daftarProduk ?? [];
      isLoading = false;
    });
    debugPrint('Initialized data - Business ID: ${widget.dataUsaha.id}, Produk Count: ${daftarProduk.length}');
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user_role');
      userId = prefs.getInt('user_id');
      debugPrint('Loaded user data - Role: $userRole, User ID: $userId, Business ID: ${widget.dataUsaha.id}');
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesan tidak boleh kosong')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    debugPrint('Sending message - Token: ${token != null && token.length > 20 ? token.substring(0, 20) : token}..., Recipient ID: ${widget.dataUsaha.id}');
    if (token == null) {
      debugPrint('Token null, redirecting to login');
      _redirectToLogin();
      return;
    }

    if (widget.dataUsaha.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID penerima tidak valid')),
      );
      return;
    }

    final baseUrl = userRole == 'visitor_logged' ? '/visitor' : '/entrepreneur';
    final entrepreneurId = widget.dataUsaha.id.toString();

    try {
      final response = await http.post(
        Uri.parse('${Config.baseApiUrl}$baseUrl/chats'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'recipient_id': entrepreneurId,
          'message': message,
        }),
      );
      debugPrint('API Response - Status: ${response.statusCode}, Body: ${response.body}');
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final threadId = data['thread_id'];
        Navigator.pop(context); // Close the bottom sheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesan berhasil dikirim')),
        );
        _messageController.clear();
        // Navigate to ConversationScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              threadId: threadId,
              partnerId: widget.dataUsaha.id!,
              partnerName: widget.dataUsaha.namaPemilik ?? 'Unknown',
            ),
          ),
        );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesi kedaluwarsa, silakan login ulang')),
        );
        _redirectToLogin();
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Gagal mengirim pesan: ${response.statusCode}')),
        );
      }
    } catch (e) {
      debugPrint('API Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _redirectToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void _showMessageBottomSheet() {
    if (userRole != 'visitor_logged') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus login sebagai pengunjung untuk akses fitur chat')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Kirim Pesan ke Pelaku Usaha',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tulis pesan Anda',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Text('Kirim'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataUsaha.namaUsaha.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Data usaha tidak tersedia")),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        title: const Text("Informasi Usaha"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBusinessInfoRow(context),
                SizedBox(height: 24.h),
                _buildMapSection(context),
                SizedBox(height: 24.h),
                _buildGallerySection(context),
                SizedBox(height: 24.h),
                _buildProductInformationColumn(context),
                if (userRole == 'visitor_logged' || userRole == null || userRole!.isEmpty) ...[
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: _showMessageBottomSheet,
                    child: const Text('Kirim Pesan ke Pelaku Usaha'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessInfoRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          width: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            color: Colors.grey[200],
            image: widget.dataUsaha.logoUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(widget.dataUsaha.logoUrl),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      debugPrint('Gagal load logo: $error');
                    },
                  )
                : null,
          ),
          child: widget.dataUsaha.logoUrl.isEmpty
              ? Icon(Icons.image_not_supported, size: 40, color: Colors.grey)
              : null,
        ),
        SizedBox(width: 16.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dataUsaha.namaUsaha,
                style: CustomTextStyles.titleSmallBluegray900?.copyWith(
                  fontSize: 16.fSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.dataUsaha.sektor,
                style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.dataUsaha.namaPemilik,
                style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 4.h),
              if (widget.dataUsaha.noHp?.isNotEmpty == true)
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgCall,
                      height: 16.h,
                      width: 16.h,
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      widget.dataUsaha.noHp!,
                      style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              SizedBox(height: 4.h),
              if (widget.dataUsaha.alamat?.isNotEmpty == true)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: 'assets/images/Location.png',
                      height: 16.h,
                      width: 16.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Text(
                        widget.dataUsaha.alamat!,
                        style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection(BuildContext context) {
    final bool hasValidCoordinates = widget.dataUsaha.latitude != null &&
        widget.dataUsaha.longitude != null &&
        widget.dataUsaha.latitude! >= -90 &&
        widget.dataUsaha.latitude! <= 90 &&
        widget.dataUsaha.longitude! >= -180 &&
        widget.dataUsaha.longitude! <= 180;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lokasi Usaha",
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: hasValidCoordinates
              ? FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(widget.dataUsaha.latitude!, widget.dataUsaha.longitude!),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(widget.dataUsaha.latitude!, widget.dataUsaha.longitude!),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'Lokasi tidak tersedia',
                    style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    final List<String> galleryImages = [
      '${Config.baseStorageUrl}/pelaku_usaha/contohproduk.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gallery Usaha",
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Berikut beberapa foto mengenai usaha kami",
          style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: galleryImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8.h),
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  image: DecorationImage(
                    image: NetworkImage(galleryImages[index]),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      debugPrint('Gagal load gallery: $error - ${galleryImages[index]}');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductInformationColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informasi Produk",
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Berikut beberapa contoh produk dari usaha kami",
          style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
        isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(child: CircularProgressIndicator()),
              )
            : daftarProduk.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        "Belum ada produk tersedia",
                        style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                  )
                : Column(
                    children: daftarProduk.map((produk) {
                      return InformasiUsahaItemWidget(
                        namaProduk: produk.nama,
                        hargaProduk: produk.harga,
                        informasiProduk: produk.informasi,
                        photo: produk.photo,
                      );
                    }).toList(),
                  ),
      ],
    );
  }
}