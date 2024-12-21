import 'package:flutter/material.dart';
import 'package:ecom_express/addremark.dart';

class Remarks extends StatefulWidget {
  final Map<String, String>? submittedRemark;

  const Remarks({super.key, this.submittedRemark});

  @override
  _RemarksState createState() => _RemarksState();
}

class _RemarksState extends State<Remarks> {
  final TextEditingController _searchController = TextEditingController();
  bool showSearch = false;

  // List to store all submitted remarks
  List<Map<String, String>> remarksList = [];

  @override
  void initState() {
    super.initState();
    // Add initial remark if provided
    if (widget.submittedRemark != null) {
      remarksList.add(widget.submittedRemark!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter remarks based on search input
    List<Map<String, String>> filteredRemarksList = remarksList.where((remark) {
      return (remark['name']?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false) ||
             (remark['remarks']?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Remarks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          showSearch = !showSearch;
                        });
                      },
                    ),
                    if (showSearch)
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Remarks',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {}); // Refresh the UI on search input change
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Display filtered remarks in card format
              filteredRemarksList.isNotEmpty
                  ? Column(
                      children: filteredRemarksList.map((remark) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              remark['name'] ?? 'N/A', // Use null-aware operator
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  'Date: ${remark['dateOfJoining'] ?? 'N/A'}', // Use null-aware operator
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Remarks: ${remark['remarks'] ?? 'N/A'}', // Use null-aware operator
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No remarks to display.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to Addremark page and await the result
                  final newRemark = await Navigator.push<Map<String, String>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Addremark(),
                    ),
                  );

                  // If a new remark was added, save it to the list
                  if (newRemark != null) {
                    setState(() {
                      remarksList.add(newRemark);
                    });
                  }
                },
                child: const Text(
                  'Add New Remarks',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 24, 8, 114),
                  minimumSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
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

