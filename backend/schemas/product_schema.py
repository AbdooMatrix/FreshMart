from pydantic import BaseModel
from typing import Optional


# Used when CREATING a new product (Admin)
class ProductCreate(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    stock: int = 0
    category: Optional[str] = None
    image_url: Optional[str] = None


# Used when UPDATING a product — all fields optional
class ProductUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    price: Optional[float] = None
    stock: Optional[int] = None
    category: Optional[str] = None
    image_url: Optional[str] = None


# Used when RETURNING product data to Flutter
class ProductResponse(BaseModel):
    id: int
    name: str
    description: Optional[str] = None
    price: float
    stock: int
    category: Optional[str] = None
    image_url: Optional[str] = None

    class Config:
        from_attributes = True