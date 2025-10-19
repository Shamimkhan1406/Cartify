import 'package:cartify/controllers/vendor_controller.dart';
import 'package:cartify/provider/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class StoresScreen extends ConsumerStatefulWidget {
  const StoresScreen({super.key});

  @override
  ConsumerState<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends ConsumerState<StoresScreen> {
  bool isLoading = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureBanners = VendorController().loadBanners();
    _fetchVendor();
  }

  Future<void> _fetchVendor() async {
    final VendorController vendorController = VendorController();
    try {
      final vendors = await vendorController.loadVendors();
      ref.read(vendorProvider.notifier).setVendors(vendors);
    } catch (e) {
      print('Error fetching vendors: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final vendors = ref.watch(vendorProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    // set the crossAxisCount based on screen width
    // if screen width is less than 600, set crossAxisCount to 2
    // if screen width is greater than 600, set crossAxisCount to 4
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    // set the expect ration (screen to height ) of each grid based on the screen width
    // for smaller screen, set the expect ratio to 3.4 taller items
    // for larger screen, set the expect ratio to 4.5 square items
    final childAspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;
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
                            vendors.length.toString(),
                            //cartData.length.toString(),
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
                  'Stores',
                  style: GoogleFonts.lato(
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
      body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                     vendors.isEmpty
                        ? const Center(child: Text('No products found'))
                        : GridView.builder(
                          itemCount: vendors.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: childAspectRatio,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemBuilder: (context, index) {
                            final vendor = vendors[index];
                            return Text(vendor.fullName);
                          },
                        ),
              ),
    );
  }
}
