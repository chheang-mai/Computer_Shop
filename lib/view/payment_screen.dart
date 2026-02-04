import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedMethod = -1;
  bool saveCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x14000000),
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Total price",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$100",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE53935),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  if(selectedMethod == 0 || selectedMethod == 1 ){
                    showDialog(
                      context: context,
                       builder: (context){
                          return AlertDialog(
                            title: Text("Scan here"),
                            backgroundColor: Colors.white,
                            content: Container(
                              width: 320,
                              height: 320,
                              child: Center(
                                child: QrImageView(data: "This is simple QR code",
                                version: QrVersions.auto,
                                size: 320,
                                gapless: false,
                                backgroundColor: Colors.white,
                                ),
                                
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: (){}, child: Text("Done"))
                            ],
                          );
                       });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Total",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text("\$15.50"),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Delivery Fees"),
                  Text("\$1.50"),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Sub Total"),
                  Text("\$17.00"),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 12),

            // ABA (0)
            InkWell(
              onTap: () => setState(() => selectedMethod = 0),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selectedMethod == 0
                      ? const Color(0xFFE53935)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedMethod == 0
                        ? Colors.transparent
                        : const Color(0xFFE9E9E9),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedMethod == 0
                            ? Colors.white.withOpacity(0.15)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        "https://informal.digitaleconomy.gov.kh/images/ministry-icon/aba_round.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ABA",
                            style: TextStyle(
                              color: selectedMethod == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "5105 •••• •••• 0505",
                            style: TextStyle(
                              color: selectedMethod == 0
                                  ? Colors.white70
                                  : Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selectedMethod == 0
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedMethod == 0
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ACLEDA (1)
            InkWell(
              onTap: () => setState(() => selectedMethod = 1),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selectedMethod == 1
                      ? const Color(0xFFE53935)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedMethod == 1
                        ? Colors.transparent
                        : const Color(0xFFE9E9E9),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedMethod == 1
                            ? Colors.white.withOpacity(0.15)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        "https://www.acledasecurities.com.kh/as/assets/listed_company/ABC/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ACLEDA",
                            style: TextStyle(
                              color: selectedMethod == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "3566 •••• •••• 0505",
                            style: TextStyle(
                              color: selectedMethod == 1
                                  ? Colors.white70
                                  : Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selectedMethod == 1
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedMethod == 1
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // DELIVERY (2) ✅ FIXED (was 0 before)
            InkWell(
              onTap: () => setState(() => selectedMethod = 2),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selectedMethod == 2
                      ? const Color(0xFFE53935)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedMethod == 2
                        ? Colors.transparent
                        : const Color(0xFFE9E9E9),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedMethod == 2
                            ? Colors.white.withOpacity(0.15)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://image.similarpng.com/file/similarpng/original-picture/2020/11/Modern-delivery-man-on-scooter-on-transparent-background-PNG.png",
                          fit: BoxFit.contain,
                          width: 60,
                          height: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DELIVERY",
                            style: TextStyle(
                              color: selectedMethod == 2
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Cash on delivery",
                            style: TextStyle(
                              color: selectedMethod == 2
                                  ? Colors.white70
                                  : Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selectedMethod == 2
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedMethod == 2
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  onChanged: (v) => setState(() => saveCard = v ?? false),
                  activeColor: const Color(0xFFE53935),
                ),
                const Expanded(
                  child: Text(
                    "Save card details for future payments",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
