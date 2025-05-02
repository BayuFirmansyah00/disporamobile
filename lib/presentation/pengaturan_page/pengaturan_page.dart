import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  _removeOverlay(); // solusi anti-pusing
}

  @override
  void didPushNext() {
    _removeOverlay(); // saat pindah halaman
  }

  @override
  void didPopNext() {
    _removeOverlay(); // saat kembali ke halaman
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif', isSelectedSwitch);
    await prefs.setString('language', selectedLanguage);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedSwitch = prefs.getBool('notif') ?? true;
      selectedLanguage = prefs.getString('language') ?? 'Indonesia';
    });
  }

  bool isSelectedSwitch = true;
  String selectedLanguage = "Indonesia";

  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }

  void _showDropdown(BuildContext context) {
    final RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    double dropdownWidth = 160;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx + size.width - dropdownWidth,
            top:
                offset.dy +
                size.height +
                5, // turun sedikit biar gak nabrak box
            width: dropdownWidth,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      ['Indonesia', 'English'].map((lang) {
                        bool isSelected = selectedLanguage == lang;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLanguage = lang;
                            });
                            _savePreferences();
                            _removeOverlay();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Color(0xFF123458)
                                      : Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  lang,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Spacer(),
                                if (isSelected)
                                  Icon(
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
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // ambil preferensi saat halaman dibuka
  }

  // @override
  // void dispose() {
  //   _removeOverlay();
  //   super.dispose();
  // }

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
              SizedBox(height: 30.h),
              _buildLanguageSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Notifikasi
  Widget _buildNotificationSettings(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconButton(
            height: 60.h,
            width: 60.h,
            padding: EdgeInsets.all(6.h),
            decoration: IconButtonStyleHelper.none,
            child: CustomImageView(imagePath: ImageConstant.notif),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text("Notifikasi", style: theme.textTheme.bodyLarge),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: CustomSwitch(
              value: isSelectedSwitch,
              onChange: (value) {
                setState(() {
                  isSelectedSwitch = value;
                });
                _savePreferences();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Bahasa
  Widget _buildLanguageSettings(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
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
              child: CustomImageView(imagePath: ImageConstant.language),
            ),
            SizedBox(width: 8.h),
            Text("Bahasa", style: theme.textTheme.bodyLarge),
            Spacer(),
            GestureDetector(
              key: _dropdownKey,
              onTap: () {
                if (_overlayEntry == null) {
                  _showDropdown(context);
                } else {
                  _removeOverlay();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedLanguage,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.h),
                    Icon(
                      _overlayEntry == null
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}