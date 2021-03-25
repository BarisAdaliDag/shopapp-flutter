//204 dismissible
/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //return Future.value(true);
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove the item from cart?'),
              //backgroundColor: Colors.black54,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: Text('No')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: Text('Yes')),
              ]),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}   -   $quantity x'),
            trailing: IconButton(
              onPressed: () {
                Provider.of<Cart>(context, listen: false).removeItem(productId);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              iconSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );
  Widget sweepContainer(BuildContext ctx, IconData icon, Alignment alignment) {
    return Container(
      color: Theme.of(ctx).errorColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
      alignment: alignment,
      padding: EdgeInsets.only(right: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);

    return Dismissible(
      key: ValueKey(id),
      background:
          sweepContainer(context, Icons.delete_sweep, Alignment.centerLeft),
      secondaryBackground:
          sweepContainer(context, Icons.delete_outline, Alignment.centerRight),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          product.removeItem(productId);
        } else {
          product.removeItem(productId);
          if (quantity > 1) {
            product.addItem(productId, price, title);
          }
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('$price')),
            ),
            title: Text(title),
            subtitle: Text('x $quantity'),
            trailing: Text('Total: ${price * quantity}'),
          ),
        ),
      ),
    );
  }
}
