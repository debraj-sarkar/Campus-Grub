import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class HomePage extends StatefulWidget {
  final double totalAmount;

  // Constructor accepting totalAmount parameter
  const HomePage({Key? key, required this.totalAmount}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "debrajsarkarsiliguri123@okicici",
      receiverName: 'Debraj Sarkar',
      transactionRefId: 'TestingUpiIndiaPlugin',
      //transactionNote: 'Not actual. Just an example.',
      amount: widget.totalAmount,
    );
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: apps!.map<Widget>((UpiApp app) {
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
                          fontWeight: FontWeight.bold),
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
            ElevatedButton(
              onPressed: () {
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
              },
              child: Text('Initiate Transaction'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 48, 1),
        title: const CustomText(
          text: 'Payment Screen',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
              child: FutureBuilder(
            future: _transaction,
            builder:
                (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      _upiErrorHandler(snapshot.error.runtimeType),
                      style: header,
                    ), // Print's text message on screen
                  );
                }

                // If we have data then definitely we will have UpiResponse.
                // It cannot be null
                // UpiResponse _upiResponse = snapshot.data!;

                // Data in UpiResponse can be null. Check before printing
                // String txnId = _upiResponse.transactionId ?? 'N/A';
                // String resCode = _upiResponse.responseCode ?? 'N/A';
                // String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                // String status = _upiResponse.status ?? 'N/A';
                // String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                // _checkTxnStatus(status);

                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       displayTransactionData('Transaction Id', txnId),
                //       displayTransactionData('Response Code', resCode),
                //       displayTransactionData('Reference Id', txnRef),
                //       displayTransactionData('Status', status.toUpperCase()),
                //       displayTransactionData('Approval No', approvalRef),
                //     ],
                //   ),
                // );

                // If you don't want to display any data yet, return null
                return Container();
              } else
                return Center(
                  child: Text(''),
                );
            },
          ))
        ],
      ),
    );
  }
}
