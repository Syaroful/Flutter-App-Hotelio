import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio/config/app_asset.dart';
import 'package:hotelio/config/app_color.dart';
import 'package:hotelio/config/app_format.dart';
import 'package:hotelio/config/app_route.dart';
import 'package:hotelio/widget/button_custom.dart';

import '../controller/c_user.dart';
import '../model/booking.dart';
import '../model/hotel.dart';
import '../source/booking_source.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  final cUser = Get.put(CUser());

  final Rx<Booking> _bookedData = initBooking.obs;
  Booking get bookedData => _bookedData.value;
  set bookedData(Booking n) => _bookedData.value = n;

  final List facilities = [
    {
      'icon': AppAsset.iconCoffee,
      'label': 'Lounge',
    },
    {
      'icon': AppAsset.iconWifi,
      'label': 'Wi-Fi',
    },
    {
      'icon': AppAsset.iconOffice,
      'label': 'Office',
    },
    {
      'icon': AppAsset.iconStore,
      'label': 'Store',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    BookingSource.checkIsBooked(cUser.data.id!, hotel.id).then((bookingValue) {
      bookedData = bookingValue ?? initBooking;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Page',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // bottomNavigationBar: bookingNow(hotel, context),
      bottomNavigationBar: Obx(() {
        if (bookedData.id == '') return bookingNow(hotel, context);
        return viewReceipt();
      }),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.darkBackgroundScaffold,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            images(hotel),
            const SizedBox(height: 16),
            name(hotel, context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                hotel.description,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Facilities',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            gridFacilities(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Activities',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            activities(hotel),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container viewReceipt() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1.5),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'You booked this.',
            style: TextStyle(color: Colors.grey),
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.secondary,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                child: Text(
                  'View Receipt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container bookingNow(Hotel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(
            color: Colors.grey[700]!,
            width: 1,
          ),
        ),
      ),
      height: 80,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormat.currency(hotel.price.toDouble()),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const Text(
                  'per night',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ButtonCustom(
            label: 'Booking Now',
            onTap: () {
              Navigator.pushNamed(context, AppRoute.checkout, arguments: hotel);
            },
          )
        ],
      ),
    );
  }

  SizedBox activities(Hotel hotel) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        itemCount: hotel.activities.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Map activity = hotel.activities[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.activities.length - 1 ? 16 : 8,
              0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      activity['image'],
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  activity['name'],
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GridView gridFacilities() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      itemCount: facilities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[700]!),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(facilities[index]['icon']),
                color: AppColor.secondary,
              ),
              const SizedBox(height: 4),
              Text(
                facilities[index]['label'],
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding name(Hotel hotel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                Text(
                  hotel.location,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rate_rounded, color: AppColor.starActive),
          const SizedBox(width: 4),
          Text(
            hotel.rate.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox images(Hotel hotel) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: hotel.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.images.length - 1 ? 16 : 8,
              0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                hotel.images[index],
                fit: BoxFit.cover,
                height: 200,
                width: 280,
              ),
            ),
          );
        },
      ),
    );
  }
}
