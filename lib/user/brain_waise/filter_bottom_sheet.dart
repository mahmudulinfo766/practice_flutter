import 'package:flutter/material.dart';

class FilterBottomSheetExample extends StatefulWidget {
  @override
  _FilterBottomSheetExampleState createState() => _FilterBottomSheetExampleState();
}

class _FilterBottomSheetExampleState extends State<FilterBottomSheetExample> {
  // Sample categories for the filter
  final List<String> _categories = [
    "Deep Relaxation",
    "Stress Relief",
    "Inner Peace",
    "Better Sleep",
    "Focus",
    "Anxiety Reduction",
    "Positivity",
    "Mindfulness",
  ];

  // Keep track of selected categories
  List<String> _selectedCategories = ["Stress Relief", "Inner Peace"];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showFilterBottomSheet(context);
        },
        child: Text("Open Filter"),
      ),
    );
  }

  // Function to show the bottom sheet with the filter options
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand with scrolling
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar indicator
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Title of the sheet
                  Text(
                    "Filter by Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Custom Checkbox List
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: _categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Checkbox(
                              value: _selectedCategories.contains(_categories[index]),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedCategories.add(_categories[index]);
                                  } else {
                                    _selectedCategories.remove(_categories[index]);
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              _categories[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Bottom Buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cancel Button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                        // Apply Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Handle the apply logic if needed
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}