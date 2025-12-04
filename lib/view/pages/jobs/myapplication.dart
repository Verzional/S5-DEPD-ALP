import 'dart:ui'; // Diperlukan untuk BackdropFilter (efek blur modal)
import 'dart:math'; // Diperlukan untuk logika pagination
import 'package:flutter/material.dart';

// --- IMPORT MODEL DAN DATA ---
import '../models/application_model.dart';
import '../data/dummy_data.dart';
// Jika Anda masih memisahkan modal di file lain, import di sini.
// Jika sudah digabung di bawah, tidak perlu import file modal.
// import 'application_detail_modal.dart';

// ================= KONSTANTA WARNA =================
class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color whiteCard = Colors.white;
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);
  static const Color statusGreen = Color(0xFF4CD964);
  static const Color statusYellow = Color(0xFFFFCC00);
  static const Color statusBlue = Color(0xFF5856D6);
  static const Color statusRed = Color(0xFFFF3B30);
  static const Color primaryOrange = Color(0xFFFF6B6B);
  static const Color textLightGrey = Color(0xFFB2B2B2);
}

// ================= TEXT STYLES =================
class TextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.textGrey,
  );
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle badgeText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

// ================= HALAMAN UTAMA =================
class MyApplicationPage extends StatefulWidget {
  const MyApplicationPage({super.key});

  @override
  State<MyApplicationPage> createState() => _MyApplicationPageState();
}

class _MyApplicationPageState extends State<MyApplicationPage> {
  // --- STATE VARIABLES ---
  final List<String> _selectedStatuses = [];
  bool _isStatusExpanded = true;
  final TextEditingController _searchCtrl = TextEditingController();
  String _activeSearchQuery = "";

  // --- PAGINATION STATE ---
  int _currentPage = 1;
  static const int _itemsPerPage = 5; // Tampilkan 5 per halaman

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _toggleStatusFilter(String status, bool? value) {
    setState(() {
      if (value == true) {
        _selectedStatuses.add(status);
      } else {
        _selectedStatuses.remove(status);
      }
      _currentPage = 1; // Reset halaman saat filter berubah
    });
  }

  void _performSearch() {
    setState(() {
      _activeSearchQuery = _searchCtrl.text.toLowerCase();
      _currentPage = 1; // Reset halaman saat search
    });
  }

  void _resetSearch() {
    setState(() {
      _searchCtrl.clear();
      _activeSearchQuery = "";
      _currentPage = 1;
    });
  }

  // --- LOGIC: Filter Data Utama ---
  List<ApplicationModel> get _filteredList {
    return dummyApplications.where((app) {
      // 0. CEK USER ID (BARU)
      // Hanya tampilkan lamaran milik User yang sedang Login (currentUser)
      if (app.userId != currentUser.id) {
        return false; // Skip data orang lain
      }

      // 1. Cek Status
      bool statusMatch = true;
      if (_selectedStatuses.isNotEmpty) {
        statusMatch = _selectedStatuses.contains(app.status);
      }

      // 2. Cek Search Query
      bool searchMatch = true;
      if (_activeSearchQuery.isNotEmpty) {
        searchMatch = app.jobTitle.toLowerCase().contains(_activeSearchQuery) ||
                      app.companyName.toLowerCase().contains(_activeSearchQuery);
      }

      return statusMatch && searchMatch;
    }).toList();
  }

  // --- LOGIC: Pagination Slicing ---
  List<ApplicationModel> get _paginatedList {
    final all = _filteredList;
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    if (startIndex >= all.length) return [];
    final endIndex = (startIndex + _itemsPerPage < all.length)
        ? startIndex + _itemsPerPage
        : all.length;
    return all.sublist(startIndex, endIndex);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Diterima":
        return AppColors.statusGreen;
      case "Ditinjau":
        return AppColors.statusYellow;
      case "Wawancara":
        return AppColors.statusBlue;
      case "Ditolak":
        return AppColors.statusRed;
      default:
        return AppColors.textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _filteredList;
    final totalItems = filteredData.length;
    final totalPages = (totalItems / _itemsPerPage).ceil();
    final displayList = _paginatedList;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 40,
              ),
              child: Column(
                children: [
                  const Text("My Applications", style: TextStyles.h1),
                  const SizedBox(height: 16),
                  const Text(
                    "Manage your applications efficiently...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Filter & Search Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Box
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 250,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => setState(
                                () => _isStatusExpanded = !_isStatusExpanded,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Status",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    _isStatusExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                  ),
                                ],
                              ),
                            ),
                            if (_isStatusExpanded) ...[
                              const SizedBox(height: 10),
                              _buildCheckboxItem("Ditinjau"),
                              _buildCheckboxItem("Wawancara"),
                              _buildCheckboxItem("Diterima"),
                              _buildCheckboxItem("Ditolak"),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      // Search Bar
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _searchCtrl,
                                  onSubmitted: (_) => _performSearch(),
                                  decoration: const InputDecoration(
                                    hintText:
                                        "Job title, position, or keyword...",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              // Tombol Silang (Reset)
                              ValueListenableBuilder(
                                valueListenable: _searchCtrl,
                                builder: (context, TextEditingValue value, __) {
                                  if (value.text.isEmpty &&
                                      _activeSearchQuery.isEmpty)
                                    return const SizedBox.shrink();
                                  return IconButton(
                                    onPressed: _resetSearch,
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColors.primaryOrange,
                                    ),
                                    tooltip: "Clear Search",
                                  );
                                },
                              ),
                              const SizedBox(width: 8),

                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.gradientStart,
                                      AppColors.gradientEnd,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  onPressed: _performSearch,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Search",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // --- SHOWING COUNT (ITEM BARU) ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Showing $totalItems Applications",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ---------------------------------

                  // LIST APPLICATIONS
                  if (displayList.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.folder_off_outlined,
                            size: 60,
                            color: AppColors.textGrey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No applications found.",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    // Tampilkan List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final app = displayList[index];
                        return ApplicationCard(
                          logoUrl: app.companyLogoUrl,
                          jobTitle: app.jobTitle,
                          companyInfo: "${app.companyName} • ${app.type}",
                          location: app.location,
                          date: app.appliedDate,
                          status: app.status,
                          statusColor: _getStatusColor(app.status),
                          isClickable: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ApplicationDetailModal(
                                  applicationData: app,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // --- PAGINATION CONTROLS (KANAN BAWAH) ---
                    if (totalPages > 1)
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildPaginationControls(totalPages),
                      ),
                  ],
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  // --- PAGINATION WIDGET BUILDER ---
  Widget _buildPaginationControls(int totalPages) {
    List<Widget> pageButtons = [];

    // Previous Button
    pageButtons.add(
      InkWell(
        onTap: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: _currentPage > 1
                  ? Colors.grey.shade300
                  : Colors.grey.shade100,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Icon(
            Icons.chevron_left,
            color: _currentPage > 1 ? AppColors.textDark : Colors.grey.shade300,
          ),
        ),
      ),
    );
    pageButtons.add(const SizedBox(width: 8));

    // Numbered Buttons Logic
    if (totalPages <= 7) {
      for (int i = 1; i <= totalPages; i++) {
        pageButtons.add(_buildPageNumberButton(i));
        if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
      }
    } else {
      pageButtons.add(_buildPageNumberButton(1));
      pageButtons.add(const SizedBox(width: 5));
      if (_currentPage > 4)
        pageButtons.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("...", style: TextStyle(color: Colors.grey)),
          ),
        );

      int start = max(2, _currentPage - 1);
      int end = min(totalPages - 1, _currentPage + 1);
      if (_currentPage < 4) {
        start = 2;
        end = 4;
      }
      if (_currentPage > totalPages - 3) {
        start = totalPages - 3;
        end = totalPages - 1;
      }

      for (int i = start; i <= end; i++) {
        pageButtons.add(_buildPageNumberButton(i));
        pageButtons.add(const SizedBox(width: 5));
      }

      if (_currentPage < totalPages - 3)
        pageButtons.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("...", style: TextStyle(color: Colors.grey)),
          ),
        );
      pageButtons.add(const SizedBox(width: 5));
      pageButtons.add(_buildPageNumberButton(totalPages));
    }

    // Next Button
    pageButtons.add(const SizedBox(width: 8));
    pageButtons.add(
      InkWell(
        onTap: _currentPage < totalPages
            ? () => setState(() => _currentPage++)
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: _currentPage < totalPages
                  ? Colors.grey.shade300
                  : Colors.grey.shade100,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Icon(
            Icons.chevron_right,
            color: _currentPage < totalPages
                ? AppColors.textDark
                : Colors.grey.shade300,
          ),
        ),
      ),
    );

    return Row(mainAxisSize: MainAxisSize.min, children: pageButtons);
  }

  Widget _buildPageNumberButton(int pageNum) {
    bool isActive = _currentPage == pageNum;
    return InkWell(
      onTap: () => setState(() => _currentPage = pageNum),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                )
              : null,
          color: isActive ? null : Colors.white,
          border: isActive ? null : Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.gradientStart.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            "$pageNum",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    final bool isSelected = _selectedStatuses.contains(label);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => _toggleStatusFilter(label, !isSelected),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              activeColor: AppColors.gradientStart,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (val) => _toggleStatusFilter(label, val),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= COMPONENTS (Card, Navbar, Footer) =================
class ApplicationCard extends StatelessWidget {
  final String logoUrl;
  final String jobTitle;
  final String companyInfo;
  final String location;
  final String date;
  final String status;
  final Color statusColor;
  final bool isClickable;
  final VoidCallback? onTap;
  const ApplicationCard({
    super.key,
    required this.logoUrl,
    required this.jobTitle,
    required this.companyInfo,
    required this.location,
    required this.date,
    required this.status,
    required this.statusColor,
    this.isClickable = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: isClickable ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      logoUrl,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.business, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: TextStyles.cardTitle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        companyInfo,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.textGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        date,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= WIDGET MODAL DETAIL APLIKASI (INTEGRATED) =================
class ApplicationDetailModal extends StatelessWidget {
  final ApplicationModel applicationData;
  const ApplicationDetailModal({super.key, required this.applicationData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color badgeColor;
    switch (applicationData.status) {
      case "Diterima":
        badgeColor = AppColors.statusGreen;
        break;
      case "Ditinjau":
        badgeColor = AppColors.statusYellow;
        break;
      case "Wawancara":
        badgeColor = AppColors.statusBlue;
        break;
      case "Ditolak":
        badgeColor = AppColors.statusRed;
        break;
      default:
        badgeColor = AppColors.textGrey;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: screenWidth > 700 ? 700 : screenWidth * 0.9,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Detail Aplikasi: ${applicationData.jobTitle}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textGrey,
                        size: 28,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: badgeColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    applicationData.status,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: applicationData.timeline.asMap().entries.map((
                          entry,
                        ) {
                          int idx = entry.key;
                          var event = entry.value;
                          IconData icon = event.isCompleted
                              ? Icons.check_circle
                              : (event.isActive
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined);
                          Color color = event.isActive
                              ? badgeColor
                              : (event.isCompleted
                                    ? AppColors.statusGreen
                                    : AppColors.textGrey);
                          return _TimelineItem(
                            icon: icon,
                            color: color,
                            date: event.date,
                            title: event.title,
                            subtitle: event.subtitle,
                            isFirst: idx == 0,
                            isLast: idx == applicationData.timeline.length - 1,
                            isActive: event.isActive,
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dokumen Terkirim",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _DocumentItem(
                            title: "CV",
                            fileName: applicationData.cvFileName,
                          ),
                          if (applicationData.portfolioFileName != null) ...[
                            const SizedBox(height: 15),
                            _DocumentItem(
                              title: "Portofolio",
                              fileName: applicationData.portfolioFileName!,
                            ),
                          ],
                          if (applicationData.coverLetterFileName != null) ...[
                            const SizedBox(height: 15),
                            _DocumentItem(
                              title: "Motivation Letter",
                              fileName: applicationData.coverLetterFileName!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (applicationData.status == "Ditolak") ...[
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA53F3F),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Lihat Alasan",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String date;
  final String title;
  final String? subtitle;
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  const _TimelineItem({
    required this.icon,
    required this.color,
    required this.date,
    required this.title,
    this.subtitle,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
  });
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : color,
                  shape: BoxShape.circle,
                  border: isActive ? Border.all(color: color, width: 3) : null,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isActive ? color : Colors.white,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 30.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isActive ? AppColors.textDark : AppColors.textGrey,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title;
  final String fileName;
  const _DocumentItem({required this.title, required this.fileName});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fileName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            side: const BorderSide(color: AppColors.textGrey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            "Lihat",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.textGrey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

// ================= NAVBAR & FOOTER (SHARED) =================
class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
              shape: BoxShape.circle,
            ),
            child: const Text(
              "UC",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "UC HUB",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          _navLink(
            "Home",
            onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          _navLink("Features"),
          _navLink("My Applications", isActive: true),
          _navLink("How it Works"),
          _navLink("About"),
          const SizedBox(width: 30),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Login",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Register Now",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navLink(String text, {bool isActive = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isActive ? AppColors.gradientStart : AppColors.textDark,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(80, 60, 80, 30),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientEnd,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "UC",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "UC HUB",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Platform job & internship\nuntuk mahasiswa\nUniversitas Ciputra.",
                      style: TextStyle(color: AppColors.textGrey, height: 1.5),
                    ),
                  ],
                ),
              ),
              _footerLinkColumn("Platform", [
                "For Students",
                "For Companies",
                "For Departments",
              ]),
              _footerLinkColumn("Resources", [
                "Help Center",
                "Career Guide",
                "Blog",
              ]),
              _footerLinkColumn("Legal", ["Privacy", "Terms", "Contact"]),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 30),
          const Text(
            "© 2025 UC HUB — Universitas Ciputra. All rights reserved.",
            style: TextStyle(color: AppColors.textLightGrey),
          ),
        ],
      ),
    );
  }

  Widget _footerLinkColumn(String title, List<String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ...links.map(
            (link) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                link,
                style: const TextStyle(color: AppColors.textGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
