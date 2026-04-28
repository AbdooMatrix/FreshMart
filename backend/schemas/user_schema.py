from pydantic import BaseModel
from typing import Optional


# Used when creating a new user
class UserCreate(BaseModel):
    name: str
    email: str
    password: str
    role: str = "customer"
    phone: Optional[str] = None
    address: Optional[str] = None


# Used when returning user data (never return password!)
class UserResponse(BaseModel):
    id: int
    name: str
    email: str
    role: str
    phone: Optional[str] = None
    address: Optional[str] = None

    class Config:
        from_attributes = True