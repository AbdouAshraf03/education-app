import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/widgets/custom_pay_method.dart';

import '../../core/app_assets.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    double dHight = MediaQuery.of(context).size.height;
    double dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              height: dHight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            Container(
              height: dWidth * (184 / 315),
              width: dWidth - 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1C71C2),
                    Color(0xFF5BAFFF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Text('YOUR BALANCE',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'card')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 75,
                          height: 100,
                          child: Image.asset(
                            ImageAppAssets.mastercard,
                            fit: BoxFit.contain,
                            alignment: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('1234 EGP',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'card')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Pay Methods',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black54, fontSize: 20, fontFamily: 'cairo'),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                CustomPayMethod(
                  icon: Iconsax.wallet,
                  title: 'Wallet',
                ),
                CustomPayMethod(
                  icon: Iconsax.card,
                  title: 'Card',
                ),
                CustomPayMethod(
                  icon: Iconsax.code,
                  title: 'code',
                ),
                CustomPayMethod(
                  icon: Iconsax.scan,
                  title: 'QR Code',
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
