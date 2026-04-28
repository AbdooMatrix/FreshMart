from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime


# Used when customer clicks "Place Order"
class CheckoutRequest(BaseModel):
    user_id: int
    shipping_address: Optional[str] = None
    payment_method: str = "COD"


# Used inside OrderResponse to show each item
class OrderItemResponse(BaseModel):
    product_id: int
    product_name: str
    quantity: int
    price_at_purchase: float

    class Config:
        from_attributes = True


# Used when returning the full order to Flutter
class OrderResponse(BaseModel):
    id: int
    user_id: int
    total_amount: float
    status: str
    payment_method: str
    shipping_address: Optional[str] = None
    created_at: datetime
    items: List[OrderItemResponse] = []

    class Config:
        from_attributes = True