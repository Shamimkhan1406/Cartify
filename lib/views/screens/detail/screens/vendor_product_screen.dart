import 'package:cartify/models/vendor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorProductScreen extends ConsumerStatefulWidget {
  final Vendor vendor;
  const VendorProductScreen({super.key, required this.vendor});

  @override
  ConsumerState<VendorProductScreen> createState() =>
      _VendorProductScreenState();
}

class _VendorProductScreenState extends ConsumerState<VendorProductScreen> {
  @override
  Widget build(BuildContext context) {
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
                            '0',
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
                  widget.vendor.fullName.toUpperCase(),
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              widget.vendor.storeImage!.isNotEmpty
                  ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.vendor.storeImage!),
                  )
                  : CircleAvatar(
                    radius: 50,
                    child: Text(
                      widget.vendor.fullName[0].toUpperCase(),
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              widget.vendor.storeDescription!.isEmpty
                  ? Text('')
                  : Text(
                    widget.vendor.storeDescription!,
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
