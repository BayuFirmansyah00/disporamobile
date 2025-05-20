import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_switch.dart';
import '../../presentation/notification_service/widgets/local_storage_service.dart'; // Import LocalStorageService
import '../../../main.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    _removeOverlay();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _removeOverlay();
  }

  @override
  void didPushNext() {
    _removeOverlay();
  }

  @override
  void didPopNext() {
    _removeOverlay();
  }

  Future<void> _savePreferences() async {
    try {
      // Save notification setting using LocalStorageService
      await LocalStorageService.setNotificationEnabled(isSelectedSwitch);
      // Save language setting directly (LocalStorageService doesn't handle this)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', selectedLanguage);
      print(
        'Preferences saved: notif_enabled=$isSelectedSwitch, language=$selectedLanguage',
      );
    } catch (e) {
      print('Error saving preferences: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan preferensi: $e')),
      );
    }
  }

  Future<void> _loadPreferences() async {
    try {
      // Load notification setting using LocalStorageService
      final isNotifEnabled = await LocalStorageService.isNotificationEnabled();
      // Load language setting directly
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isSelectedSwitch = isNotifEnabled;
        selectedLanguage = prefs.getString('language') ?? 'Indonesia';
        print(
          'Preferences loaded: notif_enabled=$isSelectedSwitch, language=$selectedLanguage',
        );
      });
    } catch (e) {
      print('Error loading preferences: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat preferensi: $e')),
      );
    }
  }

  bool isSelectedSwitch = true;
  String selectedLanguage = "Indonesia";

  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {});
      print('Dropdown overlay removed');
    }
  }

  void _showDropdown(BuildContext context) {
    if (_dropdownKey.currentContext == null) {
      print('Dropdown key context is null');
      return;
    }

    final RenderBox? renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      print('RenderBox is null');
      return;
    }

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    const double dropdownWidth = 160;

    _removeOverlay(); // Ensure previous overlay is removed

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + size.width - dropdownWidth,
        top: offset.dy + size.height + 5,
        width: dropdownWidth,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['Indonesia', 'English'].map((lang) {
                bool isSelected = selectedLanguage == lang;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = lang;
                    });
                    _savePreferences();
                    _updateLocale(lang); // Update app language
                    _removeOverlay();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF123458)
                          : const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          lang,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
    print('Dropdown overlay shown');
  }

  void _updateLocale(String language) {
    Locale newLocale;
    switch (language) {
      case 'English':
        newLocale = const Locale('en', 'US');
        break;
      case 'Indonesia':
      default:
        newLocale = const Locale('id', 'ID');
        break;
    }

    // Update the app's locale
    // MyApp.of(context)?.setLocale(newLocale);
    print('Locale updated to: $newLocale');
  }

  Future<void> _copyEmailToClipboard(String email) async {
    await FlutterClipboard.copy(email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email disalin ke clipboard')),
    );
  }

  Future<void> _openEmailApp(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Pertanyaan dari Ekraf Kuy'},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka aplikasi email')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 28.h, top: 60.h, right: 28.h),
          child: Column(
            children: [
              _buildNotificationSettings(context),
              // SizedBox(height: 30.h),
              // _buildLanguageSettings(context),
              SizedBox(height: 30.h),
              _buildSupportContact(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Notifikasi
  Widget _buildNotificationSettings(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.h),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      width: double.maxFinite,
      child: SwitchListTile(
        title: Text("Notifikasi", style: theme.textTheme.bodyLarge),
        secondary: CustomIconButton(
          height: 60.h,
          width: 60.h,
          padding: EdgeInsets.all(6.h),
          decoration: IconButtonStyleHelper.none,
          child: const Icon(Icons.notifications, size: 30, color: Colors.black),
        ),
        value: isSelectedSwitch,
        onChanged: (value) async {
          setState(() {
            isSelectedSwitch = value;
            print('Notification switch changed to: $value');
          });
          await _savePreferences();
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 8.h),
      ),
    );
  }

  /// Bahasa
  // Widget _buildLanguageSettings(BuildContext context) {
  //   return CompositedTransformTarget(
  //     link: _layerLink,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.h),
  //       decoration: AppDecoration.fillBlueGray.copyWith(
  //         borderRadius: BorderRadiusStyle.roundedBorder16,
  //       ),
  //       width: double.maxFinite,
  //       child: Row(
  //         children: [
  //           CustomIconButton(
  //             height: 60.h,
  //             width: 60.h,
  //             padding: EdgeInsets.all(6.h),
  //             decoration: IconButtonStyleHelper.none,
  //             child: const Icon(Icons.language, size: 30, color: Colors.black),
  //           ),
  //           SizedBox(width: 8.h),
  //           Text("Bahasa", style: theme.textTheme.bodyLarge),
  //           const Spacer(),
  //           GestureDetector(
  //             key: _dropdownKey,
  //             onTap: () {
  //               if (_overlayEntry == null) {
  //                 _showDropdown(context);
  //               } else {
  //                 _removeOverlay();
  //               }
  //             },
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFD9D9D9),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     selectedLanguage,
  //                     style: theme.textTheme.bodyLarge?.copyWith(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   SizedBox(width: 8.h),
  //                   Icon(
  //                     _overlayEntry == null
  //                         ? Icons.keyboard_arrow_down
  //                         : Icons.keyboard_arrow_up,
  //                     size: 20,
  //                     color: Colors.black,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Hubungi Kami
  Widget _buildSupportContact(BuildContext context) {
    const String supportEmail = 'support@ekrafkuy.com';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.h),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          CustomIconButton(
            height: 60.h,
            width: 60.h,
            padding: EdgeInsets.all(6.h),
            decoration: IconButtonStyleHelper.none,
            child: const Icon(Icons.email, size: 30, color: Colors.black),
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hubungi Kami", style: theme.textTheme.bodyLarge),
                GestureDetector(
                  onTap: () => _openEmailApp(supportEmail),
                  child: Text(
                    supportEmail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 20, color: Colors.black),
            onPressed: () => _copyEmailToClipboard(supportEmail),
          ),
        ],
      ),
    );
  }
}