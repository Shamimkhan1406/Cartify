import 'package:cartify/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final wishItemData = ref.watch(favoriteProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.2,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/cartb.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/not.png", width: 25, height: 25),
                    Positioned(
                      top: 0,
                      right: 0,

                      child: Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 250, 201),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            wishItemData.length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'Wishlist',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: wishItemData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final wishItem = wishItemData.values.toList()[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: 335,
                height: 96,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  // color: const Color.fromARGB(255, 255, 250, 201),
                  // borderRadius: BorderRadius.circular(14),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 96,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 250, 201),
                            border: Border.all(
                              color: const Color(0xffe0e0e0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 9,
                        child: Container(
                          width: 78,
                          height: 78,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 246, 215, 251),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 265,
                        top: 16,
                        child: Text(
                          '₹${wishItem.productPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.montserrat(
                            color: const Color(0xff212121),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 101,
                        top: 14,
                        child: SizedBox(
                          width: 162,
                          child: Text(
                            wishItem.productName,
                            style: GoogleFonts.montserrat(
                              color: const Color(0xff212121),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23,
                        top: 14,
                        child: Image.network(
                          wishItem.images[0],
                          width: 56,
                          height: 67,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 284,
                        top: 47,
                        child: Image.asset(
                          "assets/icons/delete.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
