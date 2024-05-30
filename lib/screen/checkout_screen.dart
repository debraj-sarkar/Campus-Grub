import 'package:campus_grub_official/payment_summery/payment.dart';
import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:campus_grub_official/utils/order_confirmation.dart';
import 'package:campus_grub_official/utils/upi_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<UpiResponse>? _transaction;
  UpiApp? _selectedUpiApp;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  String? _selectedPaymentOption;

  // Define confirmOrder function outside the build method
  void confirmOrder(List<Map<String, dynamic>> cartItems) {
    final reviewcartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    reviewcartProvider.uploadOrderToFirebase(cartItems);

    // Clear the cart items
    reviewcartProvider.clearCart();

    // Notify all listeners about the change in cart items
    reviewcartProvider.notifyListeners();

    // Other logic related to confirming the order...
  }

  @override
  Widget build(BuildContext context) {
    final reviewcartProvider = Provider.of<ReviewCartProvider>(context);
    final cartItems = reviewcartProvider.cartItems;
    final reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    print(cartItems);

    double totalAmount = 0;
    cartItems.forEach((item) {
      totalAmount += (item['itemPrice'] * item['quantity']);
    });

    Future<UpiResponse> initiateTransaction(UpiApp app) async {
      return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "arijtroy@okaxis",
        receiverName: 'Debraj Sarkar',
        transactionRefId: 'TestingUpiIndiaPlugin',
        //transactionNote: 'Not actual. Just an example.',
        amount: 1,
      );
    }

    bool isFirstAppSelected = false;

    Widget displayUpiApps() {
      if (apps == null) {
        return Center(child: CircularProgressIndicator());
      } else if (apps!.isEmpty) {
        return Center(
          child: Text(
            "No apps found to handle transaction.",
            style: header,
          ),
        );
      } else {
        return Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: apps!.map<Widget>((UpiApp app) {
                        if (!isFirstAppSelected && _selectedUpiApp == null) {
                          _selectedUpiApp = app;
                          isFirstAppSelected = true;
                        }
                        return ListTile(
                          leading: Image.memory(
                            app.icon,
                            height: 60,
                            width: 60,
                          ),
                          title: CustomText(
                            text: app.name,
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Radio<UpiApp>(
                            value: app,
                            groupValue: _selectedUpiApp,
                            onChanged: (value) {
                              setState(() {
                                _selectedUpiApp = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    String _upiErrorHandler(error) {
      switch (error) {
        case UpiIndiaAppNotInstalledException:
          return 'Requested app not installed on device';
        case UpiIndiaUserCancelledException:
          return 'You cancelled the transaction';
        case UpiIndiaNullResponseException:
          return 'Requested app didn\'t return any response';
        case UpiIndiaInvalidParametersException:
          return 'Requested app cannot handle the transaction';
        default:
          return 'An Unknown error has occurred';
      }
    }

    void _checkTxnStatus(String status) {
      switch (status) {
        case UpiPaymentStatus.SUCCESS:
          print('Transaction Successful');
          break;
        case UpiPaymentStatus.SUBMITTED:
          print('Transaction Submitted');
          break;
        case UpiPaymentStatus.FAILURE:
          print('Transaction Failed');
          break;
        default:
          print('Received an Unknown transaction status');
      }
    }

    Widget displayTransactionData(title, body) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title: ", style: header),
            Flexible(
                child: Text(
              body,
              style: value,
            )),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 240, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 48, 1),
        title: const CustomText(
          text: 'Checkout Screen',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // menu items and total
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartItems.map((item) {
                      return MenuItem(
                        name: item['itemName'],
                        price: '\₹ ${item['itemPrice']}',
                        quantity: item['quantity'],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: 'Total to Amount Pay:',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: '\₹$totalAmount',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Payment
                const CustomText(
                  text: 'Online Payment Options',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),

                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: displayUpiApps(),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: _transaction,
                          builder: (BuildContext context,
                              AsyncSnapshot<UpiResponse> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    _upiErrorHandler(
                                        snapshot.error.runtimeType),
                                    style: header,
                                  ), // Print's text message on screen
                                );
                              }

                              // If we have data then definitely we will have UpiResponse.
                              // It cannot be null
                              UpiResponse _upiResponse = snapshot.data!;

                              // Data in UpiResponse can be null. Check before printing
                              String txnId =
                                  _upiResponse.transactionId ?? 'N/A';
                              String resCode =
                                  _upiResponse.responseCode ?? 'N/A';
                              String txnRef =
                                  _upiResponse.transactionRefId ?? 'N/A';
                              String status = _upiResponse.status ?? 'N/A';
                              String approvalRef =
                                  _upiResponse.approvalRefNo ?? 'N/A';
                              _checkTxnStatus(status);

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    displayTransactionData(
                                        'Transaction Id', txnId),
                                    displayTransactionData(
                                        'Response Code', resCode),
                                    displayTransactionData(
                                        'Reference Id', txnRef),
                                    displayTransactionData(
                                        'Status', status.toUpperCase()),
                                    displayTransactionData(
                                        'Approval No', approvalRef),
                                  ],
                                ),
                              );
                            } else
                              return Center(
                                child: Text(''),
                              );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Place Order Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () async {
                  if (_selectedUpiApp != null) {
                    _transaction = initiateTransaction(_selectedUpiApp!);
                    setState(() {});
                  } else {
                    // Handle case where no app is selected
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please select a payment method.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  UpiResponse? response;

                  try {
                    if (_transaction != null) {
                      response = await _transaction!;

                      if (response != null) {
                        // Handle other transaction statuses if needed
                        if (response.status == UpiPaymentStatus.FAILURE) {
                          print('Transaction failed.');
                        } else {
                          print('Transaction status unknown.');
                        }
                      } else {
                        // Handle case where response is null (transaction canceled)
                        print('Transaction canceled.');
                      }
                    } else {
                      // Handle case where transaction is null
                      print('Transaction is null.');
                    }
                  } catch (e) {
                    // Handle any exceptions that occur during the transaction
                    print('Error during transaction: $e');
                  } finally {
                    // Navigate to OrderConfirmation page regardless of transaction status
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmation(
                          responseStatus: response?.status ??
                              '', // Pass status if available
                        ),
                      ),
                    );
                  }
                  // Upload order to Firebase
                  // await reviewCartProvider.uploadOrderToFirebase(cartItems);

                  // // Clear cart items after upload is complete
                  // reviewCartProvider.clearCart();
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 5, 7, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;

  const MenuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.transparent,
              width: 1,
            )),
            child: CustomText(
              text: name,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          CustomText(
            text: price,
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          const CustomText(
              text: 'X',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal),
          CustomText(
              text: quantity.toString(),
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
