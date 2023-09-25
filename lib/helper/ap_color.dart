import 'package:flutter/material.dart';

const Primary = Colors.white;

Widget myBottomSheet(BuildContext context) {
  return Container(
    height: 400,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 80,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.5),
        ListTile(
          title: Text('Pin Image'),
          onTap: () {
            // Handle option 1 tap
            Navigator.pop(context); // Close the bottom sheet
          },
        ),
        ListTile(
          title: Text('Downlode'),
          onTap: () {
            // Handle option 2 tap
            Navigator.pop(context); // Close the bottom sheet
          },
        ),
        // Add more options as needed
      ],
    ),
  );
}
