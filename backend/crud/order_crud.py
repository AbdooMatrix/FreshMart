from sqlalchemy.orm import Session
from models.cart import Cart
from models.order import Order
from models.order_item import OrderItem
from models.payment import Payment
from models.product import Product
from schemas.order_schema import CheckoutRequest


def checkout(db: Session, data: CheckoutRequest):
    # ──── STEP 1: Get cart items ────
    cart_items = db.query(Cart).filter(Cart.user_id == data.user_id).all()
    if not cart_items:
        return None, "Cart is empty"

    # ──── STEP 2 & 3: Validate stock + calculate total ────
    total = 0.0
    items_to_order = []

    for cart_item in cart_items:
        product = db.query(Product).filter(Product.id == cart_item.product_id).first()

        # Check: does this product still exist?
        if not product:
            return None, f"Product ID {cart_item.product_id} not found"

        # Check: is there enough stock?
        if product.stock < cart_item.quantity:
            return None, f"Insufficient stock for '{product.name}'. Available: {product.stock}, Requested: {cart_item.quantity}"

        subtotal = product.price * cart_item.quantity
        total += subtotal

        items_to_order.append({
            "product": product,
            "quantity": cart_item.quantity,
            "price": product.price,
        })

    # ──── STEP 4: Create order ────
    order = Order(
        user_id=data.user_id,
        total_amount=round(total, 2),
        status="confirmed",
        payment_method=data.payment_method,
        shipping_address=data.shipping_address,
    )
    db.add(order)
    db.flush()  # flush() gets the order.id WITHOUT committing yet

    # ──── STEP 5: Create order items + reduce stock ────
    for entry in items_to_order:
        order_item = OrderItem(
            order_id=order.id,
            product_id=entry["product"].id,
            quantity=entry["quantity"],
            price_at_purchase=entry["price"],
        )
        db.add(order_item)
        entry["product"].stock -= entry["quantity"]

    # ──── STEP 6: Create payment record ────
    payment = Payment(
        order_id=order.id,
        amount=order.total_amount,
        method=data.payment_method,
        status="pending" if data.payment_method == "COD" else "completed",
    )
    db.add(payment)

    # ──── STEP 7: Clear cart ────
    db.query(Cart).filter(Cart.user_id == data.user_id).delete()

    # ──── COMMIT everything at once ────
    db.commit()
    db.refresh(order)

    return order, None


def get_order_with_items(db: Session, order_id: int):
    """
    Get a complete order with all its items.
    Used to build the response after checkout.
    """
    order = db.query(Order).filter(Order.id == order_id).first()
    if not order:
        return None

    items = db.query(OrderItem).filter(OrderItem.order_id == order_id).all()
    order_items = []
    for item in items:
        product = db.query(Product).filter(Product.id == item.product_id).first()
        order_items.append({
            "product_id": item.product_id,
            "product_name": product.name if product else "Unknown",
            "quantity": item.quantity,
            "price_at_purchase": item.price_at_purchase,
        })

    return {
        "id": order.id,
        "user_id": order.user_id,
        "total_amount": order.total_amount,
        "status": order.status,
        "payment_method": order.payment_method,
        "shipping_address": order.shipping_address,
        "created_at": order.created_at,
        "items": order_items,
    }