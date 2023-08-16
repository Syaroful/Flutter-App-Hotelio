import 'package:flutter/material.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';

class NearbyPage extends StatelessWidget {
  const NearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        header(context),
        const SizedBox(height: 20),
        searchField(),
        const SizedBox(height: 30),
      ],
    );
  }

  Container searchField() {
    return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    hintText: 'Search by name or city',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Material(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(45),
                child: InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: () {},
                  child: const SizedBox(
                    height: 45,
                    width: 45,
                    child: Center(
                      child: ImageIcon(
                        AssetImage(AppAsset.iconSearch),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAsset.profile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Near Me',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              const Text(
                '23 hotels',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
