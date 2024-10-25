import 'package:flutter/material.dart';

class CollegeEventCard extends StatelessWidget {
  final String title;
  final String department;
  final DateTime dateTime;
  final String contactDetails;
  final String venue;
  final String description;
  final String techTag;
  final Color backgroundColor; // New background color parameter
  final Color textColor;       // New text color parameter
  final String? imageUrl;

  const CollegeEventCard({
    Key? key,
    required this.title,
    required this.department,
    required this.dateTime,
    required this.contactDetails,
    required this.venue,
    required this.description,
    required this.techTag,
    this.backgroundColor = Colors.white, // Default color if not specified
    this.textColor = Colors.black87,     // Default text color if not specified
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 4,
      color: backgroundColor, // Apply background color here
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,)
              ),
            const SizedBox(height: 8),
            // Tech Tag
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                techTag.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor, // Apply text color here
              ),
            ),
            const SizedBox(height: 4),
            Text(
              department,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: textColor.withOpacity(0.7)),
                const SizedBox(width: 6),
                Text(
                  "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute}",
                  style: TextStyle(color: textColor.withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 18, color: textColor.withOpacity(0.7)),
                const SizedBox(width: 6),
                Text(
                  venue,
                  style: TextStyle(color: textColor.withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 18, color: textColor.withOpacity(0.7)),
                const SizedBox(width: 6),
                Text(
                  contactDetails,
                  style: TextStyle(color: textColor.withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
