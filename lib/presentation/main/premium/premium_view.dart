import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';

class PremiumView extends StatefulWidget {
  const PremiumView({Key key}) : super(key: key);

  @override
  _PremiumViewState createState() => _PremiumViewState();
}

class _PremiumViewState extends State<PremiumView> {
  StreamSubscription<dynamic> _subscription;

  Set<String> _kIds = <String>{'remove_ads'};

  List<ProductDetails> products = [];

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        if (purchaseDetails.status == PurchaseStatus.pending) {
          debugPrint(
              'purchaseDetails.status ${purchaseDetails.status} PremiumPage');
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            debugPrint(
                'purchaseDetails.status ${purchaseDetails.status} PremiumPage');
            debugPrint(
                'purchaseDetails.error ${purchaseDetails.error?.message}');
            if (purchaseDetails.error?.message ==
                'BillingResponse.itemAlreadyOwned') {
              context.read<ProfileCubit>().changeVipStatus();
              debugPrint(
                  'purchaseDetails: ürün daha önceden satın alınmıştır şimdi update edilecek PremiumPage');
            }
          } else if (purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) {
            debugPrint(
                'purchaseDetails.status ${purchaseDetails.status} PremiumPage');
          }
          if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            debugPrint(
                'Complete purchase: ${purchaseDetails.productID} ${purchaseDetails.status} ${purchaseDetails.transactionDate} ${purchaseDetails.verificationData} ${purchaseDetails.error} ${purchaseDetails.pendingCompletePurchase} PremiumPage');
            context.read<ProfileCubit>().changeVipStatus();
          }
        }
      },
    );
  }

  Future<bool> checkStoreStatus() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    return available;
  }

  Future<List<ProductDetails>> loadProducts() async {
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('PRODUCT ID ERROR PremiumPage');
      return null;
    } else {
      List<ProductDetails> products = response.productDetails;
      return products;
    }
  }

  Future<void> inAppPurchaseSetup() async {
    bool storeStatus = await checkStoreStatus();
    products = await loadProducts();
    debugPrint('StoreStatus: $storeStatus - Products: $products PremiumPage');
  }

  Future<void> makingPurchase() async {
    final ProductDetails productDetails =
        products[0]; // Saved earlier from queryProductDetails().
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  void initState() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      debugPrint('error $error PremiumPage');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundWidget,
          FutureBuilder(
            future: inAppPurchaseSetup(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _inAppPurchaseLoadedWidget;
              } else {
                return _loadingAnimationWidget;
              }
            },
          ),
        ],
      ),
    );
  }

  Container get _backgroundWidget {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1],
          colors: [
            Theme.of(context).colorScheme.secondary,
            //Theme.of(context).colorScheme.secondary,
            Colors.white
          ],
        ),
      ),
    );
  }

  Widget get _inAppPurchaseLoadedWidget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Column(
              children: [
                FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Lottie.asset("assets/animations/crown.json")),
                Text(
                  "AD-FREE USE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "You can turn off ads and meet more people!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      //Theme.of(context).colorScheme.secondary,
                      blurRadius: 50,
                      spreadRadius: 5,
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Text(
                      "Best Value - Save 75%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Lifetime",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "(Pay once)",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          products.first.price,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  "Upgrade Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await makingPurchase();
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Center get _loadingAnimationWidget =>
      Center(child: Lottie.asset('assets/animations/loading.json'));
}
