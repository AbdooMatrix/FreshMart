from sqlalchemy.orm import Session
from models.cart import Cart
from models.product import Product
from schemas.cart_schema import CartAdd, CartUpdate


def get_cart_items(db: Session, user_id: int):
    """
    Get all cart items for a user.
    Joins with Products table to get name, price, and image.
    Calculates subtotal for each item.
    """
    cart_items = db.query(Cart).filter(Cart.user_id == user_id).all()
    result = []
    for item in cart_items:
        product = db.query(Product).filter(Product.id == item.product_id).first()
        if product:
            result.append({
                "id": item.id,
                "user_id": item.user_id,
                "product_id": item.product_id,
                "quantity": item.quantity,
                "product_name": product.name,
                "product_price": product.price,
                "product_image": product.image_url,   
                "subtotal": round(product.price * item.quantity, 2),
            })
    return result


def add_to_cart(db: Session, cart_data: CartAdd):
    """
    Add a product to the user's cart.
    If already in cart, increase quantity.
    If new, create new cart row.
    """
    existing = (
        db.query(Cart)
        .filter(Cart.user_id == cart_data.user_id, Cart.product_id == cart_data.product_id)
        .first()
    )
    if existing:
        existing.quantity += cart_data.quantity
        db.commit()
        db.refresh(existing)
        return existing

    new_item = Cart(
        user_id=cart_data.user_id,
        product_id=cart_data.product_id,
        quantity=cart_data.quantity,
    )
    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    return new_item


def update_cart_item(db: Session, cart_data: CartUpdate):
    """Update the quantity of a specific cart item"""
    item = db.query(Cart).filter(Cart.id == cart_data.cart_item_id).first()
    if not item:
        return None
    item.quantity = cart_data.quantity
    db.commit()
    db.refresh(item)
    return item


def remove_cart_item(db: Session, item_id: int):
    """Remove a specific item from the cart"""
    item = db.query(Cart).filter(Cart.id == item_id).first()
    if not item:
        return False
    db.delete(item)
    db.commit()
    return True


def clear_user_cart(db: Session, user_id: int):
    """Remove ALL items from a user's cart (used after checkout)"""
    db.query(Cart).filter(Cart.user_id == user_id).delete()
    db.commit()