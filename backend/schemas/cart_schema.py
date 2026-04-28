from pydantic import BaseModel


# Used when ADDING item to cart
class CartAdd(BaseModel):
    user_id: int
    product_id: int
    quantity: int = 1


# Used when UPDATING cart item quantity
class CartUpdate(BaseModel):
    cart_item_id: int
    quantity: int


# Used when RETURNING cart data to Flutter
class CartItemResponse(BaseModel):
    id: int
    user_id: int
    product_id: int
    quantity: int
    product_name: str        # Joined from Products table
    product_price: float     # Joined from Products table
    subtotal: float          # Calculated: price × quantity

    class Config:
        from_attributes = True