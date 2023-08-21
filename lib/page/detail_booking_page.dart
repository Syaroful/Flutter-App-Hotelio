import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio/config/app_asset.dart';
import 'package:hotelio/config/app_color.dart';
import 'package:hotelio/config/app_format.dart';
import 'package:hotelio/model/booking.dart';
import 'package:hotelio/widget/button_custom.dart';
import 'package:intl/intl.dart';

import '../config/app_route.dart';
import '../controller/c_user.dart';
import '../model/hotel.dart';
import '../source/booking_source.dart';

class DetailBookingPage extends StatelessWidget {
  DetailBookingPage({Key? key}) : super(key: key);
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    Booking booking = ModalRoute.of(context)!.settings.arguments as Booking;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(booking, context),
          const SizedBox(height: 16),
          bookDetail(booking, context),
          const SizedBox(height: 12),
          paymentMethod(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.dark,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColor.dark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[700]!),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.iconMasterCard,
                  width: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Master Card',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '**** **** **** 1234',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w200,
                              color: Colors.grey[100],
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle, color: AppColor.secondary)
              ],
            ),
          )
        ],
      ),
    );
  }

  Container bookDetail(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.dark,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          itemRoomDetail(
            context,
            'Date',
            AppFormat.date(booking.date),
          ),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Guest', "${booking.guest} guest"),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Breakfast', booking.breakfast),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Check-in Time', booking.checkInTime),
          const SizedBox(height: 8),
          itemRoomDetail(
              context, '${booking.night} night', AppFormat.currency(1899000)),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'service fee',
              AppFormat.currency(booking.serviceFee.toDouble())),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Activities',
              AppFormat.currency(booking.activities.toDouble())),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Total Payment',
              AppFormat.currency(booking.totalPayment.toDouble())),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Row itemRoomDetail(BuildContext context, String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Container header(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.dark,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              booking.cover,
              width: 90,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                Text(booking.location,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
