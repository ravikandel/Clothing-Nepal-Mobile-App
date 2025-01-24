import 'package:demo/screens/product_screen.dart'; // Import ProductScreen
import 'package:demo/utils/snackbar_lib.dart';
import 'package:demo/utils/cart_manager.dart';
import 'package:demo/widgets/custom_bottom_nav_bar.dart';
import 'package:demo/widgets/dashed_line.dart';
import 'package:demo/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _selectedPaymentMethod = 'PayPal'; // Default

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      UIUtils.showSnackbar(context, 'Page Refreshed!', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar1(title: 'Checkout'),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<CartManager>(
          builder: (context, cartManager, child) {
            final cart = cartManager.cartItems;
            final totalPrice = cartManager.totalPrice;
            final discount = cartManager.discount;
            final discountCode = cartManager.discountCode;
            final shipping = cartManager.shipping;

            return cart.isEmpty
                ? const Center(child: Text('Your cart is empty.'))
                : Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          ...cart.map((item) {
                            final product = item['product'];
                            final productSize = item['product_size'];
                            final productQuantity = item['product_quantity'];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductScreen(product: product),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFFD9D9D9), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        product.productImages[0],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.productName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF004D67),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (product.discountPrice >
                                                  0.0) ...[
                                                Text(
                                                  '\$${product.discountPrice.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                if (product.actualPrice > 0.0)
                                                  const SizedBox(width: 4),
                                              ],
                                              const SizedBox(width: 8),
                                              Text(
                                                '|  Size: $productSize',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '|  Qty.: $productQuantity',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '\$${product.discountPrice.toStringAsFixed(2)} X $productQuantity = \$${(product.discountPrice * productQuantity).toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 19,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                          // discount code
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // discount code Field
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Have Coupon Code?',
                                        controller: _couponController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            false, // Marking this field as required
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        final couponCode =
                                            _couponController.text.trim();
                                        if (couponCode.isEmpty) {
                                          UIUtils.showSnackbar(
                                            context,
                                            'Please enter a coupon code!',
                                            Colors.red,
                                          );
                                        } else {
                                          UIUtils.showSnackbar(
                                            context,
                                            'Coupon code applied succesfully!',
                                            Colors.green,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF204E2D),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 18), // Added padding
                                      ),
                                      child: const Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Summary Section
                          const SizedBox(height: 20),
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D67),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sub Total',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                    Text(
                                      '\$${totalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomPaint(
                                  painter: DashedLinePainter(),
                                  child: SizedBox(
                                    height: 15,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Discount ($discountCode)',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                    Text(
                                      '- \$${discount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Shipping',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                    Text(
                                      '\$${shipping.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomPaint(
                                  painter: DashedLinePainter(),
                                  child: SizedBox(
                                    height: 15,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Grand Total',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF004D67),
                                      ),
                                    ),
                                    Text(
                                      '\$${((totalPrice + shipping) - discount).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // shipping section
                          const SizedBox(height: 20),
                          const Text(
                            'Shipping Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D67),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // first name and last name
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'First Name',
                                        controller: _fnameController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Last Name',
                                        controller: _lnameController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                                // email address
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Email Address',
                                        controller: _emailController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),

                                // phone and country
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Phone',
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Country',
                                        controller: _countryController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                                // address
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Address',
                                        controller: _addressController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                                //apartment and city
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Apartment',
                                        controller: _apartmentController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            false, // Marking this field as required
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'City',
                                        controller: _cityController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                                //state and zip
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'State',
                                        controller: _stateController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Zip Code',
                                        controller: _zipController,
                                        keyboardType: TextInputType.number,
                                        isRequired:
                                            true, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                                // note
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ShippingInputField(
                                        labelText: 'Note (if any)',
                                        controller: _noteController,
                                        keyboardType: TextInputType.name,
                                        isRequired:
                                            false, // Marking this field as required
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //payment method
                          const SizedBox(height: 20),
                          const Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D67),
                            ),
                          ),
                          const SizedBox(height: 20),

                          GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildRadioButton('PayPal'),
                              _buildRadioButton('Apple Pay'),
                              _buildRadioButton('Optus Pay'),
                              _buildRadioButton('After Pay'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors
              .transparent, // Set the BottomAppBar background color to white
          child: Container(
            color: Colors
                .transparent, // This ensures the button's background is also white
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Proceed to pay Button
                SizedBox(
                  width: double.infinity, // Full-width button
                  child: ElevatedButton(
                    onPressed: () {
                      //if (_formKey.currentState!.validate()) {
                      // final email = _fnameController.text.trim();
                      // final password = passwordController.text.trim();

                      // Access the CartManager and clear the cart
                      final cartManager =
                          Provider.of<CartManager>(context, listen: false);
                      cartManager.clearCart(); // Clear the cart

                      Navigator.pushReplacementNamed(
                        context,
                        '/success',
                        arguments:
                            'Order placed successfully!', // Passing the message
                      );
                      // } else {
                      //   UIUtils.showSnackbar(
                      //       context, 'Checkout failed!', Colors.red);
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF004D67),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(String paymentMethod) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedPaymentMethod = paymentMethod;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: _selectedPaymentMethod == paymentMethod
              ? Color(0xFF004D67)
              : Color(0xFFD9D9D9),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale:
                1.5, // Adjust this value to make the radio button larger or smaller
            child: Radio<String>(
              value: paymentMethod,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              activeColor: Color(0xFF004D67),
            ),
          ),
          Text(
            paymentMethod,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF004D67),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
