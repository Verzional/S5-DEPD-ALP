import 'package:flutter/material.dart';
import 'dart:math';

import '../../../model/job_model.dart';
import '../../../model/category_model.dart';
import '../../../data/dummy_jobs_data.dart';
import 'detailjob.dart';
import 'my_account_page.dart';
import 'myapplication.dart';
import 'saved_jobs_page.dart';

void main() {
  runApp(const UcHubApp());
}

// ================= CONSTANTS =================
class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color filterBackground = Color(0xFFFFEFE2);
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color textLightGrey = Color(0xFFB2B2B2);
  static const Color primaryOrange = Color(0xFFFF6B6B);
}

// ================= MAIN APP =================
class UcHubApp extends StatelessWidget {
  const UcHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UC HUB Job Listing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.backgroundCream,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.gradientStart),
      ),
      home: const JobListingPage(),
    );
  }
}

// ================= HALAMAN UTAMA =================
class JobListingPage extends StatefulWidget {
  const JobListingPage({super.key});

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  // --- STATE FILTER ---
  final List<String> _selectedJobTypes = [];
  final List<String> _selectedCategories = [];
  RangeValues _selectedSalaryRange = const RangeValues(0, 40000000);
  String? _selectedWorkModel;

  // --- STATE PENCARIAN (MANUAL) ---
  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  String _activeSearchQuery = "";
  String _activeLocationQuery = "";

  // --- STATE PAGINATION ---
  int _currentPage = 1;
  static const int _itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    // Listener untuk update tampilan tombol silang secara real-time
    _searchCtrl.addListener(() {
      setState(() {});
    });
    _locationCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  // LOGIC FILTER
  void _toggleJobTypeFilter(String type, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedJobTypes.add(type);
      } else {
        _selectedJobTypes.remove(type);
      }
      _currentPage = 1;
    });
  }

  void _toggleCategoryFilter(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
      _currentPage = 1;
    });
  }

  void _updateSalaryRange(RangeValues values) {
    setState(() {
      _selectedSalaryRange = values;
      _currentPage = 1;
    });
  }

  void _updateWorkModel(String? model) {
    setState(() {
      if (_selectedWorkModel == model) {
        _selectedWorkModel = null;
      } else {
        _selectedWorkModel = model;
      }
      _currentPage = 1;
    });
  }

  void _performSearch() {
    setState(() {
      _activeSearchQuery = _searchCtrl.text;
      _activeLocationQuery = _locationCtrl.text;
      _currentPage = 1;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedJobTypes.clear();
      _selectedCategories.clear();
      _selectedSalaryRange = const RangeValues(0, 40000000);
      _selectedWorkModel = null;
      _searchCtrl.clear();
      _locationCtrl.clear();
      _activeSearchQuery = "";
      _activeLocationQuery = "";
      _currentPage = 1;
    });
  }

  // Khusus reset search bar saja (tombol silang di atas)
  void _resetSearchBarOnly() {
    setState(() {
      _searchCtrl.clear();
      _locationCtrl.clear();
      _activeSearchQuery = "";
      _activeLocationQuery = "";
      _currentPage = 1;
    });
  }

  double _parseSalary(String salaryString) {
    String cleanString = salaryString
        .split('-')[0]
        .replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(cleanString) ?? 0;
  }

  List<JobModel> get _filteredJobs {
    return dummyJobs.where((job) {
      // 1. Job Type
      bool typeMatch = true;
      if (_selectedJobTypes.isNotEmpty) {
        typeMatch = false;
        for (var filter in _selectedJobTypes) {
          if (job.type.contains(filter)) {
            typeMatch = true;
            break;
          }
        }
      }

      // 2. Categories
      bool categoryMatch = true;
      if (_selectedCategories.isNotEmpty) {
        categoryMatch = false;
        for (var selectedCat in _selectedCategories) {
          if (job.category.contains(selectedCat)) {
            categoryMatch = true;
            break;
          }
        }
      }

      // 3. Salary
      double jobMinSalary = _parseSalary(job.salaryRange);
      bool salaryMatch =
          jobMinSalary >= _selectedSalaryRange.start &&
          jobMinSalary <= _selectedSalaryRange.end;

      // 4. Work Model
      bool modelMatch = true;
      if (_selectedWorkModel != null) {
        if (!job.type.contains(_selectedWorkModel!) &&
            !job.location.contains(_selectedWorkModel!)) {
          modelMatch = false;
        }
      }

      // 5. Search Text
      bool searchMatch = true;
      if (_activeSearchQuery.isNotEmpty) {
        final query = _activeSearchQuery.toLowerCase();
        searchMatch =
            job.title.toLowerCase().contains(query) ||
            job.companyName.toLowerCase().contains(query);
      }

      // 6. Location Text
      bool locationMatch = true;
      if (_activeLocationQuery.isNotEmpty) {
        locationMatch = job.location.toLowerCase().contains(
          _activeLocationQuery.toLowerCase(),
        );
      }

      return typeMatch &&
          categoryMatch &&
          salaryMatch &&
          modelMatch &&
          searchMatch &&
          locationMatch;
    }).toList();
  }

  List<JobModel> get _paginatedJobs {
    final allFiltered = _filteredJobs;
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    if (startIndex >= allFiltered.length) return [];
    final endIndex = (startIndex + _itemsPerPage < allFiltered.length)
        ? startIndex + _itemsPerPage
        : allFiltered.length;
    return allFiltered.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = _filteredJobs.length;
    final totalPages = (totalItems / _itemsPerPage).ceil();

    // Filter sidebar aktif?
    bool isSidebarFilterActive =
        _selectedJobTypes.isNotEmpty ||
        _selectedCategories.isNotEmpty ||
        _selectedWorkModel != null ||
        _selectedSalaryRange.start > 0 ||
        _selectedSalaryRange.end < 40000000;

    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // --- SEARCH BAR (DIJAMIN TIDAK GESER) ---
                  HeroAndSearchSection(
                    searchController: _searchCtrl,
                    locationController: _locationCtrl,
                    onSearchPressed: _performSearch,
                    onResetPressed: _resetSearchBarOnly,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80.0,
                      vertical: 40,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- SIDEBAR FILTER (KATEGORI SEARCHABLE) ---
                        FilterSidebar(
                          selectedFilters: _selectedJobTypes,
                          selectedCategories: _selectedCategories,
                          currentSalaryRange: _selectedSalaryRange,
                          currentWorkModel: _selectedWorkModel,
                          isFilterActive: isSidebarFilterActive,
                          onFilterChanged: _toggleJobTypeFilter,
                          onCategoryChanged: _toggleCategoryFilter,
                          onSalaryChanged: _updateSalaryRange,
                          onWorkModelChanged: _updateWorkModel,
                          onResetSidebar:
                              _resetFilters, // Reset sidebar clears everything for safety
                        ),

                        const SizedBox(width: 40),

                        // --- DAFTAR PEKERJAAN ---
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Showing $totalItems Jobs",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (_filteredJobs.isEmpty)
                                Container(
                                  padding: const EdgeInsets.all(40),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.search_off,
                                        size: 50,
                                        color: AppColors.textLightGrey,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "No jobs found matching your filters.",
                                        style: TextStyle(
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else ...[
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _paginatedJobs.length,
                                  itemBuilder: (context, index) {
                                    final job = _paginatedJobs[index];
                                    return JobCard(
                                      title: job.title,
                                      company: job.companyName,
                                      type: job.type,
                                      location: job.location,
                                      logoUrl: job.companyLogoUrl,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => JobDetailPage(
                                              id: job.id,
                                              category: job.category,
                                              jobTitle: job.title,
                                              companyName: job.companyName,
                                              jobType: job.type,
                                              location: job.location,
                                              salaryRange: job.salaryRange,
                                              logoUrl: job.companyLogoUrl,
                                              description: job.description,
                                              responsibilities:
                                                  job.responsibilities,
                                              qualifications:
                                                  job.qualifications,
                                              benefits: job.benefits,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                const SizedBox(height: 30),

                                if (totalPages > 1)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildPaginationControls(totalPages),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    List<Widget> pageButtons = [];
    // Prev
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

    // Number Logic
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

    // Next
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
}

// ================= HERO & SEARCH SECTION (STABIL) =================
class HeroAndSearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final TextEditingController locationController;
  final VoidCallback onSearchPressed;
  final VoidCallback onResetPressed;

  const HeroAndSearchSection({
    super.key,
    required this.searchController,
    required this.locationController,
    required this.onSearchPressed,
    required this.onResetPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Cek apakah ada teks
    bool hasText =
        searchController.text.isNotEmpty || locationController.text.isNotEmpty;

    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          "Find a Job",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Looking for jobs? Browse our latest job openings to\nview & apply the best jobs today",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.textGrey),
        ),
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.search, color: Colors.grey[400]),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Job title, position, or keyword...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(height: 30, width: 1, color: Colors.grey[300]),
              const SizedBox(width: 20),
              Icon(Icons.location_on_outlined, color: Colors.grey[400]),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "Location or remote",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                ),
              ),

              // --- TOMBOL SILANG (STABIL) ---
              // Visibility maintainSize: true membuat ruang tombol tetap ada meski invisible
              // Jadi layout tidak bergeser saat tombol muncul/hilang
              Visibility(
                visible: hasText,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onResetPressed();
                  },
                  icon: const Icon(Icons.close, color: AppColors.primaryOrange),
                  tooltip: "Clear Search",
                ),
              ),
              const SizedBox(width: 8),

              GradientButton(
                text: "Search",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  onSearchPressed();
                },
                width: 120,
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================= SIDEBAR FILTER (STATEFUL & SEARCHABLE CATEGORY) =================
class FilterSidebar extends StatefulWidget {
  final List<String> selectedFilters;
  final List<String> selectedCategories;
  final RangeValues currentSalaryRange;
  final String? currentWorkModel;
  final bool isFilterActive;

  final Function(String, bool) onFilterChanged;
  final Function(String, bool) onCategoryChanged;
  final ValueChanged<RangeValues> onSalaryChanged;
  final Function(String?) onWorkModelChanged;
  final VoidCallback onResetSidebar;

  const FilterSidebar({
    super.key,
    required this.selectedFilters,
    required this.selectedCategories,
    required this.currentSalaryRange,
    this.currentWorkModel,
    required this.isFilterActive,
    required this.onFilterChanged,
    required this.onCategoryChanged,
    required this.onSalaryChanged,
    required this.onWorkModelChanged,
    required this.onResetSidebar,
  });

  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<FilterSidebar> {
  final TextEditingController _catSearchCtrl = TextEditingController();
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    // Awalnya tampilkan semua kategori
    _filteredCategories = dummyCategories;
  }

  void _searchCategory(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = dummyCategories;
      } else {
        _filteredCategories = dummyCategories
            .where(
              (cat) => cat.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.filterBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gradientStart.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filters",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (widget.isFilterActive)
                InkWell(
                  onTap: widget.onResetSidebar,
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // --- CATEGORY FILTER (SEARCHABLE) ---
          _filterTitle("Category"),
          const SizedBox(height: 8),
          // Search Box Kecil
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _catSearchCtrl,
              onChanged: _searchCategory,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: "Search category...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                border: InputBorder.none,
                icon: Icon(Icons.search, size: 18, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // List Kategori (Scrollable jika panjang)
          Container(
            constraints: const BoxConstraints(
              maxHeight: 150,
            ), // Batasi tinggi agar tidak memanjang ke bawah
            child: SingleChildScrollView(
              child: Column(
                children: _filteredCategories.isEmpty
                    ? [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "No category found.",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ]
                    : _filteredCategories
                          .map((cat) => _InteractiveCategoryCheckbox(cat.name))
                          .toList(),
              ),
            ),
          ),

          const SizedBox(height: 24),
          _filterTitle("Job Type"),
          _InteractiveCheckbox("Full Time"),
          _InteractiveCheckbox("Part Time"),
          _InteractiveCheckbox("Intern"),
          _InteractiveCheckbox("Freelance"),
          const SizedBox(height: 24),
          _filterTitle("Salary Range"), const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatCurrency(widget.currentSalaryRange.start),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _formatCurrency(widget.currentSalaryRange.end),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: widget.currentSalaryRange,
            min: 0,
            max: 40000000,
            divisions: 20,
            activeColor: AppColors.gradientStart,
            inactiveColor: Colors.grey[300],
            labels: RangeLabels(
              _formatCurrency(widget.currentSalaryRange.start),
              _formatCurrency(widget.currentSalaryRange.end),
            ),
            onChanged: widget.onSalaryChanged,
          ),
          const SizedBox(height: 24),
          _filterTitle("Onsite/Remote"),
          _InteractiveRadio("Onsite"),
          _InteractiveRadio("Remote"),
          _InteractiveRadio("Hybrid"),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    if (value == 0) return "Rp 0";
    double inMillion = value / 1000000;
    String s = inMillion.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
    return "Rp ${s}jt";
  }

  Widget _InteractiveCheckbox(String label) {
    final bool isSelected = widget.selectedFilters.contains(label);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () => widget.onFilterChanged(label, !isSelected),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: isSelected ? AppColors.textDark : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _InteractiveCategoryCheckbox(String label) {
    final bool isSelected = widget.selectedCategories.contains(label);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => widget.onCategoryChanged(label, !isSelected),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 18,
              color: isSelected ? AppColors.textDark : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _InteractiveRadio(String label) {
    final bool isSelected = widget.currentWorkModel == label;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () => widget.onWorkModelChanged(label),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
              color: isSelected ? AppColors.textDark : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}

// ================= COMPONENT LAIN (TETAP SAMA) =================
class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String type;
  final String location;
  final String logoUrl;
  final VoidCallback onTap;
  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.type,
    required this.location,
    required this.logoUrl,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$company • $type",
                        style: const TextStyle(color: AppColors.textGrey),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: NetworkImage(logoUrl),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.business, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 45,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: Row(
        children: [
          // --- LOGO ---
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          const Spacer(),

          // --- MENU LINKS ---
          _navLink(
            "Home",
            onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          _navLink("Features"),
          _navLink(
            "My Applications",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApplicationPage(),
                ),
              );
            },
          ),

          // --- MENU SAVED JOBS (FAVORIT) ---
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedJobsPage()),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8.0,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.favorite_border,
                    color: AppColors.textDark,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Saved",
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          _navLink("How it Works"),
          _navLink("About"),

          const SizedBox(width: 30),

          // --- PROFIL USER (PENGGANTI LOGIN) ---
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyAccountPage()),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const NetworkImage(
                      "https://i.pravatar.cc/300?img=5",
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Stefanie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),
          // Tombol Register (Opsional, bisa dihapus jika sudah login)
          // GradientButton(text: "Register Now", onPressed: () {}, width: 130),
        ],
      ),
    );
  }

  Widget _navLink(String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
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
