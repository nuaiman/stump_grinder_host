import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stump_grinder_host/models/contact_us.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key, required this.contactUs});

  final ContactUsModel contactUs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(contactUs.name),
        Text(contactUs.address),
        Text(contactUs.email),
        Text(contactUs.phone),
        Text(contactUs.note),
        CarouselSlider(
          options: CarouselOptions(
            height: 450,
            viewportFraction: 0.5,
            // onPageChanged: (index, reason) {
            //   setState(() {
            //     imageCounter = index;
            //   });
            // },
          ),
          items: contactUs.images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.network(
                    i,
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
